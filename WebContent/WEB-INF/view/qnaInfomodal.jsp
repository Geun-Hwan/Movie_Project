<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div data-refresh = 'true'class="modal fade" id="qnaInfo" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog" role="document" style="max-width:1000px;">
			<div class="modal-content" style="width:1000px;">
			
			<div class="modal-header">
					<h5 class="modal-title">문의 내용</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
			<div class="modal-body">
					<div class="form-group" style="display:flex; flex-direction:row;">
							<label for="qna_title" class="col-form-label">제목</label>
							<input type="text" class="form-control" id="qna_title" name="qna_title" readonly style=" width:800px; margin-left:50px;"/>
					</div>
					<div class="form-group" style="display:flex; flex-direction:row;">
							<label for="qna_userid" class="col-form-label">작성자</label>
							<input type="text" class="form-control" id="qna_userid" name="qna_userid" readonly style="width:200px; margin-left:30px;"/>
							<input type="hidden" name="code2" id="code2">
							<label for="qna_write_date" class="col-form-label" style="margin-left:30px;">작성일</label>
							<input type="text" class="form-control" id="qna_write_date" name="qna_write_date" readonly style="width:300px; margin-left:20px;"/> 
							<label for="qna_category" class="col-form-label" style="margin-left:30px;">문의유형</label>
							<input type="text" class="form-control" id="qna_category" name="qna_category" readonly style="width:80px; margin-left:20px;"/>
					</div>
			
						<div class="form-group" style="height:300px;">
							<label for="qna_content" class="col-form-label">내용</label>
							<textarea class="form-control" rows="50" cols="6" id="qna_content"  name="qna_content"style="width:800px; height:250px; margin-left:70px;"maxlength="300" onkeyup="fncChkByte(this, 250)" readonly></textarea>
						</div>
					
					<div class="form-group" style="display:flex; flex-direction:row; float:right; align-items:center; padding-right:150px;">
							<label for="appendfile" class="col-form-label" style="margin-right:20px;">첨부파일</label>
							 <a id=fileCheck>첨부파일 없음</a>
							
					</div>
						
				</div>
					<div class="modal-header">
					<h5 class="modal-title">답변 내용</h5>
				</div>
	
	<div id='answerNull' class='modal-body' style='height:80px; align-items:center;'><h3 style='text-align:center;'>등록된 답변이 없습니다.</h3></div>
	
			<div id ="answerCheck"class="modal-body">
					<div class="form-group" style="display:flex; flex-direction:row;">
							<label for="answer_title" class="col-form-label">제목</label>
							<input type="text" class="form-control" id="answer_title" name="answer_title" readonly style=" width:800px; margin-left:50px;"/>
					</div>
					<div class="form-group" style="display:flex; flex-direction:row;">
							<label for="answer_userid" class="col-form-label">작성자</label>
							<input type="text" class="form-control" id="answer_userid" name="answer_userid" readonly style="width:200px; margin-left:30px;"/>
							<label for="answer_write_date" class="col-form-label" style="margin-left:30px;">작성일</label>
							<input type="text" class="form-control" id="answer_write_date" name="answer_write_date" readonly style="width:300px; margin-left:20px;"/>
							<label for="answer_category" class="col-form-label" style="margin-left:30px;">답변유형</label>
							<input type="text" class="form-control" id="answer_category" name="answer_category" readonly style="width:80px; margin-left:20px;"/> 
					</div>
			
						<div class="form-group" style="height:300px;">
							<label for="answer_content" class="col-form-label">내용</label>
							<textarea class="form-control" rows="50" cols="6" id="answer_content"  name="answer_content"style="width:800px; height:250px; margin-left:70px;"maxlength="300" onkeyup="fncChkByte(this, 250)" readonly></textarea>
						</div>				
				</div>				
				<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
						</div>
	 		</div>
	 </div>
 </div>
