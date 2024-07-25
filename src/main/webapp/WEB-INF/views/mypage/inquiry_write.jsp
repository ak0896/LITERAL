<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<link rel="stylesheet" href="/css/notice.css">
<!-- notice_write.jsp -->

<!--사이드 메뉴 시작  -->
<div class="contents_inner">
    <div class="sidebar">
     <h2>마이페이지</h2>
		<ul>
			<li><a href="${pageContext.request.contextPath}/member/editMember?email=${sessionScope.member.email}" class="button">회원정보수정/삭제</a></li>
			<li><a href="inquiry_list?email=${sessionScope.member.email}">1:1문의</a></li>
		</ul>
    </div> <!-- <div class="sidebar"> end -->
 <!--사이드 메뉴 끝  -->
 
 <!-- 본문 시작 -->
	<div class="container text-center">
		<div class="row">
	    <div class="col-sm-12">
	    	<p><h3>1:1문의 등록</h3></p>
	    </div><!-- col end -->
	  	</div><!-- row end -->
	  
	  	<div class="row">
	    <div class="col-sm-12">
			<form name="inquiry_write" id="inquiry_write" method="post" action="inquiry_insert" onsubmit="return write_check()">
				<input type="hidden" name="email" id="email" value="${sessionScope.member.email}">
				<table class="table table-hover">
			    	<tbody style="text-align: left;">
						<tr>
							<th>문의 내용:</th>
							<td><input type="text" name="inquiry_content" id="inquiry_content" class="form-control" required></td>
						</tr>
						<tr>
							<th>작성자:</th>
							<td>${sessionScope.member.email}</td>
						</tr>
					</tbody>
				</table>
				<input type="submit" value="문의 하기" class="btn btn-warning">
			</form>
	    </div><!-- col end -->
		</div><!-- row end -->
	</div><!-- class="container text-center" end -->

<script>
	function write_check(){
		let inquiry_content = $("#inquiry_content").val().trim();
		if (inquiry_content.length < 4) {
			alert("내용을 확인해주세요.");
			$("#inquiry_content").focus();
			return false;
		} else {
			return confirm("문의를 등록하시겠습니까?");
		}
	}
</script>

<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->

<%@ include file="../footer.jsp"%>
