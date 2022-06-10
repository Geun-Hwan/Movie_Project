<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<body>
	<!-- 회원수정 페이지 보이기 전에 비밀번호 입력받고 맞으면 띄워주기 -->
		<div class="container-fluid" style="width: 900px;">
			<h2 class="mb-5" style="text-align:center;">회원 정보 수정</h2>
			<p style="text-align:center; padding-bottom:10px;"><b>회 원 수 정</b></p>  
			<div style="text-align:center;">
				<form style="text-aiign:center; width:435px; margin:0 auto;" id="changeForm" action="memberUpdate.do" method="post">
					<table>
						<tr>
							<th width="110px">이름</th><td><input style="width:300px;"class="form-control" type="text" name="changeName" value="${member.name}" id="changeName"></td>
						</tr>
						<tr>
							<th>이메일</th><td><input style="width:300px;"class="form-control" type="email" name="changeEmail" readonly value="${member.email}"></td>
						</tr>
						
						<tr>
							<th>아이디</th><td><input style="width:300px;" class="form-control"  type="text" name="uid" readonly value="${member.userId}"></td>
						</tr>
						
						<tr>
							<th>비밀번호 변경</th><td><input style="width:300px;" class="form-control" type="password" name="changePass" id="changePass" placeholder="비밀번호 변경시에만 입력."> <input type="hidden" name="userpass" value="${member.userPwd}"></td>
						</tr>
						<tr>
							<th>비밀번호 확인</th><td><input style="width:300px;" class="form-control" type="password" name="changePass2" id="changePass2"></td>
						</tr>
						<tr><td colspan="2" id="passcheck"></td></tr>
						<tr>
						<th>생년월일</th><td><input type="date" class="form-control" name="birth"  min="1900-01-01" max="2021-12-31" id="birth" value="${member.birth}"></td>
						</tr>
						<tr style="height:40px;">
							<th>성별</th><td>남<input type="radio" name="changeGender" value="남" checked="checked">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;여<input type="radio" name="changeGender" value="여"></td>
						</tr>
						<tr style="height: 60px;">
						<td><a style="color:gray;font-size:12px;" href="#" onclick="selfDeleteMember()">탈퇴하기</a></td>
						<td style="text-align:right;"><button class="btn btn-secondary"type="button" onclick="changeInfo()">수정하기</button></td>
						</tr>
					</table>
				</form>
				<!-- 성별,생일 이름,비밀번호 변경 가능 -->
			</div>
		</div>
<script type="text/javascript">
	$(function() {
		
		$("input").keyup(function() {
			var pwd1 = $("#changePass").val();
			var pwd2 = $("#changePass2").val();
			if(pwd1 != "" || pwd2 != ""){
				$("#passcheck").text("");
			}
			if (pwd1 != "" || pwd2 != "") {
				if (regPwd.test(pwd1)&&(pwd1 == pwd2)) {
					$("#passcheck").text("비밀번호가 일치합니다.");
					$("#passcheck").css("fontSize",12);
					$("#passcheck").css("color","green");
					pcheck=true
					
				} else {
					$("#passcheck").text("비밀번호가 일치하지 않습니다.");
					$("#passcheck").css("fontSize",12);
					$("#passcheck").css("color","red");
					pcheck =false
				}
			}
			if((pwd1=="" && pwd2=="")){
				$("#passcheck").text("");
				$("#passcheck").css("fontSize",12);
				$("#passcheck").css("color","red");
				pcheck =true
			}
			if((!regPwd.test(pwd1))&& pwd1!=""){
				$("#passcheck").text("비밀번호는 6~15자 사이 영어와 숫자로 입력해주세요.");
				$("#passcheck").css("fontSize",12);
				$("#passcheck").css("color","red");
				pcheck=false
			}
		});
	});
</script>
<%@ include file="../layout/footer.jsp"%>
</body>
