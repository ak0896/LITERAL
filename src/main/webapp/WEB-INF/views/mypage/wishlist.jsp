<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<div class="contents_inner">
	<div class="sidebar">
	<input type="hidden" name="email" value="${sessionScope.member.email}">
		<h2>마이페이지</h2>
		<ul>
            <li><a href="${pageContext.request.contextPath}/member/editMember?email=${sessionScope.member.email}" class="button">회원정보수정/삭제</a></li>
            <li><a href="${pageContext.request.contextPath}/mypage/wishlist?email=${sessionScope.member.email}">나의서점</a></li>
            <li><a href="${pageContext.request.contextPath}/mypage/inquiry_list?email=${sessionScope.member.email}">1:1문의</a></li>
		</ul>
	</div>
	
	<div class="eventlist-main-content">
	<input type="hidden" name="email" value="${sessionScope.member.email}">
	<h3> MY 서점 </h3>
	<table>
		<thead>
			<tr>
                <th>이미지</th>
                <th>책 제목</th>
                <th>가격</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${wishlist}" var="row">
				<tr>
						<td id="img_${row.img}" name="img_${row.img}">
                        <a href="${pageContext.request.contextPath}/product/productdetail/${row.book_number}">
                            <img src="${pageContext.request.contextPath}/storage/images/${row.img}" alt="${item.book_title}" style="width: 100px; height: auto;">
                        </a>
                        </td>
                        <td id="book_title_${row.book_number}" name="booktitle_${row.book_number}">${row.book_title}</td>
                        <td id="sale_price_${row.sale_price}" name="sale_price_${row.sale_price}"><fmt:formatNumber value="${row.sale_price}" pattern="#,###"/>원</td>
						 <td>
                                <form action="wishlist_delete" method="post" style="display:inline;">
                                    <input type="hidden" name="email" value="${sessionScope.member.email}">
                                    <input type="hidden" name="wishlist_code" value="${row.wishlist_code}">
                                    <button type="submit" class="btn btn-newproduct btn-info">삭제</button>
                                </form>
                            </td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	</div>
</div>


			                
<%@ include file="../footer.jsp"%>
