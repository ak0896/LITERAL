<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- productlist.jsp -->

<!--사이드 메뉴 시작  -->
<div class="contents_inner">
 <!-- 본문 시작 -->
 	
	<div class="main-content">
		<div class="row">
			<h3 class="productlist text-center"> [나 의 서 점] </h3>
  		</div> <!-- row end -->
	  
	  	<div class="row">
		<form>
		<table>
			<form method="post" action="${pageContext.request.contextPath}/updateWishlist">
                <table>
                    <tr>
                        <th>찜 번호</th>
                        <th>이메일</th>
                        <th>책 번호</th>
                        <th>찜 여부</th>
                    </tr>
                    <c:forEach var="wishlist" items="${list}">
                        <tr>
                            <td>${wishlist.wish_number}</td>
                            <td>${wishlist.email}</td>
                            <td>${wishlist.book_number}</td>
                            <td>
                                <input type="checkbox" name="wish" value="true" <c:if test="${wishlist.wish}">checked</c:if> />
                                <input type="hidden" name="book_number" value="${wishlist.book_number}" />
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </form>			
		</table>
		</form>
		
	  </div><!-- row end -->
  	
	</div> <!-- <div class="main-content"> end -->

<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->
	
<%@ include file="../footer.jsp"%>