<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../header.jsp"%>
<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js" charset="utf-8"></script>

<!-- loginForm.jsp -->
<!-- 본문 시작 -->

<div class="center-div">
	<div class="login-form-wrapper">
		<h3>로그인</h3>
		<form name="loginfrm" id="loginfrm" action="${pageContext.request.contextPath}/member/login" method="post">
			<table class="table" style="width: 100%; margin: 0 auto;">
				<tr>
					<td colspan="2"><input type="email" name="email" id="email" placeholder="이메일" maxlength="50" required></td><!-- required 속성으로 지정되어 있어서 빈칸이 나올경우 보여짐 -->
				</tr>
				<tr>
					<td colspan="2"><input type="password" name="password" id="passwd" placeholder="비밀번호" maxlength="50" required></td>
				</tr>
				<tr>
					<td colspan="2"><label> <input type="checkbox" name="c_email" value="SAVE"> 이메일 저장
					</label></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="로그인"></td>
				</tr>
			</table>
			
			<div class="login-links">
				<a href="${pageContext.request.contextPath}/member/agreement">[회원가입]</a>
				<a href="${pageContext.request.contextPath}/member/findID">[이메일/비밀번호찾기]</a>
			</div>
			
			
			<!-- 0721 애경 수정 시작 -->
			<div class="col-lg-12 text-center mt-3">
			    <a class="kakao" href="https://kauth.kakao.com/oauth/authorize?client_id=8f9dec329968d9694db0f7ef13e6d56b&redirect_uri=http://localhost:8080/member/kakaoLogin&response_type=code">
			        <img src="${pageContext.request.contextPath}/images/kakao_login_medium_wide.png" alt="카카오로그인" style="cursor:pointer;">
			    </a>
			</div>
			<!-- 0721 애경 수정 끝 -->
			
			
		</form>
		<!-- 에러 메시지를 출력할 영역 -->
		<c:if test="${not empty errorMessage}">
            <div class="alert alert-danger"><c:out value="${errorMessage}" escapeXml="false"/></div>
        </c:if>
	</div> <!-- <div class="login-form-wrapper"> end -->
</div> <!-- <div class="center-div"> end -->

<script>
	// DOMContentLoaded 이벤트는 HTML 문서의 초기 구문 분석이 완료되었을 때 발생합니다.
	document.addEventListener("DOMContentLoaded", function() {
		// 쿠키 값을 읽어오는 함수
		function getCookie(name) {
			let cookieValue = ""; // 쿠키 값을 저장할 변수 초기화
			// document.cookie가 존재하면 세미콜론으로 구분된 쿠키 문자열을 배열로 변환
			let cookies = document.cookie ? document.cookie.split(';') : [];
			// 쿠키 배열을 순회하면서
			for (let i = 0; i < cookies.length; i++) {
				// 각 쿠키 문자열의 앞뒤 공백을 제거
				let cookie = cookies[i].trim();
				// 쿠키 이름이 일치하는지 확인
				if (cookie.substring(0, name.length + 1) === (name + '=')) {
					// 쿠키 값을 디코딩하여 cookieValue에 저장
					cookieValue = decodeURIComponent(cookie
							.substring(name.length + 1));
					break; // 일치하는 쿠키를 찾으면 반복 종료
				}
			}
			return cookieValue; // 쿠키 값을 반환
		}

		// 쿠키에서 'c_email' 값을 읽어서 이메일 입력란에 설정
		const emailInput = document.getElementById('email'); // 이메일 입력란 요소 가져오기
		const c_email = getCookie('c_email'); // 'c_email' 쿠키 값 가져오기
		if (c_email) {
			emailInput.value = c_email; // 'c_email' 쿠키 값이 있으면 이메일 입력란에 설정
			document.querySelector('input[name="c_email"]').checked = true; // '이메일 저장' 체크박스를 체크 상태로 설정
		}
	});
	
</script>

<!-- 본문 끝 -->
<%@ include file="../footer.jsp"%>
