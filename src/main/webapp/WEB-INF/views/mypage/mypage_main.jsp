<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../header.jsp"%>

<!-- mypage_main.jsp -->

<!--사이드 메뉴 시작  -->
<div class="contents_inner">
    <div class="sidebar">
        <h2>마이페이지</h2>
        <ul>
            <li><a href="${pageContext.request.contextPath}/member/editMember?email=${sessionScope.member.email}" class="button">회원정보수정/삭제</a></li>
            <li><a href="${pageContext.request.contextPath}/mypage/wishlist?email=${sessionScope.member.email}">나의서점</a></li>
            <li><a href="${pageContext.request.contextPath}/mypage/inquiry_list?email=${sessionScope.member.email}">1:1문의</a></li>
        </ul>
    </div> <!-- <div class="sidebar"> end -->
    <!--사이드 메뉴 끝  -->

    <!-- 본문 시작 -->
    <div class="main-content">
        <div class="content">
            <div class="header">
                <h1>주문배송조회</h1>
                <div class="order-status">
                    <table class="order-table">
                        <thead>
                            <tr>
                                <th>주문일</th>
                                <th>책 제목</th>
                                <th>가격</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orderList}">
                                <tr>
                                    <td>${payment.payment_date}</td>
                                    <td>${order.book_title}</td>
                                    <td>${payment.sale_price}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="section">
                <div class="section-title">나의 서점 관리</div>
                <p>관심있는 책을 등록해 주세요</p>
            </div>
        </div> <!-- <div class="content"> end -->
    </div> <!-- <div class="main-content"> end -->

<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->

<%@ include file="../footer.jsp"%>

<!-- 추가 CSS -->
<style>
.contents_inner {
    display: flex;
}

.sidebar {
    width: 20%;
    background-color: #f8f9fa;
    padding: 20px;
}

.main-content {
    width: 80%;
    padding: 20px;
}

.order-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

.order-table th, .order-table td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

.order-table th {
    background-color: #f2f2f2;
}

.order-table tr:nth-child(even) {
    background-color: #f9f9f9;
}

.order-table tr:hover {
    background-color: #f1f1f1;
}

.section {
    margin-top: 20px;
}

.section-title {
    font-weight: bold;
    margin-bottom: 10px;
}
</style>
