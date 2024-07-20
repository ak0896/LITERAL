<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>

<!-- aeventwrite.jsp -->
<!--사이드 메뉴 시작  -->
<div class="contents_inner">
    <div class="sidebar">
        <h2> 이 벤 트 </h2>
        <ul>
       		<li><a href="/admin/aeventlist"> 전체 목록 </a></li>
            <li><a href="/admin/acup_list"> 책 월드컵 </a></li>
            <li><a href="/admin/aeventwrite"> 이달의 작가 </a></li>
        </ul>
    </div> <!-- <div class="sidebar"> end -->
<!--사이드 메뉴 끝  -->

<!-- 본문 시작 -->

	<div class="eventlist-main-content">
		<h3> 이벤트 등록 </h3>
		
		<form id="fmevent" name="fmevent" method="post" action="aevent_insert" enctype="multipart/form-data">

		<table class="table-event">
	 	<tbody>
	 		<tr>
	 			<td> 제목 </td>
	 			<td><input type="text" name="event_title" id="event_title" class="form-control"></td>
	 		</tr>
	 		<tr>
	 			<td> 시작 날짜 </td>
	 			<td><input type="date" name="start_date" id="start_date" class="form-control"></td>
	 		</tr>
	 		<tr>
	 			<td> 종료 날짜 </td>
	 			<td><input type="date" name="end_date" id="end_date" class="form-control"></td>
	 		</tr>
			<tr>
	 			<td> 상세 내용 </td> 				
	 			<textarea id="summernote" name="event_content" class="form-control">  </textarea>
	 		</tr>
	 					<input type="hidden" name="event_banner" id="event_banner">
	 		<tr>
	 			<td> 책 코드 </td>
	 			<td><input type="text" name="book_code" id="book_code" class="form-control"></td>
	 		</tr>
	 		<tr>
	 			<td> 할인율 </td>
	 			<td><input type="text" name="event_discount" id="event_discount" class="form-control"></td>
	 		</tr>
	 		<button type="submit" class="btn btn-primary"> 등록 </button>
	        <button type="button" class="btn btn-primary" onclick="javascript:history.back()"> 취소 </button>
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
	        minHeight: 370,					 // 최소 높이 설정
	        maxHeight: null,				 // 최대 높이 설정 
	        focus: true,					 // 에디터 로딩 후 포커스를 자동으로 맞출지 여부
	        lang: 'ko-KR',					 // 에디터 언어를 한국어로 설정
	        callbacks: {			         // 이미지 업로드시에 호출됩니다.
	            onImageUpload: function(files) 
	            {
	                for (var i = 0; i < files.length; i++) 
	                {
	                    uploadFile(files[i], this);
	              } // for end
	            }, // onImageUpload end
	          }, // callbacks: {} end
	        }) // $('#summernote').summernote end
	}); // ready(function() end
	      
	// 이미지 저장
	function uploadFile(file) {
	    var formData = new FormData();
	    formData.append('file', file); // 'file' 파라미터 이름 확인
	    
	    $.ajax({
	        data: formData, // 전송할 데이터
	        type: "POST", // HTTP 요청 방식
	        url: '${pageContext.request.contextPath}/admin/uploadFile', // 서버의 URL
	        cache: false, // 캐시 안씀
	        contentType: false, // contentType 설정 안 함 (자동으로 multipart/form-data로 설정됨)
	        processData: false, // data를 쿼리 문자열로 변환하지 않음
	        success: function(data) { // 성공적으로 요청이 완료되었을 때 실행
	            if (data.responseCode === 'success') {
	                var imageUrl = data.url;
	                var bannerFileName = data.url.split('/').pop();
	                
	                $('#summernote').summernote('insertImage', imageUrl); // 이미지 URL을 에디터에 삽입
	                $('#event_banner').val(bannerFileName); // 이미지 파일명을 hidden input에 저장

	                // hidden input 값 확인
	                console.log("Hidden Input Event Banner: " + $('#event_banner').val());
	            } else {
	                alert('이미지 업로드에 실패했습니다.');
	            }
	        }, // success: function(data) end
	        error: function(jqXHR, textStatus, errorThrown) {
	            console.error('Error: ' + textStatus + ' ' + errorThrown);
	            alert('이미지 업로드 중 오류가 발생했습니다.');
	        }
	    }); // $.ajax end
	} // function sendFile(file, el) end
	</script>


<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->
<%@ include file="../footer.jsp"%>