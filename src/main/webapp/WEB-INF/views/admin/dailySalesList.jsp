<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>


<!-- dailySalesList.jsp -->
<!-- 본문시작  -->

<div class="contents_inner">
	<div class="sidebar">
		<ul>
			<li><a href="${pageContext.request.contextPath}/admin/branchList">지점 목록</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/branchRegister">지점 등록</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/dailySalesAll">지점 매출</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/nonMemberList">비회원 목록</a></li>
		</ul>
	</div><!-- sidebar end -->


    <!-- 매출 등록 폼 -->
    <div class="main_content">
        <!-- 매출 목록 -->
        <h2>전체 매출 목록</h2>
        <table border="1">
            <thead>
                <tr>
                    <th>지점 코드</th>
                    <th>상품 판매 수입</th>
                    <th>열람실 수입</th>
                    <th>매출 날짜</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="dailySales" items="${dailySalesList}">
                    <tr>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/dailySales?branch_code=${dailySales.branch_code}&sales_date=<fmt:formatDate value="${dailySales.sales_date}" pattern="yyyy-MM-dd"/>">
                                ${dailySales.branch_code}
                            </a>
                        </td>
                        <td>${dailySales.dtotal_product}</td>
                        <td>${dailySales.dtotal_room}</td>
                        <td><fmt:formatDate value="${dailySales.sales_date}" pattern="yyyy-MM-dd"/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div><!-- main_content end -->






<!-- 본문 끝 -->
</div><!-- contents_inner end -->

<%@ include file="../footer.jsp"%>