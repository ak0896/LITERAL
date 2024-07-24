package kr.co.literal.readingroom.dao;

import kr.co.literal.readingroom.dto.MyCouponDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class MyCouponDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "kr.co.literal.readingroom.ReadingRoomMapper";

    public List<MyCouponDTO> selectAllMyCoupons() {
        return sqlSession.selectList(NAMESPACE + ".selectAllMyCoupons");
    }

    public MyCouponDTO selectMyCouponByNumber(String mycoupon_number) {
        return sqlSession.selectOne(NAMESPACE + ".selectMyCouponByNumber", mycoupon_number);
    }

    public void insertMyCoupon(MyCouponDTO my_coupon) {
        sqlSession.insert(NAMESPACE + ".insertMyCoupon", my_coupon);
    }

    public void updateMyCoupon(MyCouponDTO my_coupon) {
        sqlSession.update(NAMESPACE + ".updateMyCoupon", my_coupon);
    }

    public void deleteMyCoupon(String mycoupon_number) {
        sqlSession.delete(NAMESPACE + ".deleteMyCoupon", mycoupon_number);
    }
    
    public int getNextCouponCount(String date, String roomCode) {
        Map<String, String> params = new HashMap<>();
        params.put("date", date);
        params.put("roomCode", roomCode);
        return sqlSession.selectOne(NAMESPACE + ".getNextCouponCount", params);
    }
    
    // getLatestCouponByEmail 메서드 추가
    public MyCouponDTO getLatestCouponByEmail(String email) {
        return sqlSession.selectOne(NAMESPACE + ".selectLatestCouponByEmail", email);
    }

    // getAllCouponsByEmail 메서드 추가
    public List<MyCouponDTO> getAllCouponsByEmail(String email) {
        return sqlSession.selectList(NAMESPACE + ".selectAllCouponsByEmail", email);
    }
    
    // 쿠폰 사용 날짜 업데이트 메서드 추가
    public void updateMyCouponUsageDate(MyCouponDTO myCoupon) {
        sqlSession.update(NAMESPACE + ".updateMyCouponUsageDate", myCoupon);
    }
    

    // 사용되지 않은 쿠폰을 가져오는 메서드 추가
    public List<MyCouponDTO> getAllUnusedCouponsByEmail(String email) {
        return sqlSession.selectList(NAMESPACE + ".selectAllUnusedCouponsByEmail", email);
    }
    
}