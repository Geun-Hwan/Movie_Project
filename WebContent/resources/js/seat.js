
let selectedSeatsArray = new Array();
const seatWrapper = document.querySelector('.seat-wrapper');
let clicked = '';
let div = '';
let seat = document.querySelectorAll('.seat'); // 전체 좌석
const selectedSeats = document.querySelector('.selected-seats');
const allSeat = document.querySelector('.all-seats');
const remainSeat = document.querySelector('.remain-seats');
const reserveNumber = document.querySelector('.reserve-number');

const selectSeatListNormal = document.querySelectorAll(
    '.select-seat-ul-normal li'
);
const selectSeatListTeen = document.querySelectorAll('.select-seat-ul-teen li');
const selectSeatListOld = document.querySelectorAll('.select-seat-ul-old li');
let selectSeatListUlActive = '';
let normalNumber = 0; // 일반 인원 수
let teenNumber = 0; // 청소년 인원 수
let oldNumber = 0;  // 우대 인원 수
let allNumber = 0;  // 전체 인원 수
let prevNumber = 0;  //?? 
let normalMoney = 0; // 일반 티켓 가격
let teenMoney = 0; // 청소년 티켓 가격
let oldMoney = 0; // 우대 티켓 가격
let allMoney = 0; // 전체 티켓 가격

const selectNumberNormal = document.querySelectorAll('.select-number-normal');
const selectNumberTeen = document.querySelectorAll('.select-number-teen');
const selectNumberOld = document.querySelectorAll('.select-number-old');

//예약 관련
const selectedMovie = document.querySelector('.selected-movie');
const selectedTheaterPlaceInfo = document.querySelectorAll(
    '.selected-theater-place-info'
);
const theaterTime = document.querySelector('.theater-time');
const theaterDate = document.querySelector('.theater-date');
const ticketPrice = document.querySelector('.ticket-price');
const payMoney = document.querySelector('.payMoney');

const seatForm = document.querySelector('.seatForm');
const reserveButton = document.querySelector('.reserve-button');
const title = document.querySelector('.title');
const selectedTheater = document.querySelector('.selectedTheater');
const reserveDate2 = document.querySelector('.reserveDate');
const runningTime = document.querySelector('.runningTime');
const ticketNumber = document.querySelector('.ticketNumber');
const selectedSeat = document.querySelector('.selectedSeat');


//버튼클릭시 다른 class 추가 초기화해주기
function selectSeatList(list) {
    allNumber = 0;
    allMoney = 0;
    list.forEach(li => {
        //클릭시에 다른 class초기화해주기
        initList(list, li);
    });
}

function initList(list, li) {
    li.addEventListener('click', function() {
        list.forEach(li => {
            li.classList.remove('select-seat-ul-active');
        });
        li.classList.add('select-seat-ul-active');
        selectSeatListUlActive = document.querySelectorAll(
            '.select-seat-ul-active'
        );
        console.log(selectSeatListUlActive);
        selectListUiFunction(selectSeatListUlActive);

        console.log(normalNumber);
        console.log(teenNumber);
        console.log(oldNumber);
        console.log(allNumber);
    });
}

function selectListUiFunction(selectSeatListUlActive) {
	var price = $(".movie.active").find("#price").val();
    selectSeatListUlActive.forEach(li => {
        if (li.parentNode.classList.contains('select-seat-ul-normal')) {
            normalNumber = Number(li.innerHTML);
            normalMoney = price * normalNumber; // 일반 티켓 가격 선정. 
            allMoney = normalMoney + teenMoney + oldMoney;
            allNumber = normalNumber + teenNumber + oldNumber;
            ticketPrice.innerHTML = allMoney + '원';
            if (allNumber > 16) {
                li.classList.remove('select-seat-ul-active');
                allMoney -= normalMoney;
                allNumber = allNumber - normalNumber;

                selectNumberNormal[0].classList.add('select-seat-ul-active');
                ticketPrice.innerHTML = allMoney + '원';
            }
        } else if (li.parentNode.classList.contains('select-seat-ul-teen')) {
            teenNumber = Number(li.innerHTML);
            teenMoney = price/2 * teenNumber; // 청소년 티켓 가격 선정.
            allMoney = normalMoney + teenMoney + oldMoney;
            allNumber = normalNumber + teenNumber + oldNumber;
            ticketPrice.innerHTML = allMoney + '원';
            if (allNumber > 16) {
                li.classList.remove('select-seat-ul-active');
                //normalNumber = teenNumber = oldNumber = 0;
                allMoney -= teenMoney;
                allNumber = allNumber - teenNumber;

                selectNumberTeen[0].classList.add('select-seat-ul-active');
                ticketPrice.innerHTML = allMoney + '원';
            }
        } else if (li.parentNode.classList.contains('select-seat-ul-old')) {
            oldNumber = Number(li.innerHTML);
            oldMoney = price/2 * oldNumber; // 경로  티켓 가격 선정.
            allMoney = normalMoney + teenMoney + oldMoney;
            allNumber = normalNumber + teenNumber + oldNumber;
            ticketPrice.innerHTML = allMoney + '원';
            if (allNumber > 16) {
                li.classList.remove('select-seat-ul-active');

                allMoney -= oldMoney;
                allNumber = allNumber - oldNumber;

                selectNumberOld[0].classList.add('select-seat-ul-active');
                ticketPrice.innerHTML = allMoney + '원';
            }
        }

        // allNumber = normalNumber + teenNumber + oldNumber;
        // allMoney = normalMoney + teenMoney + oldMoney;
        ticketPrice.innerHTML = allMoney + '원';

        payMoney.value = allMoney;
        console.log(allMoney); // 전체 티켓 가격
    });
}

