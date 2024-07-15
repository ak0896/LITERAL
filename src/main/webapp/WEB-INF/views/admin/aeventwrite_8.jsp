<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>

<div class="contents_inner">
    <div class="eventlist-main-content">
        <h3> 책 월드컵 (8강) </h3>
        
        <form id="fmcup" name="fmcup" method="post" action="/admin/cupinsert" enctype="multipart/form-data">
            <input type="hidden" name="round" value="${round}">
            <c:forEach var="book" items="${books}">
                <input type="hidden" name="bookNumbers" value="${book.book_number}">
            </c:forEach>
            <button type="submit" class="btn btn-primary"> 등록 </button>
        </form>
        
        <c:if test="${not empty books}">
            <h3>선택된 책 목록</h3>
            <ul>
                <c:forEach var="book" items="${books}">
                    <li>${book.book_title} - ${book.book_number}</li>
                </c:forEach>
            </ul>
        </c:if>
    </div>
</div>

<%@ include file="../footer.jsp"%>
