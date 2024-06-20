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
		height : 250px;
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
	$(function() {
		$(".modify_btn").on("click", function(e) {
			e.preventDefault();
			if($("#user_pw").val() == $("#user_pw_check").val()){
				$("#modify_form").submit();
			}
			else {
				alert("비밀번호가 일치하지 않습니다.");
			}
		})
		$(".member_remove").on("click", function() {
			alert("삭제완료");
			$("#modify_form").attr("action", "/member/remove");
			$("#modify_form").submit();
		});
	})
</script>
</head>
<body>
<div class="mypage_body">
	<div class="member_tag">
		<form id="modify_form" action="/member/mypage" method="post">
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
					<select name="location" id="location" name="location">
						<option value="-선택-" selected>-선택-</option>
						<option value="서울">서울</option>
						<option value="부산">부산</option>
						<option value="대구">대구</option>
						<option value="인천">인천</option>
						<option value="광주">광주</option>
						<option value="대전">대전</option>
						<option value="울산">울산</option>
						<option value="경기">경기</option>
						<option value="강원">강원</option>
						<option value="충북">충북</option>
						<option value="충남">충남</option>
						<option value="전북">전북</option>
						<option value="전남">전남</option>
						<option value="경북">경북</option>
						<option value="경남">경남</option>
						<option value="제주">제주</option>
					</select>
				</div>
				<div>
					<button class="modify_btn">회원정보 수정</button>
				</div>
			</div>
		</form>
<!-- 		<div>
			<a href="" class="empty">활동 기록</a>
		</div> -->
		<div>
			<button class="member_remove">회원 탈퇴</button>
		</div>
	</div>
</div>
</body>
    	<%@include file="../includes/footer.jsp" %>
</html>