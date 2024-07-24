<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header_admin.jsp"%>

<!-- productlist(admin).jsp -->

<div class="contents_inner">
<!--사이드 메뉴 시작  -->
	<div class="sidebar">
		<ul>
			<li><a href="${pageContext.request.contextPath}/admin">열람실 관리</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/memberList">회원정보 관리</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/productlist_admin">상품 관리</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/branchList">지점 관리</a></li>
			<li><a href="${pageContext.request.contextPath}/notice/notice_list">공지사항 관리</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/ad_inquiry_list">1:1문의 관리</a></li>
		</ul>
	</div>
	<!-- sidebar end -->


 <!-- 본문 시작 -->
	
<div class="main-content">
	<div class="row">
		<h3 class="productlist text-center"> [전 체 목 록] </h3>
 	</div> <!-- row end -->
 	
<!--     
	<select id="filter" onchange="filterProducts()">
       <option value="3"> 전체 </option>
       <option value="0"> 미판매 </option>
       <option value="1"> 판매 </option>
       <option value="2"> 보류 </option>
    </select> 
-->
	
	<table>
	<thead>
		<tr>
			<th> 장르 </th>
			<th> 책 코드 </th>
			<th> 책 번호 </th>
			<th> 책 제목 </th>
			<th> 작가 </th>
			<th> 상품 등급 </th>
			<th> 판매가 </th>
			<th> 등록한 사람 </th>
			<th> 판매 여부 </th>
			<th> 지점 코드 </th>
			<th> 등록 날짜 </th>
		</tr>
	</thead>	 
	<tbody>	
		<c:forEach items="${list}" var="row" varStatus="vs">
		<form action="/admin/quickupdate" method="post">
		<input type="hidden" name="book_number" value="${row.book_number}">
			<div class="row">
			<tr>
				<td> ${row.genre_code} </td>
				<td> ${row.book_code} </td>
				<td> ${row.book_number} </td>
				<td> <a href="aproductdetail/${row.book_number}""> ${row.book_title} </a></td>
				<td> ${row.author} </td>
				<td> ${row.grade_code} </td>
				<td> <fmt:formatNumber value="${row.sale_price}" pattern="#,###" /> 원 </td>
				<td> ${row.email} </td>
               <td>
                    <select name="availability" id="availability">
                        <option value="0" <c:if test="${row.availability == '0'}">selected</c:if>> 미판매 </option>
                        <option value="1" <c:if test="${row.availability == '1'}">selected</c:if>> 판매 </option>
                        <option value="2" <c:if test="${row.availability == '2'}">selected</c:if>> 보류 </option>
                    </select>
                </td>
                <td>
                    <select name="branch_code" id="branch_code">
                        <option value="0" <c:if test="${row.branch_code == '0'}">selected</c:if>> 온라인 </option>
                        <option value="L01" <c:if test="${row.branch_code == 'L01'}">selected</c:if>> 강남점 </option>
                        <option value="L02" <c:if test="${row.branch_code == 'L02'}">selected</c:if>> 역삼점 </option>
                        <option value="L03" <c:if test="${row.branch_code == 'L03'}">selected</c:if>> 종로점 </option>
                    </select>
                </td>
				<td> ${row.registration_date} </td>
				<td> <input type="submit" value="수정"> </td>
			</tr>
		</div><!-- row end -->
		</form>
		</c:forEach>
		
	</tbody>
	</table>
	
<!-- <script>
	function filterProducts() {
	    var filter = document.getElementById('filter').value;
	    var xhr = new XMLHttpRequest();
	    xhr.open('GET', '/admin/filterProducts?filter=' + filter, true);
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState == 4 && xhr.status == 200) {
	            document.getElementById('productlist').innerHTML = xhr.responseText;
	        }
	    };
	    xhr.send();
	}
</script> -->
	
</div> <!-- <div class="main-content"> end -->
</div><!-- contents_inner end -->
<!-- 본문 끝 -->



<style>
.main-content {
    width: 80%;
    padding: 20px;
}

.main-content h3 {
    margin-bottom: 20px;
    font-size: 24px;
    color: #333;
}

.main-content table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

.main-content table, .main-content th, .main-content td {
    border: 1px solid #ddd;
}

.main-content th, .main-content td {
    padding: 12px;
    text-align: left;
}

.main-content th {
    background-color: #f4f4f4;
    font-weight: bold;
}

.main-content tr:nth-child(even) {
    background-color: #f9f9f9;
}

.main-content form {
    display: flex;
    align-items: center;
}

.main-content select {
    margin-right: 5px;
}

.main-content input[type="submit"] {
    margin-left: 5px;
    padding: 10px 20px;
    background-color: #FA8072;
    color: white;
    border: none;
    cursor: pointer;
    font-size: 16px;
    border-radius: 4px;
}

.main-content input[type="submit"]:hover {
    background-color: #FF4500;
}

.main-content a {
    color: #6A24FE;
    text-decoration: none;
}

.main-content a:hover {
    text-decoration: underline;
}
</style>


<%@ include file="../footer_admin.jsp"%>