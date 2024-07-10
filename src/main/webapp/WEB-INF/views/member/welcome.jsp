<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<!-- welcome.jsp -->
<!-- 본문 시작 -->

<div class="center-div">
    <div class="welcome-wrapper">
        <h3>환영합니다, ${member.name}님!</h3>
        <p>회원가입이 성공적으로 완료되었습니다. 이제 다양한 서비스를 이용하실 수 있습니다.</p>
        <div class="user-info">
            <h4>사용자 정보</h4>
            <p><strong>이메일:</strong> ${member.email}</p>
            <p><strong>전화번호:</strong> ${member.phone_number}</p>
            <p><strong>주소:</strong> ${member.address1} ${member.address2}</p>
            <p><strong>생년월일:</strong> ${member.birth_date}</p>
        </div>
        <div class="button-wrapper">
            <input type="button" value="로그인" onclick="location.href='${pageContext.request.contextPath}/member/login'">
            <input type="button" value="메인페이지" onclick="location.href='${pageContext.request.contextPath}/'">
        </div>
    </div>
</div><!-- <div class="center-div"> end -->

<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>
