package kr.co.literal.readingroom.dao;

import kr.co.literal.readingroom.dto.SeatDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class SeatDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "kr.co.literal.readingroom.ReadingRoomMapper";

    public List<SeatDTO> selectAllSeats() {
        return sqlSession.selectList(NAMESPACE + ".selectAllSeats");
    }

    public void insertSeat(SeatDTO seat) {
        sqlSession.insert(NAMESPACE + ".insertSeat", seat);
    }

    public void updateSeat(SeatDTO seat) {
        sqlSession.update(NAMESPACE + ".updateSeat", seat);
    }

    public void deleteSeat(String seat_code) {
        sqlSession.delete(NAMESPACE + ".deleteSeat", seat_code);
    }
    
	
	public List<SeatDTO> selectSeatByCode(String seat_code) { 
		 return sqlSession.selectList(NAMESPACE + ".selectSeatByCode", seat_code); 
	}
	
	
	//애경 추가
	 public int getTotalSeatsCount() {
	        return sqlSession.selectOne(NAMESPACE + ".getTotalSeatsCount");
	    }

	 public List<SeatDTO> getAvailableSeats(String branchCode, String reservationDate, String timeCode) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("branchCode", branchCode);
	        params.put("reservationDate", reservationDate);
	        params.put("timeCode", timeCode);
	        return sqlSession.selectList(NAMESPACE + ".getAvailableSeats", params);
	    }
	 
	 public int getTotalSeatsByBranch(String branchCode) {
		    return sqlSession.selectOne(NAMESPACE + ".getTotalSeatsByBranch", branchCode);
		}
	
}
