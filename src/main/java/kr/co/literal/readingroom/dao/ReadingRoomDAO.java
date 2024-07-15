package kr.co.literal.readingroom.dao;

import kr.co.literal.readingroom.dto.ReadingRoomDTO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class ReadingRoomDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "kr.co.literal.readingroom.ReadingRoomMapper";
    
    
    
    public void insertReadingRoom(ReadingRoomDTO readingRoom) {
        sqlSession.insert(NAMESPACE + ".insertReadingRoom", readingRoom);
    }

    public List<ReadingRoomDTO> selectAllReadingRooms() {
        return sqlSession.selectList(NAMESPACE + ".selectAllReadingRooms");
    }

    public ReadingRoomDTO selectReadingRoomByCode(String room_code) {
        return sqlSession.selectOne(NAMESPACE + ".selectReadingRoomByCode", room_code);
    }

    public void updateReadingRoom(String room_code) {
        sqlSession.update(NAMESPACE + ".updateReadingRoom", room_code);
    }

    public void deleteReadingRoom(String room_code) {
        sqlSession.delete(NAMESPACE + ".deleteReadingRoom", room_code);
    }
    

}
