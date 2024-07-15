package kr.co.literal.worldcup;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CupDAO {
	public CupDAO()
	{
		System.out.println("---- CupDAO() 객체 생성");
	} // public CupDAO() end

	@Autowired
	SqlSession sqlSession;
	
	
	// 책 월드컵 전체 리스트
    public List<Map<String, Object>> acuplist(){
        return sqlSession.selectList("cup.acuplist");
    }//acuplist() end
	
    
	// 생성된 worldcup_code 불러오기
    public String worldcupcode() {
    	return sqlSession.selectOne("cup.worldcupcode");
    } // public String worldcupcode end
    
    
    // 책 월드컵 insert
	public void insert(Map<String, Object> map)
	{
		sqlSession.insert("cup.insert", map);
	} // public void insert end
	
	
    // 장르별 고유한 책 목록 가져오기
	public List<Map<String, Object>> getgenrelist(String genre_code){
		return sqlSession.selectList("cup.genrelist", genre_code);
	}
	
	
    // 책 정보 가져오기
    public Map<String, Object> getBookyNumber(String book_number) {
        return sqlSession.selectOne("cup.getBookInfoByNumber", book_number);
    }
	
	
    // 월드컵 결과 저장
    public void insertResult(Map<String, Object> resultData) {
        sqlSession.insert("cup.insertResult", resultData);
    }
    
	
	// 결과 저장 리스트
    public List<Map<String, Object>> aresultlist(){
        return sqlSession.selectList("cup.aresultlist");
    }//acuplist() end
 
} // public class CupDAO end
