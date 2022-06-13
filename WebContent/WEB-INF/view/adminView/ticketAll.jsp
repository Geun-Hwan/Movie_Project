<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container-fluid" style="width: 1200px; padding-top: 40px;" id="adminContent">
			<h2 class="mb-5" style="text-align:center;">예매 내역</h2>
			<p style="text-align:center;">예매 리스트</p>  
			<div style="text-align:center;">
			<table border=1 style="margin:0 auto; border:0.5px solid rgba(0,0,0,.2);">
			<tr style="text-align:center;">
			<th width="100">예매날짜</th><th width="400">영화제목</th><th width="110">예매자</th><th width="160">극장/상영관</th><th>상영일</th><th width="70">상영시간</th><th width="40">인원</th><th width="80">금액</th><th>취소하기</th></tr>
			<c:forEach var="ticket" items="${ticketList}" varStatus="status">
				<tr height=40>
					<td style="text-align:center;">${ticket.ticketDate}</td>
					<td id="dtitle${status.index}">${ticket.title}</td>
					<td style="text-align:center;">${ticket.userid}</td>
					<td id="dcinema${status.index}">${ticket.cinema}</td>
					<td id="ddate${status.index}">${ticket.movieDate}</td>
					<td id="dtime${status.index}" style="text-align:center;">${ticket.movieTime}</td>
					<td style="text-align:center;">${ticket.person}</td>
					<td style="text-align:center;">${ticket.price}원</td>
					<td style="text-align:center;"><a href="#!"onclick="deleteTicket('${status.index}')">취소</a>
					<input type="hidden" id="duserid${status.index}" value="${ticket.userid}">
					<span style="display:none;"id="dseat${status.index}">${ticket.seat}</span>
					</td>
				</tr>
			</c:forEach>
			</table>	
			</div>
			
<div style="text-align: center; padding-left: 40px; padding-top: 50px;"
			id="tipaging">
			<ul id="tipagingul"
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
