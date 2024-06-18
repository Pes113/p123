<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/header.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title></title>
</head>
<body>
	<div id="header">
		<div class="header_name">
			<span>Spring project</span>
		</div>
		<nav>
			<a href="/board/list"><span class="menu_item">게시판</span></a>
			<a href="/member/example"><span class="menu_item">example</span></a>
			<c:choose>
				<c:when test="${not empty auth}">
					<a href="/member/logout"><span class="menu_item">로그아웃</span></a>
					<a href="/member/mypage"><span class="menu_item">마이페이지</span></a>
				</c:when>
				<c:otherwise>
					<a href="/member/login"><span class="menu_item">로그인</span></a>
					<a href="/member/signup"><span class="menu_item">회원가입</span></a>
				</c:otherwise>
			</c:choose>
		</nav>
	</div>
	<div class="user_name_div">
		<c:if test="${not empty auth}">
			<span class="user_name_text"><c:out value="${auth.user_name}님이 접속중입니다." /></span>
		</c:if>
	</div>
</body>
</html>