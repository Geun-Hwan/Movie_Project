<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/admin_header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>회원 관리</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/star.css">
<link rel="stylesheet" href="css/loading.css">
</head>
<body>
<!-- 관리자만 가능 전체회원을 보여주는 페이지-->
<c:choose>
		<c:when test="${userid==null||admin!=1}">
		<script type="text/javascript">
			alert("권한이 없습니다.");
			location.href="main";
		</script>
	</c:when>
</c:choose>
<div style="width: 1200px; margin: 0 auto;">
		<div
			style="padding-top: 25px; padding-left: 25px; margin-bottom:30px;">
			<h3 align=center>회원 목록</h3>
		</div>
		<div style="width: 1200px; margin: 0 auto;">
			<table border=1 style="margin: 0 auto; border:1px solid gray;">
				<tr>
					<th width="110">회원 아이디</th>
					<th width="110">회원 이름</th>
					<th width="250">회원 이메일</th>
					<th width="110">회원 생일</th>
					<th width="75">회원 성별</th>
					<th style="text-align:center;" width="250">회원 가입일</th>
				</tr>
				<c:forEach var="member" items="${members}">
					<tr>
						<td><a href="memberInfo?userid=${member.userId}">${member.userId}</a></td>
						<td>${member.name}</td>
						<td>${member.email}</td>
						<td>${member.birth}</td>
						<td align="center">${member.gender}</td>
						<td align="center">${member.reg_date}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<c:if test="${fn:length(banmembers)!=0}">
		<hr color="black">
		<div
			style="padding-top: 25px; padding-left: 25px; margin-bottom:30px;">
			<h3 align=center>정지 회원</h3>
		</div>
		<div style="width: 1200px; margin: 0 auto;">
			<table border=1 style="margin: 0 auto; border:1px solid gray;">
				<tr>
					<th width="110">회원 아이디</th>
					<th width="110">회원 이름</th>
					<th width="250">회원 이메일</th>
					<th width="110">회원 생일</th>
					<th width="75">회원 성별</th>
					<th style="text-align:center;" width="250">정지 해제일</th>
				</tr>
				<c:forEach var="member" items="${banmembers}">
					<tr>
						<td><a href="memberInfo?userid=${member.userId}">${member.userId}</a></td>
						<td>${member.name}</td>
						<td>${member.email}</td>
						<td>${member.birth}</td>
						<td align="center">${member.gender}</td>
						<td align="center">${member.ban_date}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		</c:if>
	</div>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/popper.js"></script>
	​<script src="js/movieSearch.js"></script>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>