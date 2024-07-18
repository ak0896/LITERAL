package kr.co.literal.cart;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import jakarta.servlet.http.HttpSession;
import kr.co.literal.product.ProductDTO;

@Repository
public class CartDAO {

    public CartDAO() {
        System.out.println("-----CartDAO() 객체생성");
    }

    @Autowired
    SqlSession sqlSession;

	public int cartInsert (CartDTO cartDto)
	{
		return sqlSession.insert("cart.insert", cartDto);
	}
	
	
	public List<CartDTO> cartlist(String id)
	{
		return sqlSession.selectList("cart.cartlist", id);
	} // public List<CartDTO> end

	
	public int cartDelete(HashMap<String, Object> map)
	{
		return sqlSession.delete("cart.delete", map);
	} // public int cartDelete() end
	 
	
	public List<Map<String, Object>> cartList2(String id) 
	{
		return sqlSession.selectList("cart.list2", id);
	}//cartList() end // public List cartList2() end
	
} // public class CartDAO end
