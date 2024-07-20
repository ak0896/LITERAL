package kr.co.literal.event;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CupDAO {
	
    public CupDAO() {
        System.out.println("---- CupDAO() 객체 생성");
    }

    @Autowired
    SqlSession sqlSession;

    /* 사용자 */
    // 책 월드컵 전체 리스트
    public List<Map<String, Object>> cup_list() {
        return sqlSession.selectList("cup.cup_list");
    }
    
    // 상세 내용
	public Map<String, Object> cup_detail(String worldcup_code)
	{
		return sqlSession.selectOne("cup.cup_detail", worldcup_code);
	} // public Map<String, Object> detail() end
	
    
    
    
    /* 관리자 페이지 */
    // 책 월드컵 전체 리스트
    public List<Map<String, Object>> acup_list() {
        return sqlSession.selectList("cup.acup_list");
    }

    // 생성된 worldcup_code 불러오기
    public String worldcupcode() {
        return sqlSession.selectOne("cup.worldcupcode");
    }

    // 책 월드컵 insert
    public void acup_insert(Map<String, Object> map) {
        sqlSession.insert("cup.acup_insert", map);
    }

    // 상세 내용
	public Map<String, Object> acup_detail(String worldcup_code)
	{
		return sqlSession.selectOne("cup.acup_detail", worldcup_code);
	} // public Map<String, Object> detail() end
	
	
    // 장르별 고유한 책 목록 가져오기
    public List<Map<String, Object>> getgenrelist(String genre_code) {
        return sqlSession.selectList("cup.genrelist", genre_code);
    }

    // 책 정보 가져오기
    public Map<String, Object> getBookyNumber(String book_number) {
        return sqlSession.selectOne("cup.getBookyNumber", book_number);
    }
    

} // public class CupDAO end
