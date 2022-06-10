<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../layout/admin_header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/star.css">
<link rel="stylesheet" href="css/loading.css">

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
	<form style="margin-top: 50px; position: relative;" action="movieWrite.do" enctype = "multipart/form-data" method="post" id="movieWriteForm">
		<div style="margin: 0 auto; width: 600px;">


			<h2 align="center">
				&lt;영화 정보 입력&gt;
			</h2>
			<div align="right">
				<input type="text" id="code" name="code" placeholder="영화 코드 입력" required="required">
				</div>
			<div class="input-group mb-3">
				<span style="right: 20px;" class="input-group-text" id="basic-addon1"> 제목</span>
				<input type="text" class="form-control" name="title" id="title"placeholder="영화 제목">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text" id="basic-addon2"> 감독</span>
				<input type="text" class="form-control" name="director" id="director" placeholder="영화  감독">
			</div>

			<div class="input-group mb-3">
				<span class="input-group-text" id="basic-addon3"> 배우</span>
				<input type="text" class="form-control" name="actor" id="actor" placeholder="영화 배우">
			</div>

			<div class="input-group mb-3">
				<span class="input-group-text" id="basic-addon2"> 가격</span> <input
					type="text" class="form-control" name="price" id="price" placeholder="영화 가격">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text" id="basic-addon1">장르</span> 
					<!-- checkbox로 변경 -->
					<!-- 범죄,액션,어드벤처,환타지,드라마,스릴러,전쟁,애니메이션,미스터리,다큐멘터리,뮤지컬,코미디,호러,로맨스,멜로 등등-->
				<select 
					class="form-control" name="category" id="category">
					<option value="comedy">코미디</option>
					<option value="romance">로맨스</option>
					<option value="horror">공포</option>
					<option value="action">액션</option>
					<option value="thriller">스릴러</option>
				</select>
			</div>



			<div class="input-group">
				<span class="input-group-text">영화 내용</span>
				<textarea style="height: 8em" class="form-control" aria-label="With textarea" name="synopsis" id="synopsis"></textarea>
			</div>

		
			<div class="star-rating space-x-4 mx-auto">
				<input type="radio" id="5-stars" name="rating" value="5" checked="checked"/>
				<label for="5-stars" class="star">★</label>
				<input type="radio" id="4-stars" name="rating" value="4" />
				<label for="4-stars" class="star">★</label>
				<input type="radio" id="3-stars" name="rating" value="3"  />
				<label for="3-stars" class="star">★</label>
				<input type="radio" id="2-stars" name="rating" value="2"/>
				<label for="2-stars" class="star">★</label>
				<input type="radio" id="1-star" name="rating" value="1" />
				<label for="1-star" class="star">★</label>
			</div> <!-- 해당 부분은 추후에 리뷰작성 기능 추가시 사용하면 좋을것 같음. -->
			<p style="text-align: center;">영화 총점</p>
					
			<!-- 커버이미지 들어오는 부분 (임시로 이미지를 넣어줬다)-->

			<div class="selectCover" style="padding-left: 0; text-align: left; display:flex; flex-direction:row;">

				<img id="cover" style="width: 182px; height: 268px;" />
				
			<!-- 파일등록 -->
				<div class="form-group" style="margin: 8px 0 8px; width:100px;">

					<input type="file" id="myFileUp" name="poster" style="width:400px; margin-left:200px;">
				</div>
				<div style="margin-top:100px;">
					<p>이미지 미선택시 noimage 자동 등록</p>
				</div>
			</div>
			<div style="text-align: center; padding-top:50px;">
				<button type="button" class="btn btn-primary" onclick="movieCheck()">등록</button> <!-- 중복된 코드면 이미 등록된 영화입니다.경고창 띄우고 return -->
				<button type="reset" class="btn btn-primary">초기화</button>

			</div>
		</div>

	</form>
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
					if(e.target.result ==""){
						$('#cover').attr('src', "");
					}
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
		// 영화 중복 등록 체크
		function movieCheck(){
			let check = /^[0-9]+$/;
			var mcode =$("#code").val();
			var newForm = document.getElementById('movieWriteForm');
			newForm.method="post";
			
			if(mcode.length==0){ /* 숫자만 입력해주세요 추가 */
				alert("코드를 입력해 주세요");
				return false;
			}
			if(!check.test(mcode)){
				alert("코드는 숫자만 입력가능합니다.");
				return false;
			}
			if(!check.test($("#price").val())){
				alert("가격은 숫자만 입력해주세요.");
				return false;
			}
			if($("#title").val().length==0){ 
				alert("제목을 입력해 주세요");
				return false;
			}
			if($("#director").val().length==0){ 
				alert("감독을 입력해 주세요");
				return false;
			}
			if($("#actor").val().length==0){ 
				alert("배우를 입력해 주세요");
				return false;
			}
			if($("#synopsis").val().length==0){ 
				alert("내용을 입력해 주세요");
				return false;
			}
			$.ajax({
				type : "get",
				url : "movieCheck.do",
				data : {mcode:mcode},
				dataType :'json',
				success : function(data){
				if(data==0){
					newForm.submit();
					alert("등록 성공");
				}else{
					alert("이미 등록된 영화입니다.");
					return false;
					}		
				}
			});		
		}
	</script>
	<%@ include file="../../layout/footer.jsp"%>
</body>
</html>