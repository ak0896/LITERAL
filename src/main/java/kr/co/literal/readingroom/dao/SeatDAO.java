package kr.co.literal.readingroom.dao;

import kr.co.literal.readingroom.dto.SeatDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

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
	 
}
