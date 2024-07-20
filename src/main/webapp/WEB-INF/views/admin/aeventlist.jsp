<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>


<!-- aeventlist.jsp -->


<div class="contents_inner">
    <div class="sidebar">
        <h2> 이 벤 트 </h2>
        <ul>
            <li><a href="/admin/acup_write"> 책 월드컵 </a></li>
            <li><a href="/admin/aeventwrite"> 이달의 작가 </a></li>
        </ul>
    </div>
    <!-- 본문 시작 -->
    <div class="eventlist-main-content">
     <h3> 이벤트 목록 </h3>

    <h4>이달의 작가</h4>
    <table>
        <thead>
            <tr>
                <th> 코드 </th>
                <th> 제목 </th>
                <th> 시작 날짜 </th>
                <th> 종료 날짜 </th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${aevent_list}" var="event">
                <tr>
                    <td><a href="${pageContext.request.contextPath}/admin/aeventdetail/${event.event_code}">${event.event_code}</a></td>
                    <td>${event.event_title}</td>
                    <td>${event.start_date}</td>
                    <td>${event.end_date}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <h4>책 월드컵</h4>
    <table>
        <thead>
            <tr>
                <th> 코드 </th>
                <th> 제목 </th>
                <th> 시작 날짜 </th>
                <th> 종료 날짜 </th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${acup_list}" var="cup">
                <tr>
                    <td><a href="${pageContext.request.contextPath}/admin/acup_detail/${cup.worldcup_code}">${cup.worldcup_code}</a></td>
                    <td>${cup.wc_title}</td>
                    <td>${cup.cupstart_date}</td>
                    <td>${cup.cupend_date}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div>
    <!-- 본문 끝 -->
</div>
<%@ include file="../footer.jsp"%>
