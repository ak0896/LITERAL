<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>
<link rel="stylesheet" href="/css/notice.css">

<!-- notice_detail.jsp -->

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
	<div class="container text-center">
	  	<div class="row">
	    <div class="col-sm-12">
	    	<form name="inquiry" id="inquiry" method="post" enctype="multipart/form-data" >
		    	<table class="table table-hover">
			    	<tbody style="text-align: left;">
						<tr>
							<th>문의 코드:</th>
							<td>${inquiry.inquiry_code}</td>
						</tr>
						<tr>
							<th>작성자:</th>
							<td>${inquiry.email}</td>
						</tr>
						<tr>
							<th>내용:</th>
							<td>${inquiry.inquiry_content}</td>
						</tr>
						<tr>
							<th>작성일:</th>
							<td>${inquiry.inquiry_date}</td>
						</tr>
					</tbody>
				</table>
	    	</form>
	    </div><!-- col end -->
	  	</div><!-- row end -->
	  	<div class="row"><!--답 쓰기 -->
     	<div class="col-sm-12">
			<form name="inquiry_update" id="inquiry_update" method="post" action="ad_inquiry_update">
				<input type="hidden" name="email" id="email" value="${inquiry.email}">
				<input type="hidden" name="inquiry_code" id="inquiry_code" value="${inquiry.inquiry_code}">
				<table class="table table-borderless">
					<tr>
						<th>답변:</th>
						<td>
							<input type="text" name="inquiry_answer" id="inquiry_answer" value="${inquiry.inquiry_answer}" placeholder="답변을 입력하세요" class="form-control" >
						</td>
						<td>
			 				<input type="submit"  class="btn btn-secondary" value="답변 등록">
						</td>
				
				</table>
		</form>
		<input type="button" value="목록으로" class="btn btn-warning" onclick="location.href='/admin/ad_inquiry_list'">
    </div><!-- col end -->
  </div><!-- row end -->
</div><!--  <div class="container text-center"> end -->

<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->	
	




	
	
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