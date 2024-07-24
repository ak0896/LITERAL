<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
 
 <!-- productdetail.jsp -->

<!--사이드 메뉴 시작  -->
<div class="contents_inner">
    <div class="sidebar">
        <h2> 국내도서 </h2>
        <ul>
            <li><a href="${pageContext.request.contextPath}/product/G_productlist">고전소설</a></li>
            <li><a href="${pageContext.request.contextPath}/product/M_productlist">공포/미스테리소설</a></li>
            <li><a href="${pageContext.request.contextPath}/product/H_productlist">역사소설</a></li>
            <li><a href="${pageContext.request.contextPath}/product/S_productlist">판타지/과학소설</a></li>
            <li><a href="${pageContext.request.contextPath}/product/R_productlist">로맨스소설</a></li>
            <li><a href="${pageContext.request.contextPath}/product/P_productlist">무협소설</a></li>
            <li><a href="${pageContext.request.contextPath}/product/T_productlist">청소년소설</a></li>
            <li><a href="${pageContext.request.contextPath}/product/W_productlist">웹/드라마/영화소설</a></li>
        </ul>
    </div> <!-- <div class="sidebar"> end -->
 <!--사이드 메뉴 끝  -->
 
 <!-- 본문 시작 -->	
	<div class="main-content">  		
		<div class="row">
			<div class="col-sm-12">
			<h3 class="productlist text-center"> [상 품] </h3>
			</div> <!-- class="col-sm-12" end -->
			
        <div class="pro-container">
            <div class="content-inner">
                <div class="book-img">
                	<div class="book-img-info">
						<c:if test="${product.img != '-'}">
							<img src="/storage/images/${product.img}" width="100px">
						</c:if>     
					</div>           
                </div> <!-- <div class="pro-book-img"> end -->
                			
				<div class="book-detail">
		            <div class="book-info">
		                <h2 class="book-title"> ${product.book_title} </h2>
		                <p class="book-info-item">
		                    <span class="author"> "${product.author}" </span>
		                    <span> 저자 </span>
		                </p>
		                <p class="book-info-item">
		                    <span> 등록일 : ${product.registration_date} </span>
		                </p>
		                <div class="price-area">
		                    <c:choose>
		                        <c:when test="${product.availability eq 0}">
		                            <p>
		                                <span class="discount"> <fmt:formatNumber value="${product.original_price}" pattern="#,###" /> 원 </span>
		                                →
		                                <span class="price"> <fmt:formatNumber value="${product.sale_price}" pattern="#,###" /> 원 </span>
		                            </p>
		                        </c:when>
		                        <c:when test="${product.availability eq 1}">
		                            <p style="color: red;">sold_out</p>
		                        </c:when>
		                        <c:otherwise>
		                            <!-- availability가 2일 경우 아무것도 표시하지 않음 -->
		                        </c:otherwise>
		                    </c:choose>
		                </div>
		                <div>
			                <p class="book-info-item">
			                	<span> 출판사 </span>
			                    <span> ${product.press} </span>
			                </p>
			                <p class="book-info-item">
			                	<span> 출판일 </span>
			                    <span> ${product.publishing_date} </span>
			                </p>
			                <p class="book-info-item">
			                	<span> 판매자 책 소개 </span>
			                    <span> ${product.intro_book} </span>
			                </p>	
		                </div>	                		                
		                <div>
		                <c:if test="${sessionScope.member != null && sessionScope.member.type_code == 0}">
		                
			                <!-- 테스트 -->
			                <hr>
			                <p class="book-info-item">
			                    <span> 장르 : ${product.genre_code} </span>
			                </p>		                
			                
			                <p class="book-info-item">
			                    <span> book_code : ${product.book_code} </span>
			                </p>
			                
			                <p class="book-info-item">
			                    <span> book_number : ${product.book_number} </span>
			                </p>
			                
			                <p class="book-info-item">
			                    <span> grade_code : ${product.grade_code} </span>
			                </p>
			                
			                <p class="book-info-item">
			                    <span> 작성자 : ${product.email} </span>
			                </p>
			                
			                <p class="book-info-item">
			                    <span> 판매여부 : ${product.availability} </span>
			                </p>
			                		               
			                <p class="book-info-item">
			                    <span> 지점코드 : ${product.branch_code} </span>
			                </p>
			                		                
			           		</c:if>
		            	</div>
		            <div>
		                <p> 등록된 책 
       						<a href="${pageContext.request.contextPath}/product/productlist?book_code=${product.book_code}"> 더보기 </a>    
		                </p>
		                <form name="actionForm" id="actionForm" action="${pageContext.request.contextPath}/cart/insert" method="post" enctype="multipart/form-data">
		                <input type="hidden" name="book_number" value="${product.book_number}">
		                <input type="hidden" name="availability" value="${product.availability}">
		                
                       <input type="hidden" name="book_title" value="${product.book_title}">
                       <input type="hidden" name="sale_price" value="${product.sale_price}">
                       <input type="hidden" name="original_price" value="${product.original_price}">
                       <input type="hidden" name="img" value="${product.img}">
                                   
		                
			                <table class="price-box-tb table">
			                    <tbody>
								<c:forEach var="row" items="${productList}">
								<tr>
									<td>
										<a href="${pageContext.request.contextPath}/product/productdetail/${row.book_number}">
											<img src="${pageContext.request.contextPath}/storage/images/${row.img}" width="50px">		                            
										</a> 
									</td>
		                            <td>
			                            <p> ${row.book_title} </p>
			                            <p> <fmt:formatNumber value="${row.original_price}" pattern="#,###" /> 원 → <fmt:formatNumber value="${row.sale_price}" pattern="#,###" /> 원 </p>
							    	</td>
							    </tr>

							    </c:forEach>
								<tr>
									<td colspan="4" align="center">
										<button type="button" class="btn btn-newproduct" onclick="location.href='${pageContext.request.contextPath}/product/productlist'"> 상품 목록 </button>
										<button type="submit" class="btn btn-newproduct btn-info"> 장바구니 </button>
									</td>
							    </tr> 	                    
			                    </tbody>
			                </table>
		                </form> <!-- actionForm end -->
		            </div> <!-- div end -->
				</div> <!-- class="book-detail" end -->		
			</div> <!-- class="content-inner" end -->
  		</div> <!-- class="pro-container" end -->
	</div> <!-- class="row" end -->
