<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../header.jsp"%>

<!-- orderProcess.jsp -->

<!-- 본문 시작 -->
<div class="main">
    <h1>결제 완료</h1>
    <div class="order-details">
        <div class="product-list">
            <h2>주문한 상품</h2>
            <c:forEach items="${cartItems}" var="row">
                <div class="product">
                    <img src="${pageContext.request.contextPath}/images/${row.img}" alt="${row.book_title}">
                    <div class="product-info">
                        <h3>${row.book_title}</h3>
                        <p>수량: ${row.quantity}개</p>
                        <p>가격: ${row.sale_price}원</p>
                    </div>
                </div>
            </c:forEach>
            <p class="total">총 결제 금액: ${totalOrderAmount}원</p>
        </div>
        <div class="shipping-info">
            <h2>배송 및 주문자 정보</h2>
            <p>주문번호: ${orderInfo.payment_code}</p>
            <p>주문일: ${orderInfo.payment_date}</p>
            <p>주문인: ${orderInfo.recipient_name}</p>
            <p>주소: ${orderInfo.shipping_address}</p>
        </div>
    </div>
    <button class="confirm-btn" onclick="location.href='/'">확인</button>
</div>



<!-- 본문 끝 -->

<style>
.main {
    max-width: 800px;
    margin: 0 auto;
    background-color: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h1 {
    text-align: center;
    color: #333;
}

.order-details {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
}

.product-list, .shipping-info {
    width: 48%;
    background-color: #f9f9f9;
    padding: 15px;
    border-radius: 8px;
}

h2 {
    font-size: 18px;
    margin-top: 0;
    margin-bottom: 15px;
}

.product {
    display: flex;
    margin-bottom: 15px;
}

.product img {
    width: 100px;
    height: 100px;
    object-fit: cover;
    margin-right: 15px;
}

.product-info h3 {
    margin-top: 0;
    margin-bottom: 5px;
}

.product-info p {
    margin: 3px 0;
    font-size: 14px;
}

.total {
    font-weight: bold;
    margin-top: 15px;
}

.shipping-info p {
    margin: 5px 0;
    font-size: 14px;
}

.confirm-btn {
    display: block;
    width: 100%;
    padding: 10px;
    background-color: #000;
    color: white;
    border: none;
    border-radius: 5px;
