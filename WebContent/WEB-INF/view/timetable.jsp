<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div style='width: 300px; margin: 0 auto; margin-bottom: 30px; margin-top: 10px;'>
	<small class='cinema'><b>3층 5관</b></small>
	</div>
	
	<div class='time-list' style='width: 300px; margin: 0 auto;'>
	<c:forEach items="${remainSeat}" var="remain" varStatus="status">
	<div>
	<button class='time-select' type='button'>${10+(status.index*3)}:00</button>
	<c:if test="${120-remain ==120}">
	<span class='seatcount' style="color:green;">120석</span>
	</c:if>
	<c:if test="${120-remain !=120}">
	<span class='seatcount' style="color:red;">${120-remain}석</span>
	</c:if>
	</div>
	</c:forEach>
	</div>
	<div style='width: 300px; margin: 0 auto; margin-top:200px;'>
	<button style='float: right; height:60px; width:140px;' type='button' data-toggle='modal'
	onclick='ticketGo()'>예약하기</button>
	</div>