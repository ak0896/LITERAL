<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../header_admin.jsp"%>

<!-- acup_result.jsp -->

<!--사이드 메뉴 시작  -->
<div class="contents_inner">
    <div class="sidebar">
        <h2> 이 벤 트 </h2>
        <ul>
            <li><a href="/admin/acuplist"> 책 월드컵 </a></li>
            <li><a href="/admin/aresultlist"> 책 월드컵 결과 </a></li>
            <li><a href="#"> 이달의 작가 </a></li>
        </ul>
    </div> <!-- <div class="sidebar"> end -->
<!--사이드 메뉴 끝  -->
 
<!-- 본문 시작 -->
	<div class="eventlist-main-content">
	<h3> 책 월드컵 결과 </h3>

	<table>
		<thead>
			<tr>
				<th> 결과 코드 </th>
				<th> 월드컵 코드 </th>
				<th> 이메일 </th>
				<th> 책 코드 </th>
				<th> 날짜 </th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${acuplist}" var="row">
			<input type="hidden" id="worldcup_code" value="${book_worldcup.worldcup_code}">
				<c:if test="${book_worldcup.worldcup_code != null}">
					<tr>
					    <td>
							<a href="${pageContext.request.contextPath}/admin/aeventdetail/${event.event_code}">
								${row.re_code}
					    	</a>
					    </td>
						<td>${row.worldcup_code}</td>
						<td>${row.email}</td>
						<td>${row.book_code}</td>
						<td>${row.cup_date}</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	</div> <!-- class="eventlist-main-content" end -->
	
</div> <!-- <div class="contents_inner"> end -->
<!-- 본문 끝 -->
<%@ include file="../footer.jsp"%>