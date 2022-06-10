<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="modal fade" id="findPw" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">비밀번호 찾기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group">
							<label for="userid2" class="col-form-label">사용자 아이디</label>
							<input type="text" class="form-control" id="userid2" name="userid2">
						</div>
						<div class="form-group">
							<label for="email2" class="col-form-label">회원 가입시 입력한 이메일</label>
							<input type="email" class="form-control" id="email2" name="email2">
						</div>
						<!-- 인증번호 받기 -->
						<div class="modal-footer" style="display:flex; flex-direction:row; justify-content:space-between;">
							<span id="confirmPwd" style="padding-right:110px; text-align:left;"></span>
							<div>
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button id="findpassbtn"type="button" class="btn btn-primary" onclick="findPwd()">찾기</button>
							</div>
							<!-- 이메일 인증 후 인증완료 되면 새 비밀번호 등록 ,dao에 추가 할지 update에 추가할지 선정. -->
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 인증번호 입력받기 -->
	<div class="modal fade" id="findPwCheck" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">비밀번호 찾기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group">
							<label for="checkcode" class="col-form-label">인증번호 입력
								<span style="padding-left:220px;">남은시간</span><span id="timer" style="margin-left:15px;"></span></label>
							<input type="text" class="form-control" id="checkcode" name="checkcode">
						</div>
						
						<!-- 인증번호 받기 -->
						<div style="display:flex; flex-direction:row; justify-content:space-between;">	
							<span style="text-align:left; width:300px;" id="codeConfirm"></span>
							<div>
							<button id="codeCheckbtn"style="float:right;"type="button" class="btn btn-primary" onclick="confirmCode()">인증</button>
							<button id="recodeCheckbtn"style="float:right; display:none; margin-right:10px;"type="button" class="btn btn-primary" onclick="reconfirmCode()" >재전송</button>	
							</div>
							<!-- 이메일 인증 후 인증완료 되면 새 비밀번호 등록  -->
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 비밀번호 교체하기 -->
	<div class="modal fade" id="changePwd" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">비밀번호 변경</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group">
							<label for="newpass" class="col-form-label">새로운 비밀번호</label>
							<input type="password" class="form-control" id="newpass" name="newpass">
						</div>
						<div class="form-group">
							<label for="newpass2" class="col-form-label">새로운 비밀번호 확인</label>
							<input type="password" class="form-control" id="newpass2" name="newpass2">
						</div>
						<!-- 인증번호 받기 -->
						<div style="display:flex; flex-direction:row; justify-content:space-between;">	
							<span style="text-align:left; width:300px;" id="passcheck"></span>
							<div>
							<button id="changePw"style="float:right;"type="button" class="btn btn-primary" onclick="changePwd()">변경</button>
							<button type="button" style="float:right;"class="btn btn-secondary" data-dismiss="modal">취소</button>
							</div>
							<!-- 이메일 인증 후 인증완료 되면 새 비밀번호 등록  -->
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>