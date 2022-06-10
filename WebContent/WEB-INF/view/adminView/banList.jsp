<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container-fluid" style="width: 1200px; padding-top: 40px;" id="adminContent">
			<h2 class="mb-5" style="text-align:center;">정지 내역</h2>
			<p style="text-align:center;">정지 회원 리스트</p>  
			<div style="text-align:center;">
			<table border=1 style="margin:0 auto; border:0.5px solid rgba(0,0,0,.2);">
			<tr style="text-align:center;">
			<th>회원 아이디</th><th>회원 이메일</th><th>회원 가입일</th><th>정지 해제일</th> <th colspan="2">관리</th>
			<c:forEach var="member" items="${banMember}" varStatus="status">
				<tr height=40>
					<td style="text-align:center;">${member.userId}</td>
					<td>${member.email}</td>
					<td style="text-align:center;">${member.reg_date}</td>
					<td>${member.ban_date}</td>
					<td><a class="list-group-item" href="#" data-target="#bandateChange" data-toggle="modal" onclick="banCheck('${member.userId}','${member.ban_date}')">정지기간 변경</a></td>
					<td><a class="list-group-item" onclick="if(!confirm('회원 정지를 해제 하시겠습니까?')){return false;}"
					href="memberPermit?userId=${member.userId }">즉시 해제</a></td>
				</tr>
			</c:forEach>
			</table>	
		</div>
</div>


<div class="modal fade" id="bandateChange" tabindex="-1" role="dialog" aria-hidden="true" style="height:600px;" data-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">정지 기간 변경</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="reviewUpdate" method="post" id="reviewChangeForm">
					<div class="form-group" style="margin:0 auto;display:flex; width:250px;">
							<label for="banuser" class="col-form-label">정지유저</label>
							<input type="text" class="form-control" id="banuser" name="banuserid" readonly style="width:150px; margin-left:20px;"/> 
					</div>
					<div class="form-group" style="margin:0 auto; height:100px; display:flex; width:250px; padding-top:30px;">
						<label for="ban_date" class="col-form-label">정지기간</label>
						<input type="date" class="form-control" id="ban_date" name="ban_date" style="width:150px; margin-left:20px;"/>
					</div>
					<div style="text-align:center; margin-bottom:30px;"><b>오늘 날짜 이후로 선택해주세요.</b></div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary" onclick="banDateChangeOk()">변경</button>
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>