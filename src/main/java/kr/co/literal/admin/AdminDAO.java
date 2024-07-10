package kr.co.literal.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.literal.member.MemberDTO;

@Repository
public class AdminDAO {

	    public AdminDAO() {
	    	 System.out.println("----- AdminDAO() 객체 생성");
		}
	    
		@Autowired
		private SqlSession sqlSession;
	    
	    private static final String NAMESPACE = "kr.co.literal.admin.adminMapper";


	    // 회원 목록 조회
	    public List<MemberDTO> getAllMembers() {
	        return sqlSession.selectList(NAMESPACE + ".getAllMembers");
	    }
	    
	    // 상품 목록 조회
	    public List<Map<String, Object>> list(){
	        return sqlSession.selectList("kr.co.literal.admin.adminMapper.list");
	    }//list() end
	    
	    // 상품 상세
		public Map<String, Object> detail(String book_number)
		{
			return sqlSession.selectOne("kr.co.literal.admin.adminMapper.detail", book_number);
		} // public Map<String, Object> detail() end
		
		// 상품 검색
	    public List<Map<String, Object>> search(String book_title) { //검색어
	        return sqlSession.selectList("kr.co.literal.admin.adminMapper.search", "%" + book_title + "%");
	    }//search() end

	    // 상품 수정
		public void update(Map<String, Object> map)
		{
			sqlSession.update("kr.co.literal.admin.adminMapper.update", map);
		} // public void update() end
		
		// 이미지
	    public String img(String book_number) {
	        return sqlSession.selectOne("kr.co.literal.admin.adminMapper.img", book_number);
	    }//filename() end
	    
}//AdminDAO() end
