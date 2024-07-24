<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>


<!-- memberList.jsp -->
<!-- 사이드 바 시작 -->
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
<!-- 사이드 바 끝 -->

<!-- 본문 시작 -->
<div class="main-content" id="main-content">
		<h1>회원 목록</h1>
		<table>
			<thead>
				<tr>
					<th>이메일</th>
					<th>이름</th>
					<th>전화번호</th>
					<th>생년월일</th>
					<th>회원 구분</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="member" items="${members}">
					<c:if test="${member.type_code != 0}">
					<tr>
						<td>${member.email}</td>
						<td>${member.name}</td>
						<td>${member.phone_number}</td>
						<td>${member.birth_date}</td>
						 <td>
					        <select name="type_code_select" onchange="updateTypeCode(this)">
					            <option value="1" <c:if test="${member.type_code == 1}">selected</c:if>>일반회원</option>
					            <option value="2" <c:if test="${member.type_code == 2}">selected</c:if>>판매자</option>
					        </select>
					    </td>
					    <td>
					        <form action="${pageContext.request.contextPath}/admin/updateMemberType" method="post" class="form-inline">
					            <input type="hidden" name="email" value="${member.email}">
					            <input type="hidden" name="type_code" value="${member.type_code}">
					            <input type="submit" value="수정">
					        </form>
					    </td>
					    <td>
					        <form action="${pageContext.request.contextPath}/admin/deleteMember" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');" class="form-inline">
					            <input type="hidden" name="email" value="${member.email}">
					            <input type="submit" value="삭제">
					        </form>
					    </td>
					</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
	</div> <!-- <div class="main-content"> end -->
</div><!-- contents_inner end -->
<!-- 본문 끝 -->



<script>
function updateTypeCode(selectElement) {
    var form = selectElement.closest('tr').querySelector('form');
    var typeCodeInput = form.querySelector('input[name="type_code"]');
    typeCodeInput.value = selectElement.value;
}
</script>




<style>
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

.form-inline {
    display: flex;
    align-items: center;
}

.form-inline select {
    margin-right: 5px;
}

.form-inline input[type="submit"] {
    margin-left: 5px;
    padding: 10px 20px; /* 버튼 크기 조정 */
    background-color: #6A24FE; /* 버튼 색상 */
    color: white;
    border: none;
    cursor: pointer;
    font-size: 16px; /* 폰트 크기 조정 */
    border-radius: 4px;
}

.form-inline input[type="submit"]:hover {
    background-color: #6A24FE;
}

</style>


<%@ include file="../footer_admin.jsp"%>