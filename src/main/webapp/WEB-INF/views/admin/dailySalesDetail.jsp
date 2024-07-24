<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <!-- 차트 링크 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  
<!-- dailySalesDetail.jsp -->


<!--사이드 메뉴 시작  -->
<div class="contents_inner">
	<div class="sidebar">
	    <ul class="nav nav-pills nav-stacked">
	        <li><a href="${pageContext.request.contextPath}/admin">열람실 관리</a></li>
	        <li><a href="${pageContext.request.contextPath}/admin/memberList">회원정보 관리</a></li>
	        <li><a href="${pageContext.request.contextPath}/admin/productlist_admin">상품 관리</a></li>
	        <li>
	            <a href="#branchSubMenu" data-toggle="collapse" aria-expanded="false">지점 관리 <span class="caret"></span></a>
	            <ul class="nav nav-pills nav-stacked collapse" id="branchSubMenu">
	                <li><a href="${pageContext.request.contextPath}/admin/branchList">지점 목록</a></li>
	                <li><a href="${pageContext.request.contextPath}/admin/branchRegister">지점 등록</a></li>
	                <li><a href="${pageContext.request.contextPath}/admin/dailySales">지점 매출</a></li>
	                <li><a href="${pageContext.request.contextPath}/admin/nonMemberList">비회원 목록</a></li>
	            </ul>
	        </li>
	       	<li><a href="${pageContext.request.contextPath}/notice/notice_list">공지사항 관리</a></li>
	        <li><a href="${pageContext.request.contextPath}/admin/ad_inquiry_list">1:1문의 관리</a></li>
	    </ul>
	</div><!-- <div class="sidebar">  end-->
 <!--사이드 메뉴 끝  -->


    <div class="sales-container">
        <h2>지점 매출 조회</h2>
        
        <!-- 매출 조회 폼 -->
        <form action="${pageContext.request.contextPath}/admin/dailySalesDetail" method="get">
            <label for="branch-select">지점 선택:</label>
            <select id="branch-select" name="branch_code">
                <option value="">전체 지점</option>
                <c:forEach items="${branchesList}" var="branch">
                    <option value="${branch.branch_code}">${branch.branch_name}</option>
                </c:forEach>
            </select>

            <label for="start-date">시작 날짜:</label>
            <input type="date" id="start-date" name="start_date" required>
            
            <label for="end-date">종료 날짜:</label>
            <input type="date" id="end-date" name="end_date">
            
            <button type="submit">조회</button>
        </form>

        <!-- 매출 결과 표시 -->
        <c:if test="${not empty salesData}">
            <h3>선택된 지점: ${selectedBranch.branch_name}</h3>
            <h3>선택된 기간: <fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd"/> 
                <c:if test="${not empty endDate}">
                    ~ <fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd"/>
                </c:if>
            </h3>
            <br>
            
            <div class="sales-summary">
                <h3>총 상품 매출: <fmt:formatNumber value="${totalProductSales}" pattern="#,###"/>원</h3>
                <h3>총 열람실 매출: <fmt:formatNumber value="${totalRoomSales}" pattern="#,###"/>원</h3>
            </div>
            <br>
            
            <!-- 차트 표시 -->
            <canvas id="salesChart"></canvas>
        </c:if>
    </div>
</div><!-- contents_inner end -->



    <script>
        function drawChart() {
            var ctx = document.getElementById('salesChart').getContext('2d');
            var chartType = ${empty endDate || startDate eq endDate} ? 'bar' : 'line';
            
            var chartData = {
                labels: [
                    <c:forEach items="${salesData}" var="data">
                        '<fmt:formatDate value="${data.sales_date}" pattern="yyyy-MM-dd"/>',
                    </c:forEach>
                ],
                datasets: [{
                    label: '상품 매출',
                    data: [
                        <c:forEach items="${salesData}" var="data">
                        	${(data.dtotal_product != null ? data.dtotal_product : 0) + 0},
                        </c:forEach>
                    ],
                    borderColor: 'rgba(242, 13, 154, 1)',
                    backgroundColor: 'rgba(242, 13, 154, 0.2)',
                }, {
                    label: '열람실 매출',
                    data: [
                        <c:forEach items="${salesData}" var="data">
                        	${(data.dtotal_room != null ? data.dtotal_room : 0) + 0},
                        </c:forEach>
                    ],
                    borderColor: 'rgba(66, 66, 189, 1)',
                    backgroundColor: 'rgba(66, 66, 189, 0.2)',
                }]
            };

            new Chart(ctx, {
                type: chartType,
                data: chartData,
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true,
                            min: 0,
                            ticks: {
                                precision: 0,
                                callback: function(value, index, values) {
                                    return value.toLocaleString() + '원';
                                }
                            }
                        }
                    },
                    plugins: {
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    let label = context.dataset.label || '';
                                    if (label) {
                                        label += ': ';
                                    }
                                    if (context.parsed.y !== null) {
                                        label += context.parsed.y.toLocaleString() + '원';
                                    }
                                    return label;
                                }
                            }
                        }
                    }
                }
            });
            
        }//drawChart() end

        // 페이지 로드 시 차트 그리기
        window.onload = function() {
            if (document.getElementById('salesChart')) {
                drawChart();
            }
        };
    </script>




<style>

/* sidebar속에 li 스타일 */

.sidebar {
    padding: 20px 0;
    width: 200px; /* 사이드바의 너비 설정 */
}
.sidebar .nav-pills > li {
    width: 100%; /* 각 항목이 전체 너비를 차지하도록 설정 */
}
.sidebar .nav-pills > li > a {
    border-radius: 0;
    white-space: nowrap; /* 텍스트가 한 줄로 유지되도록 설정 */
    overflow: hidden; /* 너비를 넘어가는 텍스트 숨김 */
    text-overflow: ellipsis; /* 너비를 넘어가는 텍스트에 '...' 추가 */
    padding-left: 20px; 
}
.sidebar .nav-pills > li > ul > li > a {
    padding-left: 40px;
}

</style>

<%@ include file="../footer_admin.jsp"%>
