<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="css/bootstrap.css" rel="stylesheet">
<link rel="stylesheet" href="css/loading.css">
<link href="css/content.css" rel="stylesheet" />

<title>고객 센터</title>
<style type="text/css">
#nopagingul {
    text-align: center;
    display: inline-block;
    border: 1px solid #ccc;
    border-right: 0;
}

#nopagingul li {
    text-align: center;
    float: left;
}

#nopagingul li a {
    display: block;
    font-size: 14px;
    padding: 9px 12px;
    border-right: solid 1px #ccc;
    box-sizing: border-box;
}

#nopagingul li.on {
    background: #666;
}

#nopagingul li.on a {
    color: #fff;
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

<div style="width:1400px; margin:0 auto; padding-top:20px; ">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-3">
				<!-- 사이드 바 메뉴-->
				<div class="panel panel-info">
					<div class="panel-heading">
						<!-- 패널 타이틀1 -->
						<h3 class="panel-title">
							<!-- 아이콘 붙이기 -->
							<i class="glyphicon glyphicon-leaf"></i> <span>Panel Title</span>
						</h3>
					</div>
					<!-- 사이드바 메뉴목록1 -->
					<ul class="list-group">
						<li style="font-weight: bold;"class="list-group-item">공지사항</li>
						<li class="list-group-item"><a href="#" onclick="alert('미구현');">자주묻는질문</a></li>
						<li class="list-group-item"><a href="Oneone">1대1문의하기</a></li>
					</ul>
				</div>

			</div>
			<!-- 9단길이의 첫번째 열 -->
			<div class="col-md-9" id="noticeDiv">
				<div class="jumbotron">
					<h2>공지사항</h2>

					<input type="button" value="메인으로" onclick="location.href='main'">
					<c:if test="${admin=='1'}"><input type="button" value="글쓰기" onclick="location.href='noticeWrite'"></c:if>

					<!-- 테이블 시작 -->
					<table class="table table-hover">

						<thead>
							<tr>
								<th width="50" scope="col" class="text-center">번호</th>
								<th width="350" scope="col" class="text-center">제목</th>
								<th width="100" scope="col" class="text-center">글쓴이</th>
								<th width="150" scope="col" class="text-center">작성일</th>
								<th width="80" scope="col" class="text-center">조회수</th>
							</tr>
						</thead>
						<fmt:parseNumber var="number" integerOnly="true" value="${totalData -(currentPage-1)*10 }"/>
						<c:forEach var="notice" items="${noticeList}">
						<tr height="40">
							<td width="50" align="center">${number}</td>
							<td width="320" align="left">
								<a href="noticeInfo?num=${notice.num}" style="text-decoration: none">${notice.title}</a>
							</td>
							<td width="100" align="center">${notice.userid}</td>
							<td width="150" align="center">${notice.reg_date}</td>
							<td width="80" align="center">${notice.readCount}</td>
						</tr>
						<fmt:parseNumber var="number" integerOnly="true" value="${number -1}"/>
						</c:forEach>
					</table>
					<br> <br>
					<div style="text-align: center; padding-left: 40px; padding-top: 50px;"
			id="nopaging">
			<ul id="nopagingul"
				style='list-style-type: none; padding: 0px; margin: 0 auto;'>
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

	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/popper.js"></script>
	<script src="js/movieSearch.js"></script>
	​<script src="js/jquery.blockUI.js"></script>
	<script type="text/javascript">
	
	$(document).on("click","#nopagingul li a",function(){ 
		 pageNum=$(this).attr("id");    
		
		 console.log(pageNum);
		
		$('.wrap-loading').removeClass('display-none');
		$.blockUI({ message: null });
			
		 $.ajax({
				type : "post",
					url : "noticePaging",
					data : {
						pageNum : pageNum
					},
					async: true,
					dataType : 'json',
					
					complete : function ( ){
						$.ajax({
							type : "GET",
							url : "noticeList",
							async : false,
							dataType : "html",
							cache : false,
							success : function(data2) {
								$("#noticeDiv").children().remove();
								$('#noticeDiv').html(data2);
							},
							complete : function(){
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