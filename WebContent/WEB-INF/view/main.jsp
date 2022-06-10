<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>메인 페이지</title>
<link href="css/bootstrap.css" rel="stylesheet" />
<link href="css/content.css" rel="stylesheet" />
<link rel="stylesheet" href="css/loading.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
<style>


.movieChartBeScreen_wrap {
	clear: none;
	float: none;
	background-image: linear-gradient(to bottom, rgba(255, 255, 255, 1),
		rgba(232, 232, 232, 0.37));
	position: relative;
	height: 498px;
}

}
#contaniner .contents {
	width: 980px;
	height: 100%;
	margin: 0 auto;
}

.tab {
	list-style: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
}

#amovie {
	display: inline-block;
	color: #000;
	text-align: center;
	text-decoration: none;
	padding: 14px 16px;
	transition: 0.3s;
	font-size: 25px;
}
/* 스타일을 태그이름으로 주면 nav랑 충돌이 있어서 클래스로 변경 */
.li {
	float: left;
	display: inline-block;
	color: #000;
	text-align: center;
	text-decoration: none;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		// tab operation
		$('.tabmenu').click(function() {
			var activeTab = $(this).attr('data-tab');
			var f = document.forms[0];
			$('li').css('font-weight', 'normal');
			$(this).css('font-weight', 'bold');

			$.ajax({
				type : 'GET', //get방식으로 통신
				url : "nowmovie", //탭의 data-tab속성의 값으로 된 html파일로 통신
				dataType : "html", //html형식으로 값 읽기
				data : {
					activeTab : activeTab
				},
				error : function() { //통신 실패시
					alert('통신실패!');
				},
				success : function(data) { //통신 성공시 탭 내용담는 div를 읽어들인 값으로 채운다.
					$('#tabcontent').html(data);

				}
			});

		});
		$('#default').click();
		//refreshMemList();
	});
</script>
</head>
<body style="background-image: linear-gradient(to bottom, rgba(255, 255, 255, 1), rgba(232, 232, 232, 0.37));">
	<c:choose>
		<c:when test="${userid!=null&&admin==1}">
			<script type="text/javascript">
				location.href = "adminMain";
			</script>
		</c:when>
	</c:choose>
	<!-- 이미지 슬라이드 영역 이벤트 띄워주기 -->
	<div class="movieSelection_wrap">
		<div class="contents" style="width: 980px; height: 100%; margin: 0 auto;">

			<div class="movie_wrap">
				<div id="myCarousel" class="carousel slide" data-ride="carousel">
					<!-- Indicators -->
					<ul class="carousel-indicators">
						<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#myCarousel" data-slide-to="1"></li>
						<li data-target="#myCarousel" data-slide-to="2"></li>
						<li data-target="#myCarousel" data-slide-to="3"></li>
					</ul>
					<!--  -->
					<div class="carousel-inner">
						<div class="carousel-item active">
							<img src="images/popcorn.jpg" alt="Los Angeles" width="1000"height="490">
						</div>
						<div class="carousel-item">
							<img src="images/soundx_02.jpg" alt="Chicago" width="1000" height="490">
						</div>
						<div class="carousel-item">
							<img src="images/screenx_03.jpg" alt="New York" width="1000" height="490">
						</div>
						
                        <div class="carousel-item">
	                    <video autoplay="" muted="" width="1000" height="490">
	                        <source src="https://adimg.cgv.co.kr/images/202205/Witch2/220527_Witch2_1080x608.mp4" type="video/mp4">
	                    </video>             
                        <strong id="ctl00_PlaceHolderContent_AD_MOVIE_NM" class="movieSelection_title">마녀(魔女) Part2. The Other One</strong>
                        <span id="ctl00_PlaceHolderContent_AD_DESCRIPTION_NM" class="movieSelection_txt">모든 것의 시작,<br>또 다른 존재가 깨어난다!</span>
                    </div>
					</div>

					<!-- Left and right controls -->
					<a class="carousel-control-prev" href="#myCarousel" data-slide="prev">
						<span class="carousel-control-prev-icon"></span>
					</a>
					<a class="carousel-control-next" href="#myCarousel" data-slide="next">
						<span class="carousel-control-next-icon"></span>
					</a>
				</div>

			</div>
		</div>
	</div>

	<!-- 영화 상영작 목록 -->
	<div class="moviechartbescreen_wrap">
		<div class="contents" style="width: 1200px; margin: 0 auto;">
			<div class="movieChartBeScreen_btn_wrap">
				<div class="tabBtn_wrap">
					<ul class="tab">
						<li data-tab="tab1(nowmovie)" class='tabmenu li' id="default"><a id="amovie" href="#" onclick="return false;">현재상영작 </a></li>
						<li data-tab="tab2(uncoming)" class='tabmenu li'><a id="amovie"  href="#" onclick="return false;">개봉예정작</a></li>
					</ul>

				</div>
				<a href="movieList" id="btn_allView_Movie" class="btn_allView" onclick="$('.wrap-loading').removeClass('display-none');">전체보기</a>
			</div>
			<div id="tabcontent"></div>
		</div>
	</div>

	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/popper.js"></script>
	<script src="js/movieSearch.js"></script>

	<%@ include file="../layout/footer.jsp"%>
</body>
</html>