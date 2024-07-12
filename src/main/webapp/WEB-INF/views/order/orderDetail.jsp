<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../header.jsp"%>

<!-- orderDetail.jsp -->

<!-- 본문 시작 -->

 <div class="delivery-wrap">
	<div class="delivery-info">
	    <h2>배송지</h2>
	    <form>
	        <div class="form-group">
	            <label>배송지 선택*</label>
	            <div class="radio-group">
	                <input type="radio" id="new-address" name="address-type" checked>
	                <label for="new-address">신규 배송지</label>
	                <input type="radio" id="saved-address" name="address-type">
	                <label for="saved-address">기존 배송지</label>
	            </div>
	        </div>
	        <div class="form-group">
	            <label>배송 방법*</label>
	            <div class="radio-group">
	                <input type="radio" id="domestic" name="delivery-method" checked>
	                <label for="domestic">국내 배송</label>
	            </div>
	        </div>
	        <div class="form-group">
	            <label for="recipient">수령인*</label>
	            <input type="text" id="recipient" placeholder="수령인 이름을 입력하세요">
	            <label class="checkbox-label">
	                <input type="checkbox" id="order-name">
	                주문자와 동일
	            </label>
	        </div>
	        <div class="form-group">
	            <label>연락처1*</label>
	            <div class="phone-input">
	                <select><option>선택</option></select>
	                <input type="text" placeholder="-">
	                <input type="text" placeholder="-">
	            </div>
	        </div>
	        <div class="form-group">
	            <label>연락처2</label>
	            <div class="phone-input">
	                <select><option>선택</option></select>
	                <input type="text" placeholder="-">
	                <input type="text" placeholder="-">
	            </div>
	        </div>
	        <div class="form-group">
	            <label>배송지 주소*</label>
	            <button type="button" class="address-search">우편번호 검색</button>
	            <input type="text" placeholder="주소" readonly>
	            <input type="text" placeholder="상세주소">
	        </div>
	        <div class="delivery-memo">
	            <h3>배송 메모</h3>
	            <label class="radio-label">
	                <input type="radio" name="memo" checked>
	                기본배송지로 설정
	            </label>
	            <label class="radio-label">
	                <input type="radio" name="memo">
	                배송지 목록에 추가
	            </label>
	        </div>
	    </form>
	    <div class="order-items">
	        <h3>주문상품 <span class="totalCount">2종 2개</span> 
	        <button class="view-items">주문상품 수정하기</button></h3>
	        <table class="item-list">
	            <thead>
	                <tr>
	                    <th>상품정보</th>
	                    <th>판매가</th>
	                    <th>수량</th>
	                    <th>예상 적립금</th>
	                    <th>금액 합계</th>
	                </tr>
	            </thead>
	            <tbody>
	            	 <c:forEach items="${order}" var="row">
		                <tr>
		                    <td class="item-info">
		                        <img src="${pageContext.request.contextPath}/images/${row.img}" alt="${row.book_title}">
		                        <div>
		                            <p class="boot-title">${row.book_title}</p>
		                        </div>
		                    </td>
		                    <td>
		                        <p class="discount">10%</p>
		                        <p class="price">11,700원</p>
		                        <p class="original-price">13,000원</p>
		                    </td>
		                    <td>1</td>
		                    <td>${row.save_points}원</td>
		                    <td class="sale-price">11,700원</td>
		                </tr>
	                </c:forEach>
	            </tbody>
	        </table>
	    </div>
	    <div class="discount-section">
	        <h3>할인 <span class="toggle-icon">^</span></h3>
	        <div class="discount-content">
	            <p class="no-discount">사용가능한 쿠폰이 없습니다.</p>
	            <div class="discount-item">
	                <span>예치금</span>
	                <input type="text" value="0">
	                <button>전액 사용</button>
	                <span class="available">(보유 : 0원)</span>
	            </div>
	            <div class="discount-item">
	                <span>적립금</span>
	                <input type="text" value="0">
	                <button>전액 사용</button>
	                <span class="available">(보유 : 1,550원)</span>
	            </div>
	            <div class="discount-item">
	                <span>YP 머니</span>
	                <input type="text" value="0">
	                <button>전액 사용</button>
	                <span class="available">(보유 : 0원)</span>
	            </div>
	            <p class="discount-note">ㆍ쿠폰, 예치금, 적립금 사용 시 예상 적립금이 변경될 수 있습니다.</p>
	            <p class="discount-note">주문 완료 후 마이페이지 → 주문 상세에서 확인해 주세요.</p>
	        </div>
	    </div>
	    
	    <div class="payment-method">
	        <h3>결제수단 <span class="check-icon">✓</span> 선택한 결제수단을 다음에도 사용</h3>
	        <p class="total-payment">총 결제 금액 <span class="total-amount">${row.total_amount}</span></p>
	        <div class="payment-options">
	            <div class="payment-option">
	                <img src="kakao_pay.png" alt="카카오페이">
	                <p>신용카드</p>
	            </div>
	            <div class="payment-option">
	                <img src="payco.png" alt="페이코">
	                <p>실시간 계좌이체</p>
	            </div>
	            <div class="payment-option">
	                <img src="toss.png" alt="토스">
	                <p>무통장(온라인)입금</p>
	            </div>
	        </div>
	        <p class="payment-note">카카오페이 이용안내</p>
	    </div>
	</div>

    <div class="order-aside">
            <div class="customer-info">
                <h3>주문자 정보</h3>
                <p>주문자</p>
            </div>
            <div class="payment-info">
                <h3>결제 정보</h3>
                <table>
                    <tr>
                        <td>전체 주문금액</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>상품수</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>상품금액</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>할인금액</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>배송비</td>
                        <td>0원</td>
                    </tr>
                    <tr>
                        <td>예상 적립금</td>
                        <td></td>
                    </tr>
                </table>
            </div>
            <button class="order-button">주문하기</button>
        </div>
 </div>



<style>


.delivery-wrap{
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
</style>
			
<!-- 본문 끝 -->
<%@ include file="../footer.jsp"%>