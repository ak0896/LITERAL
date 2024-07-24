<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>

<!-- branchDetail_admin.jsp -->

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
 

	<div class="container branch-info-container">
		<h2>지점 상세 정보</h2>

		<div class="branch-details">
			<p><strong>지점 코드:</strong> ${branch.branch_code}</p>
			<p><strong>지점 이름:</strong> ${branch.branch_name}</p>
			<p><strong>지점 주소:</strong> ${branch.branch_address}</p>
			<div id="map_${branch.branch_code}" class="map-container"></div>
			<div class="branch-description">
				<p><strong>상세 정보:</strong> ${branch.branch_detail}</p>
			</div>
			<p class="latitude" hidden aria-hidden="true">${branch.latitude}</p>
			<p class="longitude" hidden aria-hidden="true">${branch.longitude}</p>
			<div class="branch-actions">
				<form action="${pageContext.request.contextPath}/admin/branchEdit" method="post" style="display: inline-block;">
					<input type="hidden" name="branch_code" value="${branch.branch_code}">
					<input type="submit" value="수정" class="btn btn-primary">
				</form>
				<form action="${pageContext.request.contextPath}/admin/deleteBranch" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');" style="display: inline-block;">
					<input type="hidden" name="branch_code" value="${branch.branch_code}">
					<input type="submit" value="삭제" class="btn btn-danger">
					<input type="button" value="취소" class="btn btn-success" onclick="javascript:history.back()">
				</form>
			</div>
		</div><!-- <div class="branch-details"> end  -->
	</div><!-- <div class="container branch-info-container"> end -->

<!-- 본문 끝 -->
</div><!-- contents_inner end -->


<!-- Kakao 지도 API -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1d2c6fcb1c84e26382b93490500af756&libraries=services"></script>
<script>
		$(document).ready(
				function() {
					function initializeMap() {
						var mapId = 'map_${branch.branch_code}';
						var lat = parseFloat($('.latitude').text());
						var lng = parseFloat($('.longitude').text());
						var mapOption = {
							center : new kakao.maps.LatLng(lat, lng),
							level : 3
						};

						var map = new kakao.maps.Map(document
								.getElementById(mapId), mapOption);
						var marker = new kakao.maps.Marker({
							position : new kakao.maps.LatLng(lat, lng)
						});
						marker.setMap(map);

						setTimeout(function() {
							map.relayout();
							map.setCenter(new kakao.maps.LatLng(lat, lng));
						}, 100);
					}

					initializeMap();
				});
</script>



<style>
    .branch-info-container {
        margin-top: 30px;
    }
    .map-wrapper {
        width: 100%;
        margin-bottom: 20px; /* 지도 아래에 여백 추가 */
        display: flex;
        justify-content: center;
    }
    .map-container {
        height: 400px;
        width: 80%; /* 지도의 폭을 줄임 */
        position: relative;
    }
    .branch-details {
        background-color: #f9f9f9;
        padding: 20px;
        border-radius: 5px;
    }
    .branch-details h3 {
        margin-top: 0;
        color: #333;
    }
    .branch-details p {
        margin-bottom: 10px;
    }
    .branch-details strong {
        color: #555;
    }
    .branch-actions {
        margin-top: 20px;
        text-align: center; /* 버튼들을 오른쪽 정렬 */
    }
    .branch-actions .btn {
        margin-left: 10px; /* 버튼 간격 */
    }
    
    
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