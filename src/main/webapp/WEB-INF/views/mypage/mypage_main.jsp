<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- mypage_main.jsp -->
	
<!--사이드 메뉴 시작  -->
<div class="contents_inner">
	<div class="sidebar">
		<h2>마이페이지</h2>
		<ul>
            <li><a href="${pageContext.request.contextPath}/member/editMember?email=${sessionScope.member.email}" class="button">회원정보수정/삭제</a></li>
            <li><a href="${pageContext.request.contextPath}/mypage/wishlist?email=${sessionScope.member.email}">나의서점</a></li>
            <li><a href="#">리뷰</a></li>
            <li><a href="${pageContext.request.contextPath}/mypage/inquiry_list?email=${sessionScope.member.email}">1:1문의</a></li>
		</ul>
	</div> <!-- <div class="sidebar"> end -->
	<!--사이드 메뉴 끝  -->

	<!-- 본문 시작 -->
	<div class="main-content">
		<div class="content">
			<div class="header">
				<h1>주문배송조회</h1>
				<div class="order-status"></div>
			</div>
			<div class="section">
				<div class="section-title">나의 서점 관리</div>
				<p>관심있는 책을 등록해 주세요</p>
			</div>
		</div> <!-- <div class="content"> end -->
	</div> <!-- <div class="main-content"> end -->
	
<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->

<%@ include file="../footer.jsp"%>