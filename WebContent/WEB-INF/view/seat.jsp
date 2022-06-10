<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal fade" id="seatSelect" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static">
<div class="modal-dialog" role="document" style= "max-width:900px;width:900px;">
	<div class="select-container modal-content" style="width:900px; margin:0 auto;">
		<div class="select-wrapper" style= "width:900px; height:950px;">
			<div class="select-title">인원/좌석 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button></div>
					
			<div class="select-seat-container">
				<div class="select-seat-number-container">
					<div class="select-seat-number-wrapper">
						<div class="select-seat">
							<div class="select-seat-age">일반</div>
							<div class="select-seat-number">
								<ul class="select-seat-ul select-seat-ul-normal">
									<li class="select-number-normal ">0</li>
									<li class="select-number-normal">1</li>
									<li class="select-number-normal">2</li>
									<li class="select-number-normal">3</li>
									<li class="select-number-normal">4</li>
									<li class="select-number-normal">5</li>
									
								</ul>
							</div>
						</div>
						<div class="select-seat">
							<div class="select-seat-age">청소년</div>
							<div class="select-seat-number">
								<ul class="select-seat-ul select-seat-ul-teen">
									<li class="select-number-teen">0</li>
									<li class="select-number-teen">1</li>
									<li class="select-number-teen">2</li>
									<li class="select-number-teen">3</li>
									<li class="select-number-teen">4</li>
									<li class="select-number-teen">5</li>
									
								</ul>
							</div>
						</div>
						<div class="select-seat">
							<div class="select-seat-age">우대</div>
							<div class="select-seat-number">
								<ul class="select-seat-ul  select-seat-ul-old">
									<li class="select-number-old">0</li>
									<li class="select-number-old">1</li>
									<li class="select-number-old">2</li>
									<li class="select-number-old">3</li>
									<li class="select-number-old">4</li>
									<li class="select-number-old">5</li>
								</ul>
							</div>
						</div>

					</div>
					<div class="reserve-number-wrapper">
						<div class="reserve-number-title">선택된 좌석 수</div>
						<div class="reserve-number">0</div>
					</div>
				</div>
				<div class="select-seat-information">
					<div class="selected-movie"></div>
					<div class="select-seat-information-wrapper">
						<div class="select-theater-place selected-theater-place-info" style="width:75px;">상영관</div>
						<div class="select-theater-place selected-theater-place-info" style="width:75px;">3층 5관</div>
						<div class="select-theater-place">
							<span>남은좌석</span><span class="remain-seats"></span>/<span
								class="all-seats"></span>
						</div>

					</div>
					<div class="select-theater-date">
						<div class="theater-date"></div>
						<div class="theater-time"></div>
					</div>
					<div class="selected-seats-wrapper" style="height:25px;">
						<span class="selected-seats-title" >좌석번호</span> <span
							class="selected-seats">선택한 좌석이 없습니다.</span>
					</div>
					<div class="ticket-price-wrapper">
						<div class="ticket-price-title">가격</div>
						<div class="ticket-price">0원</div>
						<button style="width:225px;"type="button" class="reserve-button">
							결제하기<img src="images/kakaopay.png">
						</button>
					</div>
					<form action="kakaopay.do" class="seatForm" method="post">
						<input type="hidden" class="title" name="title"> <input
							type="hidden" class="selectedTheater" name="selectedTheater">
						<input type="hidden" class="reserveDate" name="movieDate">
						<input type="hidden" class="runningTime" name="runningTime">
						<input type="hidden" class="movieAge" name="movieAge">
						<!-- 티켓의수(선택한 좌석) -->
						<input type="hidden" class="ticketNumber" name="ticketNumber">
						<input type="hidden" class="selectedSeat" name="selectedSeat">
						<!-- 결제 정보 -->
						<input type="hidden" class="payMoney" name="payMoney">
					</form>
				</div>

			</div>
			<div class="seat-container" style="height:600px;">

				<div class="seat-wrapper" style="height:600px;">
					<div class="screen-view-wrapper">
						<div class="screen-view" >SCREEN</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</div>