<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<body>
	<div id="checkout">
		<ul id="movie_point_list_container" class="point_col2" style="display:flex; flex-direction:column; list-style-type:none;">
                    <!-- for문으로 감싸기 최대 3행 2로 나눴을때 몫이 없고 나머지가 1이면 1번실행 -->
                    <c:if test="${totalData != 0}">
                    <c:forEach var="size" begin="0" end="${rcount}" varStatus="status">
						<li class="" data-spoilercnt="0"data-reportcnt="0"><a href="javascript:return false;"
							class="screen_spoiler">&nbsp;</a>
							<div style="width:950px;display:flex; flex-direction:row; height:280px;">
								<!-- for문으로 감싸기 최대 2열  2로 나눠서 나머지 있으면 마지막 행에선 1번만 실행 아니면 2번-->
							<c:if test="${!status.last}">
								<c:forEach var="review" items="${rlist}" begin="${0+(2*size)}" end="${1+(2*size)}" varStatus="status3">
												
								<ul class="writerinfo" style='padding-right:30px; padding-left:20px;display:flex; flex-direction:column; list-style-type:none; border:0.5px solid rgba(0, 0, 0, .1); border-radius:9px;'>
									<li class='writer-name' style='margin-left:28px; padding-top:20px; display:flex; flex-direction:row; justify-content:space-between; '>
									<span id="reuserid${status3.index}">${review.userid}</span>
									<!-- 본인이 작성한 글에는 신고하기 숨기기 조건달기 -->
									<c:if test="${userid != review.userid && userid !='admin' &&review.userid != 'admin'}">
											<span id="userReport"><a
												href="#report${review.userid}" id="report${review.userid}" onclick="userReport('${review.userid}','${review.write_date}')" >신고하기</a></span>
										</c:if> <!-- 관리자는 신고대신 정보보기 만들기 -->
										<c:if test="${userid =='admin' && review.userid !='admin'}"><span id="memberInfo"><a
												href="#" id="info" onclick="memberInfo('${review.userid}')">회원보기</a></span></c:if>  
									</li>
									<li>
										<div style='margin-left:20px;'>
										<c:forEach begin="0" end="4" var='i'>
											<c:choose>
												<c:when test="${i<review.score}">
													<span style="color:#fdf113;">★</span>
												</c:when>
												<c:otherwise>
													<span style="color:#ded8ad">★</span>
												</c:otherwise>
											</c:choose>
										</c:forEach></div>
									</li>
									<li style='height:160px; margin-top:0px;'>
									<c:if test="${review.changeCheck ==1}">
										<span style="margin-left:20px;">[수정됨]</span>
									</c:if>
										<div style='word-break:break-all;height:130px; width:300px; margin-left:20px;' id="recontent${status3.index}">${review.content}</div>
										
									</li>
									<li class='writer-etc' style='margin-left:20px; padding-bottom:20px; display:flex; flex-direction:row; justify-content:space-between;'>
									<div style="padding-bottom:0px;"><span class="day" id="day${status3.index}">${review.write_date}</span>
										<span class="like point_like" id="${review.userid}"
											style="padding-left:5px;" onclick="reviewLike(this);"> <a
											href="javascript:return false;" class="btn_point_like"><span><img
													src="http://img.cgv.co.kr/R2014/images/point/ico_point_default.png"
													alt="like"></span></a>
											</span>
											<span style="padding-left:5px;"id="idLikeValue${review.userid}">${review.commentlike}</span>
										</div>
										<!-- 로그인 아이디와 작성자가 같으면  수정 삭제 보이기 관리자는 다 보이기-->
										<c:choose>
											<c:when test="${userid == review.userid || userid =='admin'}">
											<div style='margin-top:20px;'> 
												<button class="custombutton"type="button"data-toggle="modal"data-target="#reviewChange" onclick="reviewChange('${status3.index}')" style="padding-left:0px; border:0; width:40px;"><span style=' font-size:11px;'>수정</span></button>
												&nbsp;
												<button class="custombutton" type="button" style="border:0; width:40px; padding-left:0px;"><span style=' font-size:11px;' onclick="reviewDelete()">삭제</span></button>
											</div>
											</c:when>
										</c:choose>
										</li>	
									</ul>
									<!-- 2열 반복문 종료 -->	
									</c:forEach>
								</c:if>
								<c:if test="${status.last}">
								<c:forEach var="review" items="${rlist}" begin="${0+(2*size)}" end="${fn:length(rlist)}" varStatus="status2"> <!-- 아이디 수정 -->
												
								<ul class="writerinfo" style="padding-right:30px; padding-left:20px;display:flex; flex-direction:column; list-style-type:none; border:0.5px solid rgba(0, 0, 0, .1); border-radius:9px;">
									<li class="writer-name" style="margin-left:28px; padding-top:20px; display:flex; flex-direction:row; justify-content:space-between;">
									<span id="reuserid${status2.index}">${review.userid}</span>
									<!-- 본인이 작성한 글에는 신고하기 숨기기 조건달기 -->
									<c:if test="${userid != review.userid && userid !='admin' &&review.userid != 'admin'}">
											<span id="userReport"><a
												href="#report${review.userid}" id="report${review.userid}" onclick="userReport('${review.userid}','${review.write_date}')" >신고하기</a></span>
										</c:if> <!-- 관리자는 신고대신 정보보기 만들기 -->
										<c:if test="${userid =='admin' && review.userid !='admin'}"><span id="memberInfo"><a
												href="#" id="info" onclick="memberInfo('${review.userid}')">회원보기</a></span></c:if>
									<!-- 관리자는 신고대신 정보보기 만들기 -->  
									</li>
									<li>
										<div style="margin-left:20px;">
										<c:forEach begin="0" end="4" var="i">
											<c:choose>
												<c:when test="${i<review.score}">
													<span style="color:#fdf113;">★</span>
												</c:when>
												<c:otherwise>
													<span style="color:#ded8ad">★</span>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										</div>
									</li>
									<li style="height:160px; margin-top:0px;">
									<c:if test="${review.changeCheck ==1}">
										<span style="margin-left:20px;">[수정됨]</span>
									</c:if>
										<div style="word-break:break-all; height:130px; width:300px; margin-left:20px;" id="recontent${status2.index}">${review.content}</div>
										
									</li>
									<li class="writer-etc" style="margin-left:20px; padding-bottom:20px; display:flex; flex-direction:row; justify-content:space-between;">
									<div style="padding-bottom:0px;"><span class="day" id="day${status2.index}">${review.write_date}</span>
										<span class="like point_like" id="${review.userid}"
											style="padding-left:5px;" onclick="reviewLike(this);"> <a
											href="javascript:return false;" class="btn_point_like"><span><img
													src="http://img.cgv.co.kr/R2014/images/point/ico_point_default.png"
													alt="like"></span></a>
													
											</span>
											<span style="padding-left:5px;"id="idLikeValue${review.userid}">${review.commentlike}</span>
										</div>
										<!-- 로그인 아이디와 작성자가 같으면  수정 삭제 보이기 관리자는 다 보이기-->
										
											<c:choose>
											<c:when test="${userid == review.userid || userid =='admin'}">
											<div style='margin-top:20px;'> 
												<button class="custombutton"type="button"data-toggle="modal"data-target="#reviewChange" onclick="reviewChange('${status2.index}')" style="padding-left:0px; border:0; width:40px;"><span style=' font-size:11px;'>수정</span></button>
												&nbsp;
												<button class="custombutton" type="button" style="border:0; width:40px; padding-left:0px;"><span style=' font-size:11px;' onclick="reviewDelete()">삭제</span></button>
											</div>
											</c:when>
										</c:choose>
										</li>	
									</ul>
									<!-- 2열 반복문 종료 -->	
									</c:forEach>
								</c:if>	
								</div>
							</li>
							<!-- 3행 반복문 종료 -->
							</c:forEach>
							</c:if>
						</ul>	
		<!-- 페이징 처리 -->
		<div
			style="text-align: center; width: 816px; padding-left: 40px; padding-top: 20px;"
			id="paging">
			<ul id="pagingul"
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

</body>