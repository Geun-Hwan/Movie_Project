<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../layout/admin_header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link href="css/bootstrap.css" rel="stylesheet" />
<link rel="stylesheet" href="css/loading.css">
<link rel="stylesheet" href="css/module.css">
<meta charset="UTF-8">
<title>영화 수정 페이지</title>
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
<!-- 영화 리스트 출력(이미지,제목같이 간단한 정보) 하고 영화 선택시 code값 가지고 movieUpdate  -->
<div style="width: 1200px; margin: 0 auto;">
	<div style="padding-top: 25px; padding-left: 25px; display: flex; flex-direction: row;">
			<h3>영화 수정</h3>
			<b style="padding-left:10px; padding-top:15px;">수정할 영화를 클릭하세요</b>
		</div>
		<hr color="black">
<div style="width: 1200px; margin: 0 auto;">
		<c:forEach var="mcount" begin="0" end="${count/4}" varStatus="status">
			<c:choose>
				<c:when test="${status.last}">
					<ol style="display: flex; flex-direction: row;">
						<c:forEach var="movie" items="${list}" begin="${4*mcount+0}"
							end="${count}">
							<li
								style="list-style-type: none; padding-left: 40px; padding-right: 40px;">
								<div class="box-image" style="width: 200px; height: 300px;">
								<a href="movieUpdate?code=${movie.code}">
									<span class="thumb-image"> <img src="${movie.poster}"
										alt="${movie.title} 포스터" onerror="errorImage(this)"
										style="width: 200px; height: 300px;" />
									</span>
								</a>
								</div>
								<div class="box-contents"
									style="width: 200px; padding-top: 10px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden;">
									<div style="height: 50px;">
										<a href="movieUpdate?code=${movie.code}"> <strong
											class="title">${movie.title}</strong>
										</a>
									</div>
								</div>
							</li>
						</c:forEach>
					</ol>
				</c:when>
				<c:otherwise>
					<ol style="display: flex; flex-direction: row;">
						<c:forEach var="movie" items="${list}" begin="${4*mcount+0}"
							end="${3+mcount*4}">
							<li
								style="list-style-type: none; padding-left: 40px; padding-right: 40px;">
								<div class="box-image" style="width: 200px; height: 300px;">
								<a href="movieUpdate?code=${movie.code}">
									<span class="thumb-image"> <img src="${movie.poster}"
										alt="${movie.title} 포스터" onerror="errorImage(this)"
										style="width: 200px; height: 300px;" />
									</span>
								</a>
								</div>
								<div class="box-contents"
									style="width: 200px; padding-top: 10px; text-overflow:ellipsis;white-space:nowrap;overflow:hidden;">
									<div style="height: 50px;">
										<a href="movieUpdate?code=${movie.code}"> <strong
											class="title">${movie.title}</strong>
										</a>
									</div>
								</div>
							</li>
						</c:forEach>
					</ol>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</div>
</div>
<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/popper.js"></script>
	​<script src="js/movieSearch.js"></script>
	<%@ include file="../../layout/footer.jsp"%>
</body>
</html>