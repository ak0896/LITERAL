<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<h1>결제 성공</h1>
<p>이용권 구매가 완료되었습니다.</p>
<p>쿠폰 번호: ${myCoupon.mycoupon_number}</p>
<p>이용권 종류: ${myCoupon.room_code}</p>
<p>발급 날짜: ${myCoupon.issue_date}</p>
<p>만료 날짜: ${myCoupon.expiry_date}</p>

<%@ include file="../footer.jsp"%>
