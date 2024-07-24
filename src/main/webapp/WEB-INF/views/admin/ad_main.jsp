<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- ad_main.jsp -->

<!-- 사이드 메뉴 시작 -->
<div class="contents_inner">
	<div class="sidebar">
		<ul>
			<li><a href="${pageContext.request.contextPath}/admin">열람실 관리</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/memberList">회원정보 관리</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/productlist_admin">상품 관리</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/branchList">지점 관리</a></li>
			<li><a href="${pageContext.request.contextPath}/notice/notice_list">공지사항 관리</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/ad_inquiry_list">1:1문의 관리</a></li>
		</ul>
	</div>
	<!-- sidebar end -->
<!-- 사이드 메뉴 끝 -->


	<!-- 본문시작 -->
	<div class="adminPage">
		<h1>예약 목록</h1>
		<div class="container">
				<section class="summary">
					<div class="summary-grid">
						<div class="summary-item">
							<h3>총 예약 수</h3>
							<p>${reservations.size()}</p>
						</div>
						<div class="summary-item">
							<h3>총 좌석 수</h3>
							<p>${totalSeats}</p>
						</div>
						<div class="summary-item">
							<h3>현재 사용 중인 좌석</h3>
							<p>${occupiedSeats}</p>
						</div>
					</div>
				</section>


				<h1>예약 목록</h1>
				<c:if test="${not empty message}">
					<div class="admin-alert admin-alert-success">${message}</div>
				</c:if>
				<c:if test="${not empty error}">
					<div class="admin-alert admin-alert-danger">${error}</div>
				</c:if>

				<section class="admin-reservation-list">
					<table>
						<thead>
							<tr>
								<th>예약 코드</th>
								<th>지점</th>
								<th>좌석 번호</th>
								<th>예약자 이름</th>
								<th>시작 시간</th>
								<th>종료 시간</th>
								<th>예약 날짜</th>
								<th>액션</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="reservation" items="${reservations}">
								<c:set var="branchCode"
									value="${fn:substring(reservation.seat_code, 0, 3)}" />
								<c:choose>
									<c:when test="${branchCode == 'L01'}">
										<c:set var="branchName" value="강남점" />
									</c:when>
									<c:when test="${branchCode == 'L02'}">
										<c:set var="branchName" value="연희점" />
									</c:when>
									<c:when test="${branchCode == 'L03'}">
										<c:set var="branchName" value="종로점" />
									</c:when>
									<c:otherwise>
										<c:set var="branchName" value="알 수 없음" />
									</c:otherwise>
								</c:choose>
								<tr>
									<td>${reservation.reservation_code}</td>
									<td>${branchName}</td>
									<td>${reservation.seat_code}</td>
									<td>${reservation.re_name}</td>
									<td>${reservation.time_code}</td>
									<td>${reservation.end_time}</td>
									<td>${reservation.reservation_date}</td>
									<td><a href="/admin/reservation/${reservation.reservation_code}" class="admin-btn admin-btn-info">상세</a>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</section>
			<div class="charts-container">
	            <c:choose>
	                <c:when test="${branchCode == 'L01'}">
	                    <c:set var="branchName1" value="강남점" />
	                    <c:set var="branch1OccupiedSeats" value="${branch1OccupiedSeats}" />
	                    <c:set var="branch1TotalSeats" value="${branch1TotalSeats}" />
	                </c:when>
	                <c:when test="${branchCode == 'L02'}">
	                    <c:set var="branchName2" value="연희점" />
	                    <c:set var="branch2OccupiedSeats" value="${branch2OccupiedSeats}" />
	                    <c:set var="branch2TotalSeats" value="${branch2TotalSeats}" />
	                </c:when>
	                <c:when test="${branchCode == 'L03'}">
	                    <c:set var="branchName3" value="종로점" />
	                    <c:set var="branch3OccupiedSeats" value="${branch3OccupiedSeats}" />
	                    <c:set var="branch3TotalSeats" value="${branch3TotalSeats}" />
	                </c:when>
	            </c:choose>
	
	            <div class="chart-wrapper">
	                <canvas id="chart1"></canvas>
	            </div>
	            <div class="chart-wrapper">
	                <canvas id="chart2"></canvas>
	            </div>
	            <div class="chart-wrapper">
	                <canvas id="chart3"></canvas>
	            </div>
           	</div><!-- <div class="charts-container"> end -->
		</div><!--  <div class="container"> end -->
	</div><!--<div class="adminPage">  end-->
</div><!-- contents_inner end -->
<!-- 본문 끝 -->


<script>

