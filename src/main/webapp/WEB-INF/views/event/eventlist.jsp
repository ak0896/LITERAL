<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- eventlist.jsp -->

<!--사이드 메뉴 시작  -->
<div class="contents_inner">
 <!-- 본문 시작 -->
 	
	<div class="main-content">
		<div class="row">
			<div class="col-sm-12">
			<h3 class="productlist text-center"> [이벤트 목록] </h3>
			
			<c:choose>
			    <c:when test="${not empty sessionScope.member}">
			        <c:if test="${sessionScope.member.type_code eq 0}">
			            <p>
			                <button type="button" class="btn btn-newproduct" onclick="location.href='eventwrite'"> 이벤트 등록 </button>
			            </p>
			        </c:if>
	            </c:when>
			</c:choose>

			</div>
  		</div> <!-- row end -->
	  
	  	<div class="row">
		<c:forEach items="${list}" var="row" varStatus="vs">
			<div class="col-sm-4 col-md-4">
				<a href="eventdetail/${row.event_code}">
					<img src="/storage/images/${row.img}" class="img-responsive margin" style="width:100px">
				</a>
				<br> <br>
					<a href="eventdetail/${row.event_code}"> 
					 ${row.start_date} ~ ${row.end_date} 
					</a>
				<br>
				
				<!-- 한줄에 3칸씩 -->
				<c:if test="${vs.count mod 3 == 0}">
				</div><!-- row end -->
					<div style="height: 50px;"> </div>
	  				<div class="row">
				</c:if>
				
			</div>
		</c:forEach>
	  </div><!-- row end -->
  	
	</div> <!-- <div class="main-content"> end -->
	
<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->
	
<%@ include file="../footer.jsp"%>