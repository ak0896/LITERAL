<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>

<!-- aeventlist.jsp -->

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
	<h3> 이벤트 목록 </h3>

	<c:choose>
	    <c:when test="${not empty sessionScope.member}">
	        <c:if test="${sessionScope.member.type_code eq 0}">
	            <p>
              		<button type="button" class="btn btn-newevent" onclick="location.href='/admin/aeventwrite'"> 이벤트 게시글 등록 </button>
	            </p>
	        </c:if>
           </c:when>
	</c:choose>
	
	<table>
		<thead>
			<tr>
				<th> 이벤트 코드 </th>
				<th> 이벤트 제목 </th>
				<th> 시작 날짜 </th>
				<th> 종료 날짜 </th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${adlist}" var="event">
			<input type="hidden" id="event_code" value="${event.event_code}">
				<c:if test="${event.event_code != null}">
					<tr>
					    <td>
							<a href="${pageContext.request.contextPath}/admin/aeventdetail/${event.event_code}">
								${event.event_code}
					    	</a>
					    </td>
						<td>${event.event_title}</td>
						<td>${event.start_date}</td>
						<td>${event.end_date}</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	</div> <!-- class="eventlist-main-content" end -->
<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->
<%@ include file="../footer.jsp"%>