</div> <!-- div class="main-content" end -->


<!--modal 추가 7/5 윤지 -->
<!-- modal -->
	<div class="modal-wrap">
	     <div class="modal-container">
	         <div class="dialog-content">
	             <p class="alert-txt">
	                 상품이 장바구니에 담겼습니다.
	             </p>
	             <p class="alert-txt-s">
	                 장바구니로 이동하시겠습니까?
	             </p>
	         </div>
	         <div class="dialog-footer">
	             <button class="btn btn-g">
	                     <span class="txt">취소</span>
	             </button>
	             <button class="btn btn-b">
	                 <span class="txt">확인</span>
	             </button>
	         </div>
	     </div>
	   
	</div>
<!-- modal 끝 --> 
	
<script>
	/* 댓글 */
	function product_update() {
  		//document.productfrm은 본문의 <form name=productfrm>을 가리킴
  		document.productfrm.action="/product/update";
  		document.productfrm.submit();
  	}//product_update() end

  	function product_delete() {
  		if(confirm("첨부된 파일은 영구히 삭제됩니다\n진행할까요?")){
			document.productfrm.action="/product/delete";
			document.productfrm.submit();
		}//if end
  	}//product_delete() end  	
  	
	/* 모달 */
	const modal = document.querySelector('.modal-wrap');
	const modalOpen = document.querySelector('.btn-info');
    const modalClose = document.querySelector('.btn-g');
    const modalConfirm = document.querySelector('.btn-b');
    const actionForm = document.getElementById('actionForm');
	
	// 열기 버튼을 눌렀을 때 모달팝업이 열림
    modalOpen.addEventListener('click', function(event) {
        event.preventDefault(); // 페이지 리로드 방지
        modal.classList.add('on');
    });
	
	// 닫기 버튼을 눌렀을 때 모달팝업이 닫힘
	modalClose.addEventListener('click', function() {
	    modal.classList.remove('on');
	});
	
    // 확인 버튼을 눌렀을 때 폼 제출 및 장바구니로 이동
    modalConfirm.addEventListener('click', function() {
        actionForm.submit();
   });
</script>

