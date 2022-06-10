<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="css/bootstrap.css" rel="stylesheet" />
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/module.css">
<link rel="stylesheet" href="css/loading.css">
<link rel="stylesheet" href="css/content.css">
<title>영화 리스트</title>
<!-- 모든 영화 출력 (예매 율순, 현재 상영작, 영화 4개 출력시마다 줄바꿈)-->
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
<div style="width:1200px; margin:0 auto;">
        <div style="margin:0 auto;width:1100px;padding-top:25px; padding-left:25px; display:flex; display-direction:row; justify-content:space-between;">
            <h3>무비차트</h3>
            <div class="submenu" style="padding-left:30px;">
                <ul style="display:flex; display-direction:row; list-style-type:none;" class="sort">
                    <li id="chart1"style="text-align:left; width:70px; padding-right:0px;" class="sortTab on"><a href="#" >무비차트<span class="arrow-down"></span></a></li>
                    <li id="chart2"style="width:110px;text-align:left; padding-left:10px;" class="sortTab"><a href="#" onclick="chart2()">상영예정작<span class="arrow-down"></span></a></li>
                    <!--<li><a href="/movies/?lt=3">CGV아트하우스</a></li>//-->
                </ul>
            </div>
         </div>
         <hr style="width:1050px; border:1.5px solid gray;"color="gray">
          <div style="width:1100px; margin:0 auto;display:flex; flex-direction:row; justify-content:space-between; padding-left:25px;">
             <div style="margin-top:20px; margin-bottom:20px;">
                  <input type="checkbox" id="chk_nowshow" />
            	 <label for="chk_nowshow">현재 상영작만 보기</label>                
            </div>
           
