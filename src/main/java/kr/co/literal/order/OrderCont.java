package kr.co.literal.order;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequestMapping("/order")
public class OrderCont {
    
    public OrderCont() {
        System.out.println("-----OrderCont() 객체생성");
    }
    
    @Autowired
    OrderDAO orderDao;
    
    @GetMapping("/orderDetail")
    public ModelAndView orderDetail(HttpSession session) {
        ModelAndView mav = new ModelAndView("order/orderDetail");

        String email = (String)session.getAttribute("email");
        if(email == null) {
            mav.addObject("msg1", "<p>세션이 만료되었거나 이메일 정보가 없습니다.</p>");
            mav.addObject("msg2", "<p><a href='/member/login'>로그인</a></p>");
            mav.setViewName("member/login");
            return mav;
        }

        List<HashMap<String, Object>> cartItems = orderDao.getCartItems(email);
        int totalProductCount = cartItems.size();
        int totalProductAmount = cartItems.stream().mapToInt(item -> (int) item.get("sale_price")).sum();
        int totalOrderAmount = totalProductAmount;
        int expectedPoints = (int) (totalOrderAmount * 0.05); // 예상 적립금 계산
        int deliveryFee = (totalOrderAmount < 20000) ? 2500 : 0; // 배송비 계산
        totalOrderAmount += deliveryFee; // 총 주문 금액에 배송비 추가

        mav.addObject("cartItems", cartItems);
        mav.addObject("totalProductCount", totalProductCount);
        mav.addObject("totalProductAmount", totalProductAmount);
        mav.addObject("totalOrderAmount", totalOrderAmount);
        mav.addObject("expectedPoints", expectedPoints); 
        mav.addObject("deliveryFee", deliveryFee); 

        return mav;
    }
   

    @Transactional
    @PostMapping("/orderProcess")
    public ModelAndView orderProcess(@ModelAttribute OrderDTO orderDto, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/order/orderProcess");
        
        String email = (String) session.getAttribute("email");
        if (email == null) {
            mav.addObject("msg1", "<p>세션이 만료되었거나 이메일 정보가 없습니다.</p>");
            mav.addObject("msg2", "<p><a href='/member/login'>로그인</a></p>");
            return mav;
        }
        
        // 총 결제 금액 구하기
        int totalamount = orderDao.totalamount(email);
        
        // 주문 데이터 삽입 전에 orderDto에 email 및 기타 필요한 정보 설정
        orderDto.setEmail(email);
        
        // 카트 코드 가져오기 (세션에서 직접 가져오기)
        String cartCode = (String) session.getAttribute("cart_code");
        if (cartCode == null) {
            cartCode = orderDao.cart_code(email);
        }
        
        // cartCode 유효성 검사 및 생성
        if (cartCode == null || !orderDao.isCartCodeValid(cartCode)) {
            mav.addObject("msg1", "<p>유효하지 않은 카트 코드입니다.</p>");
            mav.addObject("msg2", "<p><a href='/order/orderDetail'>주문 페이지로 돌아가기</a></p>");
            System.out.println("카트코드: " + cartCode);
            return mav;
        }
        
        orderDto.setCart_code(cartCode); // orderDto에 cart_code 설정

        int result = orderDao.insertOrder(orderDto);
        
        if (result > 0) {
            // orderDto에 세션아이디, 총결제금액 추가로 담기
            orderDto.setTotal_amount(totalamount);
            
            // orderList 테이블에 행 추가
            int cnt = orderDao.orderlistInsert(orderDto);
            if (cnt == 1) {
                // cart에 있는 주문상품상세내역을 orderdetail 테이블에 옮겨 담기
                HashMap<String, String> map = new HashMap<>();
                map.put("paymentCode", orderDto.getPayment_code());
                map.put("email", email);
                
                // 외래 키 제약 조건 비활성화
                orderDao.disableForeignKeyChecks();
                
                try {
                    // cart 테이블 비우기
                    int deleteCount = orderDao.cartDelete(email);
                    if (deleteCount == 0) {
                        throw new RuntimeException("장바구니를 비우는 데 실패했습니다.");
                    }
                } finally {
                    // 외래 키 제약 조건 활성화
                    orderDao.enableForeignKeyChecks();
                }
                
                mav.addObject("msg1", "<p>주문이 완료되었습니다.</p>");
                mav.addObject("msg2", "<p><a href='/order/orderDetail'>주문 내역 보기</a></p>");
            } else {
                mav.addObject("msg1", "<p>주문에 실패했습니다. 다시 시도해주세요.</p>");
                mav.addObject("msg2", "<p><a href='/order/orderDetail'>주문 페이지로 돌아가기</a></p>");
                return mav;
            }
        } else {
            mav.addObject("msg1", "<p>주문에 실패했습니다. 다시 시도해주세요.</p>");
            mav.addObject("msg2", "<p><a href='/order/orderDetail'>주문 페이지로 돌아가기</a></p>");
            return mav;
        }
        
        return mav;
    }


    private String order_sendMail(OrderDTO orderDto) {
        // 메일 보내기 구현
        // 주문내역서 메일 보내기
        String content = order_sendMail(orderDto);

        return "메일 내용";
    }
}