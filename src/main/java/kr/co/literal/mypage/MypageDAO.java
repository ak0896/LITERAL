package kr.co.literal.mypage;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MypageDAO {
	
		private final SqlSession sqlSession;

		
		private static final String NAMESPACE = "kr.co.literal.mypage.mypageMapper";

	    @Autowired
	    public MypageDAO(SqlSession sqlSession) {
	        this.sqlSession = sqlSession;
	        System.out.println("----- MypageDAO()");
	    }
		
		
}//class end
