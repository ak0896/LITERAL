<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- ad_reviewwrite.jsp -->

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
	
	<form action="submit_survey" method="post">
	    <div class="survey-section">
	        <label for="email">이메일</label>
	        <input type="text" id="email" name="email" required>
	    </div>
	    <div class="survey-section">
	        <label for="book_number">책 번호</label>
	        <input type="text" id="book_number" name="book_number" required>
	    </div>
	    <div class="survey-section">
	        <label for="rating">평점</label>
	        <select id="rating" name="rating" required>
	            <option value="1">1점</option>
	            <option value="2">2점</option>
	            <option value="3">3점</option>
	            <option value="4">4점</option>
	            <option value="5">5점</option>
	        </select>
	    </div>
	    <div class="survey-section">
	        <label for="delivery_condition">배송/포장 상태</label>
	        <select id="delivery_condition" name="delivery_condition">
	        	<option value="5"> 매우 좋다 </option>
	        	<option value="4"> 좋다 </option>
	        	<option value="3"> 보통 </option>
	        	<option value="2"> 좋지 않다 </option>
	        	<option value="1"> 매우 좋지 않다 </option>
	        </select>
	    </div>
	    <div class="survey-section">
	        <label for="book_condition">책 상태</label>
	        <select id="book_condition" name="book_condition">
	        	<option value="5"> 매우 좋다 </option>
	        	<option value="4"> 좋다 </option>
	        	<option value="3"> 보통 </option>
	        	<option value="2"> 좋지 않다 </option>
	        	<option value="1"> 매우 좋지 않다 </option>
	        </select>
	    </div>
	    <div class="survey-section">
	        <label for="price_appropriateness">가격 적정성</label>
	        <select id="price_appropriateness" name="price_appropriateness">
	        	<option value="5"> 매우 좋다 </option>
	        	<option value="4"> 좋다 </option>
	        	<option value="3"> 보통 </option>
	        	<option value="2"> 좋지 않다 </option>
	        	<option value="1"> 매우 좋지 않다 </option>
	        </select>
	    </div>
	    <div class="survey-section">
	        <label for="seller_question">판매자 질문</label>
	        <textarea id="seller_question" name="seller_question" rows="4" required></textarea>
	    </div>
	    <div class="survey-section">
	        <label for="review">리뷰</label>
	        <textarea id="review" name="review" rows="4" required></textarea>
	    </div>
	    <div class="survey-footer">
	        <input type="submit" value="확인">
	    </div>
	</form>
       
</div> <!-- <div class="survey-container"> end -->

<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->
<%@ include file="../footer.jsp"%>