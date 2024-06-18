<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%@include file="../includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Register</title>
<style>
	li {
		display: inline-block;
		list-style-type: none;
	}
	.writing {
		font-size: 30px;
		color: #02343F;
		margin-bottom: 20px;
        text-align: center;
	}
	.register_body {
		padding-top: 130px;
    	float: center;
	    margin: auto;
		width:500px;
    	border:solid 1px #DCE2F0;
	}
	.register_title {
		float:left;
	}
	.input_title {
		padding-left: 22px;
	}
	.input_title > input{
		width: 220px;
	}
	.register_user_id {
		float:left;
	}
	.register_content_textarea {
		width: 450px;
		height: 200px;
	}
	.register_content_div {
        text-align: center;
		width:100%;
    	float: center;
	}
	.register_submit > input {
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
	.register_submit {
		padding-bottom: 5px;
        text-align: center;
	}
	.article_bottom {
    	padding-left: 22px;
	}
	#pre_upload_img {
		width: 100px;
	}
</style>
<script>
	$(function() {
		$("#writing").on("click", function(e){	// hidden 태그를 이용해 input으로 이미지 정보 전달
			e.preventDefault();
			if(isValid()) {
				let form = $('.register_from');
				let str = "";
				$('.uploadResult ul li').each(function(i, listItem) {
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
				alert("글쓰기 완료");
	    	}
		});
		
		function isValid() {	// 빈 칸 확인
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
 					showUploadResult(result);
 					showImg(result);
 				}
 			});
 		});
 		
		$('.uploadResult').on("click", "ul li button", function() {
			let file = $(this).data('file');
			let type = $(this).data('type');
			let attach = {filename: file, type: type};
			let now = $(this);
  			$.ajax({
 				type: 'delete',
 				url: '/deleteFile',
 				processData: false,
 				data: JSON.stringify(attach),
 				contentType: "application/json; charset=utf-8",
 				success: function(result) {
 					alert(result);
 					now.parent().closest("li").remove();
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
 		
 		function showUploadResult(result) {
 			console.log("showUploadResult");
 		}
 		
 		function showImg(list) {
			let str = "";
 			for(let i = 0; i < list.length; i++) {
 				console.log(list[i].uploadpath);
 				console.log(list[i].uuid);
 				console.log(list[i].filename);
				let file_call_path = encodeURIComponent(list[i].uploadpath
						+ "\\s_" + list[i].uuid + "_" + list[i].filename);
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
			$('.uploadResult ul').append(str);
 			console.log(str);
		}
	});
</script>
</head>
<body>
<form name="frmlogin" method="post" encType="UTF-8" action="/board/list" class="register_from">
	<div class="register_body">
		<div class="writing">
			<span>글쓰기</span>
		</div>
		<div class="input_title">
			<input class="register_title" name="title" id="title" placeholder="제목">
		</div>
		<div class="input_title">
			<input class="register_user_id" id="writer" value="${auth.user_id}" disabled />
			<input type="hidden" name="writer" value="${auth.user_id}" />
		</div>
		<div class="register_content_div">
			<textarea class="register_content_textarea" name="content" rows="10" cols="65" maxlength="4000">
			</textarea>
		</div>
		<div class="article_bottom">
			<div class="filed1 get-th field-style">
				<label><b>첨부파일</b></label>
			</div>
			<div class="file2 get-th field-style">
				<input type="file" name="uploadFile" id="uploadFile" class="file_input" multiple/>
				<!-- 타입을 파일로 설정, multiple로 여러개 받기 가능 -->
			</div>
			<div class="uploadResult">
				<ul></ul>
			</div>
		</div>
		<div class="register_submit">
			<input id="writing" type="submit" value="글쓰기"/>
	        <input type="reset" value="다시입력">
		</div>
	</div>
</form>
</body>
	<%@include file="../includes/footer.jsp" %>
</html>