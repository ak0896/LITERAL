<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- editMember.jsp -->
<!--사이드 메뉴 시작  -->
<div class="contents_inner">
	<div class="sidebar">
		<h2>마이페이지</h2>
		<ul>
            <li><a href="${pageContext.request.contextPath}/member/editMember?email=${sessionScope.member.email}" class="button">회원정보수정/삭제</a></li>
            <li><a href="#">나의서점</a></li>
            <li><a href="${pageContext.request.contextPath}/mypage/inquiry_list?email=${sessionScope.member.email}">1:1문의</a></li>
		</ul>
	</div> 
	<!--사이드 메뉴 끝  -->

	<!-- 본문 시작 -->
	<div class="main-content">

		<div class="member-form-wrapper">
			<h3>회원 정보 수정</h3>
			<form name="memberForm" id="memberForm" method="post"
				action="${pageContext.request.contextPath}/member/updateMember"
				onsubmit="return combinedFunction()">
				<input type="hidden" name="email" value="${member.email}" />
				<table class="table">
					<tr>
						<td>이름</td>
						<td><input type="text" name="name" id="name" size="20"
							maxlength="10" value="${member.name}" required
							oninput="validateName()"> <span id="nameMessage"
							style="color: red;"></span></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="password" id="password"
							size="20" maxlength="20" value="${member.password}" required
							oninput="validatePW()"> <span id="passwordMessage"
							style="color: red;"></span></td>
					</tr>
					<tr>
						<td>비밀번호 확인</td>
						<td><input type="password" name="repassword" id="repassword"
							size="20" maxlength="20" required oninput="validatePW()">
							<span id="passwordConfirmMessage" style="color: red;"></span></td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td><input type="text" name="phone_number" id="phone_number"
							size="13" maxlength="13" value="${member.phone_number}" required
							oninput="formatPhoneNumber(this)"></td>
					</tr>
					<tr>
						<td>우편번호</td>
						<td><input type="text" name="zipcode" id="zipcode" size="5"
							value="${member.zipcode}" readonly required> <input
							type="button" value="주소찾기" onclick="DaumPostcode()"
							class="small-button"></td>
					</tr>
					<tr>
						<td colspan="2">
							<div id="wrap"></div>
						</td>
					</tr>
					<tr>
						<td>주소</td>
						<td><input type="text" name="address1" id="address1"
							size="45" value="${member.address1}" readonly required></td>
					</tr>
					<tr>
						<td>상세주소</td>
						<td><input type="text" name="address2" id="address2"
							size="45" value="${member.address2}" required></td>
					</tr>
					<tr>
						<td>생년월일</td>
						<td><input type="date" name="birth_date" id="birth_date"
							value="${member.birth_date}" required></td>
					</tr>
					<tr>
						<td>은행</td>
						<td><select name="bank" id="bank" required>
								<option value="신한"
									<c:if test="${member.bank == '신한'}">selected</c:if>>신한</option>
								<option value="국민"
									<c:if test="${member.bank == '국민'}">selected</c:if>>국민</option>
								<option value="농협"
									<c:if test="${member.bank == '농협'}">selected</c:if>>농협</option>
								<option value="우리"
									<c:if test="${member.bank == '우리'}">selected</c:if>>우리</option>
								<option value="케이뱅크"
									<c:if test="${member.bank == '케이뱅크'}">selected</c:if>>케이뱅크</option>
								<option value="카카오뱅크"
									<c:if test="${member.bank == '카카오뱅크'}">selected</c:if>>카카오뱅크</option>
								<option value="토스뱅크"
									<c:if test="${member.bank == '토스뱅크'}">selected</c:if>>토스뱅크</option>
								<option value="기업"
									<c:if test="${member.bank == '기업'}">selected</c:if>>기업</option>
								<option value="우체국"
									<c:if test="${member.bank == '우체국'}">selected</c:if>>우체국</option>
						</select></td>
					</tr>
					<tr>
						<td>계좌번호</td>
						<td><input type="text" name="account_number"
							id="account_number" size="30" maxlength="30"
							value="${member.account_number}" required></td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="button-wrapper">
								<input type="submit" value="수정"> <input type="button"
									value="취소"
									onclick="location.href='${pageContext.request.contextPath}/mypage_main'">
							</div>
						</td>
					</tr>
				</table>
			</form>

			<!-- 회원 탈퇴 링크 -->
			<div class="button-wrapper">
				<a href="#" class="red-text" onclick="confirmDelete()">탈퇴하기</a>
			</div>

		</div> <!-- <div class="member-form-wrapper"> end -->

		<!-- ----- DAUM 우편번호 API 시작 ----- -->
		<script
			src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        element_wrap.style.display = 'none';
    }//foldDaumPostcode() end

    function DaumPostcode() {
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = '';
                var extraAddr = '';

                if (data.userSelectedType === 'R') {
                    addr = data.roadAddress;
                } else {
                    addr = data.jibunAddress;
                }

                if(data.userSelectedType === 'R'){
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    document.getElementById("address2").value = extraAddr;
                } else {
                    document.getElementById("address2").value = '';
                }

                document.getElementById('zipcode').value = data.zonecode;
                document.getElementById("address1").value = addr;
                document.getElementById("address2").focus();

                element_wrap.style.display = 'none';
                document.body.scrollTop = currentScroll;
            },
            onresize: function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width: '100%',
            height: '100%'
        }).embed(element_wrap);

        element_wrap.style.display = 'block';
    }//DaumPostcode() end

 	// 우편번호 입력 필드에 커서를 가져다 놓았을 때 자동으로 Daum Postcode 함수 호출
    document.getElementById('zipcode').addEventListener('focus', DaumPostcode);
    
