<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>

<!-- memberList.jsp -->

<!-- 본문 시작 -->
<div class="main-content">
	
	<h1>회원 목록</h1>
	<table border="1">
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
                        <form action="${pageContext.request.contextPath}/admin/updateMemberType" method="post">
                            <input type="hidden" name="email" value="${member.email}">
                            <select name="type_code">
                                <option value="1" <c:if test="${member.type_code == 1}">selected</c:if>>일반회원</option>
                                <option value="2" <c:if test="${member.type_code == 2}">selected</c:if>>판매자</option>
                            </select>
                            <input type="submit" value="수정">
                        </form>
                    </td>
                    <td>
                        <form action="${pageContext.request.contextPath}/admin/deleteMember" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
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
<!-- 본문 끝 -->

<%@ include file="../footer.jsp"%>