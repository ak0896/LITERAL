<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
 
<link rel="stylesheet" href="/css/notice.css">
 
<!-- faq_list.jsp --> 

<!--사이드 메뉴 시작  -->
<div class="contents_inner">
    <div class="sidebar">
        <h2>공지사항</h2>
        <ul>
            <li><a href="/notice/notice_list">공지사항</a></li>
            <li><a href="/notice/faq_list">자주 묻는 질문</a></li>
        </ul>
    </div> <!-- <div class="sidebar"> end -->
  <!--사이드 메뉴 끝  -->
  
  <!-- 본문 시작 -->
    <div class="container">
    <h1>자주 묻는 질문</h1>
    <c:forEach var="faq" items="${faq_list}">
        <div class="faq-item">
        	<div class="faq-title">
	        	 <span>${faq.faq_title}</span>
	             <button onclick="location.href='/notice/faq_update?faq_code=${faq.faq_code}'">수정</button>
	             <form action="faq_delete" method="post">
                    <input type="hidden" name="faq_code" value="${faq.faq_code}">
                    <button type="submit">삭제</button>
                </form>
            </div> <!-- <div class="faq-title"> end -->
            <div class="faq-answer">${faq.faq_answer}</div>
        </div> <!-- <div class="faq-item"> end -->
    </c:forEach>
    <input type="button" value="FAQ 등록" onclick="location.href='faq_write'">
	</div> <!-- <div class="container"> end -->
	
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script>
    	$(document).ready(function(){
        $('.faq-title').click(function(){
            $(this).next('.faq-answer').slideToggle();
        });
    });
</script>

<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->

<%@ include file="../footer.jsp"%>
