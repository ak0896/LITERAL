<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>
<link rel="stylesheet" href="/css/notice.css">
<!-- notice_list.jsp -->

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
		<input type="button" value="공지사항 등록" onclick="location.href='notice_write'">
		<hr>
		<form name="list" id="list" method="post" >
			<table>
				<thead>
					<th>제목</th>
					<th>작성자</th> 
					<th>작성 날짜</th>
					<th>조회수</th>
				</thead>
				<tbody>
					<c:forEach items="${noticeList}" var="notice">
						<tr>
							<td><a href="notice_detail?notice_code=${notice.notice_code}">${notice.notice_title}</a></td>
							<%-- <a href="detail?product_code=${notice.PRODUCT_CODE}">${notice.PRODUCT_NAME}</a> --%>
							<td>${notice.board_writer}</td>
							<td>${notice.notice_date}</td>
							<td>${notice.view_count}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>
	</div><!-- col end -->
	</div><!-- row end -->
	
	<div class="row">
    <div class="col-sm-12">
        <ul class="pagination">
            <c:forEach begin="1" end="${totalpage}" var="i">
                <li class="${currentpage == i ? 'active' : ''}">
                    <a href="?page=${i}">${i}</a>
                </li>
            </c:forEach>
        </ul>
    </div><!-- col end -->
  </div><!-- row end -->
</div><!-- container end -->

<script>
	function admin_button(){
		
	}
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




<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->

<%@ include file="../footer_admin.jsp"%>