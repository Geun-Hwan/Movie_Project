<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../layout/admin_header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link href="css/bootstrap.css" rel="stylesheet" />
<link rel="stylesheet" href="css/loading.css">
<meta charset="UTF-8">
<title>영화 삭제 페이지</title>
</head>
<body>
<c:choose>
	<c:when test="${userid==null||admin!=1}">
		<script type="text/javascript">
			alert("권한이 없습니다.");
			location.href="main";
		</script>
	</c:when>
</c:choose>
<!-- 영화 리스트 출력 + 삭제버튼  삭제버튼 클릭시  경고창 띄우고 확인시 
code값가지고 controller에서 삭제 처리-->

<div style="width: 1200px; margin: 0 auto;">
	<h1 align=center style="margin-top:10px;">영화 삭제</h1>
		<div
			style="padding-top: 25px; padding-left: 25px; display: flex; flex-direction: row;">
			<h3 align=center>삭제할 영화를 클릭하세요.</h3>
		</div>
		<hr color="black">
		<div style="width: 1200px; margin: 0 auto;">
			<h4 style="text-align:center; padding-top:10px; padding-bottom:10px;">영화 리스트</h4>
			<table border=1 style="margin:0 auto; border:1px solid gray;">
				<c:forEach var="movie" items="${list}" varStatus="status">
					<tr>
						<th width="100">${status.index+1}</th>
						<th>${movie.title}</th>
						<td><a onclick="if(!confirm('삭제 하시겠습니까?')){return false;}"
							href="movieDelete.do?code=${movie.code}">영화삭제</a></td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>

<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/popper.js"></script>
	​<script src="js/movieSearch.js"></script>
	<%@ include file="../../layout/footer.jsp"%>
</body>
</html>