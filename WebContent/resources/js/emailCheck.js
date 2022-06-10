var code="";
var mailconfirm=false;
var passCheck=false;
function emailSend(){
	
	var mail=document.frm.email.value;
	var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

	if (mail.length == 0) {
		alert("이메일을 입력해 주세요!");
		return;
	}
	if(!(mailJ.test(mail))){
		alert("이메일이 형식이 올바르지 않습니다.")
		return;
	}
	$("#mailjoinbtn").attr("disabled",true);
	$("#email").attr("readonly",true);
	$("#emailChk").attr("disabled", false);
		$.ajax({
			type : "post",
			url : "emailCheck.do",
			data : {
				mail : mail
			},
			dataType : 'json',
			success : function(data) {
				if (data == 1){
				$("#mailjoinbtn").attr("disabled",false);
				$("#emailconfirm").attr("disabled", true);
				$("#email").attr("readonly",false);
				alert("이미 가입한 이메일입니다.")
				return;
				}
				else{
					$("#email").attr("readonly",true);
					$("#emailconfirm").attr("disabled", false);					
					$.ajax({
						type : "post",
						url : "email.do",
						data : {
							mail : mail
						},
						dataType : 'json',
						beforeSend : function(){
							sendAuthNum();
							$(".successEmailChk").text("인증번호를 입력해주세요.");
							$(".successEmailChk").css("fontSize",12);
							$(".successEmailChk").css("color","black");		
						},
						success : function(data) {						
							code = data;											
						},
						error : function() {
							$("#mailjoinbtn").attr("disabled",false);
							$("#email").attr("readonly",false);
							clearInterval(timer);
							display.textContent="";
							$("#emailconfirm").attr("disabled", true);
							$("#emailChk").attr("disabled", true)
							isRunning = false;
							alert("메일 발송에 실패했습니다.");
						}
					});
				}
			}
		});
	}
function emailConfirm(){
	if(code==""){
		return;
	}
	if($("#emailconfirm").val() == code){
		$("#emailconfirm").attr("disabled",true);
		$("#email").attr("readonly",true);
		$(".successEmailChk").text("인증번호가 일치합니다.");
		$(".successEmailChk").css("fontSize",12);
		$(".successEmailChk").css("color","green");
		$("#emailDoubleChk").val("true");
	}else{
		$(".successEmailChk").text("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.");
		$(".successEmailChk").css("fontSize",12);
		$(".successEmailChk").css("color","red");
		$("#emailDoubleChk").val("false");
	}
}

var timer;
var isRunning = false;
// 인증번호 발송하고 타이머 함수 실행
function sendAuthNum() {
	// 남은 시간
	var leftSec = 300, display = document.querySelector('#timer');
	// 이미 타이머가 작동중이면 중지
	if (isRunning) {
		clearInterval(timer);
	}
	startTimer(leftSec, display);
}
function startTimer(count, display) {
	var minutes, seconds;
	timer = setInterval(function() {
		minutes = parseInt(count / 60, 10);
		seconds = parseInt(count % 60, 10);
		minutes = minutes < 10 ? "0" + minutes : minutes;
		seconds = seconds < 10 ? "0" + seconds : seconds;
		display.textContent = minutes + ":" + seconds;
		// 타이머 끝
		if($("#emailDoubleChk").val()=="true"){
			clearInterval(timer);
			display.textContent="";
			$("#emailconfirm").attr("disabled", true);
			$("#emailChk").attr("disabled", true)
			isRunning = false;
		}
		
		if (--count < 0) {
			clearInterval(timer);
			display.textContent = "시간초과";
			$("#mailjoinbtn").attr("disabled",false);
			$("#emailconfirm").attr("disabled", true);
			$("#emailChk").attr("disabled", true);
			$("#email").attr("readonly",false);
			$(".successEmailChk").text("인증번호를 다시 전송해주세요.");
			$(".successEmailChk").css("fontSize",12);
			$(".successEmailChk").css("color","black");
			isRunning = false;
		}
	}, 1000);
}
function findIdmodal(){
	//init
	$("#email").val("");
	$("#name").val("");
	$("#confirmId").text("");
}