/* function updateOccupiedSeats() {
    fetch('/api/admin/occupied-seats')
        .then(response => response.json())
        .then(data => {
            document.getElementById('occupiedSeats').textContent = data.occupiedSeats;
        });
}

setInterval(updateOccupiedSeats, 60000); // 1분마다 업데이트


        // 좌석 점유율 차트
    document.addEventListener('DOMContentLoaded', function() {
    // 강남점 차트
    new Chart(document.getElementById('chart1').getContext('2d'), {
        type: 'pie',
        data: {
            labels: ['사용 중인 좌석', '빈 좌석'],
            datasets: [{
                data: [${L01OccupiedSeats}, ${L01TotalSeats - L01OccupiedSeats}],
                backgroundColor: ['#FF6384', '#36A2EB'],
                hoverBackgroundColor: ['#FF6384', '#36A2EB']
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'top',
                },
                title: {
                    display: true,
                    text: '강남점 좌석 점유율'
                }
            }
        }
    });

    // 연희점 차트
    new Chart(document.getElementById('chart2').getContext('2d'), {
        type: 'pie',
        data: {
            labels: ['사용 중인 좌석', '빈 좌석'],
            datasets: [{
                data: [${L02OccupiedSeats}, ${L02TotalSeats - L02OccupiedSeats}],
                backgroundColor: ['#FF6384', '#36A2EB'],
                hoverBackgroundColor: ['#FF6384', '#36A2EB']
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'top',
                },
                title: {
                    display: true,
                    text: '연희점 좌석 점유율'
                }
            }
        }
    });

    // 종로점 차트
    new Chart(document.getElementById('chart3').getContext('2d'), {
        type: 'pie',
        data: {
            labels: ['사용 중인 좌석', '빈 좌석'],
            datasets: [{
                data: [${L03OccupiedSeats}, ${L03TotalSeats - L03OccupiedSeats}],
                backgroundColor: ['#FF6384', '#36A2EB'],
                hoverBackgroundColor: ['#FF6384', '#36A2EB']
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'top',
                },
                title: {
                    display: true,
                    text: '종로점 좌석 점유율'
                }
            }
        }
    });

    // 디버깅을 위한 로그
    console.log("강남점 데이터:", ${L01OccupiedSeats}, ${L01TotalSeats});
    console.log("연희점 데이터:", ${L02OccupiedSeats}, ${L02TotalSeats});
    console.log("종로점 데이터:", ${L03OccupiedSeats}, ${L03TotalSeats});
}); */
    </script>       

    
<style>

/* 관리자 페이지 기본 스타일 */
.adminPage {
    width: 80%;
    margin: 0 auto;
    padding: 20px;
}

.adminPage h1 {
    margin-bottom: 20px;
    font-size: 24px;
    color: #333;
}

.container {
    margin-top: 20px;
}

.summary {
    margin-bottom: 30px;
}

.summary-grid {
    display: flex;
    justify-content: space-between;
    gap: 20px;
}

.summary-item {
    flex: 1;
    padding: 15px;
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 5px;
} 

.summary-item h3 {
    margin: 0 0 10px 0;
    font-size: 18px;
    color: #555;
}

.summary-item p {
    font-size: 24px;
    margin: 0;
}

.admin-reservation-list table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

.admin-reservation-list table, .admin-reservation-list th, .admin-reservation-list td {
    border: 1px solid #ddd;
}

.admin-reservation-list th, .admin-reservation-list td {
    padding: 12px;
    text-align: left;
}

.admin-reservation-list th {
    background-color: #f2f2f2;
}

.admin-btn {
    display: inline-block;
    padding: 10px 12px;
    background-color: #45a049;
    color: white;
    text-decoration: none;
    font-size: 16px; /* 폰트 크기 조정 */
    border: none;
    cursor: pointer;
    border-radius: 4px;
}

.admin-btn-info {
    background-color: #45a049;
}

.admin-btn-info:hover {
    background-color: #45a049;
}

.admin-alert {
    padding: 10px;
    margin-bottom: 20px;
    border-radius: 5px;
}

.admin-alert-success {
    background-color: #dff0d8;
    color: #3c763d;
}

.admin-alert-danger {
    background-color: #f2dede;
    color: #a94442;
}

.occupancy-chart {
    margin-top: 30px;
}

.occupancy-chart h2 {
    font-size: 20px;
    margin-bottom: 20px;
}

.charts-container {
    display: flex;
    justify-content: space-between;
    margin-top: 30px;
}
.chart-wrapper {
    width: 30%;
    height: 300px;
}
</style>


<%@ include file="../footer_admin.jsp"%>