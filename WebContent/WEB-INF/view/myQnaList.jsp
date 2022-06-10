<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<div class="container-fluid" style="width: 1000px;" id="myContent">
			<h2 class="mb-5" style="text-align:center;">작성한 문의</h2>
			<p style="text-align:center;">문의 내역</p>  
			<div style="text-align:center;">
			<table border=1 style="margin:0 auto; border:0.5px solid rgba(0,0,0,.2);">
			<tr style="text-align:center;"><th width="160px">작성일</th><th width="600">제목</th><th>문의유형</th><th>답변 확인</th></tr>
			<c:forEach var="qna" items="${qlist}" varStatus="status">
				<tr height=40>
					<td style="text-align:center;">${qna.write_date}</td>
					<td style="text-align:left;"><a href="#" onclick="qnaInfo('${qna.num}')" data-target="#qnaInfo" data-toggle="modal">${qna.qna_title}</a></td>
					<td style="text-align:center;">${qna.category}</td>
					<td style="text-align:center;"><c:if test="${qna.answer == null}">미답변</c:if>
													<c:if test="${qna.answer != null}">답변완료</c:if>
													
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
	
