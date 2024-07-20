package kr.co.literal.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDAO {
	public ProductDAO()
	{
		System.out.println("----- ProductDAO() 객체 생성");
	} // public ProductDAO() end
	
	@Autowired
	SqlSession sqlSession;

	
	public void insert(Map<String, Object> map)
	{
		sqlSession.insert("kr.co.literal.product.ProductMapper.insert", map);
	} // public void insert end

	
	
    // 장르 코드로 새로운 책 코드를 생성하는 메서드
    public int genreBookCode(String genre_code) {
        return sqlSession.selectOne("kr.co.literal.product.ProductMapper.genreBookCode", genre_code);
    } // public int genre_BookCode() end
    
    
    // 주어진 장르 코드와 책 코드로 다음 책 번호를 가져오는 메서드
    public int getNextBookNumber(String genre_code, String book_code) {
        Map<String, Object> params = new HashMap<>();
        params.put("genre_code", genre_code);
        params.put("book_code", book_code);

        return sqlSession.selectOne("kr.co.literal.product.ProductMapper.getNextBookNumber", params);
    } // public int getNextBookNumber() end

    
    // 주어진 책 코드가 데이터베이스에 존재하는지 확인하는 메서드
    public boolean bookCodeExists(String book_code) {
        int count = sqlSession.selectOne("kr.co.literal.product.ProductMapper.bookCodeExists", book_code);
        return count > 0;
    } // public boolean bookCodeExists() end

    
    // 주어진 책 번호가 데이터베이스에 존재하는지 확인하는 메서드
    public boolean bookNumberExists(String genre_code, String book_number) {
      
    	Map<String, Object> params = new HashMap<>();
        params.put("genre_code", genre_code);
        params.put("book_number", book_number);
        
    	int count = sqlSession.selectOne("kr.co.literal.product.ProductMapper.bookNumberExists", Map.of("genreCode", genre_code, "book_number", book_number));
        return count > 0;
    } // public boolean bookNumberExists() end

    
    //  주어진 책 제목이 데이터베이스에 존재하는지 확인하는 메서드
    public boolean bookTitleExists(String genre_code, String book_title) {
        int count = sqlSession.selectOne("kr.co.literal.product.ProductMapper.bookTitleExists", Map.of("genreCode", genre_code, "book_title", book_title));
        return count > 0;
    } // public boolean bookTitleExists() end

    
    // 주어진 책 제목으로 책 코드를 가져오는 메서드
    public String getBookCodeByTitle(String genre_code, String book_title) {
        Map<String, Object> params = new HashMap<>();
        params.put("genre_code", genre_code);
        params.put("book_title", book_title);

        return sqlSession.selectOne("kr.co.literal.product.ProductMapper.getBookCodeByTitle", params);
    }
    
    
    // 책 코드 생성
    public String generateBookCode(String genre_code, String book_title) {
        String book_code;
        Map<String, Object> params = new HashMap<>();
        params.put("genre_code", genre_code);
        params.put("book_title", book_title);

        // 책 제목이 데이터베이스에 존재하지 않는 경우
        int bookTitleCount = sqlSession.selectOne("kr.co.literal.product.ProductMapper.bookTitleExists", params);
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
    } //  public String generateBookCode() end
   

    // 책 번호 생성 메서드
    public String generateBookNumber(String genre_code, String book_code) {
        // 생성된 책 코드에 대해 다음 책 번호를 생성
        int number = getNextBookNumber(genre_code, book_code);
        String book_number = book_code + String.format("%03d", number);

        // 책 번호가 이미 존재하는 경우 중복을 피하기 위해 번호를 증가시킴
        while (bookNumberExists(genre_code, book_number)) {
            number++;
            book_number = book_code + String.format("%03d", number);
        }
        
        //System.out.println("Generated book_number: " + book_number); // 디버깅 로그 추가

        return book_number;
    } // public String generateBookNumber() end
	    
    
    
    
    
    // 상품 상세
	public Map<String, Object> detail(String book_number)
	{
		return sqlSession.selectOne("kr.co.literal.product.ProductMapper.detail", book_number);
	} // public Map<String, Object> detail() end
	
	
	// 상단 바 검색
    public List<Map<String, Object>> search(String book_title) { //검색어
        return sqlSession.selectList("kr.co.literal.product.ProductMapper.search", "%" + book_title + "%");
    }//search() end
    
    
	// 상품 전체 리스트
    public List<Map<String, Object>> list(){
        return sqlSession.selectList("kr.co.literal.product.ProductMapper.list");
    }//list() end
	    
    public List<Map<String, Object>> list_G(){
        return sqlSession.selectList("kr.co.literal.product.ProductMapper.list_G");
    }//list_G() end
    
    public List<Map<String, Object>> list_M(){
        return sqlSession.selectList("kr.co.literal.product.ProductMapper.list_M");
    }//list_M() end
    
    public List<Map<String, Object>> list_H(){
        return sqlSession.selectList("kr.co.literal.product.ProductMapper.list_H");
    }//list_H() end
    
    public List<Map<String, Object>> list_S(){
        return sqlSession.selectList("kr.co.literal.product.ProductMapper.list_S");
    }//list_S() end
    
    public List<Map<String, Object>> list_R(){
        return sqlSession.selectList("kr.co.literal.product.ProductMapper.list_R");
    }//list_R() end
    
    public List<Map<String, Object>> list_P(){
        return sqlSession.selectList("kr.co.literal.product.ProductMapper.list_P");
    }//list_P() end
    
    public List<Map<String, Object>> list_T(){
        return sqlSession.selectList("kr.co.literal.product.ProductMapper.list_T");
    }//list_T() end
    
    public List<Map<String, Object>> list_W(){
        return sqlSession.selectList("kr.co.literal.product.ProductMapper.list_W");
    }//list_W() end
    // 상품 리스트 끝
    
    
    // 등록된 책
    public List<Map<String, Object>> selectTop3(String book_code) {
        return sqlSession.selectList("kr.co.literal.product.ProductMapper.selectTop3", book_code);
    } // selectTop3() end
    
    
    // 등록된 책에서 더보기
    public List<Map<String, Object>> selectAll(String book_code) {
        return sqlSession.selectList("kr.co.literal.product.ProductMapper.selectAll", book_code);
    } // selectTop3() end
    
    
    ////////////////////////////////////////////////////////////////
    //오늘 날짜에 등록된 책 리스트 조회 (0712애경추가)
    public List<ProductDTO> getTodayBookListByBranch(String branch_code) {
        return sqlSession.selectList("kr.co.literal.product.ProductMapper.getTodayBookListByBranch", branch_code);
    }//getTodayBookListByBranch() end
    
    
} // public class ProductDAO end
