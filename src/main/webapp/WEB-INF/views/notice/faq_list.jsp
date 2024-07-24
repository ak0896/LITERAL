<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">
 
   <!--사이드 메뉴 시작  -->
<div class="contents_inner">
	<div class="sidebar">
	    <ul class="nav nav-pills nav-stacked">
	        <li><a href="${pageContext.request.contextPath}/admin">열람실 관리</a></li>
	        <li><a href="${pageContext.request.contextPath}/admin/memberList">회원정보 관리</a></li>
	        <li><a href="${pageContext.request.contextPath}/admin/productlist_admin">상품 관리</a></li>
	        <li><a href="${pageContext.request.contextPath}/admin/branchList">지점 관리</a></li>
	        <li>
	        	<a href="#branchSubMenu" data-toggle="collapse" aria-expanded="false">공지사항 관리 <span class="caret"></span></a>
		        <ul class="nav nav-pills nav-stacked collapse" id="branchSubMenu">
		            <li><a href="${pageContext.request.contextPath}/notice/notice_list">공지사항</a></li>
		            <li><a href="${pageContext.request.contextPath}/notice/faq_list">자주 묻는 질문</a></li>
		        </ul>
	        <li><a href="${pageContext.request.contextPath}/admin/ad_inquiry_list">1:1문의 관리</a></li>
	    </ul>
	</div><!-- <div class="sidebar">  end-->
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
    </div>
    <div class="faq-answer">${faq.faq_answer}</div>
</div>
    </c:forEach>
    <input type="button" value="FAQ 등록" onclick="location.href='faq_write'">



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



<style>
/* sidebar속에 li 스타일 */

.sidebar {
    padding: 20px 0;
    width: 200px; /* 사이드바의 너비 설정 */
}
.sidebar .nav-pills > li {
    width: 100%; /* 각 항목이 전체 너비를 차지하도록 설정 */
}
.sidebar .nav-pills > li > a {
    border-radius: 0;
    white-space: nowrap; /* 텍스트가 한 줄로 유지되도록 설정 */
    overflow: hidden; /* 너비를 넘어가는 텍스트 숨김 */
    text-overflow: ellipsis; /* 너비를 넘어가는 텍스트에 '...' 추가 */
    padding-left: 20px; 
}
.sidebar .nav-pills > li > ul > li > a {
    padding-left: 40px;
}

</style>



<%@ include file="../footer_admin.jsp"%>