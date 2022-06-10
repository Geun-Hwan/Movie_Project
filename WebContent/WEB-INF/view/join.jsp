<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/loading.css">
</head>
<body>
<c:choose>
		<c:when test="${userid!=null&&admin==1}">
			<script type="text/javascript">
				location.href="adminMain";
			</script>
		</c:when>
</c:choose>
<div class="container" style="margin:0 auto; width:400px; padding-top:20px; border:2px solid gray; border-radius:9px; margin-top:20px;">
	<h2 align="center" style="padding-bottom:20px;">Join us</h2>
	<form action="join.do" method="post" name="frm" id="joinform">
			<div class="form-group" >
				<label for="userid" style="padding-right:10px;">아이디</label>
				<div class="form-group" style="display:flex; flex-direction:row; justify-content:space-between;padding-bottom:0;" >
					<input type="text" class="form-control" name="userid" id="userid" placeholder="Enter ID" style="width:250px;">
					<input type="hidden" name="reid" id="reid"size="20">
					<button id="idconfirmbtn" class="btn btn-secondary" type="button" onclick="idCheck()" >중복확인</button>
				</div>
				<span id="idcheck" style="font-size:12px; padding-top:0;" class="form-text text">아이디는 4자이상 15자이하의 영어와 숫자로 입력하세요</span>
			</div>
			<div class="form-group">
				<label for="Email">이메일</label> 
				<div class="form-group" style="display:flex; flex-direction:row; justify-content:space-between;">
					<input type="email" class="form-control" name="email" id="email" placeholder="이메일" style="width:300px;">
					<button class="btn btn-secondary" type="button" onclick="emailSend()" id="mailjoinbtn">인증</button>
				</div>
				<div class="form-group" style="display:flex; flex-direction:row; justify-content:space-between;">
					<input type="text" class="form-control " name="emailconfirm" id="emailconfirm" placeholder="인증번호 확인" style="width:200px;" disabled>
					<span id="timer" style="padding-top:5px;"></span>
					<button id="emailChk"class="btn btn-secondary" type="button" onclick="emailConfirm()">확인</button>
				</div>
				<span class="point successEmailChk" style="font-size:12px;padding-top:0px;">이메일 입력후 인증버튼을 클릭해주세요.</span>
				<input type="hidden" id="emailDoubleChk" name="emailDoubleChk" value="false"/>
			</div> 
			<div class="form-group">
				<label for="userpwd">비밀번호</label> 
				<input type="password" class="form-control pwd" name="userpwd" placeholder="Password" id="pwd1">
			</div>
			<div class="form-group">
				<label for="userpwcheck">비밀번호 확인</label> 
				<input type="password" class="form-control pwd" name="userpwcheck" id="pwd2" placeholder="Cofirm Password" >
				<span id="passcheck1" class="form-text text"></span>
			</div>
			<div class="form-group">
				<label for="name">이름</label> 
				<input type="text" class="form-control" name="name" placeholder="이름">
			</div>
			<div class="form-group">
				<label for="birth">생년월일</label>  
				<input type="date" class="form-control" name="birth"  min="1900-01-01" max="2021-12-31" id="birth">   
			</div>
			<div class="form-group">
				<label for="gender" style="padding-right:40px;">성별</label> 
				<input type="radio" value="남" name="gender" checked="checked"><span style="padding-right:20px;">남자</span>
				<input type="radio" value="여" name="gender"><span>여자</span>
			</div>
			<div class="d-grid gap-2 d-md-block" style="text-align:center;">
				<button type="button" class="btn btn-secondary" onclick="joinCheck()">가입하기</button>
			</div>
	</form>
</div>
	<script src="js/jquery.min.js"></script>
	<script src="js/joinCheck.js"></script>
	<script src="js/emailCheck.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/popper.js"></script>
	​<script src="js/movieSearch.js"></script>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>