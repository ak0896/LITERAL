<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- seatSelection.jsp -->
<!-- 사이드 메뉴 시작 -->
<div class="contents_inner">
	<div class="sidebar">
		<h3>지점 선택</h3>
		<form action="${pageContext.request.contextPath}/selectBranch"
			method="post" id="branchForm">
			<!-- 라디오 버튼: 선택 가능한 지점 목록을 보여줍니다. -->
			<div>
				<label> <input type="radio" name="branch_code" value="L01"
					${sessionScope.branch_code == 'L01' ? 'checked' : ''}> 강남점
				</label>
			</div>
			<div>
				<label> <input type="radio" name="branch_code" value="L02"
					${sessionScope.branch_code == 'L02' ? 'checked' : ''}> 연희점
				</label>
			</div>
			<div>
				<label> <input type="radio" name="branch_code" value="L03"
					${sessionScope.branch_code == 'L03' ? 'checked' : ''}> 종로점
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
	<h3>${branch_name}좌석선택</h3>
	<!-- 좌석 선택 폼 -->
	<form id="seatSelectionForm"
		action="${pageContext.request.contextPath}/paymentForm" method="post">
		<!-- 선택된 지점 코드를 숨긴 필드에 저장 -->
		<input type="hidden" name="branch_code" value="${sessionScope.branch_code}">
		<div class="seatArea">
			<!-- 좌석 배열을 반복문으로 처리 -->
			<c:forEach var="seat" items="${seatLayout}">
				<c:choose>
					<c:when test="${seat != 'hidden'}">
						<!-- 좌석 버튼 (좌석이 숨겨진 것이 아닌 경우) -->
						<button type="button" class="seat" data-seat_code="${seat}"
							onclick="selectSeat('${seat}')">${seat.split('-')[1]}<br>남은
							시간:
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

		<!-- 결제 정보 -->
		<div class="payment-options">
			<h2>선택된 좌석 정보</h2>
			<p>지점 :${sessionScope.branch_name}</p>
			<p>좌석 번호 : <span id="selectedSeatInfo"></span></p>
			<!-- 결제 옵션 추가 -->
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

			<!-- 시작 시간 선택 -->
			<h2>시작 시간</h2>
			<div class="times">
				<button type="button" class="time" data-time_code="T01"
					data-start_time="09:00">09:00</button>
				<button type="button" class="time" data-time_code="T02"
					data-start_time="10:00">10:00</button>
				<button type="button" class="time" data-time_code="T03"
					data-start_time="11:00">11:00</button>
				<button type="button" class="time" data-time_code="T04"
					data-start_time="12:00">12:00</button>
				<button type="button" class="time" data-time_code="T05"
					data-start_time="13:00">13:00</button>
				<button type="button" class="time" data-time_code="T06"
					data-start_time="14:00">14:00</button>
				<button type="button" class="time" data-time_code="T07"
					data-start_time="15:00">15:00</button>
				<button type="button" class="time" data-time_code="T08"
					data-start_time="16:00">16:00</button>
				<button type="button" class="time" data-time_code="T09"
					data-start_time="17:00">17:00</button>
			</div> <!-- <div class="times"> end -->

			<input type="hidden" name="time_code" id="selectedTimeCode">
			<input type="hidden" name="start_time" id="selectedStartTime">
			<input type="hidden" name="end_time" id="selectedEndTime">  
			<input type="hidden" name="isMember" value="${loggedInUser != null}"> <!-- 로그인한 경우 true로 설정 -->

			<button type="submit" class="btn-primary">다음</button>

		</div> <!-- <div class="payment-options"> end -->
	</form> <!-- <form id="seatSelectionForm" end -->

	<script>
    function selectSeat(seatCode) {
        document.getElementById('selectedSeat').value = seatCode;
        document.getElementById('selectedSeatInfo').innerText = seatCode;
        var seats = document.querySelectorAll('.seat');
        seats.forEach(function(seat) {
            seat.classList.remove('selected');
        });
        var selectedSeatButton = document.querySelector('.seat[data-seat_code="' + seatCode + '"]');
        selectedSeatButton.classList.add('selected');
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
            });
        });

        // 종료 시간을 계산하여 설정
        document.getElementById("seatSelectionForm").addEventListener("submit", function(event) {
            const startTime = document.getElementById("selectedStartTime").value;
            const durationText = document.getElementById("selectedDuration").value;
            let duration = parseDuration(durationText);
            let endTime = calculateEndTime(startTime, duration);
            document.getElementById("selectedEndTime").value = endTime;
        });

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
            let endHours = (hours + parseInt(duration)) % 24;
            return `${endHours < 10 ? '0' + endHours : endHours}:${minutes < 10 ? '0' + minutes : minutes}`;
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
