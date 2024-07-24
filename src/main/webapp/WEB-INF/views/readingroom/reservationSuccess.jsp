<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../header.jsp"%>
    <!-- reservationSuccess.jsp -->
   <!-- 본문 시작 -->


    <div class="container">
        <h1>결제 성공</h1>
       
        <p>좌석 예약이 성공적으로 완료되었습니다.</p>

        <h2>예약 정보</h2>
        <p>지점: 
            <c:choose>
                <c:when test="${branch_code == 'L01'}">강남점</c:when>
                <c:when test="${branch_code == 'L02'}">연희점</c:when>
                <c:when test="${branch_code == 'L03'}">종로점</c:when>
                <c:otherwise>알 수 없음</c:otherwise>
            </c:choose>
        </p>
        <p>좌석 번호: ${seat_code}</p>
        <p>이용 시간: ${duration}</p>
        <p>시작 시간: ${start_time}</p>
        <p>종료 시간: ${end_time}</p>
        <p>결제 금액: ${sessionScope.actualPayment}원</p> <!-- 실제 결제 금액 표시 -->
       
    </div> <!-- <div class="container"> end -->

   <!-- 본문 끝 -->
<%@ include file="../footer.jsp"%>
