<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/loading.css">
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<title>로그인 페이지</title>
</head>
<body>
	<c:choose>
		<c:when test="${userid!=null}">
			<script type="text/javascript">
				alert("이미 로그인 하셨습니다.");
				history.go("1");
			</script>
		</c:when>
	</c:choose>
	<br>
	<!-- 로그인 페이지 아이디 pw 찾기도 추가-->
	<div style="margin: 0 auto; width: 600px; border:2px solid gray; border-radius:9px;">
		<h2 style="margin-top:20px;"align="center">로그인</h2>
		<form action="login.do" method="post" style="margin: 0 auto;">
			<div class="form-group" style="width: 400px; margin: 0 auto;">
				<label for="userid">ID</label>
				<input type="text" class="form-control" name="userid" placeholder="Enter ID" required="required">
				<small id="idHelp" class="form-text text-muted">아이디 또는 이메일을 입력하세요.</small>
			</div>
			<div class="form-group" style="width: 400px; margin: 0 auto;">
				<label for="userpw">Password</label>
				<input type="password" class="form-control" name="userpwd" placeholder="Password" required="required">
			</div>
			<br>
			<button style="width: 400px; margin: 0 auto; display: block;" type="submit" class="btn btn-secondary">로그인</button>
		</form>
		<br>
		 <div style="text-align:center;">
		 <a href="javascript:kakaoLogin();">
			<img src="images/kakao_login_medium_wide.png" alt="카카오계정 로그인" style="height: 40px; width:400px;" />
		</a>
		</div>
		<br> 
		<div class="" style="width: 400px; margin: 0 auto; display: flex; flex-direction: row; justify-content: space-between;">
			<button type="button" class="btn btn-light" data-toggle="modal" data-target="#findId" data-whatever="@mdo" onclick="findIdmodal()">아이디 찾기</button>
			<button type="button" class="btn btn-light" data-toggle="modal" data-target="#findPw" data-whatever="@mdo" onclick="findPwmodal()">비밀번호 찾기</button>
			<button type="button" class="btn btn-light" onclick="location.href='join'">회원가입</button>
		</div>
		<br>
		
	</div>

	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script>
		window.Kakao.init('6e27331e617e535764066c8c3bd7d87a');

		function kakaoLogin(form) {
			window.Kakao.Auth.login({
				scope : 'account_email, gender,birthday', //동의항목 페이지에 있는 개인정보 보호 테이블의 활성화된 ID값을 넣습니다.
				success : function(response) {
					console.log(response) // 로그인 성공하면 받아오는 데이터
					window.Kakao.API.request({
						url : '/v2/user/me',
						success : function(response) {
							const email = response.kakao_account.email;
							const gender = response.kakao_account.gender;
							const birthday = response.kakao_account.birthday;
							//const name = response.kakao_account.profile.nickname;

							console.log(email);
							console.log(gender);
							console.log(birthday);
							//console.log(nickname);
							$.ajax({
								url : "kakao.do",
								data : {
									email : email,
									gender : gender,
									birthday : birthday
								},
								type : "POST",
								
								success : function(data) {
									alert("성공");
									location.href = "main";
								},
								error : function() {
									alert("에러")
								}
							});

						},
						fail : function(error) {
							console.log(error);
						}
					});
					// window.location.href='/ex/kakao_login.html' //리다이렉트 되는 코드
				},
				fail : function(error) {
					console.log(error);
				}

			//location.href = "main";
			});
		}
		
		
	</script> -->

	<!-- id찾기 이메일 인증완료시 id 보여주기 -->
	<jsp:include page="./findId.jsp"></jsp:include>
	<!-- pw찾기 새로운 비밀번호 등록-->
	<jsp:include page="./findPw.jsp"></jsp:include>


	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/popper.js"></script>​
	<script src="js/movieSearch.js"></script>
	<script src="js/emailCheck.js"></script>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>