<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- 오늘의 책 불러오기 -->
<script>var todayBooks = ${todayBooksJson != null ? todayBooksJson : '{}'};</script>

<!-- Kakao 지도 API -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1d2c6fcb1c84e26382b93490500af756&libraries=services"></script>


<!-- 지점 탭 누를 떄 마다 지도 생성 -->
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">


<!-- branchDetail.jsp -->
<!-- 본문 시작 -->
<div class="container branch-info-container">
	<h2>지점 안내</h2>

	<!-- 지점별 상단바 탭 부분 -->
	<ul class="nav nav-tabs" role="tablist">
		<c:forEach var="branch" items="${branchList}" varStatus="status">
			<li role="presentation" class="${status.index == 0 ? 'active' : ''}">
				<a href="#${branch.branch_code}"
				aria-controls="${branch.branch_code}" role="tab" data-toggle="tab">
					${branch.branch_name} </a>
			</li>
		</c:forEach>
	</ul>
	<!-- <ul class="nav nav-tabs" role="tablist">  end-->

	<!-- 지점별 지도 & 상세내용 -->
	<div class="tab-content">
		<c:forEach var="branch" items="${branchList}" varStatus="status">
			<div role="tabpanel"
				class="tab-pane fade ${status.index == 0 ? 'in active' : ''}"
				id="${branch.branch_code}">
				<div class="row">
					<div class="col-md-6">
						<div id="map_${branch.branch_code}" class="map-container"></div>
					</div>
					<div class="col-md-6">
						<div class="branch-details">
							<h3>${branch.branch_name}</h3>
							<p>
								<strong>주소:</strong> ${branch.branch_address}
							</p>
							<div class="branch-description">
								<strong>상세 정보:</strong> ${branch.branch_detail}
							</div>
							<p class="latitude" hidden aria-hidden="true">${branch.latitude}</p>
							<p class="longitude" hidden aria-hidden="true">${branch.longitude}</p>
						</div>
					</div>
				</div><!-- <div class="row"> end -->
			</div><!-- <div role="tabpanel"...>   end -->
		</c:forEach>
	</div><!-- <div class="tab-content"> end -->
</div><!-- <div class="container branch-info-container"> end -->


