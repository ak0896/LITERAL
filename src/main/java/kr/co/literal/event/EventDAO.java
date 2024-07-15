package kr.co.literal.event;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EventDAO {
	
	public EventDAO()
	{
		System.out.println("----- EventDAO() 객체 생성");
	} // public EventDAO() end
	
	
	@Autowired
	SqlSession sqlSession;

	// 상품 전체 리스트
    public List<Map<String, Object>> list(){
        return sqlSession.selectList("event.list");
    }//list() end
    
    // 상세 내용
	public Map<String, Object> detail(String event_code)
	{
		return sqlSession.selectOne("event.detail", event_code);
	} // public Map<String, Object> detail() end
	

	
	
	// 관리자 페이지
	// (관리자)상품 전체 리스트
    public List<Map<String, Object>> adlist(){
        return sqlSession.selectList("event.adlist");
    }//list() end
    
    
	// 생성된 event_code 불러오기
    public String eventcode() {
    	return sqlSession.selectOne("event.eventcode");
    } // public String eventcode end
    
    
    // insert
    public void insert(Map<String, Object> map) {
    	sqlSession.insert("event.insert", map);
    } // public void insert end
    
    // 상세 내용
	public Map<String, Object> addetail(String event_code)
	{
		return sqlSession.selectOne("event.addetail", event_code);
	} // public Map<String, Object> detail() end
	
    // update
    public void adupdate(Map<String, Object> map) {
    	sqlSession.update("event.adupdate", map);
    } // public void insert end
	
} // public class EventDAO end
