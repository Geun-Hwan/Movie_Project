<%@page import="java.util.ArrayList"%>
<%@page import="model.MovieVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/content.css" rel="stylesheet" />
<link href="css/swiper_bundle.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
<script type="text/javascript">
	new Swiper('.swiper-container-initialized', {

		slidesPerView : 5, // 동시에 보여줄 슬라이드 갯수
		spaceBetween : 50, // 슬라이드간 간격
		slidesPerGroup : 5, // 그룹으로 묶을 수, slidesPerView 와 같은 값을 지정하는게 좋음

		// 그룹수가 맞지 않을 경우 빈칸으로 메우기
		// 3개가 나와야 되는데 1개만 있다면 2개는 빈칸으로 채워서 3개를 만듬
		loopFillGroupWithBlank : true,

		loop : true, // 무한 반복

		pagination : { // 페이징
			el : '.swiper-pagination',
			clickable : true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
		},
		navigation : { // 네비게이션
			nextEl : '.swiper-button-next', // 다음 버튼 클래스명
			prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
		},
	});
</script>
</head>
<body>
<!-- 반복문 이용 5회씩.-->
	<div class="swiper movieChart_list swiper-container-initialized swiper-container-horizontal" id="movieChart_list" style="display: block;">
		<div class="swiper-wrapper" style="transform: translate3d(0px, 0px, 0px); transition-duration: 0ms;">
<%
	ArrayList<MovieVo> list=(ArrayList<MovieVo>)session.getAttribute("nowlist");
	for(int i=0; i<list.size();i++){
%>
			<div class="swiper-slide swiper-slide-movie swiper-slide-active" style="width: 170.4px; margin-right: 32px;">
				<div class="img_wrap" data-scale="false">
					<img src="<%=list.get(i).getPoster()%>" alt="<%=list.get(i).getTitle() %>" onerror="errorImage(this)">
					<div class="movieAgeLimit_wrap">
					<%
						switch(list.get(i).getGrade()){
						
						case "15세 이상" :							
					%>
						<img src="images/grade-15.png" alt="<%=list.get(i).getGrade()%>">
					<%
						break;					
						case "12세 이상" :
					%>
						<img src="images/grade-12.png" alt="<%=list.get(i).getGrade()%>">
					<%
						break;					
						case "전체" :
					%>
						<img src="images/grade-all.png" alt="<%=list.get(i).getGrade()%>">
					<%
						break;					
						case "청소년 관람불가" :
					%>
						<img src="images/grade-19.png" alt="<%=list.get(i).getGrade()%>">
					<%
						break;
						}
					%>
					
					</div>
					<div class="screenType_wrap">
						<i class="screenType"><img src="https://img.cgv.co.kr/R2014/images/common/logo/imax_white.png" alt="imax"></i>
					</div>
				</div>
				<div class="movie_info_wrap">
					<strong class="movieName" style="text-align: left;"><%=list.get(i).getTitle()  %></strong><span>예매율 <%=list.get(i).getPercent()%>%</span>
				</div>
				<div class="movieChart_btn_wrap">
					<a href="movieInfo?code=<%=list.get(i).getCode()%>" onclick="$('.wrap-loading').removeClass('display-none');" class="btn_movieChart_detail">상세보기</a>

					<a href="movieTicket?code=<%=list.get(i).getCode()%>" onclick="$('.wrap-loading').removeClass('display-none');" class="btn_movieChart_ticketing">예매하기</a>

				</div>
			</div>
			<%
		}
		%>
	
		</div>
	</div>
</body>

</html>