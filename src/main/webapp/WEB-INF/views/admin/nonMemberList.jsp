<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>

<!-- nonMemberList.jsp -->
<!-- 사이트 메뉴 시작 -->
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
	</div><!-- sidebar end -->
<!-- 사이트 메뉴 끝 -->

<!-- 본문 시작 -->
<div class="nonMemberList-main-content">
	<div class="nonMemberList-row">
		<div class="nonMemberList-col-sm-12">
			<h3>비회원 목록</h3>
		</div>
	</div><!-- branchlist-row end -->
	
    <table border="1">
        <thead>
            <tr>
                <th>비회원 코드</th>
                <th>예약 코드</th>
                <th>이름</th>
                <th>전화번호</th>
                <th>수정</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="nonMember" items="${nonMembers}">
                <tr>
                    <td>${nonMember.nonmember_code}</td>
                    <td>${nonMember.reservation_code}</td>
                    <td>${nonMember.non_name}</td>
                    <td>${nonMember.non_phone}</td>
                    <td>
                        <form action="${pageContext.request.contextPath}/updateNonMember" method="post">
                            <input type="hidden" name="nonmember_code" value="${nonMember.nonmember_code}">
                            <input type="text" name="non_name" value="${nonMember.non_name}">
                            <input type="text" name="non_phone" value="${nonMember.non_phone}">
                            <input type="submit" value="수정">
                        </form>
                    </td>
                    <td>
                        <form action="${pageContext.request.contextPath}/deleteNonMember" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                            <input type="hidden" name="nonmember_code" value="${nonMember.nonmember_code}">
                            <input type="submit" value="삭제">
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div><!-- nonMemberList-main-content end -->

<!-- 본문 끝 -->	
</div> <!-- <div class="contents_inner"> end -->


<style>

/* nonMemberList 페이지 스타일 */
.nonMemberList-main-content {
    width: 80%;
    padding: 20px;
}

.nonMemberList-main-content table {
    width: 100%;
    border-collapse: collapse;
}

.nonMemberList-main-content table, 
.nonMemberList-main-content th, 
.nonMemberList-main-content td {
    border: 1px solid black;
}

.nonMemberList-main-content th, 
.nonMemberList-main-content td {
    padding: 8px;
    text-align: left;
}

.nonMemberList-row {
    display: flex;
    flex-direction: row;
    margin-bottom: 20px;
}

.nonMemberList-col-sm-12 {
    flex: 1;
}

/* 버튼 스타일 */
.nonMemberList-main-content input[type="submit"] {
    margin-top: 10px;
    padding: 10px 15px;
    border: none;
    color: black;
    cursor: pointer;
}

.nonMemberList-main-content .update-btn {
    background-color: #3498db;
    margin-right: 10px;
}

.nonMemberList-main-content .delete-btn {
    background-color: #e74c3c;
}

</style>



<%@ include file="../footer_admin.jsp"%>