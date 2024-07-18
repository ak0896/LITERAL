<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>

<!-- acuplist.jsp -->

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
	<h3> 책 월드컵 </h3>

	<c:choose>
	    <c:when test="${not empty sessionScope.member}">
	        <c:if test="${sessionScope.member.type_code eq 0}">
	            <p>
              		<button type="button" class="btn btn-newevent" data-toggle="modal" data-target="#roundSelectModal"> 책 월드컵 등록 </button>
	            </p>            
	        </c:if>
           </c:when>
	</c:choose>
	
	<table>
		<thead>
			<tr>
				<th> 월드컵 코드 </th>
				<th> 라운드 </th>
				<th> 제목 </th>
				<th> 장르 코드 </th>
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
						<td>${row.start_date}</td>
						<td>${row.end_date}</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	</div> <!-- class="eventlist-main-content" end -->
	
<!-- 라운드 선택 모달 -->
<div class="modal fade" id="roundSelectModal" tabindex="-1" role="dialog" aria-labelledby="roundSelectModalLabel" aria-hidden="true">
    <!-- 모달 대화상자 시작 -->
    <div class="modal-dialog" role="document">
        <div class="modal-content">
        	<!-- 모달 헤더 시작 -->
            <div class="modal-header">
                <h5 class="modal-title" id="roundSelectModalLabel">라운드 선택</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <!-- 모달 창 닫기 -->
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <!-- 모달 헤더 끝 -->
            
            <!-- 모달 본문 시작 -->
            <div class="modal-body">
           		 <!-- 라운드를 선택할 수 있는 폼 시작 -->
                <form id="selectRoundForm" name="selectRoundForm" method="get" action="${pageContext.request.contextPath}/admin/createWorldCup" onsubmit="return logRoundValue()">
                    <!-- 폼 그룹 시작 -->
                    <div class="form-group">
                        <label for="round">라운드를 선택하세요:</label>
                        <!-- 라운드를 선택할 수 있는 드롭다운 메뉴 -->
                        <select name="round" id="round" class="form-control">
                            <option value="8"> 8강 </option>
                            <option value="16"> 16강 </option>
                            <option value="32"> 32강 </option>
                        </select>
                    </div>
                     <!-- 폼 그룹 끝 -->
                     
                     <!-- 폼 제출 버튼 -->
                    <button type="submit" class="btn btn-primary">확인</button>
                </form> <!-- 라운드를 선택할 수 있는 폼 끝 -->
            </div>  <!-- 모달 본문 끝 -->
        </div>
    </div> <!-- 모달 대화상자 끝 -->
</div>

<script>
function logRoundValue() {
    var form = document.getElementById("selectRoundForm");
    var round = form.round.value; // 선택된 라운드 값 가져오기

    // 값들을 콘솔에 로그로 남기기
    console.log("선택된 라운드: " + round);

    // 폼의 모든 값을 로그로 남기기 (추후 더 많은 필드가 추가될 경우)
    var formData = new FormData(form);
    formData.forEach((value, key) => {
        console.log(key + ": " + value);
    });

    return true; // 폼 제출 계속 진행
}

// 폼 제출 시 값을 로그로 남기도록 이벤트 리스너 추가
document.getElementById("selectRoundForm").addEventListener("submit", function(event) {
    logRoundValue();
});
</script>

<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->
<%@ include file="../footer.jsp"%>