<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- S_productlist.jsp -->

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
			<h3 class="productlist text-center"> [판타지 / 과학소설 소 설] </h3>
			<p>
				<button type="button" class="btn btn-newproduct" onclick="location.href='${pageContext.request.contextPath}/product/productlist'"> 전체 상품 목록 </button>
				<button type="button" class="btn btn-newproduct" onclick="location.href='productwrite'"> 상품 등록 </button>
			</p>
			</div>
  		</div> <!-- row end -->
	  
	  	<div class="row">
		<c:forEach items="${list}" var="row" varStatus="vs">
			<div class="col-sm-4 col-md-4">
				<a href="productdetail/${row.book_number}">
					<img src="/storage/images/${row.img}" class="img-responsive margin" style="width:100px">
				</a>
				<br>
				상품명 :
				<a href="productdetail/${row.book_number}"> ${row.book_title} </a>
	
				<br>
				상품가격 : <fmt:formatNumber value="${row.original_price}" pattern="#,###" /> 원 → 
						<fmt:formatNumber value="${row.sale_price}" pattern="#,###" /> 원
				
				<!-- 한줄에 3칸씩 -->
				<c:if test="${vs.count mod 3 == 0}">
				</div><!-- row end -->
					<div style="height: 50px;"> </div>
	  				<div class="row">
				</c:if>
				
			</div>
		</c:forEach>
	  </div><!-- row end --> 	
  	
	</div> <!-- <div class="main-content"> end -->
<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->
	
<%@ include file="../footer.jsp"%>