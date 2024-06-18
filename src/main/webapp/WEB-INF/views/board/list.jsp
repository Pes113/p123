<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    	<%@include file="../includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head></head>
<meta charset="UTF-8">
<style>
	table {
		text-align: center;
		width:600px;
        border:2px solid #DCE2F0;
		margin-left:auto;
		margin-right:auto; 
		margin-bottom:20px;
	}
	th {
		color: #50586C;
		background-color: #DCE2F0;
        border:2px solid #DCE2F0;
	}
	ul {
		padding-left: 40px;
		padding-right: 40px;
	}
	li {
		display: inline;
		list-style-type: none;
	}
	ul > li > a {
		text-decoration-line: none;
		text-decoration-color: none;
	}
	.list_body {
		text-align: center;
		width : 100%;
		height: 600px;
	}
	.bno {
        text-align: center;
		width:10%;
		color: #50586C;
	}
	.title {
		width:35%;
		color: #50586C;
	}
	.writer {
        text-align: center;
		width:15%;
		color: #50586C;
	}
	.redate {
        text-align: center;
		width:20%;
		color: #50586C;
	}
	.updatedate {
        text-align: center;
		width:20%;
		color: #50586C;
	}
	.write {
		width: 600px;
  		border-width: 0;
		text-align: right;
	    margin-left: auto;
	    margin-right: auto;
	}
	.write > a{
		position: relative;
		display: inline-block;
		padding: 0.3em 0.6em;
		text-decoration: none;
		text-align: center;
		cursor: pointer;
		user-select: none;
		text-decoration-line: none;
		text-decoration-color: none;
	    background: linear-gradient(135deg, #6e8efb, #a777e3);
		border-radius : 10px;
  		border-width: 0;
  		color:white;
	}
	.page_btn_present > a {
        border: 1px solid blue;
		color: blue;
	}
	.page_btn > a {
		color: purple;
	}
</style>
<title>Board List</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.12.2/xlsx.full.min.js"></script>
<script type="text/javascript">
 	$(function() {
 		let list = new Array();
 		<c:forEach var="list" items="${list}">
 			list.push(<c:out value="${list.bno}"/>);
 		</c:forEach>;
 		$.getJSON("/replies/cnt", {list : list}, function(data) {
 			let keys = Object.keys(data);
 			$(keys).each(function(i, bno){
 				let reply_cnt = data[bno];
 				let text = $("a[name = "+bno+"]").text().trim()+" ["+reply_cnt+"]";
 				$("a[name = "+bno+"]").text(text);
 			});
		});
 		
/*   		for(let i = 0; i < list.length; i++) {
 	  		$.getJSON("/board/getAttachList/"+list[i], function(data) {
 	  			console.log(data);
 	  			$(data).each(function(i, attach){
 	 	 			console.log(attach.bno+"-------------------------");
 	 	 			console.log(attach.uuid);
 	 	 			console.log(attach.uploadpath);
 	 	 			console.log(attach.filename);
 	 	 			let file_call_path = encodeURIComponent(attach.uploadpath + "\\s_"
 	 	 								+ attach.uuid + "_" + attach.filename);
 	 	 			let text = "<img src='/display?filename=" + file_call_path + "'/>";
 	 	 			//$("#"+attach.bno+"").append(text);
 	  			});
 			});
 		} */
 		
 		$("#write_bnt").on("click",function(e) {			
		}); // 댓글 개수 확인
 		
		history.replaceState({}, null, null);
		let rst = '<c:out value="${result}"/>';
		checkModal(rst);
		history.replaceState({}, null, null);
		function checkModal(rst) {
			if(rst == '' || history.state) {
				return
			}
			if(parseInt(rst) > 0) {
				rst = parseInt(rst) + "번 글이 등록되었습니다.";
			}
			else {
				rst = "처리 완료";
			}
			alert(rst);
		}
		
 		$("ul li a").on("click", function(e) {
			e.preventDefault();
			let newForm = $('<form></form>');
			newForm.attr("method","get");
			newForm.attr("action","/board/list");
			newForm.append("<input type='hidden' name='pageNum' value='"
							+$(this).attr("href")+"'>");
			newForm.append("<input type='hidden' name='amount' value='"
							+<c:out value="${pageDTO.criteria.amount}"/>+"'>");
			newForm.appendTo("body");
			newForm.submit();
		});
	});
</script>
</head>
<body>
<div class="list_body">
	<table>
		<tr>
			<th class="bno">번호</th>
			<th class="title">제목</th>
			<th class="writer">작성자</th>
			<th class="redate">게시일</th>
			<th class="updatedate">수정날짜</th>
		</tr>
		<c:forEach var="list" items="${list}">
			<tr>
				<td class="bno">
					<c:out value="${list.bno}" />
				</td>
				<td class="title" id="${list.bno}">
					<a name="<c:out value="${list.bno}"/>"
					href="/board/get?bno=${list.bno}&pageNum=${pageDTO.criteria.pageNum}&amount=${pageDTO.criteria.amount}">
					<c:out value="${list.title}" /></a>
				</td>
				<td class="writer">
					<c:out value="${list.writer}" />
				</td>
				<td class="redate">
					<fmt:formatDate pattern="YY-MM-dd hh:mm" value="${list.redate}" />
				</td>
				<td class="updatedate">
					<fmt:formatDate pattern="YY-MM-dd hh:mm" value="${list.updatedate}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<ul id="page_btn">
		<c:if test="${pageDTO.prev}">
			<li class="page_prev_btn">
				<a href="${pageDTO.startPage-1}">Prev</a>
			</li>
		</c:if>
		<c:forEach  var="i" begin="${pageDTO.startPage}" end="${pageDTO.endPage}">
			<c:choose>
				<c:when test="${pageDTO.criteria.pageNum eq i}">
					<li class="page_btn_present">
						<a href="${i}"><c:out value="${i}" /></a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page_btn">
						<a href="${i}"><c:out value="${i}" /></a>
					</li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${pageDTO.next}">
			<li class="page_next_btn">
				<a href="${pageDTO.endPage+1}">Next</a>
			</li>
		</c:if>
	</ul>
	<div class="write">
		<a id="write_bnt" href="/board/register">글쓰기</a>
	</div>
</div>
	
</body>
    	<%@include file="../includes/footer.jsp" %>
</html>