<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<body>
<div class="container-fluid" style="width: 900px;">
<h2 class="mb-5" style="text-align:center;" id="myTitle">개인 정보 수정</h2>
		<p style="text-align:center;" id="mysubTitle">회원 정보를 변경하려면 비밀번호를 입력하세요.</p> <!-- 간단한 정보만 노출? -->
	<div style="text-align:center;" id="myInfo">
	<form id='myUpdate'class='form-group'>
	 <input class='form-control' type='password' id='mypassword' name='mypassword' style='width:400px; margin:0 auto;'/>
	 <div style='width:400px; margin:0 auto; padding-top:30px;'>
	 <p style='color:red;float:left; margin-top:10px;'id='passconfirm'></p><button style='float:right;'class='btn btn-secondary' type='button' onclick='passSubmit()'>확인</button>
	 </div>
	 </form>
	 </div>
</div>
</body>
