<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- cartList.jsp -->
<!-- 본문 시작 -->
<div class="container text-center">
    <div class="row">
    <div class="col-sm-12">
        <h2>장바구니</h2>
    </div>
    </div> <!--  <div class="row"> end -->

    <form name="cartForm" id="cartForm" action="/cart/deleteSelected" method="post">
        <table class="cart-table">
            <thead>
                <tr>
                    <td>번호</td>
                    <td>책 제목</td>
                    <td>판매가</td>
                    <td><input type="checkbox" id="selectAll" onclick="toggleSelectAll(this)"></td>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="row">
                   <tr>
                        <td>${row.cart_code}</td>
                        <td>${row.book_title}</td>
                        <td>${row.sale_price}</td>
                        <td>
                            <input type="checkbox" name="selected" value="${row.cart_code}-${row.sale_price}" class="checkbox" <c:if test="${row.select_yn}">checked</c:if> onclick="calculateTotal()">
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <div class="total-area">
           <p>
           	주문 상품  : 
          	<span id="totalCount">0</span>
           </p>
           <p>
           	총 금액 : 
          	<span id="totalAmount">0</span>원
           </p>
        </div> <!-- <div class="total-area"> end -->
        <div class="btn-area">
            <input type="submit" class="btn btn-primary" value="삭제">
            <input type="button" class="btn btn-success" onclick="location.href='/product/productlist'" value="쇼핑계속하기">
            <input type="submit" class="btn btn-warning" value="주문하기">
        </div>
    </form>
</div> <!-- <div class="container text-center"> -->

<script>
	function toggleSelectAll(selectAll) {
	    const checkboxes = document.getElementsByName('selected');
	    for (let i = 0; i < checkboxes.length; i++) {
	        checkboxes[i].checked = selectAll.checked;
	    }
	    calculateTotal();
	}
	function calculateTotal() {
	    const checkboxes = document.getElementsByName('selected');
	    let total = 0;
	    let count = 0;  // 주문 상품 수를 저장할 변수
	    for (let i = 0; i < checkboxes.length; i++) {
	        if (checkboxes[i].checked) {
	            const value = checkboxes[i].value.split('-')[1];
	            const parsedValue = parseFloat(value);
	            if (!isNaN(parsedValue)) {
	                total += parsedValue;
	                count++;  // 체크된 항목 수를 증가
	            }
	        }
	    }
	    document.getElementById('totalAmount').innerText = total.toLocaleString();
	    document.getElementById('totalCount').innerText = count;  // 주문 상품 수를 표시
	}
	
	function submitDeleteForm() {
	    document.getElementById('cartForm').submit();
	}
	
	// 초기 로드 시 총 금액 계산
	window.onload = calculateTotal;
</script>

<style>
    h2 {
        color: #3d3c3f;
        text-align: left;
    }
    .cart-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 15px;
    }
    .cart-table th, .cart-table td {
        font-size: 14px;
        color: #80888a;
        font-weight: 400;
        padding: 8px;
        border-bottom: 1px solid #ddd;
    }
    .cart-table th {
        text-align: center;
    }
    .cart-table img {
        max-width: 100px;
    }
    .btn-area {
        margin-top: 20px;
    }
</style>

<!-- 본문 끝 -->
<%@ include file="../footer.jsp"%>
