<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
					<form action="reviewUpdate" method="post" id="reviewChangeForm">
					<div class="form-group" style="display:flex; flex-direction:row; width:500px;">
							<label for="reuser" class="col-form-label">작성자</label>
							<input type="text" class="form-control" id="reuser" name="reuserid" readonly style="width:150px; margin-left:20px;"/>
							<input type="hidden" name="code2" value="${movie.code}">
							<input type="hidden" name="title2" value="${movie.title}">
							<label for="write_date" class="col-form-label" style="margin-left:10px;">작성일</label>
							<input type="text" class="form-control" id="write_date2" name="write_date2" readonly style="width:150px; margin-left:20px;"/> 
					</div>
						<div class="form-group" style="display:flex; flex-direction:row;">
							<label for="score" class="col-form-label">별점</label>
							<div style="padding-left:20px;">
							 <P id="star" style="font-size:20px;"> <!-- 부모 -->
						
								   <a  class="ons" value="1">★</a> <!-- 자식들-->
								   <a  class="ons" value="2">★</a>
								   <a  class="ons" value="3">★</a>
								   <a  class="ons" value="4">★</a>
								   <a  class="ons" value="5">★</a>
							</div>
							<p>
							<div style="padding-left:20px; margin-top:10px;"><p><b>별점 미선택시 5점 자동 선택</b></p></div>
							<input type="hidden" name="rescore" id="rescore">
						</div>
						<div class="form-group" style="height:300px;">
							<label for="modal-review" class="col-form-label">내용</label>
							<textarea class="form-control" rows="50" cols="6" name="recontent"style="width:400px; height:250px; margin-left:15px;"maxlength="250" id="modal-review" onkeyup="fncChkBytemodal(this, 250)"></textarea>
							<div style="float:right;width:100px; padding-top:20px;"><span id="m-count">0</span>/<span>250 Byte</span></div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary" onclick="revChangeConfirm()">수정</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>