package kr.co.literal.order;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;


@Repository
public class OrderDAO {
    
    public OrderDAO() {
        System.out.println("-----OrderDAO() 객체생성");
    }
    
    @Autowired
    SqlSession sqlSession;
    
    // 총 결제 금액 구하기
    public int totalamount(String email) {
        return sqlSession.selectOne("order.totalamount", email);
    }
    
    // 장바구니 정보 가져오기
    public List<HashMap<String, Object>> getCartItems(String email){
        return sqlSession.selectList("order.getCartItems", email);
    }
    
    // 장바구니 코드 가져오기
    public String cart_code(String email) {
        return sqlSession.selectOne("order.cart_code", email);
    }

    // 장바구니 삭제
    public int cartDelete(String email) {
        System.out.println("장바구니 삭제 메서드 호출 - 이메일: " + email);
        int result = sqlSession.delete("order.cartDelete", email);
        System.out.println("장바구니 삭제 결과: " + result);
        return result;
    }
    
    
    // cart_code 유효성 검사
    public boolean isCartCodeValid(String cartCode) {
        int count = sqlSession.selectOne("order.cartCodeValid", cartCode);
        return count > 0;
    }

    // 외래 키 제약 조건 비활성화/활성화 메서드 추가
    public int disableForeignKeyChecks() {
        return sqlSession.update("order.disableForeignKeyChecks");
    }

    public int enableForeignKeyChecks() {
        return sqlSession.update("order.enableForeignKeyChecks");
    }

    // 특정 주문 코드의 주문 내역 조회
    public List<HashMap<String, Object>> orderDesc(String order_code) {
        return sqlSession.selectList("order.orderDesc", order_code);
    }
    
    
    // 주문 삽입
    public int insertOrder(OrderDTO orderDto) {
        // 트리거를 사용하여 결제 코드 자동 생성
        return sqlSession.insert("order.insertOrder", orderDto);
    }
    

    // 삽입된 payment_code 가져오기
    public String getPaymentCode(String email) {
        return sqlSession.selectOne("order.getPaymentCode", email);
    }

    
    // 주문 번호와 주문 날짜를 가져오는 메서드
    public List<HashMap<String, Object>> getOrderInfo(String email) {
        return sqlSession.selectList("order.getOrderInfo", email);
    }
}

