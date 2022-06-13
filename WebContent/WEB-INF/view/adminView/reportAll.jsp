<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container-fluid" style="width: 1200px; padding-top: 40px;" id="adminContent">
			<h2 class="mb-5" style="text-align:center;">신고 내역</h2>
			<p style="text-align:center;">신고 리스트</p>  
			<div style="text-align:center;">
			<table border=1 style="margin:0 auto; border:0.5px solid rgba(0,0,0,.2);">
			<tr style="text-align:center;"><th width="200px">신고날짜</th><th width="300">신고사유</th><th width="110">신고대상</th><th width="110">리뷰작성일</th><th width="110">신고자</th><th style="text-align:center;"colspan="3">내역상세보기/리뷰확인 및 수정/관리</th></tr>
			<c:forEach var="report" items="${reportList}" varStatus="status">
				<tr height=40>
					<td style="text-align:center;">${report.report_date}</td>
					<td>${report.reson}</td>
					<td style="text-align:center;"><a href="memberInfo?userid=${report.writer}">${report.writer}</a></td>
					<td style="text-align:center;">${report.write_date}</td>
					<td style="text-align:center;"><a href="memberInfo?userid=${report.reporter}">${report.reporter}</a></td>
					<td style="width:100px; text-align:center;"><a href='#'data-toggle="modal"data-target="#reportModal" onclick="detailReport('${status.index}')">상세보기</a></td>
					<td style="width:100px; text-align:center;"><a href='#'data-toggle="modal"data-target="#reviewChange" onclick="reviewCheck('${status.index}')">리뷰보기</a></td>
					<td style="width:100px; text-align:center;"><a href='#'data-toggle="modal"data-target="#reportResult" onclick="reportResult('${status.index}')">관리</a>
					<!-- 관리하기 클릭시 정지(삭제 X, 정지 끝나면 삭제 ,count X) , 신고확인(삭제 O ,신고 count +) 처리 부분 만들기 -->
					
					<input type="hidden" name="writer" id="writer${status.index}" value="${report.writer}">
					<input type="hidden" name="write_date" id="Write_date${status.index}" value="${report.write_date}">
					<input type="hidden" name="reson" id="reson${status.index}" value="${report.reson}">
					<input type="hidden" name="write_reson" id="write_reson${status.index}" value="${report.write_reson}">
					<input type="hidden" name="report_code" id="report_code${status.index}" value="${report.report_code}">
					<input type="hidden" name="reporter" id="reporter${status.index}" value="${report.reporter}">
					</td>
				</tr>
			</c:forEach>
			</table>	
			</div>
			
<div style="text-align: center; padding-left: 40px; padding-top: 50px;"
			id="repaging">
			<ul id="repagingul"
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


<div class="modal fade" id="reviewChange" tabindex="-1" role="dialog" aria-hidden="true" style="height:600px;" data-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">내용 수정</h5>
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
							<label for="write_date" class="col-form-label" style="margin-left:10px;">작성일</label>
							<input type="text" class="form-control" id="write_date2" name="write_date" readonly style="width:150px; margin-left:20px;"/> 
					</div>
						<div class="form-group" style="display:flex; flex-direction:row;">
							<label class="col-form-label">별점</label>
							<div style="padding-left:20px;">
							 <P id="star" style="font-size:20px;"> <!-- 부모 -->
								   <a class="ons" value="1">★</a> <!-- 자식들-->
								   <a class="ons" value="2">★</a>
								   <a class="ons" value="3">★</a>
								   <a class="ons" value="4">★</a>
								   <a class="ons" value="5">★</a>
							</p>
							</div>
							<div style="padding-left:20px; margin-top:10px;"><p><b>별점 수정은 회원관리에서 가능</b></p></div>
							<input type="hidden" name="rescore" id="rescore">
						</div>
						<div class="form-group" style="height:300px;">
							<label for="modal-review" class="col-form-label">내용</label>
							<textarea class="form-control" rows="50" cols="6" name="recontent"style="float:right;width:400px; height:250px; margin-right:10px;"maxlength="300" id="modal-review" onkeyup="fncChkByte(this, 250)"></textarea>
							<div style="float:right; padding-top:20px; margin-right:30px;"><span id="rev-count">0</span>/<span>250 Byte</span></div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="button" type="button"class="btn btn-primary"onclick="myReviewSubmit2()">수정</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-hidden="true" style="height:600px;" data-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">상세보기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="report.do" method="post" id="reportform">
					<div class="form-group" style="display:flex; flex-direction:row; width:500px;">
							<label for="writeUser" class="col-form-label">신고대상</label>
							<input type="text" class="form-control" id="writeUser" name="writeUser" readonly style="width:150px; margin-left:15px;"/>						
							<label for="writeDay" class="col-form-label" style="margin-left:10px; margin-right:5px;">작성일</label>
							<input type="text" class="form-control" id="writeDay" name="writeDay" readonly style="width:150px; margin-left:5px;"/>
					</div>
						<div class="form-group" style="display:flex; flex-direction:row;">
							<label for="reson" class="col-form-label">신고사유</label>												
							<input type="text" class="form-control" name="reson"id="reson" style="width:360px; margin-left:15px;"readonly>
						</div>
						<div class="form-group" style="height:300px;">						
							<label for="write-reson" class="col-form-label">상세내용</label>
							<textarea class="form-control" rows="50" cols="6" name="write-reson"style="width:370px; height:250px; margin-right:20px; float:right;"maxlength="250" id="write-reson" readonly></textarea>				 	
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="reportResult" tabindex="-1" role="dialog" aria-hidden="true" style="height:600px;" data-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">신고처리</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="banChange" method="post" id="banform">
					<div class="form-group" style="display:flex; flex-direction:row; width:500px;">
							<label for="writeUser2" class="col-form-label">신고대상</label>
							<input type="text" class="form-control" id="writeUser2" name="writeUser2" readonly style="width:150px; margin-left:15px;"/>						
							<input type="hidden" name="reportUser2" id="reportUser2">
							<input type="hidden" name="reportCode2" id="reportCode2">
					</div>
						<div class="form-group" style="display:flex; flex-direction:row;">
							<label for="reson2" class="col-form-label">신고사유</label>												
							<input type="text" class="form-control" name="reson2" id="Reson2" style="width:360px; margin-left:15px;"readonly>
						</div>
						<div class="form-group" style="margin:0 auto; height:100px; display:flex; width:250px; padding-top:30px;">
						<label for="ban_date" class="col-form-label">정지기간</label>
						<input type="date" class="form-control" id="ban_date" name="ban_date" style="width:150px; margin-left:20px;"/>
					</div>
					<div style="text-align:center; margin-bottom:30px;"><b>오늘 날짜 이후로 선택해주세요.</b></div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="button" type="button"class="btn btn-primary"onclick="reportDelete()">반려</button>
							<button type="button" type="button"class="btn btn-primary"onclick="reportProc()">접수</button>
							<button type="button" type="button"class="btn btn-warning"onclick="reportBan()">정지</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>