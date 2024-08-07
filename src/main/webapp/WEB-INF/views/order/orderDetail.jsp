<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../header.jsp"%>

<!-- 포트원 결제 -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>


<!-- orderDetail.jsp -->

<div class="delivery-wrap">
    <div class="delivery-info">
        <h2>배송지</h2>
        <form id="orderForm" action="/order/orderProcess" method="post">
            <input type="hidden" name="cart_code" value="${cartCode}">
            <input type="hidden" name="payment_code" value="${paymentCode}">
            <input type="hidden" name="email" value="${email}">
            <!-- 배송지 정보 -->
            <div class="form-group">
                <label for="recipient_name">수령인*</label>
                <input type="text" id="recipient_name" name="recipient_name" placeholder="수령인 이름을 입력하세요" required>
            </div>

            <div class="form-group">
                <label>연락처*</label>
                <div class="phone-input">
                    <select id="phone1-part1" name="phone1-part1" required>
                        <option value="">선택</option>
                        <option value="010">010</option>
                    </select>
                    <input type="text" id="phone1-part2" name="phone1-part2" placeholder="-" required>
                    <input type="text" id="phone1-part3" name="phone1-part3" placeholder="-" required>
                </div>
                <input type="hidden" id="recipient_phone" name="recipient_phone">
            </div>
            <div class="form-group">
                <label>배송지 주소*</label>
                <button type="button" class="address-search" onclick="DaumPostcode()">우편번호 검색</button>
                <div id="wrap" style="display:none;"></div>
                <input type="text" id="zipcode" name="zipcode" placeholder="우편번호" readonly>
                <input type="text" id="address" name="address" placeholder="주소" readonly>
                <input type="text" id="detailed_address" name="detailed_address" placeholder="상세주소" required>
            </div>
            <input type="hidden" id="shipping_address" name="shipping_address">

            <!-- 주문상품 정보 -->
            <div class="order-items">
                <h3>주문상품 <span class="totalCount">${totalProductCount}종 ${totalProductCount}개</span>
                <button class="view-items" onclick="location.href='/cart/cartList'">주문상품 수정하기</button></h3>
                <table class="item-list">
                    <thead>
                        <tr>
                            <th>상품정보</th>
                            <th>판매가</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${cartItems}" var="row">
                            <tr>
                                <td class="item-info">
                                    <img src="${pageContext.request.contextPath}/storage/images/${row.img}" alt="${row.book_title}">
                                    <div>
                                        <p class="boot-title">${row.book_title}</p>
                                    </div>
                                </td>
                                <td>
                                    <p class="price">${row.sale_price}원</p>
                                    <p class="original-price">${row.original_price}원</p>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- 할인 정보 -->
            <div class="discount-section">
                <h3>할인 <span class="toggle-icon">^</span></h3>
                <div class="discount-content">
                    <p class="no-discount">사용가능한 쿠폰이 없습니다.</p>
                    <div class="discount-item">
                        <span>적립금</span>
                        <input type="text" name="points" value="0">
                        <button type="button">전액 사용</button>
                        <span class="available">(보유 : 1,550원)</span>
                    </div>
                </div>
            </div>

            <!-- 결제수단 정보 -->
            <label for="payment_method">결제 방법:</label>
            <select name="payment_method" id="payment_method" required>
                <option value="신용카드">신용카드</option>
                <option value="계좌이체">계좌이체</option>
                <option value="카카오페이">카카오페이</option>
                <option value="토스페이">토스페이</option>
            </select>

            <!-- order-aside 정보 히든 필드로 추가 -->
            <input type="hidden" name="total_order_amount" value="${totalOrderAmount}">
            <input type="hidden" name="total_product_count" value="${totalProductCount}">
            <input type="hidden" name="total_product_amount" value="${totalProductAmount}">
            <input type="hidden" name="total_discount_amount" value="0">
            <input type="hidden" name="delivery_fee" value="${deliveryFee}">
            <input type="hidden" name="expected_points" value="${expectedPoints}">

            <button type="submit" class="order-button" onclick="requestPay()">주문하기</button>
        </form>
    </div>

    <!-- 결제 정보 표시 -->
    <div class="order-aside">
        <div class="customer-info">
            <h3>주문자 정보</h3>
        </div>
        <div class="payment-info">
            <h3>결제 정보</h3>
            <table>
                <tr>
                    <td>전체 주문금액</td>
                    <td>${totalOrderAmount}원</td>
                </tr>
                <tr>
                    <td>상품수</td>
                    <td>${totalProductCount}개</td>
                </tr>
                <tr>
                    <td>상품금액</td>
                    <td>${totalProductAmount}원</td>
                </tr>
                <tr>
                    <td>배송비</td>
                    <td>${deliveryFee}원</td>
                </tr>
                <tr>
                    <td>예상 적립금</td>
                    <td>${expectedPoints}원</td>
                </tr>
                <tr>
                    <td>총 금액</td>
                    <td><strong>${totalOrderAmount + deliveryFee}원</strong></td>
                </tr>
            </table>
        </div>
    </div>
