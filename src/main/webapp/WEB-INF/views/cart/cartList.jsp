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
    <input type="hidden" id="book_number" name="book_number" value="${prodcut.book_number}">
    <input type="hidden" id="cart_code" name="cart_code" value="${cart.cart_code}">
        <table class="cart-table">
            <thead>
                <tr>
                    <td><input type="checkbox" id="selectAll" onclick="toggleSelectAll(this)"></td>
                    <td> 책 제목 </td>
                    <td> 판매가 </td>
                </tr>
            </thead>
            <tbody>
				<c:forEach items="${list}" var="row">
                  <c:if test="${row.select_yn}">
                    <tr>
                        <td class="book-image">
                           <img src="${pageContext.request.contextPath}/storage/images/${row.img}" alt="${row.book_title}" style="max-width: 100px; max-height: 150px;">
                        </td>
                        <td>
                            <div class="title">${row.book_title}</div>
                            <div>
                                <span class="price">${row.sale_price}원</span>
                                <span class="original-price">${row.original_price}원</span>
                            </div>
                        </td>
                        <td>
                            <input type="checkbox" name="selected" value="${row.cart_code}-${row.sale_price}" class="checkbox" checked onclick="calculateTotal()">
                        </td>
                    </tr>
                  </c:if>
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
          	<span id="cart_amount">0</span>원
           </p>
        </div> <!-- <div class="total-area"> end -->
        <div class="btn-area">
            <input type="button" class="btn btn-primary" value="삭제" onclick="cartDelete()">
            <input type="button" class="btn btn-success" onclick="location.href='/product/productlist'" value="쇼핑계속하기">
            <input type="button" class="btn btn-warning" onclick="location.href='/order/orderDetail'" value="주문하기">
        </div>
        <!-- 숨겨진 필드를 추가하여 선택된 항목을 서버로 전송합니다 -->
        <input type="hidden" id="selectedItems" name="selectedItems" value="">
    </form>
</div> <!-- <div class="container text-center"> -->

<script>

	function cartDelete(cart_code) 
  	{
		if (confirm("장바구니에서 해당 상품을 삭제할까요?"))
		{
			location.href='/cart/delete?cart_code=' + cart_code;
		}
	} // function cartDelete(cart_code)  end
	
	function order() 
	{
		if (confirm("주문할까요?"))
		{
			location.href='/order/orderform'
		}
	} // function order() end

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
        max-width: 100px; /* 이미지 크기 설정 */
        max-height: 150px; /* 이미지 높이 설정 */
    }
    /*.cart-table img {
        max-width: 100px;
    }*/
    .btn-area {
        margin-top: 20px;
    }
    
    
</style>

<!-- 본문 끝 -->
<%@ include file="../footer.jsp"%>
