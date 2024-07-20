<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../header.jsp"%>

<!-- cup_detail.jsp -->
<!-- 본문 시작 -->

<div class="eventlist-main-content">
	<h3> 이벤트 등록 </h3>

	
    <form id="fmevent" name="fmevent" method="post" action="" enctype="multipart/form-data">
        <input type="hidden" id=" worldcup_code" name=" worldcup_code" value="${event. worldcup_code}">
        
        <table class="table-event">
            <tbody>
                <tr>
                    <td> worldcup_code </td>
                    <td> ${event.worldcup_code} </td>
                </tr>
                <tr>
                    <td> 제목 </td>
                    <td>${event.wc_title}</td>
                </tr>
                <tr>
                    <td> 시작 날짜 </td>
                    <td>${event.cupstart_date}</td>
                </tr>
                <tr>
                    <td> 종료 날짜 </td>
                    <td>${event.cupend_date}</td>
                </tr>
                <tr>
                    <td> 장르 </td>
                    <td> ${event.genre_code} </td>
                </tr>                
                <tr>
                    <td> 라운드 </td>
                    <td> ${event.round} </td>
                </tr>
                <tr>
                    <td> 내용 </td>
                    <td> ${event.wc_content} </td>
                </tr>
                <tr>
                    <td> 월드컵이벤트 할인율 </td>
                    <td> ${event.wc_discount} </td>
                </tr>
                <tr>
                    <td> 작성 날짜 </td>
                    <td> ${event.wcevent_date} </td>
                </tr>
                <tr>
                    <td> book_number </td>
                    <td> ${event.book_number} </td>
                </tr>                                                                   
                <tr>
                    <td> book_code </td>
                    <td> ${event.book_code} </td>
                </tr>
                
                <button type="button" class="btn btn-primary"> 이벤트로 이동하기 </button>
            </tbody>
        </table>
    </form>
</div> <!-- <div class="eventlist-main-content"> end -->

<!-- 본문 끝 -->
<%@ include file="../footer.jsp"%>
