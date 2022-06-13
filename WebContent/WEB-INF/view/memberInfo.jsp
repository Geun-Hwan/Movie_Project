<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/admin_header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>회원 정보</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/star.css">
<link rel="stylesheet" href="css/loading.css">
<link href="css/page.css" rel="stylesheet" />
<link href="css/mypage.css" rel="stylesheet" />
<style type="text/css">
.liston{
		background-color:#ececf6;	
	}
</style>
</head>

<body>
<!-- 멤버리스트에서 회원 클릭시 해당 회원 정보 보여주기. -->
<c:choose>
		<c:when test="${userid==null||admin!=1}">
		<script type="text/javascript">
			alert("권한이 없습니다.");
			location.href="main";
		</script>
	</c:when>
</c:choose>

<c:if test='${member.userId == null }'>
	<script type="text/javascript">
		alert("탈퇴한 회원 또는 존재하지 않는 회원입니다.");
		location.href="adminMyPage?userid=admin"
	</script>
</c:if>
<div style="width:1400px;display:flex; margin:0 auto;">
<div class="border-end bg-white" id="sidebar-wrapper"
			style="width: 200px; margin: 0 auto; padding-top: 40px; padding-right: 40px; margin-right:20px;">
			<div class="list-group list-group-flush">
				<!-- 관리자 마이페이지...카테고리? 전체 문의  확인, 신고 내역 확인, 전체회원 예매내역? 등등-->
				<input type="hidden" id="myid" value="${member.userId}">
				<a class="list-group-item list-group-item-action list-group-item-light p-3 custum-list" href="#!" onclick="myAsk()" >문의 목록</a>
				<a class="list-group-item list-group-item-action list-group-item-light p-3 custum-list"	href="#!" onclick="myTicket()">예매 목록</a>
				<a class="list-group-item list-group-item-action list-group-item-light p-3 custum-list"	href="#!" onclick="myReview()">리뷰 목록</a>
				<c:if test="${member.admin == 0}">
				<a class="list-group-item list-group-item-action list-group-item-light p-3 custum-list"
				onclick="if(!confirm('회원을 정지 시키겠습니까?(기본 한달)')){return false;}"
				href="memberBan?userId=${member.userId}">회원 정지</a>
				</c:if>
				<c:if test="${member.admin ==3}">
				<a class="list-group-item list-group-item-action list-group-item-light p-3"
				onclick="if(!confirm('회원 정지를 해제 하시겠습니까?')){return false;}"
				href="memberPermit?userId=${member.userId}">회원 정지 해제</a>
				</c:if>
				<a class="list-group-item list-group-item-action list-group-item-light p-3"
				onclick="if(!confirm('회원을 탈퇴 시키겠습니까?')){return false;}"
				href="memberDelete?userId=${member.userId}">회원 탈퇴</a>
			</div>
</div>
<div class="d-flex" id="myContent" style="width: 1400px; margin: 0 auto; margin-top:20px;">
		<div class="container-fluid" style="width: 1200px; padding-top: 40px;">
			<h3 style="margin-bottom:30px;">${member.name}님회원 정보</h3>
			<p>
				이름 : ${member.name}<br> 아이디 : ${member.userId}<br> 비밀번호 :
				${member.userPwd}<br> 생일 : ${member.birth}<br> 이메일 :
				${member.email}<br> 성별 : ${member.gender}<br> 회원 가입일 :
				${member.reg_date}<br>
				<c:if test="${member.admin ==3}">
				정지 해제일 : ${member.ban_date}<br>
				</c:if>
			</p>
		</div>
	</div>
</div>
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