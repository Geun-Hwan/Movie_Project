$(function() {
	var regPwd = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,15}$/;
	$("#passcheck1").text("비밀번호는 6~15자 사이 영어와 숫자로 입력해주세요.");
	$("#passcheck1").css("fontSize",12);
	$("input").keyup(function() {
		var pwd1 = $("#pwd1").val();
		var pwd2 = $("#pwd2").val();
		if (pwd1 != "" || pwd2 != "") {
			if (pwd1 == pwd2) {
				$("#passcheck1").text("비밀번호가 일치합니다.");
				$("#passcheck1").css("fontSize",12);
				$("#passcheck1").css("color","green");
				
			} else {
				$("#passcheck1").text("비밀번호가 일치하지 않습니다.");
				$("#passcheck1").css("fontSize",12);
				$("#passcheck1").css("color","red");
			}
		}
		if((pwd1=="" && pwd2=="")||(!regPwd.test(pwd1))){
			$("#passcheck1").text("비밀번호는 6~15자 사이 영어와 숫자로 입력해주세요.");
			$("#passcheck1").css("fontSize",12);
			$("#passcheck1").css("color","black");
		}
	});
});

function idCheck() {
	var idJ = /^[a-zA-Z0-9]*$/;
	var chk_num = document.frm.userid.value.search(/[0-9]/g);
	var chk_eng = document.frm.userid.value.search(/[a-z]/ig);
	
	if (document.frm.userid.value == "") {
		alert("아이디를 입력해 주세요.")
		document.frm.userid.focus();

		return;
	}
	
	if (!idJ.test(document.frm.userid.value)) {
		alert("아이디 형식이 맞지 않습니다.")
		document.frm.userid.focus();

		return;
	}

	if (document.frm.userid.value.length < 4) {
		alert("아이디는 4자 이상이어야 합니다.");
		document.frm.userid.focus();

		return;
	}
	
	if(chk_num < 0 || chk_eng < 0)
	{ 
	    alert('아이디는 숫자와 영문자를 포함해야 합니다.');
	    document.frm.userid.focus();
	    return;
	}

	var url = "idCheck.do?userid=" + document.frm.userid.value;
	window.open(url, "_blank_1", "toolbar=no,menubar=no,"
			+ "scrollbars=yes,resizable=no,width=450,height=200");
}

function joinCheck() {
	var regPwd = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,15}$/;
	
	if (document.frm.reid.value.length == 0) {
		alert("중복 체크를 하지 않았습니다.");
		document.frm.userid.focus();

		return false;
	}
	if (document.frm.email.value.length == 0) {
		alert("이메일을 입력해 주세요.");
		document.frm.email.focus();

		return false;
	}
	
	if (document.frm.emailDoubleChk.value !="true") {
		alert("이메일 인증을 진행해 주세요.");
		document.frm.email.focus();
		
		return false;
	}
	
	if (document.frm.userpwd.value == "") {
		alert("비밀번호는 반드시 입력해야 합니다.");
		document.frm.userpwd.focus();

		return false;
	}

	if(!regPwd.test(document.frm.userpwd.value)){
		alert("비밀번호는 6자이상 15자이하로 입력해주세요.")
	}
	
	if (document.frm.userpwd.value != document.frm.userpwcheck.value) {
		alert("비밀번호가 일치하지 않습니다.");
		document.frm.userpwcheck.focus();

		return false;
	}


	if (document.frm.name.value.length == 0) {
		alert("이름을 입력해 주세요.");
		document.frm.name.focus();

		return false;
	}

	if (document.frm.birth.value.length == 0) {
		alert("생년월일을 입력해 주세요.");
		document.frm.birth.focus();

		return false;
	}
	var newForm = document.getElementById('joinform');
	newForm.method="post";
	newForm.submit();
}
