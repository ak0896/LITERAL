package kr.co.literal.readingroom.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.literal.readingroom.dto.BranchDTO;
import kr.co.literal.readingroom.dto.ReservationDTO;
import kr.co.literal.readingroom.dto.SeatDTO;

@Repository
public class BranchDAO {
	
	@Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "kr.co.literal.readingroom.ReadingRoomMapper";
	
    public void insertBranch(BranchDTO branch) {
        sqlSession.insert(NAMESPACE + ".insertBranch", branch);
    }

    //특정지점
    public BranchDTO selectBranchByCode(String branch_code) {
        return sqlSession.selectOne(NAMESPACE + ".selectBranchByCode", branch_code);
    }
    
    //모든지점
    public List<BranchDTO> selectAllBranches() {
        return sqlSession.selectList(NAMESPACE + ".selectAllBranches");
    }
    
    //지점삭제
    public BranchDTO deleteBranch(String branch_code) {
        return sqlSession.selectOne(NAMESPACE + ".deleteBranch", branch_code);
    }
	

}

