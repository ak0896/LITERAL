<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- 포트원 결제 -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<h1>Buy Ticket</h1>

<form id="buyTicketForm" action="${pageContext.request.contextPath}/buyTicket" method="post">
    <label for="ticketType">이용권 종류:</label>
    <select name="ticketType" id="ticketType" required>
        <option value="D1">2시간 이용권</option>
        <option value="D2">4시간 이용권</option>
        <option value="D3">6시간 이용권</option>
        <option value="D4">종일권(10시간)</option>
    </select>
    <br>
    <label for="ticketAmount">결제 금액:</label>
    <input type="text" name="ticketAmount" id="ticketAmount" value="4000" readonly>
    <br>
    <label for="paymentMethod">결제 방법:</label>
    <select name="paymentMethod" id="paymentMethod" required>
        <option value="신용카드">신용카드</option>
        <option value="계좌이체">계좌이체</option>
        <option value="카카오페이">카카오페이</option>
        <option value="토스페이">토스페이</option>
    </select>
    <br>
    <button type="button" class="btn-primary" onclick="requestPay()">결제</button>
</form>

<script>
var IMP = window.IMP;
IMP.init("imp45135378"); // 실제 가맹점 식별코드로 변경 필요

document.getElementById('ticketType').addEventListener('change', function() {
    var ticketPrices = {
        'D1': 4000,
        'D2': 6000,
        'D3': 8000,
        'D4': 10000
    };
    var selectedTicket = this.value;
    var amount = ticketPrices[selectedTicket];
    document.getElementById('ticketAmount').value = amount;
});

function requestPay() {
    var ticketType = document.getElementById('ticketType').value;
    var amount = parseInt(document.getElementById('ticketAmount').value);
    var paymentMethod = document.getElementById('paymentMethod').value;
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
        pay_method: paymentMethod === '계좌이체' || paymentMethod === '토스페이' ? 'trans' : 'card',
        merchant_uid: merchant_uid,
        name: '이용권 구매: ' + ticketType,
        amount: amount,
        buyer_email: '${sessionScope.email}', // 사용자 이메일
        buyer_name: '${sessionScope.name}', // 사용자 이름
        buyer_tel: '${sessionScope.phone}', // 사용자 전화번호
        custom_data: {ticketType: ticketType}  // 이용권 종류를 custom_data로 전달
    }, function (rsp) {
        if (rsp.success) {
            alert('결제가 완료되었습니다.');
            // 결제 성공 시 추가 데이터를 폼에 포함
            var form = document.getElementById('buyTicketForm');
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

<%@ include file="../footer.jsp"%>
