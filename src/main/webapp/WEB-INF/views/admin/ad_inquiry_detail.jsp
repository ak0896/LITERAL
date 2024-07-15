<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>
<link rel="stylesheet" href="/css/notice.css">
<!-- notice_detail.jsp -->

 
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
	
<%@ include file="../footer.jsp"%>
