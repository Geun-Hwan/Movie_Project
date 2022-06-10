<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link rel="stylesheet" href="css/loading.css">
<style type="text/css">
.display-none{
	display:none;
}
.on{
	background-color:#212529;
}
</style>
</head>
<body>
<c:choose>
		<c:when test="${userid!=null&&admin==1}">
			<%@ include file="../layout/admin_header.jsp"%>
		</c:when>
		<c:otherwise>
			<%@ include file="../layout/header.jsp"%>
		</c:otherwise>
</c:choose>
	<div class="jumbotron" style="background-color:#f8f9fa;width:1200px; margin:0 auto; padding-top:20px; margin-top:20px; padding-bottom:20px; margin-bottom:20px;">
					<h2 style="text-align:cetner;">공지글 보기</h2>
					<form action="noticeUpdate.do" method="post" id="noticeUpdateform">
						<div class="row">
							<div class="col-md-6" style="display:flex; margin-top:20px;">

								<div class="form-group" style="display:flex; align-items:center;">
									<label for="userid" style="margin-right:10px; width:55px;">작성자</label>
									<input type="text" class="form-control" name="userid" id="userid" placeholder="Enter name" disabled value="${notice.userid}" style="width:200px; margin-right:10px;">
									<input type="hidden" name="num" id="num" value="${notice.num}">
								</div>
								
								<div class="form-group" style="display:flex; align-items:center; margin-left:150px;">
									<label for="reg_date" style="margin-right:10px; width:55px;">작성일</label>
									<input type="text" class="form-control" name="reg_date" id="reg_date" placeholder="Enter name" disabled value="${notice.reg_date}" style="width:200px; margin-right:10px;">
								</div>
								
								<div class="form-group" style="display:flex; align-items:center; margin-left:300px;">
									<label for="readcount" style="margin-right:10px; width:55px;">조회수</label>
									<input type="text" class="form-control" name="readCount" id="readCount" placeholder="Enter name" disabled value="${notice.readCount}" style="width:50px; margin-right:10px;">
								</div>
							</div>
						</div>

						<div class="form-group">
							<label for="title">제목</label>
							<input type="text" class="form-control" name="title" id="title" placeholder="Enter title" disabled value="${notice.title}">
						</div>

						<div class="form-group">
							<label for="content">내용</label>
							<textarea class="form-control" rows="10" name="content" id="content" disabled >${notice.content}</textarea>

						</div>

						<div class="center-block" style='width: 1150px'>
							<input class="btn btn-secondary" type="button" value="목록보기" onclick="location.href='notice'">
							<c:if test="${admin == 1 }">
							<input id="updateBtn" class="btn btn-secondary"type="button" value="수정하기" onclick="noticeUpdate()">
							<input class="btn btn-secondary"type="button" value="삭제하기" onclick="noticeDelete()">
							<input id="updateSubmit"class="btn btn-primary display-none" type="button" value="수정완료" style="float:right; margin-right:20px;">
							</c:if>							
						</div>
					</form>
				</div>
<%@ include file="../layout/footer.jsp"%>
<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/popper.js"></script>
	<script src="js/movieSearch.js"></script>
	​<script src="js/jquery.blockUI.js"></script>
	<script type="text/javascript">
	function noticeUpdate(){
		$("#updateSubmit").toggleClass('display-none');
		$("#updateBtn").toggleClass('on');
		
		if($("#updateBtn").hasClass("on")){
			$("#updateBtn").attr("value","수정취소");
		}else{
			$("#updateBtn").attr("value","수정하기");
		}
		
		if($("#content").attr("disabled") == "disabled" && $("#title").attr("disabled") == "disabled"){
			$("#content").attr("disabled",false);
			$("#title").attr("disabled",false);
		}else{
			$("#content").attr("disabled",true);
			$("#title").attr("disabled",true);
		}
	}
	function noticeDelete(){
		if(confirm("삭제 하시겠습니까?")){
			$.ajax({
				url : "noticeDelete.do",
				type : "post",
				data : {
					num: $("#num").val()
				},
				async:false,
				complete : function(){
					alert("삭제 완료.");
					location.href='notice';
				}
			});
		}
	}
	
	$(document).on("click","#updateSubmit",function(){
		if(!($("#title").val().trim().length)){ // 공백만 작성
			alert("제목을 입력해 주세요.");
			return;
		}
		if(!($("#content").val().trim().length)){ // 공백만 작성
			alert("내용을 입력해 주세요.");
			return;
		}
		if(confirm("수정 하시겠습니까?")){
			
			var newForm = $("#noticeUpdateform");
			newForm.method="post";
			newForm.submit();
			
			alert("수정 완료");
		}	
	});
	</script>
</body>
</html>