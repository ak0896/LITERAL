<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<!-- 출력하는지 확인용 -->
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%
Map<String, List<String>> seatLayouts = (Map<String, List<String>>)request.getAttribute("seatLayouts");
Map<String, String> seatStatuses = (Map<String, String>)request.getAttribute("seatStatuses");
System.out.println("JSP - seatLayouts: " + seatLayouts);
System.out.println("JSP - seatStatuses: " + seatStatuses);
%>



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
						<%-- <div class="summary-item">
							<h3>현재 사용 중인 좌석</h3>
							<p>${occupiedSeats}</p>
						</div> --%>
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
	                            <c:set var="branchCode" value="${fn:substring(reservation.seat_code, 0, 3)}" />
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
				
			<div class="branch-seats">
		    <h2>지점별 좌석 현황</h2>
			<div class="branch-layouts">
			    <%
				    pageContext.setAttribute("branchCodes", new String[]{"L01", "L02", "L03"});
				%>
				<c:forEach var="branchCode" items="${branchCodes}">
			        <div class="branch-layout">
			            <h3>
			                <c:choose>
			                    <c:when test="${branchCode == 'L01'}">강남점</c:when>
			                    <c:when test="${branchCode == 'L02'}">연희점</c:when>
			                    <c:when test="${branchCode == 'L03'}">종로점</c:when>
			                </c:choose>
			            </h3>
			            <div class="seat-layout">
			                <c:forEach var="seat" items="${seatLayouts[branchCode]}">
			                    <c:choose>
			                        <c:when test="${seat == 'hidden'}">
			                            <div class="seat hidden"></div>
			                        </c:when>
			                      <c:otherwise>
						                 <div class="seat ${seatStatuses[seat]}" data-seat-code="${seat}">
										    ${fn:substringAfter(seat, '-')}
										</div>
						            </c:otherwise>
			                    </c:choose>
			                </c:forEach>
			            </div>
			        </div>
			    </c:forEach>
			</div><!--<div class="branch-layouts"> end  -->
		   </div> <!--<div class="branch-seats"> end  -->      
            
		</div><!--  <div class="container"> end -->
	</div><!--<div class="adminPage">  end-->
</div><!-- contents_inner end -->
<!-- 본문 끝 -->



<script>
document.addEventListener('DOMContentLoaded', function() {
    function updateSeatStatus() {
        fetch('${pageContext.request.contextPath}/api/seatStatus')
            .then(response => {
                if (!response.ok) {
                    return response.json().then(err => { throw err; });
                }
                return response.json();
            })
            .then(data => {
                console.log('Full server response:', JSON.stringify(data, null, 2));
                for (let branchCode in data) {
                    let branchData = data[branchCode];
                    for (let seatCode in branchData) {
                        let fullSeatCode = `${branchCode}-${seatCode}`;
                        let seatElement = document.querySelector(`.seat[data-seat-code="${fullSeatCode}"]`);
                        if (seatElement) {
                            let seatInfo = branchData[seatCode];
                            let newStatus = seatInfo.status;

                            // 모든 상태 클래스를 제거하고 새로운 상태를 추가
                            seatElement.classList.remove('available', 'occupied', 'reserved');
                            seatElement.classList.add(newStatus);

                            console.log(`Updated seat ${fullSeatCode} to ${newStatus}`);

                            // 상태 변경 애니메이션 추가
                            seatElement.classList.add('status-changed');
                            setTimeout(() => {
                                seatElement.classList.remove('status-changed');
                            }, 500);
                        }
                    }
                }
            })
            .catch(error => {
                //console.error('Error:', error);
                //alert('좌석 상태를 업데이트하는 중 오류가 발생했습니다: ' + (error.error || error.message || '알 수 없는 오류'));
            });
    }

    // 초기 업데이트
    updateSeatStatus();

    // 1초 후 한 번 더 업데이트
    setTimeout(updateSeatStatus, 1000);

    // 30초마다 업데이트
    setInterval(updateSeatStatus, 30000);
});

/* var seatLayouts = JSON.parse('${seatLayoutsJson}');
var seatStatuses = JSON.parse('${seatStatusesJson}');
console.log('Client-side seatLayouts:', seatLayouts);
console.log('Client-side seatStatuses:', seatStatuses); */

</script>

    
<style>
.seat {
    aspect-ratio: 1 / 1;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 2px solid #ccc;
    border-radius: 5px;
    font-size: 14px;
    font-weight: bold;
    transition: all 0.3s ease;
}

.seat.available { 
    background-color: #4CAF50; 
    color: white;
}

.seat.occupied { 
    background-color: #FF5733;
    color: white;
}

.seat.reserved { 
    background-color: #FFC300; 
    color: black;
}
.seat.hidden { 
    visibility: hidden;
}

.seat.status-changed {
    animation: pulse 0.5s;
}

@keyframes pulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.05); }
    100% { transform: scale(1); }
}
.seat-layout {
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    gap: 10px;
    padding: 10px;
}

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


.branch-layouts {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
}

.branch-layout {
    width: 30%;
    margin-bottom: 20px;
}

</style>


<%@ include file="../footer_admin.jsp"%>