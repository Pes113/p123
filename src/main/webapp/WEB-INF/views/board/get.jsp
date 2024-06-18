<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    	<%@include file="../includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/get.css">
<script src="/resources/js/replyService.js" defer></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script type="text/javascript">
  	$(function() { 
  		getAttachList(${board.bno});
  		
		var urlParams = new URL(location.href).searchParams;
		let bno = urlParams.get('bno');
		let pageNum = 1;
		
		$("#move_list").on("click", function() {
			 $("#moveForm").submit();
		});
		
		$("#modify_board").on("click", function() {
			 $("#modifyForm").submit();
		});
		
		$("#modalCloseBtn").on("click", function() {
			 $(".modal").modal('hide')
		});
		$("#make_reply").on("click", function() {
			$("#reply").val("");
			$("#modalModBtn").hide();
			$("#modalRegisterBtn").show();
			$("#modalCloseBtn").show();
			$('.modal').modal('show');
		});
		$("#modalRegisterBtn").on("click", function() {
			let reply = {"reply" : $("#reply").val(), "replyer" : $("#replyer").val(), "bno" : bno};
			ReplyService.add(reply,
				function(result) {
					alert(result);
					$(".modal").modal("hide");
					location.reload(true);
				},
				function(error) {
					alert(error);
				});
		});
		
		$("#attachedFile").on("click", "ul li div",function() {
			let data = $(this).parent().data();
			let path = encodeURIComponent(data.path + "\\" + data.uuid + "_" + data.filename);
			console.log(data);
			console.log(data.path);
			console.log(path);
			console.log(data.type);
			if(data.type) {
				$(".big_picture_wrapper").css('display', 'flex').show();
				$(".big_picture").html("<img src='/display?filename=" + path + "'>")
				.animate({width:'100%', top:'0'}, 600);
			}
			else {
				if(path.toLowerCase().endsWith('pdf')) {
					window.open('/pdfviewer?filename='+path);
				}
				else {
					self.location = "/downloadFile?filename="+path;
				}
			}
		});
		
		$(".big_picture_wrapper").on("click", function(e) {
			$(".big_picture_wrapper").hide();
		});
		
		$("#modalModBtn").on("click", function() {
			let rno = $(".modal").data("rno");
			let reply = {"rno" : rno, "reply" : $("#reply").val(), "replyer" : $("#replyer").val()};
			console.log(reply);
			console.log(rno);
 			ReplyService.modify(rno, reply,
				function(result) {
					alert(result);
					$(".modal").modal("hide");
		 			getReplyListWith(true);
				},
				function(error) {
					alert(error);
				});
		});
		
		$('.reply_list').on("click", "li #modify_reply", function() {
			let rno = $(this).parents("div").data('rno');
				ReplyService.get(rno, 
				function(list) {
					console.log(list);
					if(list.replyer == $("#replyer").val()) {
			 			$(".modal").data("rno", list.rno);
			 			$("#reply").val(list.reply);
			 			$("#replyer").val(list.replyer);
						$("#modalModBtn").show();
						$("#modalRegisterBtn").hide();
						$("#modalCloseBtn").show();
						$('.modal').modal('show');
					}
					else {
						alert("접근 불가");
					}
				},
				function(error) {
					console.log(error);
				});

		});

		$('.reply_list').on("click", "li #remove_reply", function() {
			let rno = $(this).parents("div").data('rno');
			ReplyService.remove(rno, 
				function(list) {
					alert("삭제완료");
				},
				function(error) {
					console.log(error);
				});
 			location.reload(true);
		});
		
		$(".panel-footer").on("click", "ul li a", function(e) {
		    e.preventDefault();
		    console.log("page click");
		    let targetPageNum = $(this).attr("href");
		    console.log("targetPageNum: " + targetPageNum);
		    pageNum = targetPageNum;
		    getReplyListWithPaging(pageNum);
		});
		
		getReplyListWithPaging();
		function getReplyListWithPaging() {
 	  		let param = {"bno" : ${board.bno}, "page" : pageNum};
			ReplyService.getListWithPaging(param,
					function(data) {
			        	console.log(data.replyCnt);
			        	console.log(data.list);
			        	showReplyList(data.list);
			        	showReplyPaging(data.replyCnt);
					},
					function(error) {
						alert(error);
					});
		}
		
  		function showReplyList(list) {
			let str = "";
			console.log(list);
 			for(let i = 0; i < list.length; i++) {
	 			str += "<li>";
				str += "	<div>";
				str += "		<div>";
				str += "			<strong>"+list[i].replyer+"</strong>";
				str += "			<small>"+ReplyService.displayTime(list[i].regdate)+"</small>"; 
				str += "		</div>";
				str += "		<div data-rno='"+list[i].rno+"'data-replyer='"+list[i].replyer+"'>";
				str += "			<strong id='modify_reply'>"+list[i].reply+"</strong>";
				if("${auth.user_id}" == list[i].replyer){
				str += "			<button id='remove_reply' type='button' data-rno='"+list[i].rno+"'>" ;
				str += "				<span>X<span>";
				str += "			</button>";
				}
				str += "		</div>";
				str += "	</div>";
				str += "</li>";
				$('.reply_list').html(str);
			}
		} 
  		
		function showReplyPaging(replyCnt) {	// 작성된 댓글 목록 보여줌
			let endNum = Math.ceil(pageNum/10.0) * 10;
			let startNum = endNum - 9;
			let prev = (startNum != 1);
			let next = false;
			if((endNum * 5) >= replyCnt) {
				endNum = (Math.ceil(replyCnt / 5.0));
			}
			if((endNum * 5) < replyCnt) {
				next = true;
			}
			let footer = "<ul class='reply_page_list'>";
 			if(prev) {
				footer += "<li><a href="+(startNum-1)+">Prev</a></li>";
			} 
			for(let i = startNum; i <= endNum; i++) {
				footer += "<li><a href="+i+">"+i+"</a></li>";
			}
 			if(next) {
				footer += "<li><a href="+(endNum+1)+">Next</a></li>";
			} 
 			footer += "</ul>";
			$('.panel-footer').html(footer);
		}
		
		function getAttachList(bno){
			$.getJSON("/board/getAttachList/" + bno, function(data) {
				console.log(data);
				let str="";
				for(let i = 0; i<data.length; i++) {
					if(data[i].filetype){
						let file_call_path = encodeURIComponent(data[i].uploadpath + "\\s_" + data[i].uuid + "_" + data[i].filename);
						str += "<li data-path='" + data[i].uploadpath + "' data-uuid = '" + data[i].uuid + "'";
						str += "	data-filename = '" + data[i].filename + "' data-type = '" + data[i].filetype + "'>";
						str += "	<div>";
						str += "		<span>" + data[i].filename + "</span>";
						str += "		<img src='/display?filename=" + file_call_path + "'/>";
						str += "	</div>";
						str += "</li>";
					}
					else {
						str += "<li data-path='" + data[i].uploadpath + "' data-uuid = '" + data[i].uuid + "'";
						str += "	data-filename = '" + data[i].filename + "' data-type = '" + data[i].filetype + "'>";
						str += "	<div>";
						str += "		<span>" + data[i].filename + "</span>";
						str += "		<img src='/resources/img/icon.jpg'/>";
						str += "	</div>";
						str += "</li>";
					}
				}
				$('#attachedFile ul').append(str);
			});
		}
	});
