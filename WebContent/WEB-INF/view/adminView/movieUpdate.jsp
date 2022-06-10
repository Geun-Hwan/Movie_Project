<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../../layout/admin_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="css/bootstrap.css" rel="stylesheet" />
<link rel="stylesheet" href="css/loading.css">
<title>Insert title here</title>
</head>
<body>
	<c:choose>
		<c:when test="${userid==null||admin!=1}">
		<script type="text/javascript">
			alert("권한이 없습니다.");
			location.href="login";
		</script>
	</c:when>
	</c:choose>
<div style="margin: 0 auto; width: 600px;">
	<h2 align="center">
		영화 수정
		
		<!-- 영화 정보 입력 -->
		
		</h2>
		<form action = "movieUpdate" method = "post" enctype = "multipart/form-data" id = "movieUpdateform">
		
		<input type = "hidden" name = "code" value = "${movie.code}">
		<input type ="hidden" name= "percent" value="${movie.percent}">
			<div class="input-group mb-3">
				<span class="input-group-text" id="basic-addon1"> 제목</span> <input
					type="text" class="form-control" name = "title" id="title" placeholder="영화 제목" value="${movie.title}">
			</div>
			
			<div class="input-group mb-3">
				<span class="input-group-text" id="basic-addon2"> 감독</span> <input
					type="text" class="form-control" name = "director" id="director" placeholder="영화  감독" value="${movie.director}">
			</div>

			<div class="input-group mb-3">
				<span class="input-group-text" id="basic-addon3"> 배우</span> <input
					type="text" class="form-control" name = "actor" id="actor" placeholder="영화 배우" value="${movie.actor}">
			</div>
			
			<div class="input-group mb-3">
				<span class="input-group-text" id="basic-addon2"> 가격</span> <input
					type="text" class="form-control" name = "price" id="price"placeholder="영화 가격" value="${movie.price}">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text" id="basic-addon1">영화 장르</span> <!-- 장르 부분 체크 박스? 받는 값은 문자열 형식임 "," 기준으로 split 해야 함   -->
				<!-- 범죄,액션,어드벤처,환타지,드라마,스릴러,전쟁,애니메이션,미스터리,다큐멘터리,뮤지컬,코미디,호러,로맨스,멜로--> 
				<select class="form-control" name="category">
					<option>코미디</option>
					<option>로맨스</option>
					<option>공포</option>
					<option>액션</option>
					<option>스릴러</option>
				</select>
			</div>

			<div class="input-group">
				<span class="input-group-text">영화 내용</span>
				<textarea style="height: 8em" class="form-control" name = "synopsis" id="synopsis"
					aria-label="With textarea">${movie.synopsis }</textarea>
			</div>

			<!-- 파일등록 -->
			<div>
				<div class="form-group" style="margin: 8px 0 8px;">
					<input type="file" id="myFileUp" name="poster" >
					<input type="hidden" name="reid" value="${movie.poster}">  <!-- 해당 부분  확인 필요-->
				</div>
			</div>
			<!-- 커버이미지 들어오는 부분 (임시로 이미지를 넣어줬다)-->

			<div class="selectCover" style="padding-left: 0;">
				<img id="cover" src="${movie.poster }"
					style="width: 182px; height: 268px;" />
			</div>

			<div style="text-align: center;">
				<a href="#" role="button" type="button" class="btn btn-secondary" onclick="history.go(-1)">돌아가기</a>
				<input type="reset" value = "취소" class="btn btn-primary" id="btn-save">
				<input type="button" value = "수정" class="btn btn-primary" id="btn-save" onclick="changeMovie()"> <!-- 예외 발생하지 않으면 수정완료창 띄우기 -->
			</div>
		</form>
	</div>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/popper.js"></script>
	​<script src="js/movieSearch.js"></script>
	<script>
		function readURL(input) {
			console.log("버튼클릭함1");
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#cover').attr('src', e.target.result); //cover src로 붙여지고

					$('#myFileUp').val(input.files[0].name); //파일선택 form으로 파일명이 들어온다
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
		$("#myFileUp").change(function() {
			readURL(this);
			console.log("이미지 바뀜?");
		});
		
		function changeMovie(){
			var newForm = document.getElementById('movieUpdateform');
			newForm.method="post";
			let check = /^[0-9]+$/;
			
			if(!check.test($("#price").val())){
				alert("가격은 숫자만 입력해주세요.");
				return;
			}
			if($("#title").val().length==0){ 
				alert("제목을 입력해 주세요");
				return;
			}
			if($("#director").val().length==0){ 
				alert("감독을 입력해 주세요");
				return;
			}
			if($("#actor").val().length==0){ 
				alert("배우를 입력해 주세요");
				return;
			}
			if($("#synopsis").val().length==0){ 
				alert("내용을 입력해 주세요");
				return;
			}
			newForm.submit();
		}
	</script>
	<%@ include file="../../layout/footer.jsp"%>
</body>
</html>