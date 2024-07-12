<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<link rel="stylesheet" href="/css/notice.css">

<!-- faq_write.jsp -->

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
	    	<p><h3>FAQ 등록</h3></p>
	    </div><!-- col end -->
	  	</div><!-- row end -->
	  
	  	<div class="row">
	    <div class="col-sm-12">
			<form name="faq_write" id="faq__write" method="post" action="faq_insert" onsubmit="return write_check()">
				<table class="table table-hover">
			    	<tbody style="text-align: left;">
						<tr>
							<th>제목:</th>
							<td><input type="text" name="faq_title" id="faq_title" class="form-control" required></td>
						</tr>
						<tr>
							<th>내용:</th>
							<td><input type="text" name="faq_answer" id="faq_answer" class="form-control"></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" value="등록하기" class="btn btn-warning">
			</form>
	    </div><!-- col end -->
		</div><!-- row end -->
	</div><!-- <div class="container text-center"> end -->

<script>
	function write_check(){
		//제목 입력
		let notice_title=$("#faq_title").val();
		notice_title=notice_title.trim();
		if(notice_title.length<4){
			alert("제목을 확인해주세요.");
			$("#notice_title").focus();
			return false;
		}
		
		//내용 입력
		let notice_content=$("#faq_answer").val();
		notice_content=notice_content.trim();
		if(notice_content.length<4){
			alert("내용을 확인해주세요.");
			$("#notice_content").focus();
			return false;
		}
	}
</script>

<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->

<%@ include file="../footer.jsp"%>