selectSeatList(selectSeatListNormal);
selectSeatList(selectSeatListTeen);
selectSeatList(selectSeatListOld);

for (let i = 0; i < 10; i++) {
    div = document.createElement('div');
    div.classList = 'seatButtonWrapper';
    seatWrapper.append(div);

    for (let j = 0; j < 12; j++) {
        const input = document.createElement('input');
        input.type = 'button';
        input.name = 'seats';
        input.classList = 'seat';
        //3중포문을 사용하지 않기위해
        mapping(input, i, j);
        div.append(input);
        //클릭시 이벤트
        inputClickEvent(input);
    }

    seat = document.querySelectorAll('.seat');
    remainSeat.innerHTML = seat.length; //
    allSeat.innerHTML = seat.length;
}

seat.forEach(data => {
    //console.log(data.value.substring(1, data.value.length));
    // console.log(data.value.substring(0, data.value.length - 1));
    //좌석이 2나 9로 끝나는얘들은 왼쪽이나 오른쪽으로 띄워주기위한 class추가
    if (data.value.substring(1, data.value.length) === '2') {
        data.classList.add('left-margin');
    } else if (data.value.substring(1, data.value.length) === '9') {
        data.classList.add('right-margin');
    }
    //앞자리가 E로끝나는 좌석들에 class 추가
    if (
        data.value.substring(0, data.value.length - 1) === 'E' ||
        data.value.substring(0, data.value.length - 2) === 'E'
    ) {
        data.classList.add('top-margin');
    }
});

//TODO 좌석 2개씩은 커플석으로 분리하기위해서 해당 class를 추가해줘야하는데 value가 2로끝나는얘들이랑 7로끝나는 얘들은 class를 추가해주기

function inputClickEvent(input) {
    input.addEventListener('click', function(e) {
        console.log(e.target.value); //선택한 좌석 번호
        //중복방지 함수
        selectedSeatsArray = selectedSeatsArray.filter(
            (element, index) => selectedSeatsArray.indexOf(element) != index
        );

        //click class가 존재할때(제거해주는 toggle)
        if (input.classList.contains('clicked')) {
            input.classList.remove('clicked');
            clicked = document.querySelectorAll('.clicked');

            //배열안의 값 제거
            selectedSeatsArray.splice(selectedSeatsArray.indexOf(e.target.value), 1);
            clicked.forEach(data => {
                selectedSeatsArray.push(data.value);
            });
            //class가 존재안할때 추가해주는 toggle
        } else {
            input.classList.add('clicked');
            clicked = document.querySelectorAll('.clicked');
            //선택한 번호의 갯수를 넘기면 동작 못하게 하는 코드
            console.log(allNumber);
            if (clicked.length > allNumber) {
                input.classList.remove('clicked');
                alert("지정인원 초과");
                return;
            }

            clicked.forEach(data => {
                selectedSeatsArray.push(data.value);
            });
        }
        
        console.log(selectedSeatsArray.length); // 현재 선택된 좌석 수
        console.log(selectedSeatsArray); // 선택한 좌석 번호 리스트
        //좌석번호의 innerHTML 설정
        selectedSeats.innerHTML = selectedSeatsArray;
        if(selectedSeatsArray.length==0){
        	selectedSeats.innerHTML = "선택한 좌석이 없습니다.";
        }
        reserveNumber.innerHTML = selectedSeatsArray.length;
        remainSeat.innerHTML = seat.length - selectedSeatsArray.length -$(".seatok").length; //선택된 좌석 빼기. + 예매 완료된 좌석도 빼야됨.
        // if (selectedSeatsArray.length > 4) {
        //     return;
        // }
    });
}

function mapping(input, i, j) {
    if (i === 0) {
        input.value = 'A' + j;
    } else if (i === 1) {
        input.value = 'B' + j;
    } else if (i === 2) {
        input.value = 'C' + j;
    } else if (i === 3) {
        input.value = 'D' + j;
    } else if (i === 4) {
        input.value = 'E' + j;
    } else if (i === 5) {
        input.value = 'F' + j;
    } else if (i === 6) {
        input.value = 'G' + j;
    } else if (i === 7) {
        input.value = 'H' + j;
    } else if (i === 8) {
        input.value = 'I' + j;
    } else if (i === 9) {
        input.value = 'J' + j;
    } else if (i === 10) {
        input.value = 'K' + j;
    }
}

//form 제출시 hidden설정하기
reserveButton.addEventListener('click', function() {
    title.value = selectedMovie.innerHTML;
    selectedTheater.value =
        selectedTheaterPlaceInfo[0].innerHTML +
        ' ' +
        selectedTheaterPlaceInfo[1].innerHTML;
    reserveDate2.value = theaterDate.innerHTML;
    runningTime.value = theaterTime.innerHTML;
    ticketNumber.value = reserveNumber.innerHTML;
    selectedSeat.value = selectedSeats.innerHTML;
    console.log(allNumber + '임');
    console.log(ticketNumber.value);
    console.log(allNumber === ticketNumber.value);
    console.log(allNumber === Number(ticketNumber.value));
    
    console.log(selectedMovie);
    console.log(selectedTheaterPlaceInfo[0]);
    console.log(selectedTheaterPlaceInfo[1]);
    console.log(theaterDate);
    console.log(theaterTime);
    console.log(reserveNumber);
    console.log(selectedSeats);
    if (
        Number(ticketNumber.value) === allNumber &&
        ticketNumber.value !== '0' &&
        ticketNumber.value !== 0
    ) 
    {
    	
        seatForm.submit();
    } else {
        alert('좌석을 모두선택해 주세요!');
    }
   
});

