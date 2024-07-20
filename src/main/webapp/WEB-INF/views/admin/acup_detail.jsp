<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>

<!-- acup_write.jsp -->
<!--사이드 메뉴 시작  -->
<div class="contents_inner">
    <div class="sidebar">
        <h2> 이 벤 트 </h2>
        <ul>
            <li><a href="/admin/acup_write"> 책 월드컵 </a></li>
            <li><a href="/admin/aeventwrite"> 이달의 작가 </a></li>
        </ul>
    </div> <!-- <div class="sidebar"> end -->
<!--사이드 메뉴 끝  -->

<!-- 본문 시작 -->

	<div class="eventlist-main-content">
		<h3> 책 월드컵 </h3>
		
		<form id="startWorldCupForm" name="startWorldCupForm" method="post" action="cup_insert" enctype="multipart/form-data">
			
        <table class="table-cup">
        <tbody>
            <tr>
                <td> 제목 </td>
                <td><input type="text" value="${event.wc_title}" name="wc_title" id="wc_title" class="form-control"></td>
            </tr>
            <tr>
                <td> 장르 </td>
                <td>
					<select name="genre_code" id="genre_code" class="form-control">
					    <option value="G" ${product.genre_code == 'G' ? 'selected' : ''}> 고전 </option>
					    <option value="M" ${product.genre_code == 'M' ? 'selected' : ''}> 공포 / 미스테리 </option>
					    <option value="H" ${product.genre_code == 'H' ? 'selected' : ''}> 역사 </option>
					    <option value="S" ${product.genre_code == 'S' ? 'selected' : ''}> 판타지 / 과학 </option>
					    <option value="R" ${product.genre_code == 'R' ? 'selected' : ''}> 로맨스 </option>
					    <option value="P" ${product.genre_code == 'P' ? 'selected' : ''}> 무협 </option>
					    <option value="T" ${product.genre_code == 'T' ? 'selected' : ''}> 청소년 </option>
					    <option value="W" ${product.genre_code == 'W' ? 'selected' : ''}> 웹 / 드라마 / 영화 </option>                 
					</select>
                </td>
            </tr>
	 		<tr>
	 			<td> 시작 날짜 </td>
	 			<td><input type="date" value="${event.cupstart_date}" name="cupstart_date" id="cupstart_date" class="form-control"></td>
	 		</tr>
	 		<tr>
	 			<td> 종료 날짜 </td>
	 			<td><input type="date" value="${event.cupend_date}" name="cupend_date" id="cupend_date" class="form-control"></td>
	 		</tr>
	 		<tr>
	 			<td> 할인율 </td>
	 			<td><input type="text" value="${event.wc_discount}" name="wc_discount" id="wc_discount" class="form-control"></td>
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

        
	</div> <!-- <div class="eventlist-main-content"> end -->

<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->
<%@ include file="../footer.jsp"%>