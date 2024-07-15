<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../header.jsp"%>

<!-- msgView.jsp -->

<!-- 본문 시작 -->
<div class="main">
        <h1>결제 완료</h1>
        <div class="order-details">
            <div class="product-list">
                <h2>주문한 상품</h2>
                <div class="product">
                    <img src="product-image.jpg" alt="Product 298">
                    <div class="product-info">
                        <h3>Product 298</h3>
                        <p>색상: White</p>
                        <p>사이즈: XLARGE</p>
                        <p>수량: 1 / 200 원</p>
                    </div>
                </div>
                <div class="product">
                    <img src="product-image.jpg" alt="Product 304">
                    <div class="product-info">
                        <h3>Product 304</h3>
                        <p>색상: White</p>
                        <p>사이즈: SMALL</p>
                        <p>수량: 1 / 441 원</p>
                    </div>
                </div>
                <p class="total">총 결제 금액: 641 원</p>
            </div>
            <div class="shipping-info">
                <h2>배송 및 주문자 정보</h2>
                <p>주문번호: 2</p>
                <p>주문인: 제야미</p>
                <p>주소: 주소</p>
                <p>상세주소: 상세주소</p>
                <p>주문일: 2024-04-18T05:36:19.105257</p>
            </div>
        </div>
        <button class="confirm-btn">확인</button>
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
    font-size: 16px;
    margin-top: 20px;
    cursor: pointer;
}

.confirm-btn:hover {
    background-color: #333;
}

.order-details {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    overflow: hidden;
    position: relative;
}

.product-list, .shipping-info {
    width: 50%;
    padding: 15px;
    box-sizing: border-box;
}

.order-details::after {
    content: '';
    position: absolute;
    top: 10%;  /* 위에서 10% 위치에서 시작 */
    left: 50%;
    height: 80%;  /* 전체 높이의 80%만 차지 */
    width: 1px;
    background-color: #e0e0e0;
}
</style>
<%@ include file="../footer.jsp"%>