function findId(){
	
	var email=$("#email").val();
	var name=$("#name").val();
	var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	if(name.trim().length==0){
		alert("이름을 입력해 주세요.")
		return;
	}
	if (email.length == 0) {
		alert("이메일을 입력해 주세요.");
		return;
	}
	if(!(mailJ.test(email))){
		alert("이메일이 형식이 올바르지 않습니다.")
		return;
	}
	$("#findIdbtn").attr("disabled",true);
	$("#confirmId").text("메일 전송중 입니다.");
	$("#confirmId").css("color","black");
	$.ajax({
		type : "post",
		url : "findId",
		data : {
			email : email,
			name : name
		},
		dataType : 'json',
		success :function(data){
			if(data==true){	
				$("#findId").modal("hide");
				alert("해당 메일로 아이디를 전송 하였습니다. 메일을 확인해 주세요.");
				$("#findIdbtn").attr("disabled",false);
			}else{
				$("#confirmId").text("회원 정보를 확인해 주세요");
				$("#confirmId").css("color","red");
				alert("일치하는 정보가 없습니다.");
				$("#findIdbtn").attr("disabled",false);
			}
		}
	});
}

function findPwmodal(){
	//init
	$("#email2").val("");
	$("#userid2").val("");
	$("#confirmPwd").text("");
	$("#codeConfirm").text("");
	$("#codeCheckbtn").attr("disabled", false);
	$("#recodeCheckbtn").attr("disabled", false);
	$("#recodeCheckbtn").hide();
	$("#checkcode").val("");
	$("#newpass").val("");
	$("#newpass2").val("");
	$("#timer").text("");
	clearInterval(timer);
	isRunning = false;
	mailconfirm=false;
	passCheck=false;
}

function findPwd(){
	var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	var idT = /^[a-zA-Z0-9]*$/;
	var email2=$("#email2").val();
	var userid=$("#userid2").val();
	var chk_num = userid.search(/[0-9]/g);
	var chk_eng = userid.search(/[a-z]/ig);
	
	
	if(!idT.test(userid)){
		alert("아이디 형식이 옳바르지 않습니다.")
		return;
	}
	if(chk_num < 0 || chk_eng < 0)
	{ 
	    alert('아이디 형식이 옳바르지 않습니다.');
	  
	    return;
	}
	if (email2.length == 0) {
		alert("이메일을 입력해 주세요.");
		return;
	}
	if(!(mailJ.test(email2))){
		alert("이메일이 형식이 올바르지 않습니다.")
		return;
	}
	
	$("#findpassbtn").attr("disabled",true);
	$("#confirmPwd").text("메일 전송중 입니다.");
	$("#confirmPwd").css("color","black");
	$.ajax({
		type : "post",
		url : "findPw",
		data : {
			email : email2,
			userid : userid
		},
		dataType : 'json',
		success :function(data){
			if(data!=0){
				sendAuthNum2();
				code=data;
				$("#findPw").modal("hide");
				$("#findPwCheck").modal("show");
				$("#findpassbtn").attr("disabled",false);
			}else{
				$("#confirmPwd").text("회원 정보를 확인해 주세요");
				$("#confirmPwd").css("color","red");
				alert("일치하는 정보가 없습니다.");
				$("#findpassbtn").attr("disabled",false);
			}
		}
	});
}

function confirmCode(){
	var inputCode =$("#checkcode").val()
	console.log(code);
	console.log(inputCode);
	if(code==inputCode){
		mailconfirm=true;
		$("#codeConfirm").text("일치");
		$("#codeConfirm").css("color","green");
		$("#findPwCheck").modal("hide");
		$("#changePwd").modal("show");
		alert("인증이 완료되었습니다.");
	}
	else{
		$("#codeConfirm").text("인증번호가 일치하지 않습니다.");
		$("#codeConfirm").css("color","red");
	}
}

