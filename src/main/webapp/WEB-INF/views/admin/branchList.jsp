<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>


<!-- branchList.jsp -->
<!-- 본문 시작 -->

<div class="contents_inner">
    <div class="sidebar">
        <ul>
            <li><a href="${pageContext.request.contextPath}/admin/branchList">지점 목록</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/branchRegister">지점 등록</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/dailySales">지점 매출</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/nonMemberList">비회원 목록</a></li>
        </ul>
    </div><!-- sidebar end -->

    <div class="branchlist-main-content">
        <div class="branchlist-row">
            <div class="branchlist-col-sm-12">
                <h3>지점 목록</h3>
            </div>
        </div><!-- branchlist-row end -->

        <table border="1">
            <thead>
                <tr>
                    <th>지점 코드</th>
                    <th>지점 이름</th>
                    <th>지점 주소</th>
                    <th>위도</th>
                    <th>경도</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="branch" items="${branch}">
                    <c:if test="${branch.branch_code != null}">
                        <tr>
                            <td><a href="${pageContext.request.contextPath}/admin/branchDetail?branch_code=${branch.branch_code}">${branch.branch_code}</a></td>
                            <td>${branch.branch_name}</td>
                            <td>${branch.branch_address}</td>
                            <td>${branch.latitude}</td>
                            <td>${branch.longitude}</td>
                        </tr>
                    </c:if>
                </c:forEach>
            </tbody>
        </table>
    </div><!-- branchlist-main-content end -->



<style>

/* branchlist 페이지 스타일 */
.branchlist-main-content {
    width: 80%;
    padding: 20px;
}

.branchlist-main-content table {
    width: 100%;
    border-collapse: collapse;
}

.branchlist-main-content table, 
.branchlist-main-content th, 
.branchlist-main-content td {
    border: 1px solid black;
}

.branchlist-main-content th, 
.branchlist-main-content td {
    padding: 8px;
    text-align: left;
}

.branchlist-row {
    display: flex;
    flex-direction: row;
    margin-bottom: 20px;
}

.branchlist-col-sm-12 {
    flex: 1;
}

/* 버튼 스타일 */
.branchlist-main-content input[type="submit"] {
    margin-top: 10px;
    padding: 10px 15px;
    border: none;
    color: black;
    cursor: pointer;
}

.branchlist-main-content .update-btn {
    background-color: #3498db;
    margin-right: 10px;
}

.branchlist-main-content .delete-btn {
    background-color: #e74c3c;
}
</style>


<!-- 본문 끝 -->
</div><!-- contents_inner end -->

<%@ include file="../footer.jsp"%>