<style>
	.container {
	    background-color: #fff;
	    border-radius: 8px;
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	    overflow: hidden;
	    width: 80%;
	    max-width: 1200px;
	    height: 100vh;
	}
	
	.content-inner {
	    display: flex;
	    padding: 20px;
	}
	
	.book-img {
	    flex: 1;
	    padding-right: 20px;
	}
	
	.book-img-info{
		 width: 300px;
	}
	
	.book-img img {
	    width: 100%;
	    height: auto;
	    border-radius: 8px;
	}
	
	.book-detail {
	    flex: 2;
	    padding-left:20px;
	    position:relative;
	}
	
	.book-info {
	    margin-bottom: 20px;
	
	}
	
	.book-title {
	    font-size: 2em;
	    margin-bottom: 10px;
	    color: #333;
	}
	
	.book-info-item {
	    margin-bottom: 10px;
	}
	
	.author {
	    font-weight: bold;
	    color: #555;
	}
	
	.price {
	    font-size: 1.5em;
	    color: #e74c3c;
	    margin-right: 10px;
	}
	
	.discount {
	    text-decoration: line-through;
	    color: #888;
	}
	
	.price-area{
	    margin-top:20px;
	}
	
	.price-box p{
	    margin-bottom:20px;
	}
	
	.price-box-tb{
	    margin-top:50px;
	    margin-bottom:20px;
	    text-align:center;
	}
	
	.button-area{
	    position:absolute;
	    bottom:0;
	    left: 50%;
	    transform: translate(-50%);
	}
	
	.button-area input[type="button"]{
	    height:50px;
	}
	
	p {
	    margin: 0;
	    color: #333;
	}
	
	p + p {
	    margin-top: 10px;
	}
	
	@media (max-width: 768px) {
	    .content-inner {
	        flex-direction: column;
	    }
	
	    .book-img {
	        padding-right: 0;
	        margin-bottom: 20px;
	    }
	}
	
	/* 모달 추가 */
	.modal-wrap {
	/*팝업 배경*/
		display: none; /*평소에는 보이지 않도록*/
	    position: fixed;
	    top:0;
	    left: 0;
	    width: 100%;
	    height: 100vh;
	    overflow: hidden;
	    background: rgba(0,0,0,0.5);
	}
	
	.modal-wrap.on {
	     display: block;
	 }
	
	.modal-wrap .modal-container {
	/*팝업*/
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    padding: 0 37px 30px;
	    background: #ffffff;
	    border-radius: 20px;
	    width:360px;
	    text-align: center;
	}
	
	.modal-wrap .modal-container .dialog-content{
	    margin-top:40px;
	}
	
	.modal-wrap .modal-container .dialog-content .alert-txt{
	    font-size: 15px;
	    line-height: 23px;
	    letter-spacing: -0.01em;
	    font-weight: 500;
	}
	
	.modal-wrap .modal-container .dialog-content .alert-txt-s{
	    margin-top: 6px;
	    font-size: 14px;
	    line-height: 22px;
	    letter-spacing: -0.01em;
	    color: #595959;
	}
	
	.modal-wrap .modal-container .dialog-footer{
	    margin-top: 34px;
	}
	
	
	.modal-wrap .modal-container .btn_g {
	    display: block;
	    padding: 10px 20px;
	    background-color: rgb(116, 0, 0);
	    border: none;
	    border-radius: 5px;
	    color: #fff;
	    cursor: pointer;
	    transition: box-shadow 0.2s;
	}
	
	button.btn{
	    min-width: 140px;
	    height: 44px;
	    padding: 0 23px 1px;
	    border-radius: 6px;
	    font-weight: 700;
	    font-size: 15px;
	    line-height: 23px;
	    margin:0;
	}
	
	button.btn-g {
	    color: #fff;
	    background: #767676;
	    border: 1px solid #767676;
	    transition: background-color 0.2s ease-out, border-color 0.2s ease-out;
	  
	}
	
	button.btn-g:hover{
	    background-color:#595959;
	    color:#fff;
	}
	
	button.btn-b{
	    color: #fff;
	    background: #5055b1;
	    border: 1px solid #5055b1;
	    transition: background-color 0.2s ease-out, border-color 0.2s ease-out;
	    margin-left:6px;
	    margin:0;
	}
	
	button.btn-b:hover{
	    background-color:#2c307b;
	    color:#fff;
	}
		
</style>
	
<!-- 본문 끝 -->
</div> <!-- class="contents_inner" end -->

<%@ include file="../footer.jsp"%>