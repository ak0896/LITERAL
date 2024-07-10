<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- 본문 시작 -->

<div class="center-div">
	<div class="message-box">
	
		<c:choose>
	        <c:when test="${not empty message}">
			    <h3>환영합니다, ${foundMember.name}님!</h3>
				<p>본인인증정보와 일치하는 결과입니다.</p>
				<p>로그인 후 이용해 주세요.</p>
				<div class="account-info">
					<c:out value="${message}" escapeXml="false"/>
	        	</div>
	        </c:when>
	        <c:otherwise>
	        	<div class="account-info">
	            	<c:out value="${errorMessage}" escapeXml="false"/>
	            </div>
	        </c:otherwise>
    	</c:choose>
	
		<div class="button-wrapper">
			<a href="${pageContext.request.contextPath}/member/findID" class="button">이메일 찾기</a>
			<a href="${pageContext.request.contextPath}/member/findPW" class="button secondary">비밀번호 찾기</a>
		</div>
	</div> <!-- <div class="message-box"> end -->
</div><!-- <div class="center-div"> end -->

<!-- 본문 끝 -->

<%@ include file="../footer.jsp"%>
