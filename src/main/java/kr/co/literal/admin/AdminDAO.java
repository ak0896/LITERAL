package kr.co.literal.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.literal.member.MemberDTO;
import kr.co.literal.mypage.InquiryDTO;

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
	    
	    
	    
	    
	    // 상품
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
	    
	    // 장르 코드로 새로운 책 코드를 생성하는 메서드
	    public int genreBookCode(String genre_code) {
	        return sqlSession.selectOne(NAMESPACE + ".genreBookCode", genre_code);
	    } // public int genre_BookCode() end
	    
	    
	    // 주어진 장르 코드와 책 코드로 다음 책 번호를 가져오는 메서드
	    public int getNextBookNumber(String genre_code, String book_code) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("genre_code", genre_code);
	        params.put("book_code", book_code);

	        return sqlSession.selectOne(NAMESPACE + ".getNextBookNumber", params);
	    } // public int getNextBookNumber() end

	    
	    // 주어진 책 코드가 데이터베이스에 존재하는지 확인하는 메서드
	    public boolean bookCodeExists(String book_code) {
	        int count = sqlSession.selectOne(NAMESPACE + ".bookCodeExists", book_code);
	        return count > 0;
	    } // public boolean bookCodeExists() end

	    
	    // 주어진 책 번호가 데이터베이스에 존재하는지 확인하는 메서드
	    public boolean bookNumberExists(String genre_code, String book_number) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("genre_code", genre_code);
	        params.put("book_number", book_number);

	        int count = sqlSession.selectOne(NAMESPACE + ".bookNumberExists", params);
	        return count > 0;
	    } // public boolean bookNumberExists() end

	    
	    //  주어진 책 제목이 데이터베이스에 존재하는지 확인하는 메서드
	    public boolean bookTitleExists(String genre_code, String book_title) {
	        int count = sqlSession.selectOne(NAMESPACE + ".bookTitleExists", Map.of("genreCode", genre_code, "book_title", book_title));
	        return count > 0;
	    } // public boolean bookTitleExists() end

	    
	    // 주어진 책 제목으로 책 코드를 가져오는 메서드
	    public String getBookCodeByTitle(String genre_code, String book_title) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("genre_code", genre_code);
	        params.put("book_title", book_title);

	        return sqlSession.selectOne(NAMESPACE + ".getBookCodeByTitle", params);
	    }
	    
	    // 책 코드 생성 메서드
	    public String generateBookCode(String genre_code, String book_title) {
	        String book_code;
	        Map<String, Object> params = new HashMap<>();
	        params.put("genre_code", genre_code);
	        params.put("book_title", book_title);

	        // 책 제목이 데이터베이스에 존재하지 않는 경우
	        int bookTitleCount = sqlSession.selectOne(NAMESPACE + ".bookTitleExists", params);
	        if (bookTitleCount == 0) {
	            // 새로운 책 코드를 생성
	            int codeNumber = genreBookCode(genre_code);
	            book_code = genre_code + "-" + String.format("%05d", codeNumber);
	        } else {
	            // 책 제목이 데이터베이스에 존재하는 경우
	            // 해당 책 제목에 해당하는 기존 책 코드를 가져옴
	            book_code = getBookCodeByTitle(genre_code, book_title);
	        }

	        return book_code;
	    } // public String generateBookCode() end

	    
	    // 책 번호 생성 메서드
	    public String generateBookNumber(String genre_code, String book_code, String book_title) {
	        // 다음 책 번호를 생성
	        int nextNumber = getNextBookNumber(genre_code, book_code);
	        String book_number = book_code + String.format("%03d", nextNumber);

	        // 책 번호가 이미 존재하는 경우 중복을 피하기 위해 번호를 증가시킴
	        while (bookNumberExists(genre_code, book_number)) {
	            nextNumber++;
	            book_number = book_code + String.format("%03d", nextNumber);
	        }

	        return book_number;
	    }

	    
	    
	    //1:1 문의
	    public List<InquiryDTO> ad_inquiry_list(Map<String, Object> params){
	    	return sqlSession.selectList(NAMESPACE +".ad_inquiry_list",params);
	    }
	    
	    public int inquiry_list_count() {
		    return sqlSession.selectOne(NAMESPACE+".inquiry_list_count");
		}
	    
	    public void increaseViewCount(int inquiry_code) {
	        sqlSession.update(NAMESPACE+".increaseViewCount", inquiry_code);
	    }
	    
	    public InquiryDTO selectNoticeById(int inquiry_code) {
		 	increaseViewCount(inquiry_code);
	        return sqlSession.selectOne(NAMESPACE+".selectNoticeById", inquiry_code);
	    }
	    
	    public InquiryDTO ad_inquiry_detail(int inquiry_code) {
	    	return sqlSession.selectOne(NAMESPACE+".ad_inquiry_detail",inquiry_code);
	    }
	    
	    public int ad_inquiry_update(InquiryDTO inquiryDto) {
	    	return sqlSession.update(NAMESPACE+".ad_inquiry_update",inquiryDto);
	    }
	   
}//AdminDAO() end
