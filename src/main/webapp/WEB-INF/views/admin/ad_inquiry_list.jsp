<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>
<link rel="stylesheet" href="/css/notice.css">
<!-- notice_list.jsp -->

 
 <!-- 본문 시작 -->
<div class="container text-center">
	<div class="row">
	<div class="col-sm-12">
		<form name="list" id="list" method="post" >
			<table>
				<thead>
					<th>문의 코드</th>
					<th>작성자</th> 
					<th>작성 날짜</th>
				</thead>
				<tbody>
					<c:forEach items="${ad_inquiry}" var="inquiry">
						<tr>
							<td><a href="ad_inquiry_detail?inquiry_code=${inquiry.inquiry_code}">${inquiry.inquiry_code}</a></td>
							<%-- <a href="detail?product_code=${notice.PRODUCT_CODE}">${notice.PRODUCT_NAME}</a> --%>
							<td>${inquiry.email}</td>
							<td>${inquiry.inquiry_date}</td>
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