<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">  <!-- 구글이모티콘 -->
 
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
	<link rel="stylesheet" href="/css/style.css">
	<link rel="stylesheet" href="/css/side_menu.css">
	<link rel="stylesheet" href="/css/member_style.css">


    <title> LITERAL </title>
</head>


<body>
    <div class="wrap">
        <!-- header -->
        <header>
            <div class="header-container">
                <div class="logo">
                    <a href="/index"><h1>LITERAL</h1></a>
                </div>
                
              <!-- 검색 (검색 그림 수정예정 a태그) -->
			  <div class="row">
			  	<div class="col-sm-12">
					<!-- 검색 -->
                    <form method="get" action="${pageContext.request.contextPath}/product/search" class='search-form'>
                        <input type="text" name="book_title" value="${book_title}" class='search-input'>
                        <input type="submit" value="검색" class="btn">
                    </form>
			  	</div><!-- col end -->
			  </div><!-- row end -->
			  
		<!-- index수정 6/27애경-->   
       
				<!-- 세션에 member 속성이 있는지 확인하여 LOGIN/LOGOUT 링크를 선택적으로 표시 -->
                <div class="header-links user-actions">
				    <c:choose>
				        <c:when test="${not empty sessionScope.member}">
				        	<span>${sessionScope.member.name} 님</span> <!-- 로그인한 사람의 이름 출력 -->
				            <a href="/member/logout" id="logoutLink"><i class="fas fa-user"></i> LOGOUT</a>
				        </c:when>
				        <c:otherwise>
				            <a href="/member/login"><i class="fas fa-user"></i> LOGIN</a>
				        </c:otherwise>
				    </c:choose>
				    
				    <c:choose>
					    <c:when test="${not empty sessionScope.member && sessionScope.member.type_code != 0}">
					        <a href="/mypage/mypage_main"><i class="fas fa-user-circle"></i> MYPAGE</a>
					        <a href="/cart/cartList"><i class="fas fa-shopping-cart"></i> CART</a>
					    </c:when>
					    <c:when test="${empty sessionScope.member}">
					        <a href="/member/login"><i class="fas fa-user-circle"></i> MYPAGE</a>
					        <a href="/member/login"><i class="fas fa-shopping-cart"></i> CART</a>
					    </c:when>
					</c:choose>
					
						<!-- 관리자 화면 링크 표시 조건 -->
					<c:if test="${sessionScope.member != null && sessionScope.member.type_code == 0}">
						<a href="/admin"><i class="fas fa-user-shield"></i> 관리자 화면</a>
					</c:if>
				</div>
            </div>
        </header>

       <!-- nav 카테고리 시작 -->
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		    <div class="container-fluid">
		        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
		            <span class="navbar-toggler-icon"></span>
		        </button>
		        <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
		            <ul class="navbar-nav">
		                <li class="nav-item">
		                    <a class="navbar-brand" href="/index"><i class="fas fa-home home-icon"></i></a>
		                </li>
		                <li class="nav-item">
		                    <a class="nav-link font-weight-bold" href="/product/productlist">서점</a>
		                </li>
		                <li class="nav-item">
		                    <a class="nav-link font-weight-bold" href="/notice/notice_list2">공지사항</a>
		                </li>
		                <li class="nav-item">
		                    <a class="nav-link font-weight-bold" href="/reading_main">열람실</a>
		                </li>
		                <li class="nav-item">
		                    <a class="nav-link font-weight-bold" href="/branch/branchDetail">지점안내</a>
		                </li>
		            </ul>
		        </div>
		    </div>
		</nav>
		<!-- nav 카테고리 끝 -->



        <!-- container -->
        <div class="main">
           <!-- Carousel -->
            <div id="demo" class="carousel slide" data-bs-ride="carousel">

                <!-- Indicators/dots -->
                <div class="carousel-indicators">
	                <button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
	                <button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
	                <button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
                </div>
                
                <!-- The slideshow/carousel -->
                <div class="carousel-inner">
	                <div class="carousel-item active">
	                    <img src="${pageContext.request.contextPath}/storage/eventImages/main2.jpg" alt="keroro" class="d-block" style="width:100%">
	                </div>
	                <div class="carousel-item">
	              		<img src="${pageContext.request.contextPath}/storage/eventImages/웹.jpg" alt="keroro" class="d-block" style="width:100%">
	                </div>
	                <div class="carousel-item">
	              		<img src="${pageContext.request.contextPath}/storage/eventImages/이달.jpg" alt="keroro" class="d-block" style="width:100%">
	                </div>
                </div><!-- div class="carousel-inner" end -->
                
                <!-- Left and right controls/icons -->
                <button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
                </button>
            </div><!-- div id="demo" end  -->


  <div class="content">
				<div class="best-books">
					<h2>BEST</h2>
					<!-- 여기부터 슬라이드.. -->
				  
                <div class="books section">
                    <input type="radio" name="slide" id="slide1" checked>
                    <input type="radio" name="slide" id="slide2">
                    <input type="radio" name="slide" id="slide3">
                    <div class="slidewrap">
                        <ul class="slidelist">
                            <c:forEach items="${topBooks}" var="book" varStatus="status">
                                <c:if test="${status.index % 5 == 0}">
                                    <li class="slideitem">
                                    <div class="slide_flex">
                                </c:if>

                                <div class="book">
                                    <a href="../product/productdetail/${book.book_number}">
                                        <img src="../storage/images/${book.img}" alt="${book.book_number}">
                                    </a>
                                    <p>${book.book_title}</p>
                                    <span><fmt:formatNumber value="${book.sale_price}" pattern="#,###"/>원</span>
                                </div>

                                <c:if test="${status.index % 5 == 4 || status.last}">
                                    </div>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="slide_control">
                        <label for="slide1"></label>
                        <label for="slide2"></label>
                        <label for="slide3"></label>
                    </div>
                </div>
            </div>


                <div class="today-book">
                    <h2>오늘의 추천도서</h2>
                    <!-- 여기부터 슬라이드.. -->
                    <div class="books section2">
                        <input type="radio" name="slide2" id="slide2-1" checked>
                        <input type="radio" name="slide2" id="slide2-2">
                        <input type="radio" name="slide2" id="slide2-3">
                        <div class="slidewrap">
                            <ul class="slidelist">
                                <c:forEach items="${today_book}" var="book" varStatus="status">
                                    <c:if test="${status.index % 5 == 0}">
                                        <li class="slideitem">
                                            <div class="slide_flex">
                                    </c:if>
                                    
                                    <div class="book">
                                        <a href="../product/productdetail/${book.book_number}">
                                            <img src="../storage/images/${book.img}" alt="${book.book_title}">
                                        </a>
                                        <p>${book.book_title}</p>
                                        <span><fmt:formatNumber value="${book.sale_price}" pattern="#,###"/>원</span>
                                    </div>
                                    
                                    <c:if test="${status.index % 5 == 4 || status.last}">
                                            </div>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                            <div class="slide-control2">
                                <div>
                                    <label for="slide2-3" class="left"></label>
                                    <label for="slide2-2" class="right"></label>
                                </div>
                                <div>
                                    <label for="slide2-1" class="left"></label>
                                    <label for="slide2-3" class="right"></label>
                                </div>
                                <div>
                                    <label for="slide2-2" class="left"></label>
                                    <label for="slide2-1" class="right"></label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Content 끝 -->

        </div><!--  <div class="main"> -->

         <!-- Footer -->
        <footer>
            <div class="footer-container">
                <div class="footer-logo">
                    <h1>LITERAL</h1>
                    <p>LITERAL is <br>a used novel bookstore.</p>
                </div>
	           <div class="footer-info">
	                <p> 대표 : LITERAL</p>
	                <p> 주소 : 서울 강남구 역삼동 823 </p>
	                <p> 사업자등록번호 : 172-87-02395 </p>
	                <p> TEL : 02-1234-1234 </p>
	                <p> 이메일 : gangnam@gmail.com </p>
            	</div>
            	<div class="footer-info">
	                <p> 1조 </p>
	                <p> 조장 : 박애경 </p>
	                <p> 기술 지원 : 최문정, 정소연 </p>
	                <p> 디자이너 : 송윤지 </p>
	                <p> 멀티플레이어 : 송효정 </p>
            	</div>
            </div>
            <div class="footer-bottom">
                <p>Copyright © LITERAL Corp. All Rights Reserved.</p>
            </div>
        </footer>
    </div> <!-- <div class="wrap"> end -->
</body>
</html>


<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 로그아웃 링크에 클릭 이벤트 리스너 추가
        const logoutLink = document.getElementById('logoutLink');
        if (logoutLink) {
            logoutLink.addEventListener('click', function(event) {
                // 로그아웃 확인 창 표시
                const confirmed = confirm('로그아웃 하시겠습니까?');
                if (!confirmed) {
                    // 사용자가 취소를 클릭하면 로그아웃을 중단
                    event.preventDefault();
                }
            });
        }
    });
</script>