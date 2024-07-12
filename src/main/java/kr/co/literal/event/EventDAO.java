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
    
    public String NewEventCode() {
    	String newCodeNumber = sqlSession.selectOne("event.getEventCode");
        return String.format("event%03d", newCodeNumber);
    }
    
    // 주어진 책 제목으로 책 코드를 가져오는 메서드
    public String get_eventcodeTitle(String event_code, String event_title) {
    	List<String> evCodes = sqlSession.selectList("eventgetBookCodeByTitle", event_title);
      
    	if (evCodes.isEmpty()) {
            return null;
        } else {
            return evCodes.get(0); // 첫 번째 결과를 반환
        }
    } // public String getBookCodeByTitle() end
    
    // 이벤트 코드 생성
    public String geteventcode(String event_code, String event_title) {
    	String codeNumber;

        // 이벤트가 데이터베이스에 존재하지 않는 경우
        if (!eventCodeExists(event_code, event_title)) {
            // 새로운 코드를 생성
            codeNumber = get_eventcode(event_code);
            event_code = String.format("%05d", codeNumber);
        } else {
            // 책 제목이 데이터베이스에 존재하는 경우
            // 해당 책 제목에 해당하는 기존 책 코드를 가져옴
        	event_code = get_eventcodeTitle(event_code, event_title);
        }

        return event_code;
    } //  public String generateBookCode() end
    
    
    private String get_eventcode(String event_code) {
		// TODO Auto-generated method stub
		return null;
	}

	private boolean eventCodeExists(String event_code, String event_title) {
		// TODO Auto-generated method stub
		return false;
	}

	// insert
	public void insert(Map<String, Object> map)
	{
		sqlSession.insert("event.insert", map);
	} // public void insert end

    
    
    
    
    
} // public class EventDAO end
