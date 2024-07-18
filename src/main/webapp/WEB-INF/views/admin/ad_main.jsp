<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>

<!-- ad_main.jsp -->

<!-- 본문 시작 -->
<div class="main-content">
	<div class="content">
		<div class="header">
			<a href="admin/memberList"><h1>회원정보 관리</h1></a>
			<a href="admin/productlist_admin"><h1>상품 관리</h1></a>
			<a href="admin/branchList"><h1>지점 관리</h1></a>
			<a href="${pageContext.request.contextPath}/notice/notice_list"><h1>공지사항 관리</h1></a>
			<a href="admin/ad_inquiry_list"><h1>1:1문의 관리</h1></a>
			<a href="admin/ad_reviewlist"><h1>리뷰 관리</h1></a>
			<a href="admin/aeventlist"><h1>이벤트 관리</h1></a>
		
			<div class="order-status"></div>
		</div>
	</div> <!-- <div class="content"> end -->
</div> <!-- <div class="main-content"> end -->
<!-- 본문 끝 -->

<%@ include file="../footer.jsp"%>