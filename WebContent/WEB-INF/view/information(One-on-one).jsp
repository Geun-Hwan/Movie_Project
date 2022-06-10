<%@page import="dao.MemberDAO"%>
<%@page import="model.MemberVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="css/bootstrap.css" rel="stylesheet">
<link rel="stylesheet" href="css/loading.css">
<link href="css/content.css" rel="stylesheet" />
<title>고객 센터</title>
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
	<c:if test="${userid ==null }">
		<script type="text/javascript">
			alert("로그인이 필요한 항목입니다.");
			location.href = "login";
		</script>
	</c:if>
	<div style="width: 1400px; margin: 0 auto; padding-top: 20px;">
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
							<li class="list-group-item"><a href="notice">공지사항</a></li>
							<li class="list-group-item"><a href="#" onclick="alert('미구현');">자주묻는질문</a></li>
							<li style="font-weight: bold;" class="list-group-item">1대1문의하기</li>
						</ul>
					</div>

				</div>
				<!-- 9단길이의 첫번째 열 -->
				<div class="col-md-9">
					<form action="qnaWrite.do"enctype="multipart/form-data" method="post" id="oneInfoform">
						<div class="jumbotron">
							<h2>1대1 문의하기</h2>
							<p style="text-align: right;">
								체크(<em><img src="http://img.cgv.co.kr/R2014/images/common/ico/ico_redstar.png" alt="필수"></em>)된 항목은 필수 입력 사항입니다.
							</p>
							<table class="table">

								<tbody>
									<tr >
										<th scope="row"><label for="inp_name">이름</label></th>
										<td >
											<input type="text" class="form-control" name="name" id="name" readonly value="${member.getName()}" style="width:200px;">
										</td>
									</tr>
									<tr>
										<th scope="row">아이디</th>
										<td>
											<input type="text" class="form-control" name="userid" id="userid" readonly value="${userid}">
										</td>

										<th scope="row">이메일</th>
										<td>
											<input type="email" class="form-control" name="email" id="email" placeholder="Enter email" readonly value="${member.getEmail()}">
										</td>

									</tr>
									<tr class="check_info">
										<td colspan="4">
											<div style="text-align: center;">
												<strong>※&nbsp;&nbsp;문의에 대한 빠른 답변을 위해&nbsp;회원 가입 시 입력하신 정보를 확인해주세요.</strong>										
											</div>

										</td>
									</tr>
									<tr>
										<th scope="row">문의유형 <em><img src="http://img.cgv.co.kr/R2014/images/common/ico/ico_redstar.png" alt="필수"></em></th>
										<td colspan="3">
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio" name="category" id="exampleRadios1" value="문의" checked>
												<label class="form-check-label" for="exampleRadios1"> 문의 </label>

											</div>
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio" name="category" id="exampleRadios2" value="불만">
												<label class="form-check-label" for="exampleRadios2">불만 </label>
											</div>
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio" name="category" id="exampleRadios3" value="칭찬">
												<label class="form-check-label" for="exampleRadios3"> 칭찬 </label>
											</div>
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio" name="category" id="exampleRadios4" value="제안">
												<label class="form-check-label" for="exampleRadios4"> 제안 </label>
											</div>
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio" name="category" id="exampleRadios4" value="분실물">
												<label class="form-check-label" for="exampleRadios5"> 분실물 </label>
											</div>
										</td>
									</tr>									
									<tr>
										<th scope="row"><label for="inp_title">제목 <em><img src="http://img.cgv.co.kr/R2014/images/common/ico/ico_redstar.png" alt="필수"></em></label></th>
										<td colspan="3">
											<input type="text" id="inp_title" name="qna_title" class="inp01" style="width: 672px;">
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="inp_textbox">내용 <em><img src="http://img.cgv.co.kr/R2014/images/common/ico/ico_redstar.png" alt="필수"></em></label></th>
										<td colspan="3">

											<textarea class="form-control" name="qna_content" id="qna_content" rows="10" placeholder="※문의 내용 및 첨부파일 내에 개인정보(신용카드번호, 계좌번호, 주민번호 등)가 포함되지 않도록 유의하시기 바랍니다. 
※ 이벤트 굿즈 재고 문의 안내  
   경품 특성상 실시간으로 소진되어 재고 안내가 어려운 관계로 문의 글에 대한 답변이 어렵습니다.
[재고 확인 불가 상품]
- 관람 특전 굿즈 재고 (포스터/뱃지/엽서/필름 마크 등의 영화 관람 시 제공되는 굿즈 상품 모두 포함)
- 씨네샵 재고/ 매점 프로모션 콤보 재고 (상품 판매 여부 및 재고 등)
- 선재물 재고 (영화 전단지 비치 여부 및 재고 등)"></textarea>
											<div id="test_cnt">(0 / 1000)</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="voc_upload_file">첨부파일</label></th>
										<td colspan="3">
											<input type="file" id="voc_upload_file" name="file" title="voc파일 업로드" size="51" onclick="javascript:alert('주민번호 등 개인정보가 포함된 파일이 첨부되지 않도록 유의하시기 바랍니다.');">
										</td>
									</tr>
								</tbody>
							</table>
							<div style="text-align: center;">
								<button class="btn btn-primary" type="reset">취소</button>
								<button class="btn btn-primary" type="button" onclick="oneInfoWrite()" >등록</button>
							</div>
						</div>

					</form>
				</div>
			</div>
		</div>
	</div>

	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/popper.js"></script>
	<script src="js/movieSearch.js"></script>​
	<script src="js/jquery.blockUI.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#qna_content').on('keyup', function() {
			$('#test_cnt').html("(" + $(this).val().length + " / 1000)");
			if ($(this).val().length > 1000) {
				$(this).val($(this).val().substring(0, 1000));
				$('#test_cnt').html("(1000 / 1000)");
			}
		});
	});
	function oneInfoWrite(){
		
	 	if($("#userid").val() =='admin'){
			alert("관리자는 쓸수 없습니다.");
			return;
		} 
		
		if($("#inp_title").val().trim().length ==0){ // 공백만 작성
			alert("제목을 입력해 주세요.");
			return;
		}
		if($("#qna_content").val().trim().length ==0){ // 공백만 작성
			alert("내용을 입력해 주세요.");
			return;
		}

		var newForm = $("#oneInfoform");
		newForm.method="post";
		newForm.submit();
	}
	
</script>

	<%@ include file="../layout/footer.jsp"%>
</body>
</html>