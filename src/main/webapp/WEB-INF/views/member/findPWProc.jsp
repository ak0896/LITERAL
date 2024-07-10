<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- 본문시작 -->

<div class="center-div">
	<div class="message-box">
		<h3>비밀번호 찾기 결과</h3>
		 <c:choose>
	        <c:when test="${not empty message}">
	            <c:out value="${message}" escapeXml="false"/>
	        </c:when>
	        <c:otherwise>
	            <c:out value="${errorMessage}" escapeXml="false"/>
	        </c:otherwise>
    	</c:choose>
		<div class="button-wrapper">
			<a href="${pageContext.request.contextPath}/member/login" class="button">로그인</a>
			<a href="${pageContext.request.contextPath}/member/findPW" class="button secondary">비밀번호 찾기</a>
		</div>
	</div> <!-- <div class="message-box"> end -->
</div><!-- <div class="center-div">  end-->


<!-- 본문 끝 -->
<%@ include file="../footer.jsp"%>
