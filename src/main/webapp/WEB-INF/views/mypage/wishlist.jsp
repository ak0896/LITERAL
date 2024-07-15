<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- wishlisst.jsp -->
	
<!--사이드 메뉴 시작  -->
<div class="contents_inner">
	<div class="sidebar">
		<h2>마이페이지</h2>
		<ul>
            <li><a href="${pageContext.request.contextPath}/member/editMember?email=${sessionScope.member.email}" class="button">회원정보수정/삭제</a></li>
            <li><a href="#">나의서점</a></li>
            <li><a href="#">리뷰</a></li>
            <li><a href="${pageContext.request.contextPath}/mypage/inquiry_list?email=${sessionScope.member.email}">1:1문의</a></li>
		</ul>
	</div> <!-- <div class="sidebar"> end -->
	<!--사이드 메뉴 끝  -->
	
	<div class="eventlist-main-content">
	<h3> MY 서점 </h3>

	<table>
		<thead>
			<tr>
				<th> 위시 번호 </th>
				<th> 책 번호 </th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${adlist}" var="row">
			<input type="hidden" id="book_number" value="${member.email}">
				<c:if test="${row.email != null}">
					<tr>
					    <td>
							<a href="${pageContext.request.contextPath}/product/productdetail/${row.book_number}">
								${row.book_number}
					    	</a>
					    </td>
						<td>${event.event_title}</td>
						<td>${event.start_date}</td>
						<td>${event.end_date}</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	</div> <!-- class="eventlist-main-content" end -->
	
	
	<!-- 본문 시작 -->

<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->

<%@ include file="../footer.jsp"%>