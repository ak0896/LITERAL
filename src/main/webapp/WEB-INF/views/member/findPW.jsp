<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../header.jsp"%>

<!-- findPW.jsp -->
<!-- 본문 시작 -->

<div class="center-div">
    <div class="find-id-form-wrapper">
        <h3>비밀번호 찾기</h3>
        <form name="finIDWfrm" id="findIDfrm" method="post" action="${pageContext.request.contextPath}/member/findPWProc">
            <table class="table" style="width: 100%; margin: 0 auto;">
                <tr>
                    <td colspan="2">
                        <input type="text" name="name" id="name" placeholder="이름" maxlength="50" required>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="email" name="email" id="email" placeholder="이메일" maxlength="50" required>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="button-wrapper">
                        <input type="submit" value="비밀번호 찾기">
                        <input type="button" value="이메일 찾기" onclick="location.href='${pageContext.request.contextPath}/member/findID'">
                    </td>
                </tr>
            </table>
            <div class="find-id-links">
                <a href="${pageContext.request.contextPath}/member/login">[로그인]</a>
                <a href="${pageContext.request.contextPath}/member/agreement">[회원가입]</a>
            </div>
        </form>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
    </div> <!-- div class="find-id-form-wrapper"> end -->
</div><!-- <div class="center-div"> end-->

<!-- 본문 끝 -->
<%@ include file="../footer.jsp"%>