</script>
<title>Board Get</title>
</head>
<body>
	<div class="get_body">
		<div id="get_title">
			<p><c:out value="${board.title}" /></p>
		</div>
		<div id="get_writer">
			<span><c:out value="${board.writer}" /> | <fmt:formatDate pattern="MM-dd" value="${board.updatedate}" /> </span>
		</div>
		<div class="get_content_div">
			<textarea class="get_content_textarea" name="content" rows="10" cols="65" maxlength="4000" disabled><c:out value="${board.content}" /></textarea>
		</div>
		<div>
			<div>
				<p>첨부파일</p>
			</div>
			<div id="attachedFile">
				<ul></ul>
			</div>
		</div>
			<h4>댓글 목록</h4>
		<div id="reply_list_div">
			<ul class="reply_list"></ul>
			<div class="panel-footer">
			</div>
		</div>
		<div class="reply_register">
			<c:if test="${auth.user_id ne null}">
				<input class="read" id="make_reply" value="댓글 작성">
		    </c:if>
		</div>
		<div class="get_submit">
			<input class="read" id="move_list" value="목록"/>
			<c:if test="${auth.user_id eq board.writer}">
	        	<input class="read" id="modify_board" value="수정">
	        </c:if>
		</div>
		
		<!--Modal-->
		<div class="modal fade" tabindex="-1" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">REPLY MODAL</h4>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label>REPLY</label>
							<input class="form-control" id='reply' name='reply'>
						</div>					
						<div class="form-group">
							<label>REPLYER</label>
							<input class="form-control" id='replyer' name='replyer'
							value="${auth.user_id}" readonly="readonly">
						</div>
					</div>
					<div class="modal-footer">
						<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
						<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
						<button id='modalCloseBtn' type="button" class="btn btn-info">Close</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal fade -->
		
		<div class="big_picture_wrapper">
			<div class="big_picture"></div>
		</div>
		
		<form id="modifyForm" action="/board/modify" method="get">
			<input type="hidden" id="bno" name="bno" value="<c:out value="${board.bno}"/>">
			<input type="hidden" id="pageNum" name="pageNum" value="<c:out value="${criteria.pageNum}"/>">
			<input type="hidden" id="amount" name="amount" value="<c:out value="${criteria.amount}"/>">
		</form>
		<form id="moveForm" action="/board/list" method="get">
			<input type="hidden" id="pageNum" name="pageNum" value="<c:out value="${criteria.pageNum}"/>">
			<input type="hidden" id="amount" name="amount" value="<c:out value="${criteria.amount}"/>">
		</form>
	</div>
</body>
    	<%@include file="../includes/footer.jsp" %>
</html>