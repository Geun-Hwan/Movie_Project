<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-hidden="true" style="height:600px;" data-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">신고 하기</h5>
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
							<input type="hidden" name="reportUser" id="reportUser">
							<input type="hidden" name="report_code" id="report_code"> 
					</div>
						<div class="form-group" style="display:flex; flex-direction:row;">
							<label for="reson" class="col-form-label">신고사유</label>												
							<select style="width:370px; margin-left:10px;" name="reson" id="reson">
								<option>욕설/혐오/불쾌한 표현입니다.</option>
								<option>불법정보를 포함하고 있습니다.</option>
								<option>개인정보 노출글 입니다.</option>
								<option>스팸/홍보글 입니다.</option>
							</select>
						</div>
						<div class="form-group" style="height:300px;">						
							<label for="write-reson" class="col-form-label">상세내용</label>
							<textarea rows="50" cols="6" name="write-reson"style="width:370px; height:250px; margin-right:20px; float:right;"maxlength="250" id="write-reson" onkeyup="fncChkBytemodal2(this, 250)"></textarea>
							<div style="float:right;width:100px; padding-top:20px;"><span id="reson-count">0</span>/<span>250 Byte</span></div>
							 	
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary" onclick="reportdo();">신고</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>