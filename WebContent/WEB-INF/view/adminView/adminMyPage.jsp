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
<link rel="stylesheet" href="css/loading.css">
<link rel="stylesheet" href="css/page.css">
<link rel="stylesheet" href="css/star.css">
<style type="text/css">
	.liston{
		background-color:#ececf6;	
	}
</style>
<title>Insert title here</title>
</head>
<body>
<c:choose>
		<c:when test="${userid==null || admin!=1}">
			<script type="text/javascript">
				alert("권한이 없습니다.");
				location.href="main";
			</script>
		</c:when>
		<c:when test="${userid!=null&&admin==0}">
			<script type="text/javascript">
				location.href="myPage";
			</script>
		</c:when>
</c:choose>
	<div class="d-flex" id="wrapper" style="width: 1400px; margin: 0 auto;">
		<div class="border-end bg-white" id="sidebar-wrapper"
			style="width: 200px; margin: 0 auto; padding-top: 40px; padding-right: 40px;">
			<div class="list-group list-group-flush">
				<a
					class="list-group-item list-group-item-action list-group-item-light p-3 custum-list"
					href="#" onclick="askAll()">전체 문의 확인</a>
				<!-- 관리자 마이페이지...카테고리? 전체 문의  확인, 신고 내역 확인, 전체회원 예매내역? 등등-->
				<a class="list-group-item list-group-item-action list-group-item-light p-3 custum-list"
					href="#" onclick="reportAll()">신고 내역 확인</a> 
					<a class="list-group-item list-group-item-action list-group-item-light p-3 custum-list"
					href="#" onclick="ticketAll()">전체 예매 확인</a> 
					<a class="list-group-item list-group-item-action list-group-item-light p-3 custum-list"
					href="#!" onclick="banUserAll()">계정 정지 확인</a> 
					<a class="list-group-item list-group-item-action list-group-item-light p-3 custum-list"
					href="testpage" target="_blank">테스트 페이지</a>
			</div>
		</div>
		<div class="container-fluid" style="width: 1200px; padding-top: 40px;" id="adminContent">
			<h2 class="mb-5">관리자 페이지</h2>
			<p>관리자 페 이 지 <br>
			${adminInfo.userId}<br>
			${adminInfo.name}<br>
			${adminInfo.birth}<br>
			${adminInfo.email}<br>
			${adminInfo.reg_date}<br>
			</p>
			
		</div>
	</div>
	<%@ include file="../qnaInfomodal.jsp" %>
	<%@ include file="answerWrite.jsp" %>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/popper.js"></script>
	​<script src="js/movieSearch.js"></script>
	​<script src="js/jquery.blockUI.js"></script>
	<script src="js/mypage.js"></script>
	<script src="js/adminPage.js"></script>
	<script type="text/javascript">
	
	$(document).ready(function(){
		$(".custum-list").click(function(){
			i = $(this).index();
			$(".custum-list").removeClass("liston");
			$(this).addClass("liston");
		});
	});
	
	function detailReport(index){
		var writer;
		var write_date;
		var reson;
		var write_reson;
		
		writer=$("#writer"+index).val();
		write_date=$("#Write_date"+index).val();
		write_reson=$("#write_reson"+index).val();
		reson=$("#reson"+index).val();
		
		$("#writeUser").val(writer)
		$("#writeDay").val(write_date)
		$("#reson").val(reson)
		$("#write-reson").val(write_reson)
	}
	
	function reviewCheck(index){
		console.log(index);
		var	mycode = $("#report_code"+index).val();
		var myid = $("#writer"+index).val();
		console.log(mycode);
		console.log(myid);
		var	my_write_date;
		var	my_title;
		var	my_score;
		var	myreview;
		
		$.ajax({
			type : "post",
			url : "myOneReview",
			data : {
					mycode : mycode,
					myid : myid
				},
			dataType : 'json',
			async : false,
			success : function(data) {
				my_write_date=data.write_date;
				my_title=data.title;
				my_score=data.score;
				myreview=data.content;
			}
		});
		
		$("#star").children("a").removeClass("ons");     
		$('#star a:eq('+(my_score-1)+')').addClass("ons").prevAll("a").addClass("ons");
		$("#rescore").val(my_score);
		
		$("#reuser").val(myid);
		$("#code2").val(mycode);
		$("#write_date2").val(my_write_date);
		$("#modal-review").val(myreview)
		$("#rescore").val(my_score);
		$("#retitle").val(my_title);
	}
	
	
	</script>
	<%@ include file="../../layout/footer.jsp"%>
</body>
</html>