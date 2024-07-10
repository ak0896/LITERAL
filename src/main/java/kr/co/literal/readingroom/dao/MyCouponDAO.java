package kr.co.literal.readingroom.dao;

import kr.co.literal.readingroom.dto.MyCouponDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

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
}