package kr.co.literal.readingroom.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.literal.readingroom.dto.NonMemberDTO;

@Repository
public class NonMemberDAO {
    
    @Autowired
    private SqlSession sqlSession;
    
    private static final String NAMESPACE = "kr.co.literal.readingroom.ReadingRoomMapper";

    public void insertNonMember(NonMemberDTO non_member) {
        sqlSession.insert(NAMESPACE + ".insertNonMember", non_member);
    }
    
    public List<NonMemberDTO> selectAllNonMembers() {
        return sqlSession.selectList(NAMESPACE + ".selectAllNonMembers");
    }
    
    public NonMemberDTO selectNonMemberByCode(String nonmember_code) {
        return sqlSession.selectOne(NAMESPACE + ".selectNonMemberByCode", nonmember_code);
    }

    public void updateNonMember(NonMemberDTO non_member) {
        sqlSession.update(NAMESPACE + ".updateNonMember", non_member);
    }
    
    public void deleteNonMember(int nonmember_code) {
    int result = sqlSession.delete(NAMESPACE + ".deleteNonMember", nonmember_code);
    System.out.println("Deleted rows: " + result);  // 삭제된 행 수 출력
}

    public NonMemberDTO findNonMember(String reservationCode, String non_name, String non_phone) {
        return sqlSession.selectOne(NAMESPACE + ".findNonMember", Map.of("non_name", non_name, "non_phone", non_phone));
    }
}
