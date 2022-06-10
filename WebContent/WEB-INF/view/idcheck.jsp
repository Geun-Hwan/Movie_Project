<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>아이디 중복 확인</h2>
<form action="idCheck.do" method="get" name="frm">
	아이디<input type="text" name="userid" value="${userid}" id="checkid">
	<input type="hidden" id="reid">
	    <input type="submit" value="중복 체크" onclick="check()"><br>
	    
	<c:if test="${result == 1 }">
		<script type="text/javascript">
			opener.document.frm.userid.value="";
			/*opener 객체는 자기 자신을 오프한 기존 창의 window 객체를 참조한다. */
		</script>
		${userid}는 이미 사용 중인 아이디입니다.<br>
	</c:if>
	<c:if test="${result == 0 }">
		${userid}는 사용 가능한 아이디입니다.&nbsp;<input type="button" value="사용" onclick="idok('${userid}')">
		<br>해당 아이디를 이용하시려면 사용 버튼을 눌러주세요.
	</c:if>
	<c:if test="${result == -1 }">
	<script type="text/javascript">
			opener.document.frm.userid.value="";
		</script>
		아이디를 입력해 주세요.
	</c:if>
	<c:if test="${result == 4 }">
	<script type="text/javascript">
			opener.document.frm.userid.value="";		
		</script>
		아이디는 4자 이상이어야 합니다.
	</c:if>
	<c:if test="${result == 5 }">
	<script type="text/javascript">
			opener.document.frm.userid.value="";		
		</script>
		4자이상 15자이하 영어와 숫자의 조합으로 입력해주세요.<br>
		한글 및 공백은 포함할 수 없습니다.
	</c:if>
</form>
<script src="js/jquery.min.js"></script>
<script type="text/javascript">
function idok(userid){
	if(userid != $("#checkid").val()){
		alert("중복체크를 해주세요.");
		return;
	}
	
	opener.frm.userid.value=document.frm.userid.value;
	opener.frm.reid.value=document.frm.userid.value;
	$("#userid",opener.document).attr("readonly",true);
	$("#idcheck",opener.document).text("인증완료");
	$("#idcheck",opener.document).css("color","green");
	self.close();
}
function check()	
{
	var idJ = /^[a-zA-Z0-9]*$/;
	var chk_num = document.frm.userid.value.search(/[0-9]/g);
	var chk_eng = document.frm.userid.value.search(/[a-z]/ig);
	
	if(document.frm.userid.value.length == 0){
		document.frm.userid.focus();

	return;
	}
	
	if (!idJ.test(document.frm.userid.value)) {
		document.frm.userid.focus();

		return;
	}
	if(document.frm.userid.value.length < 4){
		document.frm.userid.focus();
	
		return;
	}
	
	if(chk_num < 0 || chk_eng < 0)
	{ 
	    document.frm.userid.focus();
	    return;
	}
	
	return true;
}
</script>
</body>
</html>