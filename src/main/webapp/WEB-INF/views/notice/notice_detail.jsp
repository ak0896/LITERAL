<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- notice_detail.jsp -->

<!--사이드 메뉴 시작  -->
<div class="contents_inner">
    <div class="sidebar">
         <h2>공지사항</h2>
	        <ul>
	            <li><a href="/notice/notice_list">공지사항</a></li>
	            <li><a href="/notice/ask_list">자주 묻는 질문</a></li>
	        </ul>
    </div> <!-- <div class="sidebar"> end -->
 <!--사이드 메뉴 끝  -->
 
 <!-- 본문 시작 -->
	<div class="container text-center">
	  	<div class="row">
	    <div class="col-sm-12">
	    	<form name="notice_detail" id="notice_detail" method="post" enctype="multipart/form-data" >
		    	<table class="table table-hover">
			    	<tbody style="text-align: left;">
						<tr>
							<th>제목:</th>
							<td>${notice_detail.notice_title}</td>
						</tr>
						<tr>
							<th>작성자:</th>
							<td>${notice_detail.board_writer}</td>
						</tr>
						<tr>
							<th>내용:</th>
							<td>${notice_detail.notice_content}</td>
						</tr>
						<tr>
							<th>작성일</th>
							<td>${notice_detail.notice_date}</td>
						</tr>
					</tbody>
				</table>
				<input type="hidden" name="notice_code" value="${notice_detail.notice_code}">
				<input type="button" value="목록으로" class="btn btn-warning" onclick="location.href='/notice/notice_list'">
				<input type="button" value="글수정"   class="btn btn-success" onclick="location.href='/notice/notice_update?notice_code=${notice_detail.notice_code}'">
				<input type="button" value="삭제" class="btn btn-danger" onclick="notice_delete()">
	    	</form>
	    </div><!-- col end -->
	  	</div><!-- row end -->
	</div><!--  <div class="container text-center"> end -->
	
<script>
  	function notice_delete() {
  		if(confirm("첨부된 파일은 영구히 삭제됩니다\n진행할까요?")){
			document.notice_detail.action="/notice/notice_delete";
			document.notice_detail.submit();
		}//if end
  	}//product_delete() end  	
</script>

<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->
	
<%@ include file="../footer.jsp"%>
