package kr.co.literal.cart;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import kr.co.literal.product.ProductDTO;

@Repository
public class CartDAO {

    public CartDAO() {
        System.out.println("-----CartDAO() 객체생성");
    }

    @Autowired
    SqlSession sqlSession;

    public int cartInsert(CartDTO cartDto) {
        return sqlSession.insert("cart.insert", cartDto);
    }

    public List<CartDTO> cartList(String email) {
        return sqlSession.selectList("cart.list", email);
    }

    public int deleteSelected(String email, List<Integer> cartCodes) {
        Map<String, Object> params = new HashMap<>();
        params.put("email", email);
        params.put("cart_codes", cartCodes);
        return sqlSession.delete("cart.deleteSelected", params);
    }

    public ProductDTO getProductByBookNumber(String book_number) {
        return sqlSession.selectOne("cart.getProductByBookNumber", book_number);
    }
}
