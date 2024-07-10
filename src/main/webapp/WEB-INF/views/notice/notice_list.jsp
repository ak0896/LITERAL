<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- notice_list.jsp -->

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

<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->

<%@ include file="../footer.jsp"%>