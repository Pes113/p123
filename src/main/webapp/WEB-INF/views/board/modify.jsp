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
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.12.2/xlsx.full.min.js"></script>
<script type="text/javascript">
  	$(function() {

  		getAttachList(${board.bno});
  		
		$("#board_modify").on("click", function(e) {
			e.preventDefault();
			$("#operForm").attr("action", "/board/modify?pageNum=${criteria.pageNum}&amount=${criteria.amount}");
			if(isValid()) {
				let form = $('#operForm');
				let str = "";
				$('#attachedFile ul li').each(function(i, listItem) {
					let filename = $(listItem).data('filename');
					let uuid = $(listItem).data('uuid');
					let path = $(listItem).data('path');
					let type = $(listItem).data('type');
					str += "<input type='hidden' name='attachList[" + i + "].filename'  value='" + filename + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].uuid'  value='" + uuid + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].uploadpath'  value='" + path + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].filetype'  value='" + type + "'>";

				});
				form.append(str).submit();
	    	}
			alert("수정완료");
			$("#operForm").submit();
		});
		
		function isValid() {
			const title = $('#title').val();
			const content = $('#content').val();
			
			if(title === '') {
				$('#title').focus();
				alert('제목을 입력해주세요.');
				return false;
			} 
			
			if(content === '') {
				$('#content').focus();
				alert('내용을 입력해주세요.');
				return false;
			}
			return true;
		}
		
		$("#board_remove").on("click", function() {
			alert("삭제완료");
			$("#operForm").attr("action", "/board/remove?pageNum=${criteria.pageNum}&amount=${criteria.amount}");
			$("#operForm").submit();
		});
		$("#move_list").on("click", function() {
			location.href="/board/list?pageNum=${criteria.pageNum}&amount=${criteria.amount}";
		});

		$('#attachedFile').on("click", "ul li button", function() {
 			let file = $(this).data('file');
			let type = $(this).data('type');
			$(this).parent().closest("li").remove();
		});
		
		$("#uploadFile").on("change", function(e){
 			let formData = new FormData();
 			let inputFile = $("#uploadFile");
 			let files = inputFile[0].files;
 			for(let i = 0; i < files.length; i++) {
 				if(!checkExtension(files[i].name,files[i].size)) {
 	 				return false;
 	 			}
 	 			formData.append("uploadFile", files[i]);
 			}
 			console.log(formData);
 			$.ajax({
 				type:'post',
 				url:'/uploadFileAjax',
 				processData: false,
 				contentType: false,
 				data: formData,
 				success: function(result) {
 					console.log(result);
 					showImg(result);
 				}
 			});
 		});
		
		let regex = new RegExp("(.*)\.(exe|zip|alz)$");
 		let maxSize = 5*1024*1024;
 		function checkExtension(filename, fileSize) {
 			if(fileSize >= maxSize) {
 				alert("퍄일 사이즈 초과");
 				return false;
 			}
 			if(regex.test(filename)) {
 				alert("해당 종류의 파일은 업로드할 수 없습니다.");
 				return false;
 			}
 			return true;
 		}
 		
 		function showImg(list) {
			let str = "";
 			for(let i = 0; i < list.length; i++) {
 				console.log(list[i].uploadpath);
 				console.log(list[i].uuid);
 				console.log(list[i].filename);
				let file_call_path = encodeURIComponent(list[i].uploadpath + "\\s_" + list[i].uuid + "_" + list[i].filename);
 				if(list[i].image) {
		 			str += "<li id='pre_upload_img' data-path='" + list[i].uploadpath + "'";
					str += "	data-uuid='" + list[i].uuid + "' data-type ='" + list[i].image +"'";
					str += "	data-filename ='" + list[i].filename + "'>";
					str += "	<div>";
					str += "		<button type='button' data-file=\'"+ file_call_path +"\'";
					str += "			data-type='image'>X</button><br>";
					str += "		<span>"+list[i].filename+"</span>";
					str += "		<img src='/display?filename=" + file_call_path + "'/>"
				}
				else {
					str += "<li id='pre_upload_img' data-path='" + list[i].uploadpath + "'";
					str += "	data-uuid='" + list[i].uuid + "' data-type ='" + list[i].image +"'";
					str += "	data-filename ='" + list[i].filename + "'>";
					str += "	<div>";
					str += "		<button type='button' data-file=\'"+ file_call_path +"\'";
					str += "			data-type='image'>X</button><br>";
					str += "		<span>"+list[i].filename+"</span>";
					str += "	<img src='/resources/img/icon.jpg'/>"
				}
				str += "	</div>";
				str += "</li>";
			}
			$('#attachedFile ul').append(str);
 			console.log(str);
		}
 		
		function getAttachList(bno){
			$.getJSON("/board/getAttachList/" + bno, function(data) {
				console.log(data);
				let str="";
				for(let i = 0; i<data.length; i++) {
					let file_call_path = encodeURIComponent(data[i].uploadpath + "\\s_" + data[i].uuid + "_" + data[i].filename);
					if(data[i].filetype){
						str += "<li data-path='" + data[i].uploadpath + "' data-uuid = '" + data[i].uuid + "'";
						str += "	data-filename = '" + data[i].filename + "' data-type = '" + data[i].filetype + "'>";
						str += "	<div>";
						str += "		<button type='button' data-file=\'"+ file_call_path +"\'";
						str += "			data-type='image'>X</button><br>";
						str += "		<span>" + data[i].filename + "</span>";
						str += "		<img src='/display?filename=" + file_call_path + "'/>";
						str += "	</div>";
						str += "</li>";
					}
					else {
						str += "<li data-path='" + data[i].uploadpath + "' data-uuid = '" + data[i].uuid + "'";
						str += "	data-filename = '" + data[i].filename + "' data-type = '" + data[i].filetype + "'>";
						str += "	<div>";
						str += "		<button type='button' data-file=\'"+ file_call_path +"\'";
						str += "			data-type='image'>X</button><br>";
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
<title>Board Modify</title>
</head>
<body>
	<div class="get_body">
		<form id="operForm" method="post">
			<div class="get_title">
				<input id="title" name="title" value="<c:out value="${board.title}" />" />
			</div>
			<div class="get_writer">
				<span><c:out value="${board.writer}" /> | <fmt:formatDate pattern="MM-dd" value="${board.updatedate}" />
				</span>
			</div>
			<div class="get_content_div">
				<textarea class="get_content_textarea" id="content" name="content" rows="10" cols="65" maxlength="4000">
				<c:out value="${board.content}" /></textarea>
			</div>
			<input type="hidden" id="bno" name="bno" value="<c:out value="${board.bno}"/>">
		</form>
		<div class="article_bottom">
			<div class="filed1 get-th field-style">
				<label><b>추가파일</b></label>
			</div>
			<div class="file2 get-th field-style">
				<input type="file" name="uploadFile" id="uploadFile" class="file_input" multiple/>
			</div>
			<div id="attachedFile">
				<ul></ul>
			</div>
		</div>
		<div class="get_submit">
			<input class="read" id="move_list" value="목록"/>
	        <input class="read" id="board_modify" value="수정"/>
	        <input class="read" id="board_remove" value="삭제"/>
		</div>
	</div>
</body>
    	<%@include file="../includes/footer.jsp" %>
</html>