<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%@include file="../includes/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	.wrapped_login {
		float: left;
		text-align: center;
		width : 100%;
		height : 250px;
	}
	}
	.login {
		font-size: 30px;
		color: #02343F;
		margin-bottom: 20px;
	}
	.input {
		text-align: center;
		height : 50px;
		width : 100%;
	}
	input {
		width : 200px;
		border-radius : 5px;
		border-style : solid;
		border-width : 1px;
		border-color : black;
	}
</style>
<title>Login</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.12.2/xlsx.full.min.js"></script>
<script type="text/javascript">
	$(function() {
		let error = "${error}";
		if(error == "등록되지 않은 ID 입니다.") {
			$("user_id").focus();
		}
		else if(error == "비밀번호가 틀렸습니다.") {
			$("user_pw").focus();
		}
	});
</script>
</head>
<body>
	<div class="wrapped_login">
		<form action="/member/login" class="login_form" method="post">
			<div  class="login">
				<span>ID Login</span>
			</div>
			<div class="input">
				<input type="email" class="id_controll" name="user_id" id="user_id"
				placeholder="id를 입력하시오" value="${vo.user_id}">
				<div class="error" id="error_user_id">
					<c:if test="${error eq 'id'}">
						<c:out value="등록되지 않은 ID 입니다." />
					</c:if>
				</div>
			</div>
			<div class="input">
				<input type="password" class="pw_controll" name="user_pw" id="user_pw"
				placeholder="pw를 입력하시오" value="${vo.user_pw}">
				<div class="error" id="error_user_pw">
					<c:if test="${error eq 'pw'}">
						<c:out value="비밀번호가 틀렸습니다." />
					</c:if>
				</div>
			</div>
			<div class="form_login_button">
				<button class="login_button" type="submit">
					Login				
				</button>
			</div>
		</form>
	</div>
</body>
	<%@include file="../includes/footer.jsp" %>
</html>