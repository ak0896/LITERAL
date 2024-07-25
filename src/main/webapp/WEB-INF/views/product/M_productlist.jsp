<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- M_productlist.jsp -->

<!--사이드 메뉴 시작  -->
<div class="contents_inner">
    <div class="sidebar">
        <h2> 국내도서 </h2>
        <ul>
            <li><a href="G_productlist">고전소설</a></li>
            <li><a href="M_productlist">공포/미스테리소설</a></li>
            <li><a href="H_productlist">역사소설</a></li>
            <li><a href="S_productlist">판타지/과학소설</a></li>
            <li><a href="R_productlist">로맨스소설</a></li>
            <li><a href="P_productlist">무협소설</a></li>
            <li><a href="T_productlist">청소년소설</a></li>
            <li><a href="W_productlist">웹/드라마/영화소설</a></li>
        </ul>
    </div> <!-- <div class="sidebar"> end -->
 <!--사이드 메뉴 끝  -->
 <!-- 본문 시작 -->
	<div class="main-content">
		<div class="row">
			<div class="col-sm-12">
			<p>
				<button type="button" class="btn btn-newproduct" onclick="location.href='${pageContext.request.contextPath}/product/productlist'"> 전체 상품 목록 </button>
			</p>
			</div>
  		</div> <!-- row end -->
	  
	  	<!-- 상품 -->
	  	<div class="product-area">
	    	<c:forEach items="${list}" var="row" varStatus="vs">
		        <c:choose>
		            <c:when test="${row.availability eq 0}">
		                <div class="product-box">
		                    <div class="img-area">
		                        <a href="productdetail/${row.book_number}">
		                            <img src="/storage/images/${row.img}" alt="상품 이미지">
		                        </a>
		                    </div>
		                    <div class="product-info">
		                        <p>상품명: <a href="productdetail/${row.book_number}">${row.book_title}</a></p>
		                        <p class="price">
								    <span class="sale-price"><fmt:formatNumber value="${row.sale_price}" pattern="#,###"/> 원</span>
								    <span class="original-price"><fmt:formatNumber value="${row.original_price}" pattern="#,###"/> 원</span>
								</p>
		                        <p class="views">조회수: ${row.book_view}</p>
		                    </div>
		                </div>
		            </c:when>
		            <c:when test="${row.availability eq 0}">
		                <div class="product-box">
		                    <div class="img-area">
		                        <a href="productdetail/${row.book_number}">
		                            <img src="/storage/images/${row.img}" alt="상품 이미지">
		                        </a>
		                    </div>
		                    <div class="product-info">
		                        <p>상품명: <a href="productdetail/${row.book_number}">${row.book_title}</a></p>
		                        <p class="price">
								    <span class="sale-price"><fmt:formatNumber value="${row.sale_price}" pattern="#,###"/> 원</span>
								    <span class="original-price"><fmt:formatNumber value="${row.original_price}" pattern="#,###"/> 원</span>
								</p>
		                        <p class="views">조회수: ${row.book_view}</p>
		                        <p class="solo-out">sold_out</p>
		                    </div>
		                </div>
		            </c:when>
		            <c:otherwise>
		                <!-- availability가 2일 경우 아무것도 표시하지 않음 -->
		            </c:otherwise>
		        </c:choose>
	    	</c:forEach>
		</div>	
  	
	</div> <!-- <div class="main-content"> end -->
<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->
	
<%@ include file="../footer.jsp"%>