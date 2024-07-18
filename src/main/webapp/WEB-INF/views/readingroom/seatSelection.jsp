<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- seatSelection.jsp -->
<!-- 사이드 메뉴 시작 -->
<div class="contents_inner">
    <div class="sidebar">
        <h3>지점 선택</h3>
        <form action="${pageContext.request.contextPath}/selectBranch" method="post" id="branchForm">
            <!-- 라디오 버튼: 선택 가능한 지점 목록을 보여줍니다. -->
            <div>
                <label for="branch_l01"> <input type="radio" id="branch_l01" name="branch_code" value="L01" ${sessionScope.branch_code == 'L01' ? 'checked' : ''}> 강남점
                </label>
            </div>
            <div>
                <label for="branch_l02"> <input type="radio" id="branch_l02" name="branch_code" value="L02" ${sessionScope.branch_code == 'L02' ? 'checked' : ''}> 연희점
                </label>
            </div>
            <div>
                <label for="branch_l03"> <input type="radio" id="branch_l03" name="branch_code" value="L03" ${sessionScope.branch_code == 'L03' ? 'checked' : ''}> 종로점
                </label>
            </div>
            <!-- 예약하기 버튼: 선택한 지점을 예약 처리합니다. -->
            <div>
                <input type="submit" value="예약하기">
            </div>
        </form>
    </div> <!-- <div class="sidebar"> end -->
    <!-- 사이드 메뉴 끝 -->

    <!-- 본문 시작 -->
    
    <h3>${branch_name} 좌석선택</h3>
    <!-- 좌석 선택 폼 -->
    <form id="seatSelectionForm" action="${pageContext.request.contextPath}/paymentForm" method="post">
        <!-- 선택된 지점 코드를 숨긴 필드에 저장 -->
        <input type="hidden" name="branch_code" value="${sessionScope.branch_code}">
        <div class="seatArea">
            <!-- 좌석 배열을 반복문으로 처리 -->
            <c:forEach var="seat" items="${seatLayout}">
                <c:choose>
                    <c:when test="${seat != 'hidden'}">
                        <!-- 좌석 버튼 (좌석이 숨겨진 것이 아닌 경우) -->
                        <button type="button" class="seat ${seatTimes[seat] != '00:00' ? 'in-use' : ''}" data-seat_code="${seat}" data-remaining_time="${seatTimes[seat]}" onclick="selectSeat('${seat}', '${seatTimes[seat]}')">
                            ${seat.split('-')[1]}<br>남은 시간:<br><span class="remaining-time">${seatTimes[seat]}</span>
                        </button>
                    </c:when>
                    <c:otherwise>
                        <!-- 숨겨진 좌석 버튼 -->
                        <button type="button" class="seat seat_hidden">hidden</button>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div> <!-- <div class="seatArea"> end -->
        <!-- 선택된 좌석 코드를 숨긴 필드에 저장 -->
        <input type="hidden" name="seat_code" id="selectedSeat">
        <input type="hidden" name="remaining_time" id="selectedRemainingTime">

        

        <!-- 결제 정보 -->
        <div class="payment-options">
            <h2>선택된 좌석 정보</h2>
            <p>지점 :${sessionScope.branch_name}</p>
            <p>좌석 번호 : <span id="selectedSeatInfo"></span></p>
            <!-- 결제 옵션 추가 -->
            <!-- 시작 시간 선택 -->
            <h2>시작 시간</h2>
            <div class="times">
                <button type="button" class="time" data-time_code="T01" data-start_time="09:00">09:00</button>
                <button type="button" class="time" data-time_code="T02" data-start_time="10:00">10:00</button>
                <button type="button" class="time" data-time_code="T03" data-start_time="11:00">11:00</button>
                <button type="button" class="time" data-time_code="T04" data-start_time="12:00">12:00</button>
                <button type="button" class="time" data-time_code="T05" data-start_time="13:00">13:00</button>
                <button type="button" class="time" data-time_code="T06" data-start_time="14:00">14:00</button>
                <button type="button" class="time" data-time_code="T07" data-start_time="15:00">15:00</button>
                <button type="button" class="time" data-time_code="T08" data-start_time="16:00">16:00</button>
                <button type="button" class="time" data-time_code="T09" data-start_time="17:00">17:00</button>
            </div> <!-- <div class="times"> end -->

            <input type="hidden" name="time_code" id="selectedTimeCode">
            <input type="hidden" name="start_time" id="selectedStartTime">
            <input type="hidden" name="end_time" id="selectedEndTime">  
            <input type="hidden" name="isMember" value="${loggedInUser != null}"> <!-- 로그인한 경우 true로 설정 -->
            
            
            <h2>이용권</h2>
            <div class="options">
                <button type="button" class="option" data-room_code="D1" data-room_amount="4000" data-duration="2시간">
                    2 시간<br>4,000 원
                </button>
                <button type="button" class="option" data-room_code="D2" data-room_amount="6000" data-duration="4시간">
                    4 시간<br>6,000 원
                </button>
                <button type="button" class="option" data-room_code="D3" data-room_amount="8000" data-duration="6시간">
                    6 시간<br>8,000 원
                </button>
                <button type="button" class="option" data-room_code="D4" data-room_amount="10000" data-duration="종일권">
                    종일권<br>10,000 원
                </button>
            </div> <!-- <div class="options"> end -->
            <input type="hidden" name="room_code" id="selectedUsageTime">
            <input type="hidden" name="room_amount" id="selectedRoomAmount">
            <input type="hidden" name="duration" id="selectedDuration">

            
            <button type="submit" class="btn-primary">다음</button>

        </div> <!-- <div class="payment-options"> end -->
    </form> <!-- <form id="seatSelectionForm" end -->