</div>
<!-- Kakao 지도 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1d2c6fcb1c84e26382b93490500af756&libraries=services"></script>

<script>
document.getElementById('orderForm').addEventListener('submit', function(event) {
    var recipient = document.getElementById('recipient_name').value;
    var phonePart1 = document.getElementById('phone1-part1').value;
    var phonePart2 = document.getElementById('phone1-part2').value;
    var phonePart3 = document.getElementById('phone1-part3').value;
    var address = document.getElementById('address').value;
    var detailedAddress = document.getElementById('detailed_address').value;
    var zipcode = document.getElementById('zipcode').value;

    if (!recipient || !phonePart1 || !phonePart2 || !phonePart3 || !address || !detailedAddress || !zipcode) {
        alert('모든 필수 항목을 입력해 주세요.');
        event.preventDefault();
        return;
    }

    document.getElementById('recipient_phone').value = phonePart1 + '-' + phonePart2 + '-' + phonePart3;
    document.getElementById('shipping_address').value = zipcode + ' ' + address + ' ' + detailedAddress;
});


var element_wrap = document.getElementById('wrap');

function foldDaumPostcode() {
    element_wrap.style.display = 'none';
}

function DaumPostcode() {
    var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = '';
            var extraAddr = '';

            if (data.userSelectedType === 'R') {
                addr = data.roadAddress;
            } else {
                addr = data.jibunAddress;
            }

            if (data.userSelectedType === 'R') {
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraAddr += data.bname;
                }
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if (extraAddr !== '') {
                    extraAddr = ' (' + extraAddr + ')';
                }
                addr += extraAddr;
            }

            document.getElementById('zipcode').value = data.zonecode;
            document.getElementById('address').value = addr;

            element_wrap.style.display = 'none';
            document.body.scrollTop = currentScroll;
        },
        onresize: function(size) {
            element_wrap.style.height = size.height + 'px';
        },
        width: '100%',
        height: '100%'
    }).embed(element_wrap);

    element_wrap.style.display = 'block';
}


var IMP = window.IMP;
IMP.init("imp45135378");

function requestPay() {
    var today = new Date();
    var merchant_uid = "IMP" + today.getHours() + today.getMinutes() + today.getSeconds() + today.getMilliseconds();
    var paymentMethod = document.getElementById('payment_method').value;
    var amount = parseInt(document.getElementsByName('total_order_amount')[0].value);

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
        name: '서점 주문 결제',
        amount: amount,
        buyer_email: document.getElementsByName('email')[0].value,
        buyer_name: document.getElementById('recipient_name').value,
        buyer_tel: document.getElementById('phone1-part1').value + '-' + document.getElementById('phone1-part2').value + '-' + document.getElementById('phone1-part3').value,
        buyer_addr: document.getElementById('address').value,
        buyer_postcode: document.getElementById('zipcode').value,
    }, function (rsp) {
        if (rsp.success) {
            alert('결제가 완료되었습니다.');
            var form = document.getElementById('orderForm');
            var impUidField = document.createElement('input');
            impUidField.type = 'hidden';
            impUidField.name = 'imp_uid';
            impUidField.value = rsp.imp_uid;
            form.appendChild(impUidField);
            form.submit();
        } else {
            alert('결제에 실패하였습니다. ' + rsp.error_msg);
        }
    });
}

