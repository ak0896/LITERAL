<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- ad_reviewlist.jsp -->

<!--사이드 메뉴 시작  -->
<div class="contents_inner">
    <div class="sidebar">
        <h2> 리뷰 폼 </h2>
        <ul>
            <li><a href="#"> 전체 목록 </a></li>
            <li><a href="#"> 리뷰 결과 </a></li>
            <li><a href="#"> </a></li>
        </ul>
    </div> <!-- <div class="sidebar"> end -->
 <!--사이드 메뉴 끝  -->
 <!-- 본문 시작 -->
  
<div class="survey-container">
	<div class="survey-header">
	    <p>응답기간 : 2020.02.12(수) ~ 2020.02.26(수)</p>
	</div>
	
	<form action="/ad_reviewwrite" method="post">
		<div class="survey-section">
	        <label for="review_id"> 리뷰 ID </label>
			<p> ${review.review_id} </p>
	    </div>
	    <div class="survey-section">
	        <label for="email"> 판매자 </label>
	        <input type="text" id="email" name="email" required>
	    </div>
	    <div class="survey-section">
	        <label for="book_number">책 번호</label>
	        <input type="text" id="book_number" name="book_number" required>
	    </div>
	    <div class="survey-section">
	        <label for="rating">평점</label>
			<p> rating </p>
		</div>
	    <div class="survey-footer">
	        <input type="submit" value=등록하기>
	    </div>
	</form>
       
</div> <!-- <div class="survey-container"> end -->

<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->
<%@ include file="../footer.jsp"%>