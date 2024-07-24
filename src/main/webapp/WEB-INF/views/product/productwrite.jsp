<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<!-- prductwrite.jsp -->

<!--사이드 메뉴 시작  -->
<div class="contents_inner">
    <div class="sidebar">
        <h2>국내도서</h2>
        <ul>
            <li><a href="G_productlist">고전소설</a></li>
            <li><a href="M_productlist">공포/미스테리소설</a></li>
            <li><a href="H_productlist">역사소설</a></li>
            <li><a href="S_productlist">판타지/과학소설</a></li>
            <li><a href="R_productlist">로맨스소설</a></li>
            <li><a href="P_productlist">무협소설</a></li>
            <li><a href="T_productlist">청소년소설</a></li>
            <li><a href="W_productlist">웹/드라마/영화소설</a></li>
        </ul>
    </div> <!-- <div class="sidebar"> end -->
 <!--사이드 메뉴 끝  -->
 
 <!-- 본문 시작 -->
	<div class="main-content">
		<div class="row">
			<div class="col-sm-12">
			<h3 class="productlist text-center"> [상 품 등 록] </h3>
			
			<form name="fmproduct" id="fmproduct" method="post" action="insert" enctype="multipart/form-data">
			<table class="table-product">
			<tbody>
				<tr>
					<td> 책 제목 </td> <!-- 필수 -->
					<td><input type="text" name="book_title" id="book_title" class="form-control"></td>
				</tr>
				<tr>
					<td> 작가 </td> <!-- 필수 -->
					<td><input type="text" name="author" id="author" class="form-control"></td>
				</tr>
				<tr>
					<td> 장르 </td>
					<td>
						<select name="genre_code" id="genre_code" class="form-control">
							<option value="0"> 선택 </option>
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
				<tr>
				<tr>
					<td> 출판사 </td>
                	<td><input type="text" name="press" id="press" class="form-control"></td>
				</tr>
				<tr>
					<td> 출판일 </td>
                	<td><input type="text" name="publishing_date" id="publishing_date" class="form-control"></td>
				</tr>
				<tr>
					<td> 판매자 책 소개 </td>
					<td>
						<textarea rows="8" name="intro_book" id="intro_book" class="form-control"></textarea>					
					</td>
				</tr>		
				<tr>
					<td> 상품 등급 코드 </td>
					<td>
						<select name="grade_code" id="grade_code" class="form-control">
							<option value="0"> 선택 </option>
							<option value="1"> 최상 </option>
							<option value="2"> 상 </option>
							<option value="3"> 중 </option>
						</select>
					</td>															
				<tr>
					<td> 정가 </td> <!-- 필수 -->
					<td><input type="number" name="original_price" id="original_price" class="form-control"></td>
				</tr>
				<tr>
					<td> 판매가 </td>
                	<td><input type="number" name="sale_price" id="sale_price" class="form-control" readonly></td>
				</tr>
				<tr>
					<td> 이미지 </td> <!-- 필수 -->
					<td><input type="file" name="img" id="img" class="form-control"></td>
				</tr>				
				
				 <tr>
					<td colspan="2" align="center">
					    <input type="submit" value="상품 등록" class="btn btn-newproduct"> 
					</td>
			    </tr>  
			</tbody>
			</table>			
			</form>
		
	    	</div><!-- col end -->
	   	</div><!-- row end -->
	</div> 	<!-- <div class="main-content"> end -->
	
	
	<!-- Modal -->
    <div class="modal fade" id="gradeGuideModal" tabindex="-1" role="dialog" aria-labelledby="gradeGuideModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="gradeGuideModalLabel"> 중고 품질 판정 가이드 </h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <table class="table table-bordered" style="text-align: center">
              <thead>
	            <tr>
	              <th>구분</th>
	              <th>현 상태</th>
	              <th>표지</th>
	              <th>책등 / 책배</th>
	              <th>내부 / 제본상태</th>
	            </tr>
	          </thead>
	          <tbody>
	            <tr>
	              <td>최상</td>
	              <td>새것에 가까운 책</td>
	              <td>변색 없음, 찢어진 흔적 없음, 담뱃재 흔적 없음, 낙서 없음, 얼룩 없음, 도서 결표지 있음</td>
	              <td>변색 없음, 낙서 없음, 담뱃재 흔적 없음, 얼룩 없음</td>
	              <td>변색 없음, 낙서 없음, 변형 없음, 접힌 흔적 없음, 제본 탈착 없음</td>
	            </tr>
	            <tr>
	              <td>상</td>
	              <td>약간의 사용감은 있으나 깨끗한 책</td>
	              <td>희미한 변색이나 작은 얼룩이 있음, 찢어진 흔적 없음, 약간의 모서리 해짐, 낙서 없음, 도서 결표지 있음</td>
	              <td>희미한 변색이나 작은 얼룩이 있음, 약간의 담뱃재 흔적 있음, 낙서 없음</td>
	              <td>변색 없음, 낙서 없음, 변형 없음, 아주 약간의 접힌 흔적 있음, 얼룩 없음, 제본 탈착 없음</td>
	            </tr>
	            <tr>
	              <td>중</td>
	              <td>사용감이 많으며 현 느낌이 나는 책</td>
	              <td>전체적인 변색, 모서리 해짐 있음, 오염 있음, 2cm 이하의 찢어짐 있음, 낙서 있음(이름 포함)</td>
	              <td>전체적인 변색, 모서리 해짐 있음, 오염 있음, 래핑 훼손 있음</td>
	              <td>변색 있음, 낙서 있음, 2cm 이하 찢어짐 있음, 5쪽 이하 필기 및 풀칠 흔적 있음, 제본 탈착 없음, 본문 읽기에 지장 없는 부록 없음</td>
	            </tr>
	            <tr>
	              <td>매입 불가</td>
	              <td>독서 및 이용에 지장이 있는 책, 중증 도서 / 비매품</td>
	              <td>2cm 초과한 찢어진 흔적 있음, 2cm 초과한 크기의 얼룩 있음</td>
	              <td>2cm 초과한 찢어진 흔적 있음, 5쪽 초과한 필기 및 풀칠 얼룩 있음, 낙장 등 제본 불량, 분책된 경우</td>
	              <td>낙장 등 제본 불량, 분책된 경우</td>
	            </tr>
	          </tbody>
	        </table>
	      </div>
	    </div>
	  </div>
	</div> <!-- 모달 끝 -->

