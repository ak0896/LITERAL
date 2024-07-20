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
    public List<HashMap<String, Object>> getCartItems(Map<String, Object> params){
        return sqlSession.selectList("order.getCartItems", params);
    }
    
    // 장바구니 코드 가져오기
    public String cart_code(String email) {
        return sqlSession.selectOne("order.cart_code", email);
    }

    // payment_code를 사용하여 cart_code 가져오기
    public String getCartCodeByPaymentCode(String payment_code) {
        return sqlSession.selectOne("order.getCartCodeByPaymentCode", payment_code);
    }
    
    // 장바구니 삭제
    public int cartDelete(Map<String, Object> params) {
        return sqlSession.delete("order.cartDelete", params);
    }
    
    // 주문 삽입
    public int insertOrder(OrderDTO orderDto) {
        return sqlSession.insert("order.insertOrder", orderDto);
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
    
    // 중복 삽입 방지
    public boolean checkIfOrderExists(String paymentCode) {
        int count = sqlSession.selectOne("order.checkIfOrderExists", paymentCode);
        return count > 0;
    }

    // 주문 번호와 주문 날짜를 가져오는 메서드
    public List<HashMap<String, Object>> getOrderInfo(String email) {
        return sqlSession.selectList("order.getOrderInfo", email);
    }
    
    // 삽입된 payment_code 가져오기
    public String getPaymentCode(String email) {
        return sqlSession.selectOne("order.getPaymentCode", email);
    }
    
    // 주문 상세 내역 가져오기 - 이메일
    public List<HashMap<String, Object>> orderDesc(String payment_code) {
        return sqlSession.selectList("order.orderDesc", payment_code);
    }
    
    
}