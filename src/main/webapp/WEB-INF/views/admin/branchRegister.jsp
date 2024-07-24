<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>

<!-- branchRegister.jsp -->


<!--사이드 메뉴 시작  -->
<div class="contents_inner">
	<div class="sidebar">
	    <ul class="nav nav-pills nav-stacked">
	        <li><a href="${pageContext.request.contextPath}/admin">열람실 관리</a></li>
	        <li><a href="${pageContext.request.contextPath}/admin/memberList">회원정보 관리</a></li>
	        <li><a href="${pageContext.request.contextPath}/admin/productlist_admin">상품 관리</a></li>
	        <li>
	            <a href="#branchSubMenu" data-toggle="collapse" aria-expanded="false">지점 관리 <span class="caret"></span></a>
	            <ul class="nav nav-pills nav-stacked collapse" id="branchSubMenu">
	                <li><a href="${pageContext.request.contextPath}/admin/branchList">지점 목록</a></li>
	                <li><a href="${pageContext.request.contextPath}/admin/branchRegister">지점 등록</a></li>
	                <li><a href="${pageContext.request.contextPath}/admin/dailySales">지점 매출</a></li>
	                <li><a href="${pageContext.request.contextPath}/admin/nonMemberList">비회원 목록</a></li>
	            </ul>
	        </li>
	       	<li><a href="${pageContext.request.contextPath}/notice/notice_list">공지사항 관리</a></li>
	        <li><a href="${pageContext.request.contextPath}/admin/ad_inquiry_list">1:1문의 관리</a></li>
	    </ul>
	</div><!-- <div class="sidebar">  end-->
 <!--사이드 메뉴 끝  -->
 

<!-- 본문 시작 -->
	<div class="branchlist-main-content">
        <h3>지점 등록</h3>
        
        <c:if test="${not empty errorMessage}">
	        <div class="alert alert-danger">${errorMessage}</div>
	    </c:if>
	    
	    <c:if test="${not empty successMessage}">
	        <div class="alert alert-success">${successMessage}</div>
	    </c:if>

        <form id="branchForm" action="${pageContext.request.contextPath}/admin/saveBranch" method="post">
            <div class="form-group">
                <label for="branchName">지점 이름:</label>
                <input type="text" class="form-control" id="branchName" name="branch_name" required>
	            <c:if test="${not empty branchNameError}">
	                <span id="nameMessage" style="color:red;">${branchNameError}</span>
	            </c:if>
            </div>
            <div class="form-group">
                <label for="branchDetail">지점 상세:</label>
                <textarea class="form-control" id="summernote" name="branch_detail"></textarea>  <!-- summernote 확인부분 -->
            </div>
            <div class="form-group">
                <button type="button" onclick="DaumPostcode()">주소 검색</button>
                <div id="wrap" style="display:none;"></div>
                <div id="map" style="width:100%;height:400px;margin-top:10px;"></div>
                <label for="branchAddress">지점 주소:</label>
                <input type="text" class="form-control" id="branchAddress" name="branch_address" readonly>
            </div>
            <div class="form-group">
                <label for="latitude">위도:</label>
                <input type="text" class="form-control" id="latitude" name="latitude" readonly>
            </div>
            <div class="form-group">
                <label for="longitude">경도:</label>
                <input type="text" class="form-control" id="longitude" name="longitude" readonly>
            </div>
            <button type="submit" class="btn btn-primary">등록</button>
            <button type="button" class="btn btn-primary" onclick="javascript:history.back()">취소</button>
        </form>
    </div><!-- <div class="branchlist-main-content"> end -->
</div><!--<div class="branchlist">  end-->

<!-- 본문 끝 -->
</div><!-- <div class="contents_inner"> end -->




<!-- Kakao 지도 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1d2c6fcb1c84e26382b93490500af756&libraries=services"></script>



<!-- Summernote관련  CSS/JS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>



<script>

//summernote 작성부분
$(document).ready(function() {
    $('#summernote').summernote({
        placeholder: '지점 상세 내용을 입력하세요',
        minHeight: 370,
        maxHeight: null,
        focus: true,
        lang: 'ko-KR'
    });
});

//지점 중복확인
function validateBranchForm() {
    var nameMessage = document.getElementById("nameMessage");
    if (nameMessage.style.color == "red") {
        alert("지점 이름을 확인해주세요.");
        return false;
    }
    return true;
}//validateBranchForm() end






// 주소 관련
var element_wrap = document.getElementById('wrap');

function foldDaumPostcode() {
    element_wrap.style.display = 'none';
}

function DaumPostcode() {
    var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
    new daum.Postcode({
        oncomplete: async function(data) {
            var addr = '';

            if (data.userSelectedType === 'R') {
                addr = data.roadAddress;
            } else {
                addr = data.jibunAddress;
            }

            // 주소 필드에 설정
            document.getElementById('branchAddress').value = addr;

            // 주소로부터 위도와 경도 가져오기
            try {
                const coords = await getAddressCoords(addr);
                document.getElementById('latitude').value = coords.getLat();
                document.getElementById('longitude').value = coords.getLng();

                // 지도에 표시
                displayMap(coords);
            } catch (error) {
                console.error('Error getting coordinates:', error);
            }

            element_wrap.style.display = 'none';
            document.body.scrollTop = currentScroll;
        },
        onresize: function(size) {
            element_wrap.style.height = size.height + 'px';
        },
        width: '100%',
        height: '100%'
    }).embed(element_wrap);

    element_wrap.style.display = 'block';
}

const getAddressCoords = (address) => {
    return new Promise((resolve, reject) => {
        const geoCoder = new kakao.maps.services.Geocoder();
        geoCoder.addressSearch(address, (result, status) => {
            if (status === kakao.maps.services.Status.OK) {
                const coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                console.log("Coordinates found:", coords); // 로그 추가
                resolve(coords);
            } else {
            	 console.error("Failed to get coordinates:", status); // 로그 추가
                reject(status);
            }
        });
    });
};

const displayMap = (coords) => {
    const mapContainer = document.getElementById('map');
    const mapOption = {
        center: coords,
        level: 3
    };
    const map = new kakao.maps.Map(mapContainer, mapOption);
    const marker = new kakao.maps.Marker({
        position: coords
    });
    marker.setMap(map);
};

</script>



<style>
.sidebar {
    padding: 20px 0;
    width: 200px; /* 사이드바의 너비 설정 */
}
.sidebar .nav-pills > li {
    width: 100%; /* 각 항목이 전체 너비를 차지하도록 설정 */
}
.sidebar .nav-pills > li > a {
    border-radius: 0;
    white-space: nowrap; /* 텍스트가 한 줄로 유지되도록 설정 */
    overflow: hidden; /* 너비를 넘어가는 텍스트 숨김 */
    text-overflow: ellipsis; /* 너비를 넘어가는 텍스트에 '...' 추가 */
    padding-left: 20px; 
}
.sidebar .nav-pills > li > ul > li > a {
    padding-left: 40px;
}
</style>


<%@ include file="../footer_admin.jsp"%>