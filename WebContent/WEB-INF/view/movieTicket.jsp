<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link href="css/bootstrap.css" rel="stylesheet" />
<link rel="stylesheet" href="css/seat.css">
<link rel="stylesheet" href="css/loading.css">
<style>
body {
background-color: #fffffb;
}
/* content */
.norelease{
	background-color:#989ea3;
	color:black;
}
.theater-wrapper {
    padding-left: 12px;
    padding-top: 2px;
    display: flex;
}

.theater-location-wrapper {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
}

.theater-place-wrapper {
    padding-right: 2px;
    margin-left:3px;
    margin-top: 2px;
    height: 300px;
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    overflow: scroll;
    overflow-x: hidden;
}

.theater-location {
    height: 30px;
    font-size: 11px;
    text-align: right;
    background-color: #E6E4D9;
    padding: 6px 6px 6px 0;
    margin-top: 1px;
}

.theater-place {
    padding: 6px 5px;
    height: 40px;
    font-size: 12px;
    font-weight: bold;
    text-align: left;
}

.reserve-container {
	margin-top: 20px;
	display: flex;
	justify-content: center;
	height: 800px;
	/* border: 1px solid #dddddd; */
}

.reserve-container>div {
	border: 1px solid #dddddd;
}

.reserve-title {
	border-bottom: 1px solid #dddddd;
	background-color: #444444;
	text-align: center;
	color: #dddddd;
	padding: 5px;
	font-size: 13px;
	font-weight: bold;
}
.movie-list{
 	overflow-y: scroll;
 	background-color:#f8f9fa;
 	height:720px;
}
.movie-list-age {
    width: 24px;
    height: 24px;
    line-height: 24px;
    text-align:center;
    /* color: white; */
    font-weight: bold;
    font-size: 12px;
    border-radius: 100%;
    /* background-color: #AF2D2D; */
    padding-right:12px; 
    padding-left:5px;
}
.movie-part {
	width: 284px;
}

.theater-part {
	width: 264px;
}

.day-part {
	width: 91px;
}

.time-part {
	width: 384px;
}

.sort-wrapper {
	margin: 10px 6px 6px 10px;
	/* padding: 3px; */
	display: flex;
	border-bottom: 1px solid #dddddd;
	font-size: 12px;
}

.sort-wrapper>div {
	padding: 3px;
}

.sort-wrapper>div:hover {
	border-bottom: 1px solid #111111;
}

.sort-selected {
	font-weight: bold;
	border-bottom: 1px solid #111111;
}

.sort-korean {
	margin-left: 6px;
}

.reserve-date {
	padding-top: 5px;
	display: flex;
	flex-direction: column;
	align-items: center;
	height: 760px;
	overflow: scroll;
	overflow-x: hidden;
}

.movie-date-wrapper {
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 5px 2px;
	border: 0;
}

.movie-week-of-day {
	margin-left: 5px;
	font-size: 10px;
	width: 12px;
	height: 22px;
	line-height: 22px;
}

.movie-day {
	text-align: center;
	width: 34px;
	height: 22px;
	font-size: 17px;
	font-weight: bold;
}

.saturday {
	color: #31597E;
	font-weight: bold;
}

.sunday {
	color: #AF2D2D;
	font-weight: bold;
}

.movie-date-wrapper-active {
	background-color: #333333;
}

.movie-date-wrapper-active>* {
	color: white;
}

.time-select {
	border: 1px solid gray;
	font-size: 14px;
	margin-bottom: 20px;
}

.time-wrapper-active {
	background-color: #333333;
	color: white;
}

.seatcount {
	font-size: 11px;
	margin-right: 2px;
	
}

.movie{
	font-color:black;
	font-weight: bold;
	margin-top:8px;
	border:2px solid;
	background-color:#f0f0f0;
	height:32px;
	display:flex;
}

