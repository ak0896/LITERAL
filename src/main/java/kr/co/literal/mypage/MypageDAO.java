package kr.co.literal.mypage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	



}//class end
