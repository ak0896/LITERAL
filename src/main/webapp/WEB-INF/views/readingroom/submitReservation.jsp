<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

    <!-- submitReservation.jsp -->
	<!-- 본문 시작 -->

    <h1>Payment Form</h1>
    <p>지점: 
        <c:choose>
            <c:when test="${branch_code == 'L01'}">강남점</c:when>
            <c:when test="${branch_code == 'L02'}">연희점</c:when>
            <c:when test="${branch_code == 'L03'}">종로점</c:when>
            <c:otherwise>알 수 없음</c:otherwise>
        </c:choose>
    </p>
    <p>좌석 번호: ${seat_code}</p>
    <p>이용 시간: ${room_code}</p>
    <p>시작 시간: ${start_time}</p>
    <p>종료 시간: ${end_time}</p>
    
    <form id="paymentForm" action="${pageContext.request.contextPath}/submitReservation" method="post">
        <input type="hidden" name="branch_code" value="${branch_code}">
        <input type="hidden" name="seat_code" value="${seat_code}">
        <input type="hidden" name="room_code" value="${room_code}">
        <input type="hidden" name="reservation_total" value="${room_amount}">
        <input type="hidden" name="time_code" value="${time_code}">
        <input type="hidden" name="start_time" value="${start_time}">
        <input type="hidden" name="end_time" value="${end_time}">
        <input type="hidden" name="reservation_date" value="${reservation_date}"> <!-- 추가된 필드 -->
        <input type="hidden" name="using_seat" value="${using_seat}"> <!-- 추가된 필드 -->
        <input type="hidden" name="isMember" value="${isMember}"> <!-- 추가된 필드 -->

        <div class="payment-options">
            <h2>예약자 정보</h2>
            <c:if test="${isMember}">
                <p>이름: ${re_name}</p>
                <p>전화번호: ${re_phone}</p>
                <input type="hidden" name="re_name" value="${re_name}">
                <input type="hidden" name="re_phone" value="${re_phone}">
            </c:if>
            <c:if test="${!isMember}">
                <label for="re_name">이름:</label>
                <input type="text" name="re_name" id="re_name" value="${re_name}" required><br>
                
                <label for="re_phone">전화번호:</label>
                <input type="text" name="re_phone" id="re_phone" value="${re_phone}" required><br>
            </c:if>

            <h2>결제 정보</h2>
            <label for="mycoupon_number">쿠폰 번호:</label>
            <input type="text" name="mycoupon_number" id="mycoupon_number" placeholder="쿠폰 번호가 있다면 입력하세요"><br>
            
            <label for="reservation_payment">결제 방법:</label>
            <select name="reservation_payment" id="reservation_payment" required>
                <option value="신용카드">신용카드</option>
                <option value="계좌이체">계좌이체</option>
            </select>
            <br>
            <label for="reservation_total">결제 금액:</label>
            <input type="text" name="reservation_total_display" id="reservation_total_display" value="${room_amount}" readonly>

            <button type="submit" class="btn-primary">결제</button>
        </div> <!-- <div class="payment-options"> end -->
    </form>

	<!-- 본문 끝 -->
<%@ include file="../footer.jsp"%>