</script>

<style>
.delivery-wrap {
    display: flex;
    max-width: 1000px;
    margin: 15px auto;
    gap: 15px;
}

.delivery-info {
    flex: 7;
    background-color: #ffffff;
    padding: 20px;
    border-radius: 4px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.order-aside {
    flex: 3;
    background-color: #ffffff;
    padding: 20px;
    border-radius: 4px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    height: fit-content;
}

h2 {
    font-size: 16px;
    margin-bottom: 15px;
}

.form-group {
    margin-bottom: 15px;
}

.form-group label {
    display: block;
    margin-bottom: 4px;
    font-weight: bold;
    font-size: 12px;
}

.radio-group {
    display: flex;
    gap: 15px;
}

.radio-group label {
    display: flex;
    align-items: center;
    gap: 4px;
}

input[type="text"], select {
    width: 100%;
    padding: 6px 8px;
    border: 1px solid #ddd;
    border-radius: 3px;
    font-size: 12px;
}

.phone-input {
    display: flex;
    gap: 8px;
}

.phone-input select {
    width: 70px;
}

.phone-input input {
    flex: 1;
}

.address-search {
    background-color: #f8f8f8;
    border: 1px solid #ddd;
    padding: 6px 12px;
    border-radius: 3px;
    cursor: pointer;
    margin-bottom: 8px;
    font-size: 12px;
}

.delivery-memo {
    margin-top: 20px;
}

.customer-info, .payment-info {
    margin-bottom: 20px;
}

.customer-info h3, .payment-info h3 {
    font-size: 14px;
    margin-bottom: 10px;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 12px;
    font-size: 12px;
}

td {
    padding: 6px 0;
}

td:last-child {
    text-align: right;
}

.green-text {
    color: #4CAF50;
    font-size: 11px;
    margin-top: 12px;
}

.order-button {
    width: 100%;
    padding: 12px;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 14px;
    font-weight: bold;
}

.checkbox-label, .radio-label {
    display: flex;
    align-items: center;
    gap: 4px;
    margin-top: 4px;
    font-size: 12px;
}

.discount-section, .payment-method {
    border: 1px solid #ddd;
    border-radius: 4px;
    margin-top: 20px;
    overflow: hidden;
}

.discount-section h3, .payment-method h3 {
    background-color: #f8f8f8;
    padding: 10px 15px;
    margin: 0;
    font-size: 14px;
    border-bottom: 1px solid #ddd;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.toggle-icon, .check-icon {
    font-size: 12px;
    color: #888;
}

.discount-content {
    padding: 15px;
}

.no-discount {
    color: #888;
    margin-bottom: 10px;
}

.discount-item {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
}

.discount-item span {
    width: 80px;
}

.discount-item input {
    width: 100px;
    margin-right: 10px;
}

.discount-item button {
    background-color: #f8f8f8;
    border: 1px solid #ddd;
    padding: 5px 10px;
    border-radius: 3px;
    font-size: 12px;
    margin-right: 10px;
}

.available {
    color: #888;
    font-size: 12px;
}

.discount-note {
    font-size: 12px;
    color: #888;
    margin-top: 10px;
}

.payment-method {
    padding-bottom: 15px;
}

.total-payment {
    padding: 15px;
    font-weight: bold;
    border-bottom: 1px solid #ddd;
}

.total-amount {
    color: #e74c3c;
    font-size: 18px;
}

.payment-options {
    display: flex;
    justify-content: space-around;
    padding: 15px;
}

.payment-option {
    text-align: center;
}

.payment-option img {
    width: 80px;
    height: 40px;
    object-fit: contain;
    border: 1px solid #ddd;
    border-radius: 4px;
    padding: 5px;
}

.payment-option p {
    margin-top: 5px;
    font-size: 12px;
}

.payment-note {
    padding: 0 15px;
    font-size: 12px;
    color: #4CAF50;
}

.item-info{
	width:100px;
	height:150px;
}

.item-info img{
	width:100%;
}
</style>

<%@ include file="../footer.jsp"%>
