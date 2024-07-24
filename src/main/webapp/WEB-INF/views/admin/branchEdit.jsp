<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- branchEdit.jsp -->

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
    <div class="container">
        <h2>지점 정보</h2>
        <form name="branchForm" id="branchForm" action="${pageContext.request.contextPath}/admin/updateBranch" method="post" onsubmit="return combinedFunction()">
			 <div class="form-group">	
				<input type="hidden" name="branch_code" value="${branch.branch_code}"/>
 			</div>
            <div class="form-group">
                <label for="branchName">지점 이름:</label>
                <input type="text" class="form-control" id="branchName" name="branch_name"  value="${branch.branch_name}" readonly>
            </div>
            <div class="form-group">
                <label for="branchDetail">지점 상세:</label>
                <textarea class="form-control" id="summernote" name="branch_detail" required>${branch.branch_detail}</textarea>
            </div>
            <div class="form-group">
                <button type="button" onclick="DaumPostcode()">주소 검색</button>
                <div id="wrap" style="display:none;"></div>
                <div id="map" style="width:100%;height:400px;margin-top:10px;"></div>
                <label for="branchAddress">지점 주소:</label>
                <input type="text" class="form-control" id="branchAddress" name="branch_address" value="${branch.branch_address}" readonly>
            </div>
            <div class="form-group">
                <label for="latitude">위도:</label>
                <input type="text" class="form-control" id="latitude" name="latitude" value="${branch.latitude}" readonly>
            </div>
            <div class="form-group">
                <label for="longitude">경도:</label>
                <input type="text" class="form-control" id="longitude" name="longitude" value="${branch.longitude}" readonly>
            </div>
            <button type="submit" class="btn btn-primary">수정</button>
            <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/admin/branchList'">취소</button>
        </form>
    </div><!-- <div class="container"> end -->

<!-- 본문 끝 -->
</div><!-- <div class="contents_inner"> end -->



<!-- Kakao 지도 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1d2c6fcb1c84e26382b93490500af756&libraries=services"></script>


<!-- Summernote CSS/JS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>


<script>

//summernote
$(document).ready(function() {
    $('#summernote').summernote({
        placeholder: 'content',
        minHeight: 370,
        maxHeight: null,
        focus: true,
        lang: 'ko-KR'
    });
});




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
                resolve(coords);
            } else {
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



//수정과 동시에 유효성검사
function combinedFunction() {
	    return confirm('수정하시겠습니까?') && validateForm();
}//combinedFunction
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
