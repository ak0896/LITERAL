<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<div class="coupon-area">
   <h1>결제 성공</h1>
   <p>이용권 구매가 완료되었습니다.</p>
   <div class="coupon-info">
       <p><strong>쿠폰 번호:</strong> ${myCoupon.mycoupon_number}</p>
       <p><strong>이용권 종류:</strong> ${myCoupon.room_code}</p>
       <p><strong>발급 날짜:</strong> ${myCoupon.issue_date}</p>
       <p><strong>만료 날짜:</strong> ${myCoupon.expiry_date}</p>
   </div>
</div>
<style>
        .coupon-area {
        	margin:50px auto;
            background-color: #fff;
            padding: 20px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            text-align: center;
        }
        .coupon-area h1 {
            color: #333;
            margin-bottom: 20px;
            font-size: 24px;
        }
        .coupon-area p {
            color: #666;
            font-size: 16px;
            margin: 10px 0;
        }
        .coupon-info {
            background-color: #f1f1f1;
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
            text-align: left;
        }
        .coupon-info p {
            margin: 5px 0;
        }
        .coupon-info strong {
            color: #333;
        }
    </style>
<%@ include file="../footer.jsp"%>
