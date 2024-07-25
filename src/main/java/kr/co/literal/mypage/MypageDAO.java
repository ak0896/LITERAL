package kr.co.literal.mypage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.literal.product.ProductDTO;
import kr.co.literal.product.WishlistDTO;

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
	

    public void addWishlist(String bookNumber, String email) {
        Map<String, Object> params = new HashMap<>();
        params.put("bookNumber", bookNumber);
        params.put("email", email);
        sqlSession.insert("mypage.addWishlist", params);
    }

    
    public void removeWishlist(String bookNumber, String email) {
        Map<String, Object> params = new HashMap<>();
        params.put("bookNumber", bookNumber);
        params.put("email", email);
        sqlSession.delete("mypage.removeWishlist", params);
    }
    
    public List<WishlistDTO> wishlist(String email) {
        return sqlSession.selectList("mypage.wishlist", email);
    }
        
    public int wishlist_delete(WishlistDTO wishlistDto) {
		return sqlSession.delete("mypage.wishlist_delete",wishlistDto);
	}
	
    
}//class end
