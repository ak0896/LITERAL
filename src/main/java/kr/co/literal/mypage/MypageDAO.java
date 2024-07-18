package kr.co.literal.mypage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.literal.product.ProductDTO;

@Repository
public class MypageDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
    public MypageDAO(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
        System.out.println("----- MypageDAO()");
    }
    
    //회원1:1문의
	public List<InquiryDTO> inquiry_list(String email){
		return sqlSession.selectList("mypage.inquiry_list", email);
	}//list() end
	
	public int inquiry_insert(InquiryDTO inquiryDto) {
		return sqlSession.insert("mypage.inquiry_insert",inquiryDto);
	}
	
	public int inquiry_delete(InquiryDTO inquiryDto) {
		return sqlSession.delete("mypage.inquiry_delete",inquiryDto);
	}
	
	
	
/*	
	// wisthlist
    // wishlist에 항목을 추가하는 메서드
    public void insertWishlist(String email, String book_number) {
        Map<String, Object> params = new HashMap<>();
        params.put("email", email);
        params.put("book_number", book_number);
        sqlSession.insert("mypage.insertWishlist", params);
    }

    // wishlist에서 항목을 삭제하는 메서드
    public void deleteWishlist(String email, String book_number) {
        Map<String, Object> params = new HashMap<>();
        params.put("email", email);
        params.put("book_number", book_number);
        sqlSession.delete("mypage.deleteWishlist", params);
    }

    // wishlist 조회 메서드
    public List<ProductDTO> getWishlist(String email) {
        return sqlSession.selectList("mypage.getWishlist", email);
    }
*/
    

    
}//class end
