<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
				<div class="jumbotron">
					<h2>공지사항</h2>

					<input type="button" value="메인으로" onclick="location.href='main'">
					<c:if test="${admin=='1'}"><input type="button" value="글쓰기" onclick="location.href='noticeWrite'"></c:if>

					<!-- 테이블 시작 -->
					<table class="table table-hover">

						<thead>
							<tr>
								<th width="50" scope="col" class="text-center">번호</th>
								<th width="350" scope="col" class="text-center">제목</th>
								<th width="100" scope="col" class="text-center">글쓴이</th>
								<th width="150" scope="col" class="text-center">작성일</th>
								<th width="80" scope="col" class="text-center">조회수</th>
							</tr>
						</thead>
						<fmt:parseNumber var="number" integerOnly="true" value="${totalData -(currentPage-1)*10 }"/>
						<c:forEach var="notice" items="${noticeList}">
						<tr height="40">
							<td width="50" align="center">${number}</td>
							<td width="320" align="left">
								<a href="noticeInfo?num=${notice.num}" style="text-decoration: none">${notice.title}</a>
							</td>
							<td width="100" align="center">${notice.userid}</td>
							<td width="150" align="center">${notice.reg_date}</td>
							<td width="80" align="center">${notice.readCount}</td>
						</tr>
						<fmt:parseNumber var="number" integerOnly="true" value="${number -1}"/>
						</c:forEach>
					</table>
					<br> <br>
					<div style="text-align: center; padding-left: 40px; padding-top: 50px;"
			id="nopaging">
			<ul id="nopagingul"
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