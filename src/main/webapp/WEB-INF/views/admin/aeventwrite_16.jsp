<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>

<!-- aeventwrite_16.jsp -->
<!--사이드 메뉴 시작  -->
<div class="contents_inner">
    <div class="sidebar">
        <h2> 이 벤 트 </h2>
        <ul>
            <li><a href="/admin/acuplist"> 책 월드컵 </a></li>
            <li><a href="/admin/aresultlist"> 책 월드컵 결과 </a></li>
            <li><a href="#"> 이달의 작가 </a></li>
        </ul>
    </div> <!-- <div class="sidebar"> end -->
<!--사이드 메뉴 끝  -->

<!-- 본문 시작 -->

	<div class="eventlist-main-content">
		<h3> 책 월드컵 (16강) </h3>
		
		<form id="fmcup" name="fmcup" method="post" action="/cupinsert" enctype="multipart/form-data">
        <table class="table-cup">
        <tbody>
            <tr>
                <td> 제목 </td>
                <td><input type="text" name="wc_title" id="wc_title" class="form-control"></td>
            </tr>
            <tr>
                <td> 장르 </td>
                <td>
                    <select name="genre_code" id="genre_code" class="form-control">
                        <option value="G"> 고전 </option>
                        <option value="M"> 공포 / 미스테리 </option>
                        <option value="H"> 역사 </option>
                        <option value="S"> 판타지 / 과학 </option>
                        <option value="R"> 로맨스 </option>
                        <option value="P"> 무협 </option>
                        <option value="T"> 청소년 </option>
                        <option value="W"> 웹 / 드라마 / 영화 </option>                    
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="submit" class="btn btn-primary"> 등록 </button>
                    <button type="button" class="btn btn-primary" onclick="javascript:history.back()"> 취소 </button>
                </td>
            </tr>
        </tbody>
        </table>
        </form>
        
        <c:if test="${not empty books}">
            <h3>선택된 책 목록</h3>
            <ul>
                <c:forEach var="book" items="${books}">
                <input type="hidden" name="bookNumbers[]" value="${book.book_number}">
                    <li>${book.book_title}</li>
                </c:forEach>
            </ul>
        </c:if>
                
	</div> <!-- <div class="eventlist-main-content"> end -->
	
<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->
<%@ include file="../footer.jsp"%>