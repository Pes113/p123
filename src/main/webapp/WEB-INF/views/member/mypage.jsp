<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%@include file="../includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
<style>
	.mypage_body {
		padding-top : 160px;
		width : 100%;
		height : 400px;
	}
	.member_modify > div {
		text-align: center;
		width : 300px;
		height: 30px;
		margin : auto;
	}
	input {
		width : 80%;
		border-radius : 5px;
		border-style : solid;
		border-width : 1px;
		border-color : black;
		text-decoration: none;
	}
	.mypage_body > div {
		text-align: center;
		width : 300px;
		height: 30px;
		margin : auto;
	}
	.member_tag > div{
		text-align: center;
		width : 500px;
		height : 30px;
	}

</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.12.2/xlsx.full.min.js"></script>
<script type="text/javascript">
</script>
</head>
<body>
<div class="mypage_body">
	<div class="member_tag">
		<form action="/member/signup" method="post">
			<div class="member_modify">
				<div>
					<input name="user_name" id="user_name" type="text" placeholder="수정할 이름을 입력하시오."/>
				</div>
				<div>
					<input name="user_pw" id="user_pw" type="password" placeholder="수정할 비밀번호를 입력하시오."/>
				</div>
				<div>
					<input id="user_pw_check" type="password" placeholder="수정할 비밀번호를 다시 입력하시오."/>
				</div>
				<div>
					<button class="member_modify">회원정보 수정</button>
				</div>
			</div>
		</form>
		<div>
			<a href="" class="member_remove">활동 기록</a>
		</div>
		<div>
			<button class="member_remove">회원 탈퇴</button>
		</div>
	</div>
</div>
</body>
    	<%@include file="../includes/footer.jsp" %>
</html>