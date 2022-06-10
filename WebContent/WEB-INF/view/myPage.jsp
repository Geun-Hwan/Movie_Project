<%@page import="model.Ticket"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.TicketDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../layout/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="css/bootstrap.css" rel="stylesheet" />
<link href="css/star.css" rel="stylesheet" />
<link href="css/page.css" rel="stylesheet" />
<link href="css/mypage.css" rel="stylesheet" />
<link href="css/loading.css" rel="stylesheet" />
<style type="text/css">
	.liston{
		background-color:#ececf6;	
	}
</style>
<title>나의 정보</title>
</head>
<body>
	<c:choose>
		<c:when test="${userid==null}">
		<script type="text/javascript">
			alert("로그인이 필요한 페이지 입니다.");
			location.href="login";
		</script>
		</c:when>
		<c:when test="${userid!=null&&admin==1}">
			<script type="text/javascript">
				location.href="adminMyPage";
			</script>
		</c:when>
		<c:when test="${userid eq 'kakao'}">
			<script type="text/javascript">
				alert("카카오 유저 미구현");
				history.go(-1);
			</script>
		</c:when>
	</c:choose>
	
	<% 
	ArrayList<Ticket> tlist =(ArrayList<Ticket>)request.getAttribute("tlist");
	%>
	<input type="hidden" id="myid" value="${userid}">
	<!-- 회원탈퇴 페이지를 따로 만들지 수정페이지에서 탈퇴기능을 넣을지 ?-->
	<div class="d-flex" id="wrapper" style="width: 1300px; margin: 0 auto;">
		<div class="border-end bg-white" id="sidebar-wrapper" style="width: 200px; margin-left:50px; padding-top: 40px; ">
			<div class="list-group list-group-flush">  <!-- 해당 리스트를 클릭하면 myPage 에서만 이동하게 끔 . -->
				<a class="list-group-item list-group-item-action list-group-item-light p-3 custum-list" href="#" onclick="myTicket()">예매내역</a> 
				<a class="list-group-item list-group-item-action list-group-item-light p-3 custum-list" href="#" onclick="myAsk()">문의내역</a> <!-- 고객센터에 자신이 문의한 글을 게시판 형식으로 보여줌 다른 table 생성 해야함-->
				<a class="list-group-item list-group-item-action list-group-item-light p-3 custum-list" href="#" onclick="myReview()">작성한 리뷰</a> <!-- 본인이 작성한 리뷰만 게시판 형식으로  -->
				<a class="list-group-item list-group-item-action list-group-item-light p-3 custum-list" href="#" onclick="myInfoUpdate()">개인정보 수정</a> 
			</div>
			<!-- 회원탈퇴 버튼 작게 추가 -->
		</div>

		<div class="container-fluid" style="width: 900px; padding-top: 50px; padding-left:0px;" id="myContent">
			<h2 class="mb-5" style="text-align:center;" id="myTitle">마이 페이지</h2>
			<p style="text-align:center;" id="mysubTitle"><b>개인 정보</b></p> <!-- 간단한 정보만 노출? -->
			<div id="myInfo" style="display:flex;">
			<div style="width:200px;height:250px;">
				<c:if test="${member.gender eq '남'}">
					<img style="width:200px; height:230px;"alt="남자" src="images/man.jpg">
				</c:if>
				<c:if test="${member.gender eq '여'}">
					<img style="width:200px; height:230px;" alt="여자" src="images/girl.jpg">
				</c:if>
			</div>
			<div id="memberInfo" style="margin-left:30px;">
			<div style="align-items: center; display:flex;"class="name"><span style="width:100px; text-align:center;" >이름</span><input style="width:250px;"type="text" class="form-control" readonly value="${member.name}"></div>
			<div style="align-items: center;display:flex;"class="id"><span style="width:100px; text-align:center;">아이디</span><input style="width:250px;"type="text" class="form-control" readonly value="${member.userId}"></div>
			<div style="align-items: center; display:flex;"class="email"><span style="width:100px; text-align:center;">이메일</span><input style="width:250px;"type="text" class="form-control" readonly value="${member.email}"></div>
			<div style="align-items: center;display:flex;"class="gender"><span style="width:100px; text-align:center;">성별</span><input style="width:250px;"type="text" class="form-control" readonly value="${member.gender}"></div>
			<div style="align-items: center;display:flex;"class="birth"><span style="width:100px; text-align:center;">생일</span><input style="width:250px;" type="text" class="form-control" readonly value="${member.birth}"></div>
			<div style="align-items: center;display:flex;"class="reg_date"><span style="width:100px; text-align:center;">가입일</span><input style="width:250px;" type="text" class="form-control" readonly value="${member.reg_date}"></div>
			</div>
			<div style="margin-left:30px; witdh:250px;">
				<button class="btn btn-light" type="button">button1</button>
				<button class="btn btn-light"type="button">button2</button>
				<button class="btn btn-light"type="button">button3</button>
			</div>	
			</div>
			<div style="text-align:center; padding-top:50px; margin-top:40px;"><h2>최신 예매내역</h2>
				<br>최근 예매한 기준으로 3개만 노출됩니다.
				<%
						if (tlist.size()==0) {
					%>
					<div style="font-size:30px; padding-top:30px;">예약한 영화가 없습니다</div>
									
					<%
						} else {
					%>
							<div class="movie-reserve-list">
					<%
							for (int i = 0; i < tlist.size(); i++) {
								Ticket ticket = tlist.get(i);
					%>
					<div class="movie-reserve">
						<div class="movie-reserve-age"><%=ticket.getMovieAge()%></div>
						<div class="movie-reserve-title" style="text-overflow:ellipsis;white-space:nowrap;overflow: hidden;"><%=ticket.getTitle() %></div>
						<div class="movie-reserve-theater-wrapper">
							<div><%=ticket.getCinema() %></div>
							&nbsp;/&nbsp;
							<div class="ticket-numeber"><%=ticket.getPerson() %>장</div>
						</div>
						<div class="movie-reserve-seats"><%=ticket.getSeat() %></div>
						<div class="movie-reserve-date-wrapper">
							<div class="movie-reserve-date"><%=ticket.getMovieDate() %></div>
							<div class="movie-reserve-runningTime"><%=ticket.getMovieTime() %></div>
						</div>
						<div class="movie"></div>

						<div class="pay-information-wrapper">
							<div class="pay-information-date-wrapper">
								<div class="pay-information-date-title">결제한 날</div>
								<div class="pay-information-date"><%=ticket.getTicketDate()%></div>
							</div>

							<div class="pay-information-money-wrapper">
								<div class="pay-information-money-title">결제한 비용</div>
								<div class="pay-information-money"><%=ticket.getPrice() %>원</div>
							</div>

							<div class="barcode-wrapper">
								<div>EZV</div>
								<img src="images/barcode.png">
							</div>

						</div>
					</div>
					<%
						}
							}
					%>
			</div>
		</div>
	</div>
	</div>
	
	<!-- 리뷰 수정 클릭시 모달 -->
	<div class="modal fade" id="reviewChange" tabindex="-1" role="dialog" aria-hidden="true" style="height:600px;" data-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">리뷰 수정</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="reviewUpdate" method="post" id="myreviewChangeForm">
					<div class="form-group" style="display:flex; flex-direction:row; width:500px;">
							<label for="retitle" class="col-form-label">제목</label>
							<input type="text" class="form-control" id="retitle" name="retitle" readonly style=" width:400px; margin-left:10px;"/>
					</div>
					<div class="form-group" style="display:flex; flex-direction:row; width:500px;">
							<label for="reuser" class="col-form-label">작성자</label>
							<input type="text" class="form-control" id="reuser" name="reuserid" readonly style="width:150px; margin-left:20px;"/>
							<input type="hidden" name="code2" id="code2">
							<label for="write_date2" class="col-form-label" style="margin-left:10px;">작성일</label>
							<input type="text" class="form-control" id="write_date2" name="write_date2" readonly style="width:150px; margin-left:20px;"/> 
					</div>
						<div class="form-group" style="display:flex; flex-direction:row;">
							<label for="score" class="col-form-label">별점</label>
							<div style="padding-left:20px;">
							 <P id="star" style="font-size:20px;"> <!-- 부모 -->
						
								   <a href="#" class="ons" value="1">★</a> <!-- 자식들-->
								   <a href="#" class="ons" value="2">★</a>
								   <a href="#" class="ons" value="3">★</a>
								   <a href="#" class="ons" value="4">★</a>
								   <a href="#" class="ons" value="5">★</a>
								</p>
							</div>
							
							<div style="padding-left:20px; margin-top:10px;"><p><b>별점 미선택시 기존 점수 사용</b></p></div>
							<input type="hidden" name="rescore" id="rescore">
						</div>
						<div class="form-group" style="height:300px;">
							<label for="modal-review" class="col-form-label">내용</label>
							<textarea class="form-control" rows="50" cols="6" name="recontent"style="width:400px; height:250px; margin-left:15px;"maxlength="300" id="modal-review" onkeyup="fncChkByte(this, 250)"></textarea>
							<div style="float:right; padding-top:20px; margin-right:30px;"><span id="rev-count">0</span>/<span>250 Byte</span></div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="button" type="button"class="btn btn-primary"onclick="myReviewSubmit()">수정</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="qnaInfomodal.jsp" %>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/popper.js"></script>
	​<script src="js/movieSearch.js"></script>
	​<script src="js/mypage.js"></script>
	​<script src="js/jquery.blockUI.js"></script>
	<script type="text/javascript">
	$('#star a').click(function(){ 
		 $(this).parent().children("a").removeClass("ons");    
		 $(this).addClass("ons").prevAll("a").addClass("ons");
		 console.log($(this).attr("value"));
		 $("#rescore").val($(this).attr("value"));
	 });
	
	$(document).on("click","#pagingul li a",function(){ 
		 pageNum=$(this).attr("id");    
		 userid=$("#myid").val();
		
		 console.log(pageNum);
		 console.log(userid);
		 
		 $.ajax({
				type : "post",
					url : "myPagePaging",
					data : {
						pageNum : pageNum,
						userid : userid
					},
					async: true,
					dataType : 'json',
					beforeSoned : function(){
						$('.wrap-loading').removeClass('display-none');
						$.blockUI({ message: null });
					},
					complete : function ( ){
						$.ajax({
							type : "GET",
							url : "myReviewList",
							async : true,
							dataType : "html",
							cache : false,
							success : function(data2) {
								$("#myContent").children().remove();
								$('#myContent').html(data2);
							},
							complete : function(){
								$('.wrap-loading').addClass('display-none');
								$.unblockUI();
							}
						});
					}
			}); 							
	});
	
	$(document).on("click","#tpagingul li a",function(){ 
		 pageNum=$(this).attr("id");    
		 
		 console.log(pageNum);
		 console.log(userid);
		 
		 $('.wrap-loading').removeClass('display-none');
		$.blockUI({ message: null });
		 $.ajax({
				type : "post",
					url : "myTicketPaging",
					data : {
						pageNum : pageNum,
						userid : userid
					},
					async: true,
					dataType : 'json',					
					complete : function(){
						$.ajax({
							type : "GET",
							url : "myTicketList",
							async : true,
							dataType : "html",
							cache : false,
							success : function(data2) {
								$("#myContent").children().remove();
								$('#myContent').html(data2);
							},
							complete : function (){
								$('.wrap-loading').addClass('display-none');
								$.unblockUI();
							}
						});	
					}
			}); 						
	});
	</script>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>