<!-- ----- DAUM 우편번호 API 종료----- -->
   
		//애경 추가 (7/5)
		//전화번호 포맷팅 함수
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
		 }//formatPhoneNumber() end

   
		 //수정과 동시에 유효성검사
		 function combinedFunction() {
			    return confirm('수정하시겠습니까?') && validateForm();
		}//combinedFunction
		 
		 
	    
		// 유효성 검사 함수
		 function validateName() {
		     var name = document.getElementById("name").value;
		     var nameMessage = document.getElementById("nameMessage");
		     if (name.length < 2) {
		         nameMessage.innerText = "이름은 2글자 이상 입력해주세요.";
		         nameMessage.style.color = "red";
		         return false;
		     } else {
		         nameMessage.innerText = "사용 가능한 이름입니다.";
		         nameMessage.style.color = "green";
		     }
		     return true;
		 }//validateName() end



		 function validatePW() {
		     var password = document.getElementById("password").value;
		     var repassword = document.getElementById("repassword").value;
		     var passwordMessage = document.getElementById("passwordMessage");
		     var passwordConfirmMessage = document.getElementById("passwordConfirmMessage");
		     var passwordRegExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;

		     if (!passwordRegExp.test(password)) {
		         passwordMessage.innerText = "숫자+영문자+특수문자 조합으로 8자리 이상 입력해주세요.";
		         passwordMessage.style.color = "red";
		         return false;
		     } else {
		         passwordMessage.innerText = "안전한 비밀번호입니다.";
		         passwordMessage.style.color = "green";
		     }

		     if (password !== repassword) {
		         passwordConfirmMessage.innerText = "비밀번호가 일치하지 않습니다.";
		         passwordConfirmMessage.style.color = "red";
		         return false;
		     } else {
		         passwordConfirmMessage.innerText = "비밀번호가 일치합니다.";
		         passwordConfirmMessage.style.color = "green";
		     }

		     return true;
		 }//validatePW() end


		 function validateForm() {
		     var isNameValid = validateName();
		     var isPasswordValid = validatePW();

		     return isNameValid && isPasswordValid;
		 }//validateForm() end

		
		
		// 탈퇴확인문구
		function confirmDelete() {
        if (confirm('정말 탈퇴하시겠습니까?')) {
            document.getElementById('deleteMemberForm').submit();
        	}
   		}//confirmDelete() end	
   		
   		
</script>

	<form id="deleteMemberForm"
		action="${pageContext.request.contextPath}/member/deleteMember"
		method="post">
		<input type="hidden" name="email" value="${member.email}">
	</form>

	</div> <!-- <div class="main-content"> end -->


<style> /* 탈퇴하기 css */
	.red-text {
		color: red;
		text-decoration: none;
		font-weight: bold; /* 기본 글씨를 굵게 */
		font-size: 1em; /* 기본 글씨 크기 설정 */
	}
	
	.red-text:hover {
		text-decoration: underline;
		font-size: 1.2em; /* hover 시 글씨 크기 증가 */
	}
</style>


<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner">  -->

<%@ include file="../footer.jsp"%>