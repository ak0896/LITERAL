<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>

<!-- acup_list.jsp -->

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

	<div class="cuplist-main-content">
		<h3> 책 월드컵 </h3>
		
		<form id="startWorldCupForm" name="startWorldCupForm" method="post" action="/admin/acup_insert" enctype="multipart/form-data">
			<input type="hidden" name="round" value="${round}">
			
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
	 			<td> 시작 날짜 </td>
	 			<td><input type="date" name="start_date" id="cupstart_date" class="form-control"></td>
	 		</tr>
	 		<tr>
	 			<td> 종료 날짜 </td>
	 			<td><input type="date" name="end_date" id="cupend_date" class="form-control"></td>
	 		</tr>                       
			<tr>
				<c:choose>
				    <c:when test="${not empty sessionScope.member}">
				        <c:if test="${sessionScope.member.type_code eq 0}">
				            <p>
			                    <a href="" class="btn btn-newevent"> 등록 </a>
				            </p>            
				        </c:if>
			           </c:when>
				</c:choose>
			</tr>
        </tbody>
        </table>
        </form>        
	</div> <!-- <div class="cuplist-main-content"> -->
	
	<div>
	<h2>등록된 월드컵 목록</h2>
	
	<table>
		<thead>
			<tr>
				<th> 월드컵 코드 </th>
				<th> 제목 </th>
				<th> 장르 </th>
				<th> 시작 날짜 </th>
				<th> 종료 날짜 </th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${acuplist}" var="row">
			<input type="hidden" id="worldcup_code" value="${book_worldcup.worldcup_code}">
				<c:if test="${book_worldcup.worldcup_code != null}">
					<tr>
					    <td>
							<a href="${pageContext.request.contextPath}/admin/aeventdetail/${event.event_code}">
								${row.worldcup_code}
					    	</a>
					    </td>
						<td>${row.event_title}</td>
						<td>${row.genre_code}</td>						
						<td>${row.cupstart_date}</td>
						<td>${row.cupend_date}</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	</div>
	
</div> <!-- class="eventlist-main-content" end -->

<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->
<%@ include file="../footer.jsp"%>