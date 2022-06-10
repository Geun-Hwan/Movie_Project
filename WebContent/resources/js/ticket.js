var selectSeatList;
function ticketGo() {
	//selectSeatList=null;
	var tickid = $("#tickid").val();
	if (tickid == "") {
		alert("로그인후 이용해 주세요.");
		return;
	}
	if (tickid == "kakao") {
		alert("카카오유저 기능 미구현");
		return;
	}
	console.log(timecheck);
	if (timecheck == 0) {
		alert("시간을 선택해 주세요.");
		return;
	}


	normalNumber = 0; // 일반 인원 수
	teenNumber = 0; // 청소년 인원 수
	oldNumber = 0; // 우대 인원 수
	allNumber = 0; // 전체 인원 수
	normalMoney = 0; // 일반 티켓 가격
	teenMoney = 0; // 청소년 티켓 가격
	oldMoney = 0; // 우대 티켓 가격
	allMoney = 0; // 전체 티켓 가격
	$(".select-number-normal").removeClass("select-seat-ul-active")
	$(".select-number-teen").removeClass("select-seat-ul-active")
	$(".select-number-old").removeClass("select-seat-ul-active")

	$(".seat").removeClass("clicked");
	selectedSeats.innerHTML = "선택한 좌석이 없습니다.";
	ticketPrice.innerHTML = "0원";
	$(".reserve-number").text("0");

	var title = $(".movie.active").find("a").text();
	var day = $(".movie-date-wrapper-active .movie-day").text();
	var week = $(".movie-date-wrapper-active .movie-week-of-day").text();
	var time = $(".time-wrapper-active").text();
	var cinema = $(".theater-place.active").text();
	var grade = $(".movie.active").find("img").attr("alt");
	$(".movieAge").val(grade);
	
	$(".selected-movie").text(title);
	if ($(".nextMonth").index() > $(".movie-date-wrapper-active").index()) {
		$(".theater-date").text(
				year + "." + month + "." + day + "(" + week + ")");
	} else {
		$(".theater-date").text(
				year + "." + month2 + "." + day + "(" + week + ")");
	}
	$(".theater-time").text(time);
	$(".selected-theater-place-info").eq(0).text("EZV" + cinema);

	$.ajax({
		type : "POST",
		url : "seatCheck.do",
		data : {
			title : title,
			movieDate : $(".theater-date").text(),
			movieTime : $(".theater-time").text(),
			cinema : $(".selected-theater-place-info").eq(0).text() + " "
					+ $(".selected-theater-place-info").eq(1).text()
		},
		async : false,
		success : function(data) {
			selectSeatList = data;
			for (var i = 0; i < selectSeatList.length; i++) {
				console.log(selectSeatList[i]);
				for (var j = 0; j < 120; j++) {
					if ($("input[name=seats]").eq(j).val() == selectSeatList[i]) {
						$("input[name=seats]").eq(j).removeClass("seat");
						$("input[name=seats]").eq(j).addClass("seatok");
						$("input[name=seats]").eq(j).attr("disabled", true);
					}
				}
			}
		}
	});
	
	$('#seatSelect').modal('show');
	
	remainSeat.innerHTML = seat.length-$(".seatok").length;
}

$('.modal').on('hidden.bs.modal', function (e) {
	$("input[name=seats]").removeClass("seatok");
	$("input[name=seats]").addClass("seat");
	$("input[name=seats]").attr("disabled", false);
    console.log('modal close');
  $(this).data('modal',null);
});