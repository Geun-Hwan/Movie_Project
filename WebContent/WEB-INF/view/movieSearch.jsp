<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="css/bootstrap.css" rel="stylesheet" />
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/module.css">
<link rel="stylesheet" href="css/loading.css">
<link rel="stylesheet" href="css/content.css">
<title>영화 검색</title>
</head>
<body>
<c:choose>
		<c:when test="${userid!=null&&admin==1}">
			<%@ include file="../layout/admin_header.jsp"%>
		</c:when>
		<c:otherwise>
			<%@ include file="../layout/header.jsp"%>
		</c:otherwise>
</c:choose>
<div style="width:1200px; margin:0 auto;">
        <div style="padding-top:25px; padding-left:25px;">
            <h3>영화 검색결과 ${searchCount}건</h3> <!-- 검색 단어를 포함하고 있는 영화 갯수 -->
            <hr color="black">
            <!-- 검색된 영화 클릭시 해당 정보 +movie search 쿼리문 추가, controller 추가-->
            <c:forEach var="mcount" begin="0" end="${searchCount/4}" varStatus="status">
		<c:choose>
			<c:when test="${status.last}">
			<ol style="display:flex; flex-direction:row;">
            	<c:forEach var="movie" items="${searchMovie}" begin="${4*mcount+0}" end="${searchCount}">
            
            	<li style="list-style-type:none; padding-left:40px;padding-right:40px;">
            	<strong class="rank"></strong>
					<div class="box-image" style="width:200px;height:300px; position:relative">
						<div class="thumb-image">
						<a href="movieInfo?code=${movie.code}" onclick="$('.wrap-loading').removeClass('display-none');"> 
						<img src="${movie.poster}" alt="${movie.title} 포스터" onerror="errorImage(this)" style="width:200px;height:300px;"/>
						</a> 						
						</div>					 
						<div class="movieAgeLimit_wrap">
						<c:if test="${movie.grade eq '15세 이상'}">
						<img src="images/grade-15.png" style="width:24px; height:24px; right:6px; top:7px; position:absolute;">
						</c:if>
						<c:if test="${movie.grade eq '12세 이상'}">
						<img src="images/grade-12.png" style="width:24px; height:24px; right:6px; top:7px; position:absolute;">
						</c:if>
						<c:if test="${movie.grade eq '전체'}">
						<img src="images/grade-all.png" style="width:24px; height:24px; right:6px; top:7px; position:absolute;">
						</c:if>
						<c:if test="${movie.grade eq '청소년 관람불가'}">
						<img src="images/grade-19.png" style="width:24px; height:24px; right:6px; top:7px; position:absolute;">
						</c:if>
						</div>
					</div>
					<div class="box-contents" style="width:200px; padding-top:10px;">
						<div style="height:30px;">
						<a href="movieInfo?code=${movie.code}" onclick="$('.wrap-loading').removeClass('display-none');"> <strong
							class="title" >${movie.title}</strong>
						</a>
						</div>
						<div class="score">
							<strong class="percent">예매율<span>${movie.percent}%</span></strong>
						</div>

						<span class="txt-info"> <strong> ${movie.releaseDate}<span>개봉</span>

						</strong>
						<a style="float:right;"href="movieTicket?code=${movie.code}" onclick="$('.wrap-loading').removeClass('display-none');">예매하기</a>
						</span> 
					</div>
					</li>
				</c:forEach>
			</ol>
            </c:when>
            <c:otherwise>
	            <ol style="display:flex; flex-direction:row;">
	            <c:forEach var="movie" items="${searchMovie}" begin="${4*mcount+0}" end="${3+mcount*4}">
	            <li style="list-style-type:none; padding-left:40px;padding-right:40px;">
            	<strong class="rank"></strong>
					<div class="box-image" style="width:200px;height:300px; position:relative">
						<div class="thumb-image">
						<a href="movieInfo?code=${movie.code}" onclick="$('.wrap-loading').removeClass('display-none');"> 
						<img src="${movie.poster}" alt="${movie.title} 포스터" onerror="errorImage(this)" style="width:200px;height:300px;"/>
						</a> 						
						</div>					 
						<div class="movieAgeLimit_wrap">
						<c:if test="${movie.grade eq '15세 이상'}">
						<img src="images/grade-15.png" style="width:24px; height:24px; right:6px; top:7px; position:absolute;">
						</c:if>
						<c:if test="${movie.grade eq '12세 이상'}">
						<img src="images/grade-12.png" style="width:24px; height:24px; right:6px; top:7px; position:absolute;">
						</c:if>
						<c:if test="${movie.grade eq '전체'}">
						<img src="images/grade-all.png" style="width:24px; height:24px; right:6px; top:7px; position:absolute;">
						</c:if>
						<c:if test="${movie.grade eq '청소년 관람불가'}">
						<img src="images/grade-19.png" style="width:24px; height:24px; right:6px; top:7px; position:absolute;">
						</c:if>
						</div>
					</div>
					<div class="box-contents" style="width:200px; padding-top:10px;">
						<div style="height:30px;">
						<a href="movieInfo?code=${movie.code}" onclick="$('.wrap-loading').removeClass('display-none');"> <strong
							class="title" >${movie.title}</strong>
						</a>
						</div>
						<div class="score">
							<strong class="percent">예매율<span>${movie.percent}%</span></strong>
						</div>

						<span class="txt-info"> <strong> ${movie.releaseDate}<span>개봉</span>

						</strong>
						<a style="float:right;"href="movieTicket?code=${movie.code}" onclick="$('.wrap-loading').removeClass('display-none');">예매하기</a>
						</span> 
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
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>