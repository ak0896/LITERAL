<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../header.jsp"%>

<!-- eventdetail.jsp -->
<!-- 본문 시작 -->

<div class="eventlist-main-content">
	<h3> 이벤트 등록 </h3>
	<p>
		<button type="button" class="btn btn-newevent" onclick="location.href='${pageContext.request.contextPath}/event/eventlist'"> 이벤트 목록 </button>
	</p>	
	
    <form id="fmevent" name="fmevent" method="post" enctype="multipart/form-data">
        <input type="hidden" id="event_code" name="event_code" value="${event.event_code}">
        
        <table class="table-event">
            <tbody>
                <tr>
                    <td> 등록일 </td>
                    <td> ${event.event_date} </td>
                </tr>
                <tr>
                    <td> event_code </td>
                    <td> ${event.event_code} </td>
                </tr>
                <tr>
                    <td> 제목 </td>
                    <td>${event.event_title}</td>
                </tr>
                <tr>
                    <td> 시작 날짜 </td>
                    <td>${event.start_date}</td>
                </tr>
                <tr>
                    <td> 종료 날짜 </td>
                    <td>${event.end_date}</td>
                </tr>
                <tr>
                    <td> 상세 내용 </td>
                    <td>${event.event_content}</td>
                </tr>
                <tr>
                	<td>event_banner</td>
                	<td>${event.event_banner}</td>
                </tr>
                <tr>
                    <td> book_number </td>
                    <td> ${product.book_number} </td>
                </tr>
                <tr>
                    <td> 할인율 </td>
                    <td>${event.event_discount}</td>
                </tr>
                <tr>
                    <td> book_code </td>
                    <td> ${product.book_code} </td>
                </tr>
            </tbody>
        </table>
    </form>
</div> <!-- <div class="eventlist-main-content"> end -->

<!-- 본문 끝 -->
<%@ include file="../footer.jsp"%>