<script>
    function selectSeat(seatCode, remainingTime) {
        console.log(`Seat selected: ${seatCode}, Remaining Time: ${remainingTime}`);
        document.getElementById('selectedSeat').value = seatCode;
        document.getElementById('selectedRemainingTime').value = remainingTime;
        document.getElementById('selectedSeatInfo').innerText = seatCode;
        var seats = document.querySelectorAll('.seat');
        seats.forEach(function(seat) {
            seat.classList.remove('selected');
            if (seat.classList.contains('in-use-temp')) {
                seat.classList.remove('selected', 'in-use-temp');
                seat.classList.add('in-use');
            }
        });
        var selectedSeatButton = document.querySelector('.seat[data-seat_code="' + seatCode + '"]');
        if (selectedSeatButton.classList.contains('in-use')) {
            selectedSeatButton.classList.remove('in-use');
            selectedSeatButton.classList.add('in-use-temp');
        }
        selectedSeatButton.classList.add('selected');
    }

    function updateRemainingTimes() {
        const buttons = document.querySelectorAll('.seat[data-remaining_time]');
        buttons.forEach(button => {
            const remainingTimeSpan = button.querySelector('.remaining-time');
            let [hours, minutes] = remainingTimeSpan.textContent.split(':').map(Number);

            if (minutes === 0) {
                if (hours === 0) {
                    // 시간이 모두 소진된 경우
                    remainingTimeSpan.textContent = '00:00';
                } else {
                    hours -= 1;
                    minutes = 59;
                }
            } else {
                minutes -= 1;
            }

            remainingTimeSpan.textContent = `${hours < 10 ? '0' + hours : hours}:${minutes < 10 ? '0' + minutes : minutes}`;
        });
        
        /* 새로고침 추가  */  
        // 1초 경과 후 자동으로 새로고침
           setTimeout(function() {
             location.reload();
           }, 1000);
    }

    document.addEventListener("DOMContentLoaded", function() {
        const options = document.querySelectorAll(".option");
        const times = document.querySelectorAll(".time");
        let selectedOption = null;
        let selectedTime = null;

        options.forEach(option => {
            option.addEventListener("click", function() {
                if (selectedOption) {
                    selectedOption.classList.remove("selected");
                }
                selectedOption = this;
                selectedOption.classList.add("selected");
                document.getElementById("selectedUsageTime").value = selectedOption.getAttribute("data-room_code");
                document.getElementById("selectedRoomAmount").value = selectedOption.getAttribute("data-room_amount");
                document.getElementById("selectedDuration").value = selectedOption.getAttribute("data-duration");
                console.log(`Option selected: ${selectedOption.getAttribute("data-room_code")}, Duration: ${selectedOption.getAttribute("data-duration")}`);
            });
        });

        times.forEach(time => {
            time.addEventListener("click", function() {
                if (selectedTime) {
                    selectedTime.classList.remove("selected");
                }
                selectedTime = this;
                selectedTime.classList.add("selected");
                document.getElementById("selectedTimeCode").value = selectedTime.getAttribute("data-time_code");
                document.getElementById("selectedStartTime").value = selectedTime.getAttribute("data-start_time");
                console.log(`Time selected: ${selectedTime.getAttribute("data-time_code")}, Start Time: ${selectedTime.getAttribute("data-start_time")}`);
            });
        });

        // 종료 시간을 계산하여 설정
        document.getElementById("seatSelectionForm").addEventListener("submit", function(event) {
        	 const selectedSeat = document.getElementById("selectedSeat").value;
        	 const selectedStartTime = document.getElementById("selectedStartTime").value;
        	 const selectedUsageTime = document.getElementById("selectedUsageTime").value;
        	 
        	 if (!selectedSeat || !selectedStartTime || !selectedUsageTime) {
        	        event.preventDefault(); // 폼 제출 막기
        	        alert('좌석, 시작 시간, 이용권을 모두 선택해주세요.');
        	        return;
        	    }
            
        	 const startTime = selectedStartTime;
        	 const durationText = document.getElementById("selectedDuration").value;
			console.log(`Start Time: ${startTime}, Duration: ${durationText}`);
		    let duration = parseDuration(durationText);
		    let endTime = calculateEndTime(startTime, duration);
		    document.getElementById("selectedEndTime").value = endTime;
		    console.log(`Calculated End Time: ${endTime}`);

    // 이미 사용 중인 좌석인지 확인
    const remainingTime = document.getElementById('selectedRemainingTime').value;
    if (remainingTime !== '00:00') {
        // 현재 시간과 남은 시간을 비교하여 예약이 가능한지 확인
        const now = new Date();
        const [remainingHours, remainingMinutes] = remainingTime.split(':').map(Number);
        const remainingEndTime = new Date(now.getTime() + remainingHours * 3600000 + remainingMinutes * 60000);
        
        // 예약 시작 시간이 남은 시간이 끝난 후인지 확인
        const [startHours, startMinutes] = startTime.split(':').map(Number);
        const startDateTime = new Date(now.getFullYear(), now.getMonth(), now.getDate(), startHours, startMinutes);

        if (startDateTime <= remainingEndTime) {
            event.preventDefault(); // 폼 제출 막기
            alert('이미 사용 중인 좌석입니다. 다른 좌석을 선택해주세요.');
            return;
        }
    }

    // 예약된 시작 시간에 타이머 작동시키기
    startTimerAtScheduledTime(startTime, duration);
});
        // 주기적으로 남은 시간을 업데이트
        setInterval(updateRemainingTimes, 60000); // 1분마다 업데이트

        function parseDuration(duration) {
            switch (duration) {
                case "2시간":
                    return 2;
                case "4시간":
                    return 4;
                case "6시간":
                    return 6;
                case "종일권":
                    return 10;
                default:
                    throw new Error("Invalid duration: " + duration);
            }
        }

        function calculateEndTime(startTime, duration) {
            let [hours, minutes] = startTime.split(':').map(Number);
            let endHours = hours + duration;

            // 종료 시간이 24시를 넘는 경우
            if (endHours >= 24) {
                endHours -= 24;
            }

            // 종료 시간이 19시를 넘지 않도록 설정
            if (endHours > 19 || (endHours === 19 && minutes > 0)) {
                endHours = 19;
                minutes = 0;
            }

            return `${endHours < 10 ? '0' + endHours : endHours}:${minutes < 10 ? '0' + minutes : minutes}`;
        }

        function startTimerAtScheduledTime(startTime, duration) {
            const now = new Date();
            const [startHours, startMinutes] = startTime.split(':').map(Number);
            const scheduledTime = new Date(now.getFullYear(), now.getMonth(), now.getDate(), startHours, startMinutes);

            const timeUntilStart = scheduledTime.getTime() - now.getTime();

            if (timeUntilStart > 0) {
                setTimeout(() => {
                    // 타이머 시작
                    console.log('타이머 시작');
                    setInterval(updateRemainingTimes, 60000); // 1분마다 업데이트
                }, timeUntilStart);
            } else {
                // 이미 시작 시간이 지난 경우 즉시 타이머 시작
                console.log('즉시 타이머 시작');
                setInterval(updateRemainingTimes, 60000); // 1분마다 업데이트
            }

            // 타이머 종료 시간 계산
            const endHours = startHours + duration;
            const endTime = new Date(now.getFullYear(), now.getMonth(), now.getDate(), endHours, startMinutes);

            const timeUntilEnd = endTime.getTime() - now.getTime();

            if (timeUntilEnd > 0) {
                setTimeout(() => {
                    // 타이머 종료
                    console.log('타이머 종료');
                    clearInterval(updateRemainingTimes);
                }, timeUntilEnd);
            }
        }
    });
    
    
    
    
</script>



<style>
.seatArea {
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    gap: 10px;
}

.seat, .seat_hidden {
    width: 100%;
    padding: 10px;
    text-align: center;
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: #f0f0f0;
}

.seat.selected {
    background-color: #4CAF50;
}

.seat.in-use {
    background-color: #FFA500; /* 타이머가 표시되는 좌석의 색상 (오렌지색) */
}

.seat_hidden {
    visibility: hidden;
}

.option.selected, .time.selected {
    background-color: #4CAF50;
}
</style>

<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->

<%@ include file="../footer.jsp"%>