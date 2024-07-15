<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- eventlist.jsp -->

 <!-- 본문 시작 -->
 	
	<div class="main-content">
		<div class="row">
			<div class="col-sm-12">
			<h3 class="eventlit text-center"> [이벤트 목록] </h3>

			</div>
  		</div> <!-- row end -->
	  
	  	<div class="row">
		<c:forEach items="${list}" var="row" varStatus="vs">
		<input type="hidden" id="event_code" value="${event.event_code}">
		    <div class="col-sm-4 col-md-4">
		        <a href="${pageContext.request.contextPath}/event/eventdetail/${row.event_code}">
               	 	<img src="${pageContext.request.contextPath}/storage/eventImages/${row.event_banner}" alt="Event Banner" style="width: 300px;">
		        </a>
		        <br><br>
		        <a href="${pageContext.request.contextPath}/event/eventdetail/${row.event_code}"> 
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
	
<%@ include file="../footer.jsp"%>