<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- 포트원 결제 -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<!-- submitReservation.jsp -->
<!-- 본문 시작 -->
<div class="paymentArea">
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
	    <input type="hidden" name="reservation_date" value="${reservation_date}">
	    <input type="hidden" name="using_seat" value="${using_seat}">
	    <input type="hidden" name="isMember" value="${isMember}">
	
	    <div class="payment-options">
	        <h2>예약자 정보</h2>
	        <c:if test="${isMember}">
	            <p>이름: ${re_name}</p>
	            <p>전화번호: ${re_phone}</p>
	            <input type="hidden" name="re_name" id="re_name" value="${re_name}">
	            <input type="hidden" name="re_phone" id="re_phone" value="${re_phone}">
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
	            <option value="카카오페이">카카오페이</option>
	            <option value="토스페이">토스페이</option>
	        </select>
	        <br>
	        <label for="reservation_total">결제 금액:</label>
	        <input type="text" name="reservation_total_display" id="reservation_total_display" value="${room_amount}" readonly>
	
	        <button type="button" class="btn-primary" onclick="requestPay()">결제</button>
	    </div>
	</form>
</div>
<script>
var IMP = window.IMP;
IMP.init("imp45135378"); // 실제 가맹점 식별코드로 변경 필요

function requestPay() {
    console.log("requestPay function called");

    var paymentMethodElement = document.getElementById('reservation_payment');
    var amountElement = document.getElementById('reservation_total_display');
    var nameElement = document.getElementById('re_name');
    var phoneElement = document.getElementById('re_phone');

    if (!paymentMethodElement) {
        console.error("Payment method element not found");
        return;
    }
    if (!amountElement) {
        console.error("Amount element not found");
        return;
    }

    var paymentMethod = paymentMethodElement.value;
    var amount = parseInt(amountElement.value);
    var name = nameElement ? nameElement.value : '${re_name}';
    var phone = phoneElement ? phoneElement.value : '${re_phone}';
    var seat = "${seat_code}";
    var isMember = ${isMember};

    console.log("Payment Method:", paymentMethod);
    console.log("Amount:", amount);
    console.log("Name:", name);
    console.log("Phone:", phone);
    console.log("Seat:", seat);
    console.log("Is Member:", isMember);


    var today = new Date();
    var merchant_uid = "IMP" + today.getHours() + today.getMinutes() + today.getSeconds() + today.getMilliseconds();

    var pg;
    switch(paymentMethod) {
        case '카카오페이':
            pg = 'kakaopay.TC0ONETIME';
            break;
        case '토스페이': 
        	pg = 'tosspay';
        	break;
        case '신용카드':
        case '계좌이체':
        default:
            pg = 'html5_inicis';
    }

    IMP.request_pay({
        pg: pg,
        //pay_method: paymentMethod === '계좌이체' ? 'trans' : 'card',
        pay_method: paymentMethod === '계좌이체' || paymentMethod === '토스페이' ? 'trans' : 'card',
        merchant_uid: merchant_uid,
        name: '좌석 예약: ' + seat,
        amount: amount,
        buyer_name: name,
        buyer_tel: phone,
        custom_data: {isMember: isMember}  // 회원/비회원 여부를 custom_data로 전달
    }, function (rsp) {
        if (rsp.success) {
            alert('결제가 완료되었습니다.');
            // 결제 성공 시 추가 데이터를 폼에 포함
            var form = document.getElementById('paymentForm');
            var hiddenField = document.createElement('input');
            hiddenField.type = 'hidden';
            hiddenField.name = 'imp_uid';
            hiddenField.value = rsp.imp_uid;
            form.appendChild(hiddenField);
            form.submit();
        } else {
            alert('결제에 실패하였습니다. ' + rsp.error_msg);
        }
    });
}
</script>
<style>
	.paymentArea {
            max-width: 600px;
            width: 100%;
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin:20px auto;
        }
        h1, h2 {
            color: #333;
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
        input[type="text"],
        input[type="email"],
        select {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            display: block;
            width: 100%;
            text-align: center;
            font-size: 16px;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .info {
            margin-bottom: 20px;
        }
</style>

<!-- 본문 끝 -->
<%@ include file="../footer.jsp"%>