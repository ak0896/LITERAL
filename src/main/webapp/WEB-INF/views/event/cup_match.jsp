<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../header.jsp"%>

<!-- cup_match.jsp -->

<!-- 본문 시작 -->
<div class="contents_inner">
    <h3> 책 월드컵 매치 (${round}강) </h3>

    <form id="voteForm" name="voteForm" method="post" action="${pageContext.request.contextPath}/admin/vote">
        <input type="hidden" name="round" value="${round}">
        
        <c:forEach var="book" items="${books}">   
            <div class="match-item">
                <h4>${book.book_title}</h4>
                <!-- 매치 투표 버튼 등을 추가 -->
                <button type="submit" class="btn btn-primary" name="selected_book" value="${book.book_number}"> 선택하기 </button>
            </div>
        </c:forEach>
    </form>
    
</div> <!-- <div class="contents_inner"> end -->
<!-- 본문 끝 -->
<%@ include file="../footer.jsp"%>