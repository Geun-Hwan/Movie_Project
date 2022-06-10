<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="modal fade" id="findId" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">아이디 찾기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group">
							<label for="name" class="col-form-label">사용자 이름</label>
							<input type="text" class="form-control" id="name" name="name">
						</div>
						<div class="form-group">
							<label for="email" class="col-form-label">회원 가입시 입력한 이메일</label>
							<input type="email" class="form-control" id="email" name="email">
						</div>
						<div class="modal-footer" style="display:flex; flex-direction:row; justify-content:space-between;">
							<span id="confirmId" style="padding-right:110px; text-align:left;"></span>
							<div>
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button id="findIdbtn"type="button" class="btn btn-primary" onclick="findId()">찾기</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>