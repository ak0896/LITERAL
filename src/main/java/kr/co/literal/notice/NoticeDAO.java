package kr.co.literal.notice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO {
	public NoticeDAO() {
		System.out.println("-----NotieDAO() 객체생성됨");
	}
	
	@Autowired
	SqlSession sqlSession;
	
	public List<NoticeDTO> notice_list(Map<String, Object> params) {
	    return sqlSession.selectList("notice.notice_list", params);
	}

	public int notice_count() {
	    return sqlSession.selectOne("notice.notice_count");
	}
	
	 public void increaseViewCount(int notice_code) {
	        sqlSession.update("notice.increaseViewCount", notice_code);
	    }

	 public NoticeDTO selectNoticeById(int notice_code) {
		 	increaseViewCount(notice_code);
	        return sqlSession.selectOne("notice.selectNoticeById", notice_code);
	    }
	
	public int notice_insert(NoticeDTO noticeDto) {
		//return sqlSession.notice_insert("notice.notice_insert",noticeDto);
		return sqlSession.insert("notice.notice_insert",noticeDto);
		
	}
	
	public NoticeDTO notice_detail(int notice_code) {
		return sqlSession.selectOne("notice.notice_detail",notice_code);
	}
	
	 public NoticeDTO notice_update(int notice_code) {
	        return sqlSession.selectOne("notice.notice_update", notice_code);
	    }
	 
	 public int noticeUpdateProc(NoticeDTO noticeDto) {
	        return sqlSession.update("notice.notice_updateproc", noticeDto);
	    }
	 
	 public int notice_delete(int notice_code) {
		 return sqlSession.delete("notice.notice_delete",notice_code);
	 }
	
}

