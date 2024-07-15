<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../header.jsp"%>

<!-- cup_result.jsp -->

<!-- 본문 시작 -->
<div class="contents_inner">
    <h3> 책 월드컵 결과 </h3>
	
	<form id="resultForm" name="resultForm" method="post" action="${pageContext.request.contextPath}/admin/insertResult">
	    <input type="hidden" name="book_code" value="${winner.book_code}">
	    <input type="hidden" name="book_title" value="${winner.book_title}">
	    
	    <div class="winner-item">
	        <h4>우승 책: ${winner.book_title}</h4>
	    </div>
	    
	    <button type="submit" class="btn btn-primary"> 확인 </button>
    </form>
    
</div> <!-- <div class="contents_inner"> end -->
<!-- 본문 끝 -->
<%@ include file="../footer.jsp"%>