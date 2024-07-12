<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- eventwrite.jsp -->

<!--사이드 메뉴 시작  -->
<!-- 본문 시작 -->

<div class="eventlist-main-content">
	<h3> 이벤트 등록 </h3>
	<form id="fmevent" name="fmevent" method="post" action="">
	<table class="table-event">
 	<tbody>
 		<tr>
 			<td> 제목 </td>
 			<td><input type="text" name="event_title" id="event_title" class="form-control"></td>
 		</tr>
 		<tr>
 			<td> 상세 내용 </td>
 			<textarea id="summernote" name="event_content" class="form-control">  </textarea>
 		</tr>
 	
 	
 	
 	
 	</tbody>
	</table>
	</form>
</div> <!-- <div class="eventlist-main-content"> end -->


<!-- Summernote관련  CSS/JS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
	
	
<script>
//summernote 작성부분
$(document).ready(function() {
    $('#summernote').summernote({
        placeholder: '상세 내용을 입력하세요',
        minHeight: 370,
        maxHeight: null,
        focus: true,
        lang: 'ko-KR'
    });
});
</script>

<!-- 본문 끝 -->
<%@ include file="../footer.jsp"%>