<script>
$(document).ready(function() {
	
	 if (typeof todayBooks === 'undefined') {
	        console.error('todayBooks is not defined');
	        todayBooks = {};  // 기본값 설정
	 }
	window.todayBooks = window.todayBooks || {};

	console.log('Today\'s books:', todayBooks);
	
    var maps = {};
    var markers = {};
    var customOverlays = {};
    
    // todayBooks가 정의되지 않았을 경우를 대비한 안전장치
    window.todayBooks = window.todayBooks || {};
    
    function createOverlayContent(branchCode, branchName) {
        var books = (window.todayBooks && window.todayBooks[branchCode]) || [];
        var content = '<div class="overlaybox">' +
            '    <div class="boxtitle">' + branchName + ' 오늘의 책</div>';

        if (books.length > 0) {
            content += '    <div class="first">' +
                '    <ul>';

            for (var i = 0; i < Math.min(books.length, 5); i++) {
                content += '        <li>' +
                    '            <span class="number">' + (i + 1) + '</span>' +
                    '            <span class="title">' + books[i].book_title + '</span>' +
                    '        </li>';
            }

            content += '    </ul>';
        } else {
        	content += '        <li>' +
            '            <span class="title">오늘 등록된 책이 없습니다.</span>' +
            '        </li>';
        }
       		content += '</div>';
       
       		return content;
    }//createOverlayContent() end
    

    function initializeMap(branchCode) {
        var mapId = 'map_' + branchCode;
        var $mapContainer = $('#' + mapId);

        var lat = parseFloat($('#' + branchCode + ' .latitude').text());
        var lng = parseFloat($('#' + branchCode + ' .longitude').text());

        console.log('Initializing map for branch:', branchCode, 'Latitude:', lat, 'Longitude:', lng);

        var mapOption = {
            center: new kakao.maps.LatLng(lat, lng),
            level: 3
        };

        if (!maps[mapId]) {
            try {
                maps[mapId] = new kakao.maps.Map($mapContainer[0], mapOption);
                markers[mapId] = new kakao.maps.Marker({
                    position: new kakao.maps.LatLng(lat, lng)
                });
                markers[mapId].setMap(maps[mapId]);

                
                var branchName = $('#' + branchCode + ' h3').text();
                console.log('Branch name:', branchName);
                console.log('Today\'s books for branch:', todayBooks[branchCode]);
                
                var content = createOverlayContent(branchCode, branchName);
                
                
                var position = new kakao.maps.LatLng(lat, lng);
                customOverlays[mapId] = new kakao.maps.CustomOverlay({
                    position: position,
                    content: content,
                    xAnchor: 0.3,
                    yAnchor: 0.91
                });
                customOverlays[mapId].setMap(maps[mapId]);

                console.log('Map initialized for:', mapId);
            } catch (error) {
                console.error("지도 초기화 실패:", error);
                console.log("Branch code:", branchCode);
                console.log("Today's books:", todayBooks);
                
                $mapContainer.html('<p class="error-message">지도를 불러오는데 실패했습니다. 새로고침을 해주세요.</p>');
                return;
            }
        } else {
            maps[mapId].setCenter(new kakao.maps.LatLng(lat, lng));
            markers[mapId].setPosition(new kakao.maps.LatLng(lat, lng));
            
            var branchName = $('#' + branchCode + ' h3').text();
            var content = createOverlayContent(branchCode, branchName);
            
            customOverlays[mapId].setPosition(new kakao.maps.LatLng(lat, lng));
            customOverlays[mapId].setContent(content);
                   
            console.log('Map relayout for:', mapId);
        }

        // 영역이 변경된 후 지도를 다시 그리기 위해 setTimeout 사용
        setTimeout(function() {
            maps[mapId].relayout();
            maps[mapId].setCenter(new kakao.maps.LatLng(lat, lng));
        }, 100);
    }//initializeMap() end
    

    // 첫 번째 탭 활성화 및 지도 표시
    var firstTab = $('.nav-tabs li:first-child a');
    var firstTabId = firstTab.attr('href').substring(1);
    console.log('First tab:', firstTabId);
    initializeMap(firstTabId);

    
    // 탭 클릭 시 지도 초기화
    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        var targetId = $(e.target).attr("href").substring(1);
        console.log('Tab shown:', targetId);
        setTimeout(function() {
            initializeMap(targetId);
        }, 100); // 영역 변경 후 레이아웃 업데이트
    });

    
    // 창 크기 조정 시 지도 초기화
    $(window).on('resize', function() {
        var activeTabId = $('.tab-pane.active').attr('id');
        console.log('Window resize - active tab:', activeTabId);
        if (activeTabId) {
            setTimeout(function() {
                initializeMap(activeTabId);
            }, 100); // 영역 변경 후 레이아웃 업데이트
        }
    });

    
    // 탭의 CSS transition 완료 후 지도 초기화
    $('.tab-pane').on('transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd', function() {
        var activeTabId = $(this).attr('id');
        if ($(this).hasClass('active')) {
            console.log('Tab transitionend:', activeTabId);
            setTimeout(function() {
                initializeMap(activeTabId);
            }, 100);
        }
    });
});

</script>

<style>
.branch-info-container {
	margin-top: 30px;
}

.nav-tabs {
	border-bottom: none;
}

.nav-tabs>li {
	margin-bottom: 0;
}

.nav-tabs>li>a {
	border: none;
	background-color: #f8f8f8;
	color: #333;
	margin-right: 5px;
	border-radius: 0;
}

.nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover
	{
	border: none;
	background-color: #007bff;
	color: white;
}

.tab-content {
	background-color: white;
	border: 1px solid #ddd;
	padding: 20px;
	margin-top: -1px;
}

.map-container {
	height: 650px;
	width: 100%;
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

.branch-details img {
	max-width: 100%;
	height: auto;
}

.tab-content>.tab-pane {
	display: none;
}

.tab-content>.active {
	display: block;
}


/* 커스텀 오버레이 */

.overlaybox {position:relative;width:220px;height:200px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/box_movie.png') no-repeat;padding:15px 10px;}
.overlaybox div, ul {overflow:hidden;margin:0;padding:0;}
.overlaybox li {list-style: none;}
/* 지점명 */.overlaybox .boxtitle {color:#fff;font-size:16px;font-weight:bold;margin-bottom:8px;}
.overlaybox .first {position:relative;width:247px;height:136px;margin-bottom:8px;}
.overlaybox ul {width:200px;}
.overlaybox li {position:relative;margin-bottom:2px;background:#2b2d36;padding:5px 10px;color:#aaabaf;line-height: 1;}
.overlaybox li span {display:inline-block;}
.overlaybox li .number {font-size:16px;font-weight:bold;}
/* 목록제목 */.overlaybox li .title {font-size:13px;}
/* 순위 */.overlaybox li .count {position:absolute;margin-top:5px;right:15px;font-size:10px;}
.overlaybox li:hover {color:#fff;background:#d24545;}


</style>

<!-- 본문 끝 -->
<%@ include file="../footer.jsp"%>
