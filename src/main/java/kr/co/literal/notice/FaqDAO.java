package kr.co.literal.notice;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FaqDAO {
	
	public FaqDAO() {
		System.out.println("-----FaqDAO() 객체생성");
	}
	
	@Autowired
	SqlSession sqlSession;
	

	
	public List<FaqDTO> faq_list() {
		return sqlSession.selectList("faq.faq_list");
	}//list
	
	public int faq_insert(FaqDTO faqDto) {
		return sqlSession.insert("faq.faq_insert",faqDto);
	}
	
	public void faq_delete(int faq_code) {
		sqlSession.delete("faq.faq_delete",faq_code);
	}
	
	public FaqDTO faq_update(int faq_code) {
		return sqlSession.selectOne("faq.faq_update",faq_code);
	} 
	
	public int faq_updateproc(FaqDTO faqDto) {
		return sqlSession.update("faq.faq_updateproc",faqDto);
	}
}
