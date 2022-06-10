<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container-fluid" style="width: 1200px; padding-top: 40px;" id="adminContent">
			<h2 class="mb-5" style="text-align:center;">문의 내역</h2>
			<p style="text-align:center;">문의 리스트</p>  
			<div style="text-align:center;">
			<table border=1 style="margin:0 auto; border:0.5px solid rgba(0,0,0,.2);">
			<tr style="text-align:center;"><th width="200px">문의날짜</th><th width="500">제목</th><th width="110">작성자</th><th width="110">답변확인</th><th style="text-align:center;"colspan="2">답변하기/문의삭제</th></tr>
			<c:forEach var="qna" items="${qnalist}" varStatus="status">
				<tr height=40>
					<td style="text-align:center;">${qna.write_date}</td>
					<td style="text-align:left;"><a href="#" onclick="qnaInfo('${qna.num}')" data-target="#qnaInfo" data-toggle="modal">${qna.qna_title}</a></td>
					<td style="text-align:center;"><a href="memberInfo?userid=${qna.userid}">${qna.userid}</a></td>
					
					<td style="text-align:center;"><c:if test="${qna.answer == null}">미답변</c:if>
													<c:if test="${qna.answer != null}">답변완료</c:if></td>
					<td style="width:100px; text-align:center;"><a href='#'data-toggle="modal"data-target="#" onclick="answerWrite('${qna.num}')">답변하기</a></td>
					<td style="width:100px; text-align:center;"><a href='#'onclick="deleteQna('${qna.num}')">문의삭제</a></td>
					
					<td>
					<input type="hidden" id ="qna_title${qna.num}" value="${qna.qna_title}">
													<input type="hidden" id ="qna_userid${qna.num}" value="${qna.userid}">
													<input type="hidden" id ="qna_write_date${qna.num}" value="${qna.write_date}">
													<input type="hidden" id ="qna_category${qna.num}" value="${qna.category}">
													<input type="hidden" id ="qna_content${qna.num}" value="${qna.qna_content}">
													<input type="hidden" id ="qna_fileName${qna.num}" value="${qna.fileName}">
													<input type="hidden" id ="qna_answer${qna.num}" value="${qna.answer}">
					</td>
				</tr>
			</c:forEach>
			</table>	
			</div>
</div>