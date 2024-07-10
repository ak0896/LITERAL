<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- inquiry_list.jsp -->

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


<!-- 본문 시작 -->
	<div class="container">
	    <h1>자주 묻는 질문</h1>
	    <c:forEach var="inquiry" items="${inquiry_list}">
	        <div class="inquiry-item">
	        	<div class="inquiry-code">${inquiry.inquiry_code}</div>
	            <div class="inquiry-content">${inquiry.inquiry_content}</div>
	        </div>
	        <form name="inquiry_form_${inquiry.inquiry_code}" id="inquiry_form_${inquiry.inquiry_code}">
	        	<input type="hidden" name="email" value="${inquiry.email}">
	        </form>
	    </c:forEach>
	    <input type="button" value="1:1문의 등록" onclick="location.href='inquiry_write'">

	</div> <!-- <div class="container"> end -->
	
	<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
	
	<script>
	$(document).ready(function()
	{
	    $('.inquiry.code').click(function(){
	        $(this).next('.inquiry_content').slideToggle();
	    });
	});
	</script>

<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->
	

<%@ include file="../footer.jsp"%>