<script>
document.addEventListener('DOMContentLoaded', function() {
    var modalOpened = false;
    var gradeCodeSelect = document.getElementById('grade_code');
    var gradeGuideModal = document.getElementById('gradeGuideModal');

    // 모달이 닫힐 때 모달 열림 상태를 초기화
    gradeGuideModal.addEventListener('hidden.bs.modal', function () {
        modalOpened = false;
        gradeCodeSelect.blur();
    });

    // 'X' 버튼 클릭 시 모달을 닫음
    var closeButton = gradeGuideModal.querySelector('.close');
    closeButton.addEventListener('click', function() {
        var bootstrapModal = bootstrap.Modal.getInstance(gradeGuideModal);
        bootstrapModal.hide();
    });

    var discountRates = {
        0: 0,
        1: 0.3,
        2: 0.4,
        3: 0.5
    };

    var originalPriceInput = document.getElementById('original_price');
    var salePriceInput = document.getElementById('sale_price');

    gradeCodeSelect.addEventListener('change', function() {
        // 셀렉트 박스 변경 후 모달을 띄움
        if (!modalOpened) {
            var gradeCode = parseInt(gradeCodeSelect.value); // 선택된 등급 코드 값
            if (gradeCode > 0) { // 선택된 값이 '선택'이 아닌 경우에만 모달을 띄움
                var bootstrapModal = new bootstrap.Modal(gradeGuideModal);
                bootstrapModal.show();
                modalOpened = true;
            }

            var originalPrice = parseFloat(originalPriceInput.value) || 0;
            var discountRate = discountRates[gradeCode];
            var salePrice = originalPrice * (1 - discountRate);
            var roundedSalePrice = Math.floor(salePrice / 10) * 10;
            salePriceInput.value = roundedSalePrice;
        }
    });

    originalPriceInput.addEventListener('input', function() {
        var gradeCode = parseInt(gradeCodeSelect.value);
        var originalPrice = parseFloat(originalPriceInput.value) || 0;
        var discountRate = discountRates[gradeCode];
        var salePrice = originalPrice * (1 - discountRate);
        var roundedSalePrice = Math.floor(salePrice / 10) * 10;
        salePriceInput.value = roundedSalePrice;
    });

    var form = document.getElementById('fmproduct');
    form.addEventListener('submit', function(event) {
        var isValid = true;
        var requiredFields = ['book_title', 'author', 'original_price', 'img'];

        requiredFields.forEach(function(fieldId) {
            var field = document.getElementById(fieldId);
            if (!field.value) {
                isValid = false;
                field.classList.add('is-invalid');
            } else {
                field.classList.remove('is-invalid');
            }
        });

        if (!isValid) {
            event.preventDefault();
            alert('모든 필수 항목을 입력해주세요.');
        }
    });
});


	</script>

	
	<style>
	 .table-product {
    width: 100%;
    padding: 30px;
    margin-top: 30px;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    font-weight: bold;
    display: block;
    margin-bottom: 5px; /* 라벨과 입력 필드 사이의 간격 추가 */
}

.form-group input,
.form-group select,
.form-group textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
    margin-bottom: 10px; /* 입력 필드 간의 간격 추가 */
}

.form-group input[type="submit"] {
    width: auto;
    background-color: #007bff;
    color: white;
    border: none;
    padding: 10px 20px;
    cursor: pointer;
    border-radius: 4px;
    margin-top: 20px; /* 제출 버튼 위의 간격 추가 */
}

.form-group input[type="submit"]:hover {
    background-color: #0056b3;
}

.fade-in {
    animation: fadeIn 0.5s ease-in-out;
}

@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}

.fade-out {
    animation: fadeOut 0.5s ease-in-out;
}

@keyframes fadeOut {
    from {
        opacity: 1;
    }
    to {
        opacity: 0;
    }
}
	 
	 
	</style>
<!-- 본문 끝 -->
</div> <!-- <div class="contents_inner"> end -->
	

<%@ include file="../footer.jsp"%>
	