function sendAuthNum2() {
	// 남은 시간
	var leftSec = 300, display = document.querySelector('#timer');
	// 이미 타이머가 작동중이면 중지
	if (isRunning) {
		clearInterval(timer);
	}
	startTimer2(leftSec, display);
}
function startTimer2(count, display) {
	var minutes, seconds;
	timer = setInterval(function() {
		minutes = parseInt(count / 60, 10);
		seconds = parseInt(count % 60, 10);
		minutes = minutes < 10 ? "0" + minutes : minutes;
		seconds = seconds < 10 ? "0" + seconds : seconds;
		display.textContent = minutes + ":" + seconds;
		// 타이머 끝
		if(mailconfirm==true){
			clearInterval(timer);
			display.textContent="";
			isRunning = false;
		}	
		if (--count < 0) {
			clearInterval(timer);
			display.textContent = "00:00";
			$("#codeCheckbtn").attr("disabled", true);
			$("#recodeCheckbtn").attr("disabled", false);
			$("#recodeCheckbtn").show();
			$("#codeConfirm").text("인증번호를 다시 전송해주세요.");
			$("#codeConfirm").css("color","black");
			isRunning = false;
		}
	}, 1000);
}

function reconfirmCode(){
	var email2=$("#email2").val();
	var userid=$("#userid2").val();
	$("#codeConfirm").text("");
	$("#codeCheckbtn").attr("disabled", false);
	$("#recodeCheckbtn").attr("disabled", true);
	$.ajax({
		type : "post",
		url : "findPw",
		data : {
			email : email2,
			userid : userid
		},
		dataType : 'json',
		success :function(data){
			if(data!=0){
				sendAuthNum2();
				code=data;
				alert("인증번호를 재전송 했습니다.");
			}else{
				alert("오류");
			}
		}
	});
}

function changePwd(){
	var email2=$("#email2").val();
	var userid=$("#userid2").val();
	var pass;
	if(passCheck==true){
		pass=$("#newpass").val();
		$.ajax({
			type : "post",
			url : "changePw",
			data : {
				email : email2,
				userid : userid,
				userpw : pass
			},
			dataType : 'json',
			success :function(data){
				if(data!=0){
					$("#changePwd").modal("hide");
					alert("비밀번호가 변경되었습니다.");
				}else{
					alert("비밀번호 변경에 실패했습니다.");
				}
			}
		});
	}
}


$(function() {
	var regPwd = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,15}$/;

	$("#passcheck").text("비밀번호는 6~15자 사이 영어와 숫자로 조합해주세요.");
	$("#passcheck").css("fontSize",12);
	$("input").keyup(function() {
		var pwd1 = $("#newpass").val();
		var pwd2 = $("#newpass2").val();
		if (pwd1 != "" || pwd2 != "") {
			if (pwd1 == pwd2) {
				$("#passcheck").text("비밀번호가 일치합니다.");
				$("#passcheck").css("fontSize",12);
				$("#passcheck").css("color","green");
				passCheck=true;
			} else {
				$("#passcheck").text("비밀번호가 일치하지 않습니다.");
				$("#passcheck").css("fontSize",12);
				$("#passcheck").css("color","red");
				passCheck=false;
			}
		}
		if((pwd1=="" && pwd2=="")||(!regPwd.test(pwd1))){
			$("#passcheck").text("비밀번호는 6~15자 사이 영어와 숫자로 조합해주세요.");
			$("#passcheck").css("fontSize",12);
			$("#passcheck").css("color","black");
			passCheck=false;
		}
	});
});

$('#findPw').on('hidden.bs.modal', function (e) {
    console.log('modal close');
  $(this).data('modal',null);
});

$('#findPwCheck').on('hidden.bs.modal', function (e) {
    console.log('modal close');
  $(this).data('modal',null);
});