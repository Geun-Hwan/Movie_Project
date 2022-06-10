<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../layout/admin_header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="css/bootstrap.css" rel="stylesheet" />
<link href="css/content.css" rel="stylesheet" />
<link rel="stylesheet" href="css/loading.css">
<title>Insert title here</title>
</head>
<body>
<c:choose>
		<c:when test="${userid==null}">
			<script type="text/javascript">
				alert("로그인이 필요한 페이지 입니다.");
				location.href="login";
			</script>
		</c:when>
		<c:when test="${userid!=null&&admin==0}">
			<script type="text/javascript">
				alert("권한이 없습니다.");
				location.href="main";
			</script>
		</c:when>
</c:choose>
<div class="jumbotron" style="width:1200px; margin:0 auto; padding-top:20px; margin-top:20px;">
					<h2>공지 작성</h2>
					<form action="noticeWrite.do" method="post" id="noticeform">
						<div class="row">
							<div class="col-md-6">

								<div class="form-group">
									<label for="userid">ID</label>
									<input type="text" class="form-control" name="userid" id="userid" placeholder="Enter name" readonly value="${userid}" style="width:300px;">
								</div>
							</div>

						</div>

						<div class="form-group">
							<label for="title">Title</label>
							<input type="text" class="form-control" name="title" id="title" placeholder="Enter title">
						</div>

						<div class="form-group">
							<label for="content">Comment:</label>
							<textarea class="form-control" rows="10" name="content" id="content"></textarea>

						</div>

						<div class="center-block" style='width: 400px'>
							<input class="btn btn-secondary" type="button" value="Back" onclick="history.back(1)">
							<input class="btn btn-secondary"type="reset" value="다시쓰기">
							<input class="btn btn-primary"type="button" value="등록하기" onclick="noticeCheck()">
						</div>
					</form>
				</div>

<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/popper.js"></script>
	<script src="js/movieSearch.js"></script>
	​<script src="js/jquery.blockUI.js"></script>
	<script type="text/javascript">
	function noticeCheck(){
		if($("#title").val().trim().length ==0){ // 공백만 작성
			alert("제목을 입력해 주세요.");
			return;
		}
		if($("#content").val().trim().length ==0){ // 공백만 작성
			alert("내용을 입력해 주세요.");
			return;
		}

		var newForm = $("#noticeform");
		newForm.method="post";
		newForm.submit();
		
		alert("작성 완료");
	}
	</script>
<%@ include file="../../layout/footer.jsp"%>

</body>
</html>