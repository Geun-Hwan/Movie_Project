<%@page import="model.Ticket"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.TicketDAO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<body>

<div class="container-fluid" style="width: 900px;" id="myContent">
	<h2 class="mb-5" style="text-align:center;">전체 예매 내역</h2>
					<c:choose>
					<c:when test="${fn:length(tlist)==0}">
					<div style="text-align:center; font-size:30px; padding-top:30px;">예약한 영화가 없습니다</div>
					</c:when>
					<c:otherwise>
					<div class="movie-reserve-list">
					<c:forEach items="${tlist}" var="ticket" varStatus="status">
										
					<div class="movie-reserve">
						<div class="movie-reserve-age"><a href="#!"onclick="deleteTicket('${status.index}')"><span style="float:left;">예매취소</span></a>${ticket.movieAge}</div>
						<div class="movie-reserve-title" id="dtitle${status.index}"style="text-overflow:ellipsis;white-space:nowrap;overflow: hidden;">${ticket.title}</div>
						<div class="movie-reserve-theater-wrapper">
							<div id="dcinema${status.index}">${ticket.cinema}</div>
							<input type="hidden" id="duserid${status.index}" value="${ticket.userid}">
							&nbsp;/&nbsp;
							<div class="ticket-numeber">${ticket.person}장</div>
						</div>
						<div class="movie-reserve-seats" id="dseat${status.index}">${ticket.seat}</div>
						<div class="movie-reserve-date-wrapper">
							<div class="movie-reserve-date" id="ddate${status.index}">${ticket.movieDate}</div>
							<div class="movie-reserve-runningTime" id="dtime${status.index}">${ticket.movieTime}</div>
						</div>
						<div class="movie"></div>

						<div class="pay-information-wrapper">
							<div class="pay-information-date-wrapper">
								<div class="pay-information-date-title">결제한 날</div>
								<div class="pay-information-date">${ticket.ticketDate}</div>
							</div>

							<div class="pay-information-money-wrapper">
								<div class="pay-information-money-title">결제한 비용</div>
								<div class="pay-information-money">${ticket.price}원</div>
							</div>

							<div class="barcode-wrapper">
								<div>EZV</div>
								<img src="images/barcode.png">
							</div>

						</div>
					</div>
					</c:forEach>
					</div>
					</c:otherwise>
					</c:choose>
		<div
			style="text-align: center; width: 816px; padding-left: 40px; padding-top: 20px;"
			id="tpaging">
			<ul id="tpagingul"
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
