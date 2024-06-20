<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
	<%@include file="../includes/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<style>
	#body {
		text-align: center;
		width : 100%;
		height : 400px;
	}
	#signup_form_div > div{
		text-align: center;
		width : 300px;
		height: 30px;
		margin : auto;
	}
	#first_number {
		width : 20%;
		text-align: center;
	}
	#middle_number {
		width : 20%;
		text-align: center;
	}
	#last_number {
		width : 20%;
		text-align: center;
	}
	#gender_man {
		width : 10px;
	}
	#gender_woman {
		width : 10px;
	}
	#signup_body {
		padding-top : 160px;
		width:100%;
	}
	input {
		width : 80%;
		border-radius : 5px;
		border-style : solid;
		border-width : 1px;
		border-color : black;
		text-decoration: none;
	}
	.body > span {
		color : gray;
	}
</style>
<script src="/resources/js/timer.js" defer></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.12.2/xlsx.full.min.js"></script>
<script>
	$(function() {
 		let timer = new Timer();
		$("#check_number_post").on("click", function(e){
			timer.getToken($("#check_number"), $("#check_number_post"),
							$("#check_complete"), $("#check_timer"));
		});
		$("#check_complete").on("click", function(e){
			timer.getTimerIntervalConfirm($("#check_complete"), $("#sign"));
		});
		
		let first;
		let middle;
		let last;
		//let timer;
		let phone_number;
		$('#first_number').keyup(function() {	// 휴대폰 첫자리는 입력 or 010 자동입력
			first = $('#first_number').val().length;
			if(first === 3) {
				$("#middle_number").focus();
				if(middle == 4 && last == 4) {
					$("#check_number_post").attr("disabled", false);
				}
			}
			else{
				$("#check_number_post").attr("disabled", true);
			}
		});
		$('#middle_number').keyup(function() {	// 2번째 4자리 입력 확인
			middle = $('#middle_number').val().length;
			if(middle === 4) {
				$("#last_number").focus();
				if(last == 4) {
					$("#check_number_post").attr("disabled", false);
				}
			}
			else{
				$("#check_number_post").attr("disabled", true);
			}
		});
		$('#last_number').keyup(function() {	// 3번째 4자리 입력 확인
			last = $('#last_number').val().length;
			if(last == 4) {
				$("#check_number_post").focus();
				if(middle == 4) {
					$("#check_number_post").attr("disabled", false);
				}
			}
			else{
				$("#check_number_post").attr("disabled", true);
			}
		});
		
 		/* $("#check_number_post").on("click", function() {		//휴대폰 인증
			if($("#first_number").val() == "") {
				phone_number = "010"+ $("#middle_number").val()+""+$("#last_number").val();
			}
			else {
				phone_number = $("#first_number").val()+""+ $("#middle_number").val()+""+$("#last_number").val();
			}
			let min = 3;
			let sec = 0;
			$("#check_complete").attr("disabled", false);
			let random_number = Math.floor(Math.random()*1000000);
			$("#check_number").text(random_number);
			$("#check_number_post").attr("disabled", true);
			timer = setInterval(function() {
				if(sec == 0) {
					min--;
					sec = 59;
				}
				else{
					sec--;
				}
				$("#check_timer").text(min+":"+sec);
				if(sec ==0 && min == 0) {
					clearInterval(timer);
				}
			}, 1000);
		});
		$("#check_complete").on("click", function() {		//휴대폰 인증 완료
			clearInterval(timer);
			$("#check_number_post").attr("disabled", true);
			$("#check_complete").attr("disabled", true);
			alert("인증 완료");
			$("#sign").attr("disabled", false);
		}); */
		
		$("#sign").on("click", function(e) {	// 빈칸이 있는지 확인
			e.preventDefault();
			if($("#user_pw").val() != $("#user_pw_check").val()) {
				alert("password not matched");
			}
			else if($("#user_name").val() == "" ) {
				alert("name null");
			}
			else if($("#user_pw").val() == "" ) {
				alert("pw null");
			}
			else if($("#location").val() == "-선택-" ) {
				alert("location null");
			}
			else if($("input[name='gender']").is(":checked") == false){
				alert("gender null");
			}
			else{
				if(isValid()) {
					$("form").submit();
				}
			}
		});
		
		function isValid() {		// 이메일 양식 확인
			var resExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z]*\.[a-zA-Z]{2,3})$/;
			var user_email = $("#user_id").val();
			if(resExp.test(user_email)) {
				return true;
			}
			else {
				alert("이메일 양식 확인");
				return false;
			}
		}
	});
</script>
<title>Sign Up</title>
</head>
<body>
<div id="signup_body">
	<form action="/member/signup" method="post">
	<div id="signup_form_div">
		<div>
			<input name="user_id" id="user_id" type="text" placeholder="이메일을 입력하시오."/>
		</div>
		<div>
			<input name="user_name" id="user_name" type="text" placeholder="이름을 입력하시오."/>
		</div>
		<div>
			<input name="user_pw" id="user_pw" type="password" placeholder="비밀번호를 입력하시오."/>
		</div>
		<div>
			<input id="user_pw_check" type="password" placeholder="비밀번호를 다시 입력하시오."/>
		</div>
		<div>
			<input id="first_number" type="text" placeholder="010"/> - <input id="middle_number" type="text" /> - <input id="last_number" type="text" />
			<input id="phone_number" type="hidden" />
		</div>
		<div>
			<span id="check_number">000000</span>
			<button type="button" id="check_number_post" disabled>인증번호 전송</button>
			<button id="check_number_re_post" hidden="true">인증번호 재전송</button>
		</div>
		<div>
			<span id="check_timer">3:00</span>
			<button type="button" id="check_complete" disabled>인증완료</button>
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
			<input type="radio" name="gender" id="gender_man" value="남성"/>남성
			<input type="radio" name="gender" id="gender_woman" value="여성"/>여성
		</div>
		<div>
			<button type="button" id="sign" disabled>가입하기</button>
		</div>
	</div>
	</form>
</div>
</body>
</html>
	<%@include file="../includes/footer.jsp" %>