</div>
<!-- 영화 출력시 예매율 순서로 나오기때문에 새로 등록한 영화는 가장 밑으로 감.-->
<div style="width:1200px; margin:0 auto;" id="showMovieList">
	<c:forEach var="mcount" begin="0" end="${count/4}" varStatus="status">
		<c:choose>
			<c:when test="${status.last}">
			<ol style="display:flex; flex-direction:row;">
            	<c:forEach var="movie" items="${list}" begin="${4*mcount+0}" end="${count}" varStatus="status1">
            
            	<li style="list-style-type:none; padding-left:40px;padding-right:40px;">
            	<strong class="rank">No.${status1.index +1}</strong>
					<div class="box-image" style="width:200px;height:300px; position:relative">
						<div class="thumb-image">
						<a href="movieInfo?code=${movie.code}" onclick="$('.wrap-loading').removeClass('display-none');"> 
						<img src="${movie.poster}" alt="${movie.title} 포스터" onerror="errorImage(this)" style="width:200px;height:300px;"/>
						</a> 						
						</div>					 
						<div class="movieAgeLimit_wrap">
						<c:if test="${movie.grade eq '15세 이상'}">
						<img src="images/grade-15.png" style="width:24px; height:24px; right:6px; top:7px; position:absolute;">
						</c:if>
						<c:if test="${movie.grade eq '12세 이상'}">
						<img src="images/grade-12.png" style="width:24px; height:24px; right:6px; top:7px; position:absolute;">
						</c:if>
						<c:if test="${movie.grade eq '전체'}">
						<img src="images/grade-all.png" style="width:24px; height:24px; right:6px; top:7px; position:absolute;">
						</c:if>
						<c:if test="${movie.grade eq '청소년 관람불가'}">
						<img src="images/grade-19.png" style="width:24px; height:24px; right:6px; top:7px; position:absolute;">
						</c:if>
						</div>
					</div>
					<div class="box-contents" style="width:200px; padding-top:10px;">
						<div style="height:30px;">
						<a href="movieInfo?code=${movie.code}" onclick="$('.wrap-loading').removeClass('display-none');"> <strong
							class="title" >${movie.title}</strong>
						</a>
						</div>
						<div class="score">
							<strong class="percent">예매율<span>${movie.percent}%</span></strong>
						</div>

						<span class="txt-info"> <strong> ${movie.releaseDate}<span>개봉</span>

						</strong>
						<a style="float:right;"href="movieTicket?code=${movie.code}" onclick="$('.wrap-loading').removeClass('display-none');">예매하기</a>
						</span> 
					</div>
					</li>
				</c:forEach>
			</ol>
            </c:when>
            <c:otherwise>
	            <ol style="display:flex; flex-direction:row;">
	            <c:forEach var="movie" items="${list}" begin="${4*mcount+0}" end="${3+mcount*4}" varStatus="status2">
	            <li style="list-style-type:none; padding-left:40px;padding-right:40px;">
            	<strong class="rank">No.${status2.index +1}</strong>
					<div class="box-image" style="width:200px;height:300px; position:relative">
						<div class="thumb-image">
						<a href="movieInfo?code=${movie.code}" onclick="$('.wrap-loading').removeClass('display-none');"> 
						<img src="${movie.poster}" alt="${movie.title} 포스터" onerror="errorImage(this)" style="width:200px;height:300px;"/>
						</a> 						
						</div>					 
						<div class="movieAgeLimit_wrap">
						<c:if test="${movie.grade eq '15세 이상'}">
						<img src="images/grade-15.png" style="width:24px; height:24px; right:6px; top:7px; position:absolute;">
						</c:if>
						<c:if test="${movie.grade eq '12세 이상'}">
						<img src="images/grade-12.png" style="width:24px; height:24px; right:6px; top:7px; position:absolute;">
						</c:if>
						<c:if test="${movie.grade eq '전체'}">
						<img src="images/grade-all.png" style="width:24px; height:24px; right:6px; top:7px; position:absolute;">
						</c:if>
						<c:if test="${movie.grade eq '청소년 관람불가'}">
						<img src="images/grade-19.png" style="width:24px; height:24px; right:6px; top:7px; position:absolute;">
						</c:if>
						</div>
					</div>
					<div class="box-contents" style="width:200px; padding-top:10px;">
						<div style="height:30px;">
						<a href="movieInfo?code=${movie.code}" onclick="$('.wrap-loading').removeClass('display-none');"> <strong
							class="title" >${movie.title}</strong>
						</a>
						</div>
						<div class="score">
							<strong class="percent">예매율<span>${movie.percent}%</span></strong>
						</div>

						<span class="txt-info"> <strong> ${movie.releaseDate}<span>개봉</span>

						</strong>
						<a style="float:right;"href="movieTicket?code=${movie.code}" onclick="$('.wrap-loading').removeClass('display-none');">예매하기</a>
						</span> 
					</div>
					</li>
				</c:forEach>
			</ol>
            </c:otherwise>
      	</c:choose>
	</c:forEach>	
        </div>
 </div>
 
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/popper.js"></script>
	​<script src="js/movieSearch.js"></script>
	​<script src="js/jquery.blockUI.js"></script>
	<script type="text/javascript">
		
		$("#chk_nowshow").click(function(){
			if($("#chk_nowshow").is(":checked")){
				$.ajax({
					type : "post",
					url : "nowMovie",
					async : true,
					dataType : "json",
					beforeSend : function(xhr){
						$(".wrap-loading").removeClass("display-none");
						$.blockUI({ message: null });
					},
					complete : function(){
						$.ajax({
							type : "post",
							url : "nowshow",
							async : false,
							dataType : "html",
							cache : false,
							success : function(data2) {
								$("#showMovieList").children().remove();
								$('#showMovieList').html(data2);
								$(".wrap-loading").addClass("display-none");
								$.unblockUI();
							}
						});
					}
				});
			}else{
				$(".wrap-loading").removeClass("display-none");
				location.reload();
			}
		});
			
			
			
		
		function chart1(){
			$(".wrap-loading").removeClass("display-none");
			$("#chart1").addClass("on");
			$("#chart2").removeClass("on");
			location.href="movieList";
		}
		
		function chart2(){
			$(".wrap-loading").removeClass("display-none");
			$("#chart2").addClass("on");
			$("#chart1").removeClass("on");
			location.href="movieExpected";
		}
	</script>
</body>
<%@ include file="../layout/footer.jsp"%>
</html>