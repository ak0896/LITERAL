<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../header.jsp"%>

<!-- findID.jsp -->
<!-- 본문 시작 -->

<div class="center-div">
    <div class="find-id-form-wrapper">
        <h3>이메일 찾기</h3>
        
        <form name="findIDfrm" id="findIDfrm" method="post" action="${pageContext.request.contextPath}/member/findIDProc">
            <table class="table" style="width: 100%; margin: 0 auto;">
                <tr>
                    <td colspan="2">
                        <input type="text" name="name" id="name" placeholder="이름" maxlength="50" required>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="text" name="phone_number" id="phone_number" placeholder="전화번호" maxlength="13" required oninput="formatPhoneNumber(this)">
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="button-wrapper">
                        <input type="submit" value="이메일 찾기">
                        <input type="button" value="비밀번호 찾기" onclick="location.href='${pageContext.request.contextPath}/member/findPW'">
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
    </div> <!-- <div class="find-id-form-wrapper"> end -->
</div><!-- <div class="center-div"> end -->

<script>
// 전화번호 포맷팅 함수
 function formatPhoneNumber(input) {
        var value = input.value.replace(/[^0-9]/g, '');

        // 전화번호가 10자리 또는 11자리인 경우만 포맷 적용
        if (value.length === 10) {
            input.value = value.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
        } else if (value.length === 11) {
            input.value = value.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
        } else {
            input.value = value; // 포맷에 맞지 않는 경우 포맷 적용하지 않음
        }
    }
 </script>

<!-- 본문 끝 -->
<%@ include file="../footer.jsp"%>
