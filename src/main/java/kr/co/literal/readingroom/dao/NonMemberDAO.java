package kr.co.literal.readingroom.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.literal.readingroom.dto.BranchDTO;
import kr.co.literal.readingroom.dto.MyCouponDTO;
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
    
    public NonMemberDTO deleteNonMember(String nonmember_code) {
        return sqlSession.selectOne(NAMESPACE + ".deleteNonMember", nonmember_code);
    }
	

}//class end
