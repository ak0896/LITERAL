package kr.co.literal;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import kr.co.literal.product.ProductDTO;

@Repository
public class HomeDAO {

    public HomeDAO() {
        System.out.println("-----HomeDAO() 객체생성");
    }

    @Autowired
    SqlSession sqlSession;
    
    public List<ProductDTO> best_book() {
        return sqlSession.selectList("home.best_book");
    }

    public List<ProductDTO> today_book() {
        return sqlSession.selectList("home.today_book");
    }
    
}
