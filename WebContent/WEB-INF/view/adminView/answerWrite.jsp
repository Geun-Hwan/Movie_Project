<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div data-refresh = 'true'class="modal fade" id="answerWriteform" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog" role="document" style="max-width:1000px;">
			<div class="modal-content" style="width:1000px;">
			
			<div class="modal-header">
					<h5 class="modal-title">답변 쓰기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
			<form action="answerWrite.do" method="post" id="answerform">
			<div class="modal-body">
					<div class="form-group" style="display:flex; flex-direction:row;">
							<label for="admin_title" class="col-form-label">제목</label>
							<input type="text" class="form-control" id="admin_title" name="admin_title"  style=" width:800px; margin-left:50px;"/>
					</div>
					<div class="form-group" style="display:flex; flex-direction:row;">
							<label for="admin_userid" class="col-form-label">작성자</label>
							<input type="text" class="form-control" id="admin_userid" name="admin_userid" readonly style="width:200px; margin-left:30px;" value="${userid}"/> 
							<label for="admin_category" class="col-form-label" style="margin-left:30px;">답변유형</label>
							<input type="text" class="form-control" id="admin_category" name="admin_category" readonly style="width:80px; margin-left:20px;"/>
							<input type="hidden" id="ask_userid">
					</div>
			
						<div class="form-group" style="height:300px;">
							<label for="admin_content" class="col-form-label">내용</label>
							<textarea class="form-control" rows="50" cols="6" id="admin_content"  name="admin_content"style="width:800px; height:250px; margin-left:70px;"maxlength="300" ></textarea>
						</div>
						
				</div>					
				<div class="modal-footer">
							<input type="hidden" name="answerNum" id="answerNum">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary" onclick="answerOk()">답변</button>
						</div>
				</form>
	 		</div>
	 </div>
 </div>