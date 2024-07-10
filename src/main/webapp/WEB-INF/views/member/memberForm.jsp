<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../header.jsp" %>    

<!-- memberForm.jsp -->
<!-- 본문 시작 -->

<div class="member-form-wrapper">
    <h3>회원가입</h3>
    <form name="memberForm" id="memberForm" method="post" action="${pageContext.request.contextPath}/member/register" onsubmit="return validateForm()">
		<input type="hidden" id="_check_email" value="" />
        <table class="table">
            <tr>
                <td>이름</td>
                <td>
	                <input type="text" name="name" id="name" size="20" maxlength="10" required oninput="validateName()">
	            	<span id="nameMessage" style="color:red;"></span>
            	</td>
            </tr>
            <tr>
                <td>이메일</td>
                <td>
                    <input type="email" name="email" id="email" size="30" maxlength="30" required onfocus="emailCheck()">
           		</td>
            </tr>
             <tr>
                <td>비밀번호</td>
                <td>
                	<input type="password" name="password" id="password" size="20" maxlength="20" required oninput="validatePW()">
            		<span id="passwordMessage" style="color:red;"></span>
            	</td>
            </tr>
            <tr>
                <td>비밀번호 확인</td>
                <td>
                	<input type="password" name="repassword" id="repassword" size="20" maxlength="20" required oninput="validatePW()">
                	<span id="passwordConfirmMessage" style="color:red;"></span>
                </td>
            </tr>
            <tr>
                <td>전화번호</td>
                <td>
                	<input type="text" name="phone_number" id="phone_number" size="13" maxlength="13" required oninput="formatPhoneNumber(this)">
                </td>
            </tr>
            <tr>
                <td>우편번호</td>
                <td>
                    <input type="text" name="zipcode" id="zipcode" size="5" readonly required>
                    <input type="button" value="주소찾기" onclick="DaumPostcode()" class="small-button">
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="wrap"></div>
                </td>
            </tr>
            <tr>
                <td>주소</td>
                <td><input type="text" name="address1" id="address1" size="45" readonly required></td>
            </tr>
            <tr>
                <td>상세주소</td>
                <td><input type="text" name="address2" id="address2" size="45" required></td>
            </tr>
            <tr>
                <td>생년월일</td>
                <td><input type="date" name="birth_date" id="birth_date" required></td>
            </tr>
            <tr>
                <td>은행</td>
                <td>
                    <select name="bank" id="bank" required>
                        <option value="">은행 선택</option>
                        <option value="신한">신한</option>
                        <option value="국민">국민</option>
                        <option value="농협">농협</option>
                        <option value="우리">우리</option>
                        <option value="케이뱅크">케이뱅크</option>
                        <option value="카카오뱅크">카카오뱅크</option>
                        <option value="토스뱅크">토스뱅크</option>
                        <option value="기업">기업</option>
                        <option value="우체국">우체국</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>계좌번호</td>
                <td>
                	<input type="text" name="account_number" id="account_number" maxlength="30" required>
            		 <span id="accountMessage" style="color:red;"></span>
                </td>
            </tr>
            <tr>
                <td>회원 구분</td>
                <td>
                    <label><input type="radio" name="type_code" value="1" checked> 일반회원</label>
                    <label><input type="radio" name="type_code" value="2"> 판매자</label>
                </td>
            </tr>
        </table>
        <br>
        <div class="button-wrapper">
            <input type="submit" value="회원가입" class="btn btn-primary">
            <input type="button" value="취소" class="btn btn-primary" onclick="javascript:history.back()">
        </div>
    </form>
</div><!-- <div class="member-form-wrapper"> end -->
<!-- 본문 끝 -->


<!-- ----- DAUM 우편번호 API 시작 ----- -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
    }//DaumPostcode() end   <!-- ----- DAUM 우편번호 API 종료----- -->

	 // 우편번호 입력 필드에 커서를 가져다 놓았을 때 자동으로 Daum Postcode 함수 호출
    document.getElementById('zipcode').addEventListener('focus', DaumPostcode);
    
<!-- ----- DAUM 우편번호 API 종료----- -->
    
    
//우편번호 입력 필드에 커서를 가져다 놓았을 때 자동으로 Daum Postcode 함수 호출
document.getElementById('zipcode').addEventListener('focus', DaumPostcode);

//이메일 중복확인
function emailCheck() {
    // 이벤트 리스너 제거
    document.getElementById('email').removeEventListener('focus', emailCheck);
    window.open("${pageContext.request.contextPath}/member/emailCheckForm", "emailCheckForm", "width=500, height=300, resizable=no, scrollbars=no");
    // 포커스 이동
    document.getElementById('password').focus();
    // 이벤트 리스너 다시 추가
    setTimeout(function() {
        document.getElementById('email').addEventListener('focus', emailCheck);
    }, 1000);
}

// 이메일 입력 필드에 커서를 가져다 놓았을 때 자동으로 이메일 중복 확인 함수 호출
document.getElementById('email').addEventListener('focus', emailCheck);



//애경 추가 (7/5)
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
    }//formatPhoneNumber() end
    
    
    
    
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

</script>


<%@ include file="../footer.jsp" %>
