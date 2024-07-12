package kr.co.literal.pcomment;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PcommentDAO {
	
	public PcommentDAO()
	{
		System.out.println("----- PcommentDAO() 객체 생성됨");
	} // public PcommentDAO() end
	
	
	@Autowired
	SqlSession sqlSession;
	
    public int commentInsert(PcommentDTO pcommentDto) {
        return sqlSession.insert("pcomment.insert", pcommentDto);
    }//commentInsert() end
    
    
    public List<PcommentDTO> commentList(String book_number){
        return sqlSession.selectList("pcomment.list", book_number);
    }//list() end
    
    
    public int commentDelete(int pno) throws Exception{
        return sqlSession.delete("pcomment.delete", pno);
    }//delete() end
	
	
	
} // public class PcommentDAO en
