package kr.co.literal.readingroom.dao;

import kr.co.literal.readingroom.dto.ReservationDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ReservationDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "kr.co.literal.readingroom.ReadingRoomMapper";

    public void insertReservation(ReservationDTO reservation) {
        sqlSession.insert(NAMESPACE + ".insertReservation", reservation);
    }

    public List<ReservationDTO> getAllReservations() {
        return sqlSession.selectList(NAMESPACE + ".getAllReservations");
    }

    public ReservationDTO getReservationByCode(String reservation_code) {
        return sqlSession.selectOne(NAMESPACE + ".getReservationByCode", reservation_code);
    }

    public void updateReservation(ReservationDTO reservation) {
        sqlSession.update(NAMESPACE + ".updateReservation", reservation);
    }

    public void deleteReservation(String reservation_code) {
        sqlSession.delete(NAMESPACE + ".deleteReservation", reservation_code);
    }
    
    public void saveReservation(ReservationDTO reservation) {
        sqlSession.insert(NAMESPACE + ".insertReservation", reservation);
    }
    
    public int getNextSequenceNumber(boolean isMember) {
    	 return sqlSession.selectOne(NAMESPACE + ".getNextSequenceNumber", isMember);
    }
    
    public boolean isMyCouponNumberExists(String  mycoupon_number) {
        Integer count = sqlSession.selectOne(NAMESPACE + ".checkMyCouponNumber", mycoupon_number);
        return count != null && count > 0;
    }
    
    public int getNextReservationCodeNumber(String prefix) {
        // 데이터베이스에서 prefix로 시작하는 예약 코드의 최대 숫자를 가져온 다음 1을 더한 값을 반환
        return sqlSession.selectOne("kr.co.literal.readingroom.ReadingRoomMapper.getNextReservationCodeNumber", prefix);
    }
    
    //0712추가
	/*
	 * public ReservationDTO getReservationBySeatCode(String seatCode) { return
	 * sqlSession.selectOne(NAMESPACE + ".getReservationBySeatCode", seatCode); }
	 */
    
    //0713추가
    public List<ReservationDTO> getReservationsBySeatCodeAndTime(String seatCode, String startTime, String endTime) {
        Map<String, String> params = new HashMap<>();
        params.put("seatCode", seatCode);
        params.put("startTime", startTime);
        params.put("endTime", endTime);
        return sqlSession.selectList(NAMESPACE + ".getReservationsBySeatCodeAndTime", params);
    }
    
    public List<ReservationDTO> getReservationsBySeatCode(String seatCode) {
        return sqlSession.selectList(NAMESPACE + ".getReservationsBySeatCode", seatCode);
    }
    
    


    
}