.active{
	background-color: #333333;
	color: white;
}
.title-a{
text-overflow:ellipsis;
	white-space:nowrap;
	overflow: hidden;
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
	<input type="hidden" id="tickid" value="${userid}">
	<h2 style="text-align:center; padding-top:30px; padding-bottom:10px;">????????????</h2>
	<div class="reserve-container">
		<div class="movie-part">
			<div class="reserve-title">??????</div>
			<div class="sort-wrapper">
				<div class="sort-rate sort-selected" onclick="nowMovieSort()">????????????</div>
				<div class="sort-korean" onclick="koreaSort()">????????????</div>
			</div>
			<div class="movie-list" id="movie-list">

				<c:forEach var="list" items="${nlist}" varStatus="status">		
					<div class="movie" id="movie${list.code}">
					<c:if test="${list.grade eq '15??? ??????'}">
					<img src="images/grade-15.png" alt="15??? ??????"style='width:24px;height:24px;'>
					</c:if>
					<c:if test="${list.grade eq '12??? ??????'}">
					<img src="images/grade-12.png" alt="12??? ??????"style='width:24px;height:24px;'>
					</c:if>
					<c:if test="${list.grade eq '??????'}">
					<img src="images/grade-all.png" alt="???????????????"style='width:24px;height:24px;'>
					</c:if>
					<c:if test="${list.grade eq '????????? ????????????'}">
					<img src="images/grade-19.png" alt="????????? ????????????"style='width:24px;height:24px;'>
					</c:if>
					<a class="title-a">${list.title}</a>
					<input type="hidden" id="release" value="${list.releaseDate}">
					<input type="hidden" id="price" value="${list.price}">					
					</div>
				</c:forEach>

			</div>
		</div>
		<div class="theater-part">
			<div class="reserve-title">??????</div>
			<div class="theater-container">
                <div class="theater-wrapper">
                    <div class="theater-location-wrapper">
                        <button class="theater-location active">??????(21)</button>
                        <button class="theater-location">??????(0)</button>
                        <button class="theater-location">??????(0)</button>
                        <button class="theater-location">??????(0)</button>
                    </div>
                    <div class="theater-place-wrapper">
                    	<button class="theater-place">??????</button>
                        <button class="theater-place">??????</button>
                        <button class="theater-place">????????????</button>
                        <button class="theater-place">??????</button>
                        <button class="theater-place">?????????</button>
                        <button class="theater-place">?????????</button>
                        <button class="theater-place">??????</button>
                        <button class="theater-place">??????</button>
                        <button class="theater-place">??????</button>
                        <button class="theater-place">??????</button>
                        <button class="theater-place">??????</button>
                        <button class="theater-place">??????</button>
                        <button class="theater-place">??????</button>
                        <button class="theater-place">?????????</button>
                        <button class="theater-place">?????????</button>
                        <button class="theater-place">?????????</button>
                        <button class="theater-place">?????????</button>
                        <button class="theater-place">??????</button>
                        <button class="theater-place">??????</button>
                        <button class="theater-place">??????</button>
                        <button class="theater-place">??????</button>
                    </div>
                </div>
            </div>
		</div>
		<div class="day-part">
			<div class="reserve-title">??????</div>
			<div class="reserve-date"></div>
		</div>
		<div class="time-part">
			<div class="reserve-title">??????</div>
			
			<div id="checkOk" >
				<div style="text-align:center; margin-top:200px; font-size:18px;"><b>??????,??????,????????? ????????? ?????????.</b></div>
			</div>
		</div>
	</div>
	<%@ include file="seat.jsp"%>
	
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/popper.js"></script>???
	<script src="js/movieSearch.js"></script>
	<script src="js/seat.js"></script>
	<script src="js/elementCheck.js"></script>
	<script src="js/ticket.js"></script>
	<script src="js/jquery.blockUI.js"></script>
	<script>
		var code = "<%=(String)request.getAttribute("code")%>";
		var timecheck;
		
        const date = new Date();
        // console.log(date.getFullYear());
        var lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
        const reserveDate = document.querySelector(".reserve-date");     
            const weekOfDay = ["???", "???", "???", "???", "???", "???", "???"]
            const year = date.getFullYear();
            const month = date.getMonth()+1;
            for (i = date.getDate(); i <= lastDay.getDate(); i++) {

                const button = document.createElement("button");
                const spanWeekOfDay = document.createElement("span");
                const spanDay = document.createElement("span");

                //class??????
                button.classList = "movie-date-wrapper"
                spanWeekOfDay.classList = "movie-week-of-day";
                spanDay.classList = "movie-day";

                const dayOfWeek = weekOfDay[new Date(year + "-" + month + "-" + i).getDay()];
				console.log(new Date(year + "-" + month + "-" + i))		
                //?????? ??????
                if (dayOfWeek === "???") {
                    spanWeekOfDay.classList.add("saturday");
                    spanDay.classList.add("saturday");
                } else if (dayOfWeek === "???") {
                    spanWeekOfDay.classList.add("sunday");
                    spanDay.classList.add("sunday");
                }
                spanWeekOfDay.innerHTML = dayOfWeek;
                button.append(spanWeekOfDay);
                //?????? ??????
                spanDay.innerHTML = i;
                button.append(spanDay);
                //button.append(i);
                reserveDate.append(button);

                dayClickEvent(button);
                
            }
            var m =document.createElement("span");
            $(m).css("color","gray");
            $(m).css("font-size","18px");
            $(m).css("padding-top","20px");
            $(m).css("padding-bottom","20px");
            $(m).addClass("nextMonth");
            m.innerHTML = "<b>"+(month+1)+"???</b>";
            reserveDate.append(m);
            lastDay2 = new Date(date.getFullYear(), date.getMonth() + 2, 0);
            const month2 = lastDay2.getMonth()+1;
            
            for (i = 1; i <= lastDay2.getDate(); i++) {

                const button = document.createElement("button");
                const spanWeekOfDay = document.createElement("span");
                const spanDay = document.createElement("span");

                //class??????
                button.classList = "movie-date-wrapper"
                spanWeekOfDay.classList = "movie-week-of-day";
                spanDay.classList = "movie-day";

                const dayOfWeek = weekOfDay[new Date(year + "-" + month2 + "-" + i).getDay()];
						
                //?????? ??????
                if (dayOfWeek === "???") {
                    spanWeekOfDay.classList.add("saturday");
                    spanDay.classList.add("saturday");
                } else if (dayOfWeek === "???") {
                    spanWeekOfDay.classList.add("sunday");
                    spanDay.classList.add("sunday");
                }
                spanWeekOfDay.innerHTML = dayOfWeek;
                button.append(spanWeekOfDay);
                //?????? ??????
                spanDay.innerHTML = i;
                button.append(spanDay);
                //button.append(i);
                reserveDate.append(button);

                dayClickEvent(button);
                
            }
            if(code!="null"){
            	$("#movie"+code).addClass("active");	
            }
        function dayClickEvent(button) {
            button.addEventListener("click", function() {
                const movieDateWrapperActive = document.querySelectorAll(".movie-date-wrapper-active");
                
                $(".movie-date-wrapper").removeClass("movie-date-wrapper-active");
                
                button.classList.add("movie-date-wrapper-active");
                timecheck=0;
                var chtml="";
                
          		console.log($(".movie-date-wrapper-active .movie-day").text());  // ????????? ??????.
          		console.log($(".movie-date-wrapper-active .movie-week-of-day").text());  // ????????? ??????.
            })
        }
              
        $(document).on("click",".time-select",function(){ 
        	$(".time-select").removeClass("time-wrapper-active");
        	$(this).addClass("time-wrapper-active");
        	timecheck=$(".time-wrapper-active").length;
        });
        
        $(document).on("click",".theater-place",function(){ 
        	$(".theater-place").removeClass("active");
        	$(this).addClass("active");
        	timecheck=0;
        });
        
        $(document).on("click",".movie",function(){
        	$(".movie").removeClass("active");
        	$(this).addClass("active");
        	$(".movie-date-wrapper").removeClass("norelease");
        	$(".movie-date-wrapper").attr("disabled",false);
        
        	timecheck=0;
        	
        });
      
        function nowMovieSort(){
        	$(".sort-korean").removeClass("sort-selected");
        	$(".sort-rate").addClass("sort-selected");
        	
        	$.ajax({
        		type : "post",
        		url : "nowMovie",
        		dataType : 'json',
        		async: false,
        		complete : function(){
        			
                   	var chtml="<c:forEach var='list' items='${nlist}' varStatus='status'>"+
               	   	"<div class='movie' id='movie${list.code}'>"+
               	   	"<c:if test='${list.grade eq \'15??? ??????\'}'>"+
               	   	"<img src='images/grade-15.png' style='width:24px;height:24px;'>"+
               	   	"</c:if>"+
               	 	"<c:if test='${list.grade eq \'12??? ??????\'}'>"+
            	   	"<img src='images/grade-12.png' style='width:24px;height:24px;'>"+
            	   	"</c:if>"+
            	   	"<c:if test='${list.grade eq \'??????\'}'>"+
               	   	"<img src='images/grade-all.png' style='width:24px;height:24px;'>"+
               	   	"</c:if>"+
               	 	"<c:if test='${list.grade eq \'????????? ????????????\'}'>"+
            	   	"<img src='images/grade-19.png' style='width:24px;height:24px;'>"+
            	   	"</c:if>"+
               	   	"<a class='title-a'>${list.title}</a><input type='hidden' id='release' value='${list.releaseDate}'></div></c:forEach>"
                   $("#movie-list").children().remove();
                   	$("#movie-list").html(chtml)
        		}
        		});
        }
        
	   function koreaSort(){
		   $(".sort-rate").removeClass("sort-selected");
       	   $(".sort-korean").addClass("sort-selected");
       	   
       	$.ajax({
    		type : "post",
    		url : "koreanSort",
    		dataType : 'json',
    		async: false,
    		complete : function(){
           	   	var chtml="<c:forEach var='list' items='${klist}' varStatus='status'>"+
           	   	"<div class='movie' id='movie${list.code}'>"+
           	   	"<c:if test='${list.grade eq \'15??? ??????\'}'>"+
           	   	"<img src='images/grade-15.png' style='width:24px;height:24px;'>"+
           	   	"</c:if>"+
           	 	"<c:if test='${list.grade eq \'12??? ??????\'}'>"+
        	   	"<img src='images/grade-12.png' style='width:24px;height:24px;'>"+
        	   	"</c:if>"+
        	   	"<c:if test='${list.grade eq \'??????\'}'>"+
           	   	"<img src='images/grade-all.png' style='width:24px;height:24px;'>"+
           	   	"</c:if>"+
           	 	"<c:if test='${list.grade eq \'????????? ????????????\'}'>"+
        	   	"<img src='images/grade-19.png' style='width:24px;height:24px;'>"+
        	   	"</c:if>"+
           	   	"<a class='title-a'>${list.title}</a><input type='hidden' id='release' value='${list.releaseDate}'></div></c:forEach>"
           	   	$("#movie-list").children().remove();
           		$("#movie-list").html(chtml)	
    		}
    		});
       	   
        }
	   
    </script>
    <%@ include file="../layout/footer.jsp"%>???
</body>
</html>