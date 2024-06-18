<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@include file="./includes/header.jsp" %>
<link rel="stylesheet" href="resources/css/header.css">
<html>
<head>
	<title>Home</title>
</head>
<meta charset="UTF-8">
<style>
	.home_div {
		float: left;
		text-align: center;
		color: #50586C;
		width: 100%;
		height: 200px;
	}
	.image_div > div {
		float: center;
    	text-align: center;
		width: 50px;
		height: 50px;
	}
	.image_div > img{
		float: center;
		width: 50px;
		height: 50px;
	}
</style>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.12.2/xlsx.full.min.js"></script>
<body>
<div class="home_div">
	<h1>
		WELCOME TO <c:if test="${not empty auth}">
		<c:out value="${auth.user_name}'s" /></c:if> VISIT!
	</h1>
	<P>  The time on the server is ${serverTime}. </P>
	<c:if test="${imageList ne null}">
		<div class="image_div">
			<c:forEach var="list" items="${imageList}">
				<img id="${list.title}" src="${list.src}">
			</c:forEach>
		</div>
	</c:if>
</div>
</body>
    	<%@include file="./includes/footer.jsp" %>
</html>
