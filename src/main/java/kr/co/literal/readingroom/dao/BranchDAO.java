package kr.co.literal.readingroom.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.literal.admin.DailySalesDTO;
import kr.co.literal.readingroom.dto.BranchDTO;


@Repository
public class BranchDAO {
	
	@Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "kr.co.literal.readingroom.ReadingRoomMapper";
	
    //지점등록
    public void insertBranch(BranchDTO branch) {
        sqlSession.insert(NAMESPACE + ".insertBranch", branch);
    }//insertBranch() end

    
    //branch_code 생성
    public String getLastBranchCode() {
    	return sqlSession.selectOne(NAMESPACE + ".getLastBranchCode");
    }//getLastBranchCode() end
    
    
    //지점코드로 지점정보 가져오기
    public BranchDTO selectBranchByCode(String branch_code) {
        return sqlSession.selectOne(NAMESPACE + ".selectBranchByCode", branch_code);
    }//selectBranchByCode() end
    
    
    //이름으로 지점정보 가져오기
    public BranchDTO selectBranchByName(String branch_name) {
    	return sqlSession.selectOne(NAMESPACE + ".selectBranchByName", branch_name);
    }//selectBranchByName() end
    
    
    //모든지점
    public List<BranchDTO> selectAllBranches() {
        return sqlSession.selectList(NAMESPACE + ".selectAllBranches");
    }//selectAllBranches() end
    
    
    //지점수정
    public void updateBranch(BranchDTO branchDTO) {
        sqlSession.update(NAMESPACE + ".updateBranch", branchDTO);
    }//updateBranch() end
    
    
    //지점삭제
    public void deleteBranch(String branch_code) {
        sqlSession.selectOne(NAMESPACE + ".deleteBranch", branch_code);
    }//deleteBranch() end
	
    
    
    
    //지점매출관리
    // daily_sales 데이터를 삽입하는 메소드
    public void insertDailySales(DailySalesDTO dailySalesDTO) {
        sqlSession.insert("kr.co.literal.admin.adminMapper.insertDailySales", dailySalesDTO);
    }

    // 지점 코드와 매출 날짜로 daily_sales 데이터를 조회하는 메소드
	    public DailySalesDTO selectDailySales(String branch_code, Date sales_date) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("branch_code", branch_code);
	        params.put("sales_date", sales_date);
	        return sqlSession.selectOne("kr.co.literal.admin.adminMapper.selectDailySales", params);
	    }

    // 모든 daily_sales 데이터를 조회하는 메소드
    public List<DailySalesDTO> selectAllDailySales() {
        return sqlSession.selectList("kr.co.literal.admin.adminMapper.selectAllDailySales");
    }

    // daily_sales 테이블의 데이터를 업데이트하는 메소드
    public void updateDailySales(DailySalesDTO dailySalesDTO) {
        sqlSession.update("kr.co.literal.admin.adminMapper.updateDailySales", dailySalesDTO);
    }

    // 지점 코드와 매출 날짜로 daily_sales 테이블의 데이터를 삭제하는 메소드
    public void deleteDailySales(String branch_code, String sales_date) {
        Map<String, Object> params = new HashMap<>();
        params.put("branch_code", branch_code);
        params.put("sales_date", sales_date);
        sqlSession.delete("kr.co.literal.admin.adminMapper.deleteDailySales", params);
    }
    
}
    
    

