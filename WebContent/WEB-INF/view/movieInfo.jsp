<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 정보</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/module.css">
<link rel="stylesheet" href="css/star.css">
<link rel="stylesheet" href="css/page.css">
<link rel="stylesheet" href="css/loading.css">
<link rel="stylesheet" href="css/trailer.css">

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

<c:choose>
	<c:when test="${count==0}">
		<script type="text/javascript">
		alert("존재하지 않는 영화입니다.");
		history.go(-1);
		</script>
	</c:when>
</c:choose>
	<!-- movieList에서 선택한 영화의 정보 영화 이미지 정보(감독,줄거리,개봉일 등등) 밑으로 리뷰,별점 -->
	
	<div class="sect-base-movie"
		style="width: 1050px; margin: 0 auto; padding-top: 30px;">
		<h3>
			<strong>${movie.title}</strong>기본정보
		</h3>
		<div class="box-image">
			<a
				href="${movie.poster}"
				title="포스터 크게 보기 새창" target="_blank"> <span class="thumb-image">
					<img src="${movie.poster}" alt="${movie.title}포스터 새창"
					onerror="errorImage(this)"> <span class="ico-posterdetail">포스터
						크게 보기</span> <span class="ico-grade grade-15"> ${movie.grade}</span>
			</span>
			</a>
		</div>
		<div class="box-contents" style="width: 800px;">
			<div class="title">
				<strong>${movie.title}</strong>
				<p>-</p>
			</div>
			<div class="score">
				<strong class="percent">예매율&nbsp;<span>${movie.percent}%</span></strong>
				${movie.releaseDate}

			</div>

			<div class="spec">
				<dl>
					<dt>감독 :&nbsp;</dt>
					<dd>
						<a href="#">${movie.director}</a>
					</dd>

					<dd></dd>

					<dt>&nbsp;/ 배우 :&nbsp;</dt>
					<dd class="on">
						<c:forEach var="actor" items="${actor}" varStatus="status">
							<c:choose>
								<c:when test="${status.last}">
									<a href=>${actor}</a>
								</c:when>
								<c:otherwise>
									<a href=>${actor}</a>
										,&nbsp;
							    </c:otherwise>
							</c:choose>
						</c:forEach>
					</dd>

					<dt>장르 :&nbsp;${movie.category}</dt>
					<dd></dd>
					<dt>&nbsp;/ 기본 :&nbsp;</dt>
					<dd class="on">${movie.grade},&nbsp;${movie.runningTime}분,${movie.nation}&nbsp;</dd>
					<dt>개봉 :&nbsp;</dt>
					<dd class="on">${movie.releaseDate}</dd>

				</dl>
			</div>
			<span class="screentype"> </span> <span class="like">
				${movie.releaseDate} 영화찜하기 -> 프리에그 선택 변경(조회하여 노출) <a
				class="link-count" href="javascript:void (0);"> <i
					class="sprite_preegg btn_md default"></i>프리에그
			</a> <a class="link-reservation"
				href="/ticket/?MOVIE_CD=20029453&amp;MOVIE_CD_GROUP=20029381">예매</a>

			</span>
		</div>
			<div class="cols-content" id="menu">
				<div class="col-detail" style="padding-top:30px;">
					<!-- 메뉴가 선택되면 a 에 title="선택" 이라고 넣는다 -->
					<ul class="tab-menu" style="text-align: left;">
						<li><a title="현재 선택됨" href="#">주요정보 </a></li>
						<li><a href="#">트레일러</a></li>
						<li><a href="#">스틸컷</a></li>
						<li><a href="#movieReview">평점/리뷰</a></li>
						<li class="last"><a href="#">상영시간표</a></li>
					</ul>
					
				</div>
			<div class="sect-story-movie" style="padding-top:30px;">${movie.synopsis}</div>
			
			<!--  <div class = "play" id = "showTrailer">
				<svg version = "1.1" id = "Layer_1" xmlns = "http://www.w3.org/2000/svg"></svg>
			</div>  --> 
			
			<!-- 트레일러 -->
			<!-- <aside id = "blackout" class = "overlay">
				<div id = "trailerModal" class = "modal">
					<div id = "trailer"></div> YouTube 플레이어로 대체
				</div>
				<button id = "hideTrailer" class = "modal_close">닫기</button>
			</aside> -->
			
			<div id="movieReview" style="width: 1050px; padding-top: 30px; margin:0 auto; ">
				<h2 style="font-size:20px; margin-left:40px;">리뷰쓰기</h2>
				<form action="reviewWrite.do" method="post" id="reviewform">
					<input type="hidden" value="${movie.code}" name="code" id="code">
					<input type="hidden" value="${userid}" name="userid" id="userid">
					<input type="hidden" value="${movie.title}" name="title" id="title">
					<div style="width: 1050px; display:flex; flex-direction:row;">
					<textarea class="form-control"id="content"cols="60" rows="5" name="content" style="margin-left:30px;width:500px;" maxlength="250" placeholder="250바이트 이하로 작성해주세요"   onkeyup="fncChkByte(this, 250)"></textarea>
						<div style="display:flex; flex-direction:column; border:1px ; margin-left:15px; ">
							<div class="star-rating space-x-4 mx-auto" style="height:40px; font-size:20px;">
								<input type="radio" id="5-stars" name="score" value="5"  checked="checked"/>
								<label for="5-stars" class="star">★</label>
								<input type="radio" id="4-stars" name="score" value="4" />
								<label for="4-stars" class="star">★</label>
								<input type="radio" id="3-stars" name="score" value="3"  />
								<label for="3-stars" class="star">★</label>
								<input type="radio" id="2-stars" name="score" value="2"/>
								<label for="2-stars" class="star">★</label>
								<input type="radio" id="1-star" name="score" value="1" />
								<label for="1-star" class="star">★</label>		
							</div>
							<div style=margin-top:30px;>
								<button class="btn btn-outline-secondary my-2 my-sm-0" type="button" onclick="review()" style="height:50px; margin-left:20px;">리뷰 남기기</button> <!-- 로그인 확인 -->
							</div>
						</div>
					</div>
					</form>
					<div style="width:500px;display:flex; flex-direction:row; justify-content:space-between">
					<ul class="sort" id="sortTab">
                    <li class="sortTab on" id="datesort" value="1"style="text-align:left; width:60px; padding-right:0px;"><a href="javascript:void(0);" onclick="datesort()">최신순<span class="arrow-down">
                    </span>
                    </a></li>
                    <li class="sortTab" style="padding-left:20px;" id="likesort" value="2"><a href="javascript:void(0);" onclick="likesort()">추천순<span class="arrow-down"></span></a></li>
                    </ul>
                    <div id="content_cnt" style="padding-top:5px;"><span id="count">0</span>/<span id="max-count">250 Byte</span></div>
                    </div>
					<div class="wrap-persongrade" style= " width:950px; " id="reviewboard">
                    <!-- 평점 목록 -->
                    
                    <div id="checkout">
                    <ul id="movie_point_list_container" class="point_col2" style="display:flex; flex-direction:column; list-style-type:none;">
                    <!-- for문으로 감싸기 최대 3행 2로 나눴을때 몫이 없고 나머지가 1이면 1번실행 -->
                    <c:if test="${totalData != 0}">
                    <c:forEach var="size" begin="0" end="${rcount}" varStatus="status">
						<li class="" data-spoilercnt="0"data-reportcnt="0"><a href="javascript:return false;"
							class="screen_spoiler">&nbsp;</a>
							<div style="width:950px;display:flex; flex-direction:row; height:280px;">
								<!-- for문으로 감싸기 최대 2열  2로 나눠서 나머지 있으면 마지막 행에선 1번만 실행 아니면 2번-->
							<c:if test="${!status.last}">
								<c:forEach var="review" items="${rlist}" begin="${0+(2*size)}" end="${1+(2*size)}" varStatus="status3">
												
								<ul class="writerinfo" style='padding-right:30px; padding-left:20px;display:flex; flex-direction:column; list-style-type:none; border:0.5px solid rgba(0, 0, 0, .1); border-radius:9px;'>
									<li class='writer-name' style='margin-left:28px; padding-top:20px; display:flex; flex-direction:row; justify-content:space-between; '>
									<span id="reuserid${status3.index}">${review.userid}</span>
									<!-- 본인이 작성한 글에는 신고하기 숨기기 조건달기 -->
									<c:if test="${userid != review.userid && userid !='admin' &&review.userid != 'admin'}">
											<span id="userReport"><a
												href="#report${review.userid}" id="report${review.userid}" onclick="userReport('${review.userid}','${review.write_date}')" >신고하기</a></span>
										</c:if> <!-- 관리자는 신고대신 정보보기 만들기 -->
										<c:if test="${userid =='admin' && review.userid !='admin'}"><span id="memberInfo"><a
												href="#" id="info" onclick="memberInfo('${review.userid}')">회원보기</a></span></c:if>  
									</li>
									<li>
										<div style='margin-left:20px;'>
										<c:forEach begin="0" end="4" var='i'>
											<c:choose>
												<c:when test="${i<review.score}">
													<span style="color:#fdf113;">★</span>
												</c:when>
												<c:otherwise>
													<span style="color:#ded8ad">★</span>
												</c:otherwise>
											</c:choose>
										</c:forEach></div>
									</li>
									<li style='height:160px; margin-top:0px;'>
									<c:if test="${review.changeCheck ==1}">
										<span style="margin-left:20px;">[수정됨]</span>
									</c:if>
										<div style='word-break:break-all;height:130px; width:300px; margin-left:20px;' id="recontent${status3.index}">${review.content}</div>
										
									</li>
									<li class='writer-etc' style='margin-left:20px; padding-bottom:20px; display:flex; flex-direction:row; justify-content:space-between;'>
									<div style="padding-bottom:0px;"><span class="day" id="day${status3.index}">${review.write_date}</span>
										<span class="like point_like" id="${review.userid}"
											style="padding-left:5px;" onclick="reviewLike(this);"> <a
											href="javascript:return false;" class="btn_point_like"><span><img
													src="http://img.cgv.co.kr/R2014/images/point/ico_point_default.png"
													alt="like"></span></a>
											</span>
											<span style="padding-left:5px;"id="idLikeValue${review.userid}">${review.commentlike}</span>
										</div>
										<!-- 로그인 아이디와 작성자가 같으면  수정 삭제 보이기 관리자는 다 보이기-->
										<c:choose>
											<c:when test="${userid == review.userid || userid =='admin'}">
											<div style='margin-top:20px;'> 
												<button class="custombutton"type="button"data-toggle="modal"data-target="#reviewChange" onclick="reviewChange('${status3.index}')" style="padding-left:0px; border:0; width:40px;"><span style=' font-size:11px;'>수정</span></button>
												&nbsp;
												<button class="custombutton" type="button" style="border:0; width:40px; padding-left:0px;"><span style=' font-size:11px;' onclick="reviewDelete('${status3.index}')">삭제</span></button>
											</div>
											</c:when>
										</c:choose>
										</li>	
									</ul>
									<!-- 2열 반복문 종료 -->	
									</c:forEach>
								</c:if>
								<c:if test="${status.last}">
								<c:forEach var="review" items="${rlist}" begin="${0+(2*size)}" end="${fn:length(rlist)}" varStatus="status2"> <!-- 아이디 수정 -->
												
								<ul class="writerinfo" style="padding-right:30px; padding-left:20px;display:flex; flex-direction:column; list-style-type:none; border:0.5px solid rgba(0, 0, 0, .1); border-radius:9px;">
									<li class="writer-name" style="margin-left:28px; padding-top:20px; display:flex; flex-direction:row; justify-content:space-between;">
									<span id="reuserid${status2.index}">${review.userid}</span>
									<!-- 본인이 작성한 글에는 신고하기 숨기기 조건달기 -->
									<c:if test="${userid != review.userid && userid !='admin' &&review.userid != 'admin'}">
											<span id="userReport"><a
												href="#report${review.userid}" id="report${review.userid}" onclick="userReport('${review.userid}','${review.write_date}')" >신고하기</a></span>
										</c:if> <!-- 관리자는 신고대신 정보보기 만들기 -->
										<c:if test="${userid =='admin' && review.userid !='admin'}"><span id="memberInfo"><a
												href="#" id="info" onclick="memberInfo('${review.userid}')">회원보기</a></span></c:if>
									<!-- 관리자는 신고대신 정보보기 만들기 -->  
									</li>
									<li>
										<div style="margin-left:20px;">
										<c:forEach begin="0" end="4" var="i">
											<c:choose>
												<c:when test="${i<review.score}">
													<span style="color:#fdf113;">★</span>
												</c:when>
												<c:otherwise>
													<span style="color:#ded8ad">★</span>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										</div>
									</li>
									<li style="height:160px; margin-top:0px;">
									<c:if test="${review.changeCheck ==1}">
										<span style="margin-left:20px;">[수정됨]</span>
									</c:if>
										<div style="word-break:break-all; height:130px; width:300px; margin-left:20px;" id="recontent${status2.index}">${review.content}</div>
										
									</li>
									<li class="writer-etc" style="margin-left:20px; padding-bottom:20px; display:flex; flex-direction:row; justify-content:space-between;">
									<div style="padding-bottom:0px;"><span class="day" id="day${status2.index}">${review.write_date}</span>
										<span class="like point_like" id="${review.userid}"
											style="padding-left:5px;" onclick="reviewLike(this);"> <a
											href="javascript:return false;" class="btn_point_like"><span><img
													src="http://img.cgv.co.kr/R2014/images/point/ico_point_default.png"
													alt="like"></span></a>
													
											</span>
											<span style="padding-left:5px;"id="idLikeValue${review.userid}">${review.commentlike}</span>
										</div>
										<!-- 로그인 아이디와 작성자가 같으면  수정 삭제 보이기 관리자는 다 보이기-->
										
											<c:choose>
											<c:when test="${userid == review.userid || userid =='admin'}">
											<div style='margin-top:20px;'> 
												<button class="custombutton"type="button"data-toggle="modal"data-target="#reviewChange" onclick="reviewChange('${status2.index}')" style="padding-left:0px; border:0; width:40px;"><span style=' font-size:11px;'>수정</span></button>
												&nbsp;
												<button class="custombutton" type="button" style="border:0; width:40px; padding-left:0px;"><span style=' font-size:11px;' onclick="reviewDelete('${status2.index}')">삭제</span></button>
											</div>
											</c:when>
										</c:choose>
										</li>	
									</ul>
									<!-- 2열 반복문 종료 -->	
									</c:forEach>
								</c:if>	
								</div>
							</li>
							<!-- 3행 반복문 종료 -->
							</c:forEach>
							</c:if>
						</ul>	
						<!-- 페이징 처리 -->	
					<div style="text-align:center; width:816px; padding-left:40px; padding-top:20px;" id="paging">
                		<ul id="pagingul" style='list-style-type:none; padding:0px; margin:0 auto;'>
									<c:if test="${prev >0}">
										<li><a href='#${prev}' id='${prev}'> 이전 </a></li>
									</c:if>

									<c:forEach var="i" begin="${first}" end="${last}">
										<c:choose>
											<c:when test="${currentPage==i}">
												<li class=on><a href='#${i}' id="${i}">${i}</a></li>
											</c:when>
											<c:otherwise>
												<li><a href='#${i}' id="${i}">${i}</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>

									<c:if test="${last<totalPage}">
										<li><a href='#${next}' id='${next}'> 다음 </a></li>
									</c:if>
							</ul>
						</div>			
                	</div>
                	
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="./reviewUpdate.jsp"></jsp:include>
	<jsp:include page="./report.jsp"></jsp:include>
	
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/popper.js"></script>
	​<script src="js/movieSearch.js"></script>
	​<script src="js/page.js"></script>
	​<script src="js/review.js"></script>
	​<script src="js/paging.js"></script>
	​<script src="js/jquery.blockUI.js"></script>
	<script src="js/trailer.js"></script>
	<script type="text/javascript">
	
	
	
	function userReport(writeuser,writeDay){
		console.log(writeuser);
		console.log(writeDay);
		var code = $("#code").val();
		var reporter = $("#userid").val();
		var writer = writeuser;
		$("#writeUser").val(writeuser);
		$("#writeDay").val(writeDay);
		$("#report_code").val(code);
		$("#reportUser").val(reporter);
		if($("#reportUser").val() == ""){
			alert("로그인 이후 이용해주세요");
			return;
		}
		if(reporter=='kakao'){
			alert("카카오유저 기능 미구현");
			return;
		}
		var check= true;
			$.ajax({
				type : "post",
				url : "reportCheck",
				data : {
					writer : writer,
					reporter : reporter,
					code : code
				},
				dataType : 'json',
				async: false,
				success : function(data) {
					if(data ==1){
						alert("이미 신고 처리중입니다.");
						check =false;
					}
				}
			});
		if(check==true){
		$('#reportModal').modal('show');
		console.log($("#reportUser").val());
		}
	}
	
	function reportdo(){
		
		var newForm = document.getElementById('reportform');
		newForm.method = "post";
		newForm.submit();
		$("#write-reson").val("");
	}
	function memberInfo(userid){
		location.href='memberInfo?userid='+userid;
	}
	$('#star a').click(function(){ 
		 $(this).parent().children("a").removeClass("ons");    
		 $(this).addClass("ons").prevAll("a").addClass("ons");
		 console.log($(this).attr("value"));
		 $("#rescore").val($(this).attr("value"));
	 });
		
		function review(){
			var userid='<%=(String)session.getAttribute("userid")%>';
			var admin='<%=session.getAttribute("admin")%>';
			var code = $("#code").val();
			var writeCheck =true;
			var string = $("#content").val();
				if(userid=='null'){
					alert("로그인 이후 이용해주세요");
					return;
				}
				
				if(userid=='kakao'){
					alert("카카오유저 기능 미구현");
					return;
				}
				
				if(!($("#content").val().trim().length)){ // 공백만 작성
					alert("내용을 입력해 주세요.");
					return;
				}
			
				// code, userid 로 review db 작업
				
				if(admin==0){ //일반 유저는 영화 하나당 리뷰 하나만 가능
					$.ajax({
						type : "post",
						url : "reviewConfirm",
						data : {
							userid : userid,
							code : code
						},
						dataType : 'json',
						async: false,
						success : function(data) {
							if(data !=0){
								alert("이미 작성한 리뷰가 있습니다.");
								writeCheck= false;
				
							}else{
								writeCheck=true;
							}
						}
					});
				}
		if(writeCheck == true) {
				var newForm = document.getElementById('reviewform');
				newForm.method = "post";
				newForm.submit();
			}
		}
	</script>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>