<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">
 
<!--사이드 메뉴 시작  -->
<div class="contents_inner">
    <div class="sidebar">
        <h2>공지사항</h2>
	        <ul>
	            <li><a href="/notice/notice_list2">공지사항</a></li>
	            <li><a href="/notice/faq_list2">자주 묻는 질문</a></li>
	        </ul>
    </div>
  <!--사이드 메뉴 끝  -->
 <!-- 본문 시작 -->
    <div class="container">
    <h1>자주 묻는 질문</h1>
    <c:forEach var="faq" items="${faq_list}">
       <div class="faq-item">
    <div class="faq-title">${faq.faq_title}</div>
    <div class="faq-answer">${faq.faq_answer}</div>
</div>
    </c:forEach>
<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->

<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script>
    $(document).ready(function(){
        console.log('jQuery Loaded: ', !!window.jQuery); // jQuery가 로드되었는지 확인
        $('.faq-title').click(function(){
            $(this).next('.faq-answer').slideToggle();
        });
    });
</script>


</script>

<%@ include file="../footer.jsp"%>