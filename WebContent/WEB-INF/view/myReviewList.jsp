<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<body>
	<!-- 회원수정 페이지 보이기 전에 비밀번호 입력받고 맞으면 띄워주기 -->
		<div class="container-fluid" style="width: 900px;" id="myContent">
			<h2 class="mb-5" style="text-align:center;">작성한 리뷰</h2>
			<p style="text-align:center;">리뷰 내역</p>  
			<div style="text-align:center;">
			<table border=1 style="margin:0 auto; border:0.5px solid rgba(0,0,0,.2);">
			<tr style="text-align:center;"><th width="120px">작성일</th><th width="400">제목</th><th>별점</th><th>추천수</th><th style="text-align:center;"colspan="3">관리</th></tr>
			<c:forEach var="review" items="${myReviewList}" varStatus="status">
				<tr height=40>
					<td style="text-align:center;">${review.write_date}</td>
					<td><c:if test="${review.changeCheck ==1}">[수정됨]</c:if>${review.title}</td>
					<td style="text-align:center;">${review.score}</td>
					<td style="text-align:center;">${review.commentlike}</td>
					<td style="width:120px; text-align:center;"><a href='#'data-toggle="modal"data-target="#reviewChange" onclick="myReviewChange(${status.index})">보기/수정</a></td>
					<td style="width:80px; text-align:center;"><a href='#' onclick="myReviewDelete(${status.index})">삭제</a>
					
					<input type="hidden" name="mycode" id="mycode${status.index}" value="${review.code}">
					<input type="hidden" name="myid" id="myid${status.index}" value="${review.userid}">
					<input type="hidden" name="myreview" id="myreview${status.index}" value="${review.content}">
					<input type="hidden" name="my_write_date" id="my_write_date${status.index}" value="${review.write_date}">
					<input type="hidden" name="my_title" id="my_title${status.index}" value="${review.title}">
					<input type="hidden" name="my_score" id="my_score${status.index}" value="${review.score}">
					</td>
				</tr>
			</c:forEach>
			</table>	
			</div>
		<!-- 페이징처리 클릭시 해당 부분 #myContent만 새로고침 반복횟수 10회.-->
		<div
			style="text-align: center; width: 816px; padding-left: 40px; padding-top: 20px;"
			id="paging">
			<ul id="pagingul"
				style='list-style-type: none; padding: 0px; margin: 0 auto;'>
				<c:if test="${prev >0}">
					<li><a href='#${prev}' id='${prev}'> 이전 </a></li>
				</c:if>

				<c:forEach var="i" begin="${first}" end="${last}">
					<c:choose>
						<c:when test="${currentPage==i}">
							<li class=on><a href='#${i}' id="${i}">${i}</a></li>
						</c:when>
						<c:otherwise>
							<li><a href='#${i}' id="${i}">${i}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<c:if test="${last<totalPage}">
					<li><a href='#${next}' id='${next}'> 다음 </a></li>
				</c:if>
			</ul>
		</div>
	</div>		
</body>
