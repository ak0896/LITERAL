<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>

<!-- branchList.jsp -->

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
 
 
	 <div class="main-content" id="main-content">
		<div class="branchlist">
		<h1>지점 목록</h1>
		<div>

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
        </div>
    </div><!--<div class="branchlist">  end-->
    </div><!--<div class="main-content" id="main-content"> end-->
</div><!-- <div class="contents_inner"> end -->

<!-- 본문 끝 -->
</div><!-- contents_inner end -->


<style>

/* sidebar속에 li 스타일 */

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

#main-content {
    width: 80%;
    padding: 20px;
}

#main-content h1 {
    margin-bottom: 20px;
    font-size: 24px;
    color: #333;
}

#main-content table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

#main-content table, #main-content th, #main-content td {
    border: 1px solid #ddd;
}

#main-content th, #main-content td {
    padding: 12px;
    text-align: left;
}

#main-content th {
    background-color: #f4f4f4;
    font-weight: bold;
}

#main-content tr:nth-child(even) {
    background-color: #f9f9f9;
}

#main-content a {
    color: #6A24FE;
    text-decoration: none;
}

#main-content a:hover {
    text-decoration: underline;
}
</style>


<%@ include file="../footer_admin.jsp"%>