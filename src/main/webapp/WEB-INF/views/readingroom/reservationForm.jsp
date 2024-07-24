<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- reservationForm.jsp -->

<!-- 사이드 메뉴 시작 -->
<div class="contents_inner">
	<div class="sidebar">
		<h3>지점 선택</h3>
		<form action="${pageContext.request.contextPath}/selectBranch"
			method=post id="branchForm">
			<!-- 라디오 버튼: 선택 가능한 지점 목록을 보여줍니다. -->
			<div>
				<label> <input type="radio" name="branch_code" value="L01"
					${sessionScope.branch_code == 'L01' ? 'checked' : ''}> 강남점
				</label>
			</div>
			<div>
				<label> <input type="radio" name="branch_code" value="L02"
					${sessionScope.branch_code == 'L02' ? 'checked' : ''}> 연희점
				</label>
			</div>
			<div>
				<label> <input type="radio" name="branch_code" value="L03"
					${sessionScope.branch_code == 'L03' ? 'checked' : ''}> 종로점
				</label>
			</div>
			<!-- 예약하기 버튼: 선택한 지점을 예약 처리합니다. -->
			<div>
				<input type="submit" value="예약하기">
			</div>
		</form>
		
		<!-- 이용권 구매 추가 -->
		<h3>이용권 구매</h3>
		<form action="${pageContext.request.contextPath}/buyTicket"
			method="get" id="buyTicketForm">
			<!-- 이용권 구매 버튼 -->
			<div>
				<input type="submit" value="이용권 구매">
			</div>
		</form>
	</div>
	<!-- 사이드 메뉴 끝 -->
	
	<!-- 본문 시작 -->
	<div class="reservation-form">
		<h1>열람실 예약</h1>
		<hr class="title-divider">
		<!-- 예약 폼 내용 -->
		<div class="content">
			<div class="info-section">
				<div class="info-box">				
					<div class="info-text">
						<img src="./images/moon.png" alt="예약일 아이콘">
						<h3>예약일 / 이용료</h3>
						<p>사용당일 / 무료</p>
					</div>
					<div class="info-text">
						<img src="./images/moon.png" alt="이용시간 아이콘">
						<h3>이용시간</h3>
						<p>09:00 ~ 19:00</p>
					</div>
				</div>
			</div> <!-- <div class="info-section"> end -->
			<section class="usage-instructions">
				<h2>이용방법</h2>
				<ol>
					<li>열람실 좌석 예약 중 원하는 도서관 선택</li>
					<li>신청가능 좌석에 한하여 좌석 예약(1인 1석, 예약가능시간 09:00~22:00)<br> <small>※
							[신청금지] 설정된 좌석은 신청 및 이용 불가<br> ※ 신청자 본인이 신청한 좌석은 [퇴실신청] 상태로
							보이며, 타 회원이 신청한 좌석은 [이용 중]으로 표시
					</small>
					</li>
					<li>좌석 이용 후 퇴실 시 [퇴실신청] 선택 후 퇴실<br> <small>※
							장시간(2시간 이상) 부재 시 관리자에 의해 강제 퇴실 조치</small>
					</li>
				</ol>
			</section>
			<section class="usage-inquiries">
				<h2>이용문의</h2>
				<p>
					강남점 : 02-6255-8002<br> 연희점 : 02-6255-8002<br> 종로점 :
					02-6255-8002
				</p>
			</section>
		</div> <!-- div class="content" end -->
		
		<script>
			document
					.getElementById('branchForm')
					.addEventListener(
							'submit',
							function(event) {
								var selectedBranch = document
										.querySelector('input[name="branch_code"]:checked');
								if (!selectedBranch) {
									event.preventDefault();
									alert('지점을 선택해주세요.');
								}
							});
		</script>
		
	</div>	<!-- <div class="reservation-form"> -->
	<!-- 본문 끝  -->
</div>
<!-- <div class="contents_inner"> -->
<style>

	.reservation-form{
		margin-top:20px;
	}
	
	.info-box{
		display:flex;
	}
	
	.info-text{
		margin-right:20px;
	}
	
	.contents_inner h2{
		font-size:
	}
</style>

<%@ include file="../footer.jsp"%>
