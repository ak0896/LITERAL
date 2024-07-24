<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>

<!-- reservationDetail.jsp -->

<div class="contents_inner">
	<div class="sidebar">
		<ul>
			<li><a href="${pageContext.request.contextPath}/admin">열람실 관리</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/memberList">회원정보 관리</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/productlist_admin">상품 관리</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/branchList">지점 관리</a></li>
			<li><a href="${pageContext.request.contextPath}/notice/notice_list">공지사항 관리</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/ad_inquiry_list">1:1문의 관리</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/ad_reviewlist">공지사항 관리</a></li>
		</ul>
	</div>
	<!-- sidebar end -->

	<!-- 본문시작 -->


<div class="admin-main-content">
    <h1>예약 상세 정보</h1>
    
    <c:set var="branchCode" value="${fn:substring(reservation.seat_code, 0, 3)}" />
    <c:choose>
        <c:when test="${branchCode == 'L01'}"><c:set var="branchName" value="강남점" /></c:when>
        <c:when test="${branchCode == 'L02'}"><c:set var="branchName" value="연희점" /></c:when>
        <c:when test="${branchCode == 'L03'}"><c:set var="branchName" value="종로점" /></c:when>
        <c:otherwise><c:set var="branchName" value="알 수 없음" /></c:otherwise>
    </c:choose>

	<form id="reservationForm" action="/admin/reservation/update" method="post">
	    <input type="hidden" name="reservation_code" value="${reservation.reservation_code}">
	    <input type="hidden" name="room_code" value="${reservation.room_code}">
	    <input type="hidden" name="reservation_payment" value="${reservation.reservation_payment}">
	    <input type="hidden" name="reservation_date" value="${reservation.reservation_date}">
	    <table class="admin-detail-table">
	        <tr>
	            <th>예약 코드</th>
	            <td>${reservation.reservation_code}</td>
	        </tr>
	        <tr>
	            <th>지점</th>
	            <td>${branchName}</td>
	        </tr>
	        <tr>
	            <th>좌석 번호</th>
	            <td>
	                <select name="seat_code" id="seat_code">
	                    <option value="${reservation.seat_code}">${reservation.seat_code}</option>
	                    <c:forEach var="seat" items="${availableSeats}">
	                        <c:if test="${seat.seat_code != reservation.seat_code}">
	                            <option value="${seat.seat_code}">${seat.seat_code}</option>
	                        </c:if>
	                    </c:forEach>
	                </select>
	            </td>
	        </tr>
	        <tr>
	            <th>예약자 이름</th>
	            <td><input type="text" name="re_name" value="${reservation.re_name}"></td>
	        </tr>
	        <tr>
	            <th>예약자 전화번호</th>
	            <td><input type="text" name="re_phone" value="${reservation.re_phone}"></td>
	        </tr>
	        <tr>
	            <th>시작 시간</th>
	            <td>
	                <select name="time_code" id="time_code">
	                    <option value="${reservation.time_code}">${reservation.time_code}</option>
	                    <c:forEach var="time" items="${availableTimes}">
	                        <c:if test="${time.time_code != reservation.time_code}">
	                            <option value="${time.time_code}">${time.start_time}</option>
	                        </c:if>
	                    </c:forEach>
	                </select>
	            </td>
	        </tr>
	        <tr>
	            <th>종료 시간</th>
	            <td><span id="end_time">${reservation.end_time}</span></td>
	        </tr>
	        <tr>
	            <th>예약 날짜</th>
	            <td>${reservation.reservation_date}</td>
	        </tr>
	        <tr>
	            <th>이용권 종류</th>
	            <td>${reservation.room_code}</td>
	        </tr>
	        <tr>
			    <th>사용 여부</th>
			    <td>
			        <select name="using_seat">
			            <option value="Y" ${reservation.using_seat == 'Y' ? 'selected' : ''}>사용 중</option>
			            <option value="N" ${reservation.using_seat == 'N' ? 'selected' : ''}>미사용</option>
			        </select>
			    </td>
			</tr>
	    </table>
		<div class="admin-button-group">
	        <button type="submit" class="admin-btn admin-btn-primary">수정</button>
	   
			</form>
			<!-- 삭제 폼 -->
			<form id="deleteForm" action="/admin/reservation/delete" method="post" style="display: inline;">
			    <input type="hidden" name="reservation_code" value="${reservation.reservation_code}">
			    <button type="submit" class="admin-btn admin-btn-danger">삭제</button>
			</form>
			<!-- 목록으로 버튼 -->
			<a href="/admin/reservation" class="admin-btn admin-btn-secondary">목록으로</a>
		</div>	
</div><!-- <div class="admin-main-content"> end -->


<script>
$(document).ready(function() {
    $('#time_code').change(function() {
        updateEndTime();
    });

    function updateEndTime() {
        var start_time = $('#time_code option:selected').text();
        var duration = '${reservation.room_code}'; // 이용권 종류에 따른 시간
        $.ajax({
            url: '/admin/calculateEndTime',
            method: 'POST',
            data: { start_time: start_time, duration: duration },
            success: function(response) {
                $('#end_time').text(response);
            }
        });
    }
});
</script>






<style>
/* 관리자 페이지 기본 스타일 */
.admin-main-content {
	width: 80%;
	margin: 0 auto;
	padding: 20px;
}

.admin-main-content table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

.admin-main-content table, .admin-main-content th, .admin-main-content td
	{
	border: 1px solid #ddd;
}

.admin-main-content th, .admin-main-content td {
	padding: 12px;
	text-align: left;
}

.admin-main-content th {
	background-color: #f2f2f2;
}

.admin-row {
	display: flex;
	flex-direction: row;
	margin-bottom: 20px;
}

.admin-col {
	flex: 1;
}

.admin-btn {
	display: inline-block;
	padding: 8px 12px;
	background-color: #4CAF50;
	color: white;
	text-decoration: none;
	border: none;
	cursor: pointer;
}

.admin-btn:hover {
	background-color: #45a049;
}

</style>





<%@ include file="../footer_admin.jsp"%>