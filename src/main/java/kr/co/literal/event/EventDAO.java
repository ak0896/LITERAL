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
    public List<Map<String, Object>> event_list(){
        return sqlSession.selectList("event.event_list");
    }//list() end
    
    // 상세 내용
	public Map<String, Object> event_detail(String event_code)
	{
		return sqlSession.selectOne("event.event_detail", event_code);
	} // public Map<String, Object> detail() end
	

	
	
	// 관리자 페이지
	// (관리자)상품 전체 리스트
    public List<Map<String, Object>> aevent_list(){
        return sqlSession.selectList("event.aevent_list");
    }//list() end
    
    
	// 생성된 event_code 불러오기
    public String eventcode() {
    	return sqlSession.selectOne("event.eventcode");
    } // public String eventcode end
    
    
    // insert
    public void aevent_insert(Map<String, Object> map) {
    	sqlSession.insert("event.aevent_insert", map);
    } // public void insert end
    
    // 상세 내용
	public Map<String, Object> aevent_detail(String event_code)
	{
		return sqlSession.selectOne("event.aevent_detail", event_code);
	} // public Map<String, Object> detail() end
	
    // update
    public void aevent_update(Map<String, Object> map) {
    	sqlSession.update("event.adupdate", map);
    } // public void insert end
	
} // public class EventDAO end
