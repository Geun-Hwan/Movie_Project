<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../layout/admin_header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link href="css/bootstrap.css" rel="stylesheet" />
<link href="css/loading.css" rel="stylesheet" />
<meta charset="UTF-8">
<title>추가 기능</title>
</head>
<body>
<c:choose>
		<c:when test="${userid==null||admin!=1}">
		<script type="text/javascript">
			alert("권한이 없습니다.");
			location.href="main";
		</script>
	</c:when>
</c:choose>
<div style="width: 1200px; margin: 0 auto;">
	<div style="padding-top: 25px; padding-left: 25px; display: flex; flex-direction: row;">
			<h3>테스트용</h3>
		</div>
		<hr color="black">
		<div><button type="button" class="btn btn" style="margin-bottom:10px;" onclick="movieAutoWrite()">테스트 버튼1</button> <span>해당 버튼 클릭시 자동으로 영화 등록 및 수정을 진행. (cgv와 동기화) </span></div>
		<div><button type="button" class="btn btn" style="margin-bottom:10px;" onclick="movieAllDelete()">테스트 버튼2</button> <span>해당 버튼 클릭시 모든 영화 정보 삭제. </span></div>
		

</div>
<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/popper.js"></script>
	​<script src="js/movieSearch.js"></script>
	
	<script type="text/javascript">
	
	function movieAutoWrite(){
		var wch = confirm("30초에서 1분정도 시간이 소요됩니다.");
		if(wch==false){
			return;
		}
			$(".wrap-loading").removeClass('display-none');    
			setTimeout(function(){
			$.ajax({
				type : "POST",
				url : "movieAutoWrite",
				async : false,
				dataType : "json",
				cache : false,					
			  	complete: function () {
			 		$(".wrap-loading").addClass('display-none');     
			 		alert("완료");
			 	}
			});
			},100);
		}
	
	function movieAllDelete(){
		var dck = confirm("영화 전체 삭제(비추천)");
		if(dck){
			var rck =confirm("정말 삭제하시겠습니까?");
			if(rck){
				if(confirm("직접 등록한 영화는 복구가 어렵습니다.")){
					$(".wrap-loading").removeClass('display-none');    
					setTimeout(function(){
					$.ajax({
						type : "POST",
						url : "movieAllDelete",
						async : false,
						dataType : "json",
						cache : false
						,complete:function(){
							$(".wrap-loading").addClass('display-none');  		
						}
					});
					},100);
				}
			}
		}
	}
	</script>
	<%@ include file="../../layout/footer.jsp"%>
</body>
</html>