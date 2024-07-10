package kr.co.literal.cart;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import kr.co.literal.product.ProductDTO;

@Controller
@RequestMapping("/cart")
public class CartCont {

    public CartCont() {
        System.out.println("-----CartCont() 객체생성");
    }

    @Autowired
    CartDAO cartDao;

    @PostMapping("/insert")
    public String cartInsert(@ModelAttribute CartDTO cartDto, HttpSession session) {
        String email = (String) session.getAttribute("email");
        if (email == null) {
            email = "hj960419@naver.com"; // 임시 이메일 지정, 실제로는 세션에서 가져와야 함
        }
        cartDto.setEmail(email);
        System.out.println("Received CartDTO: " + cartDto);

        ProductDTO product = cartDao.getProductByBookNumber(cartDto.getBook_number());
        if (product != null) {
            cartDto.setBook_title(product.getBook_title());
            cartDto.setSale_price(product.getSale_price());
        }

        cartDto.setSelect_yn(true); // 임의로 true로 지정

        cartDao.cartInsert(cartDto);
        System.out.println("cartDto1 :" + cartDto);

        return "redirect:/cart/cartList"; // 장바구니 목록 페이지 호출
    }

    @RequestMapping("/cartList")
    public ModelAndView list(HttpSession session) {
        String email = (String) session.getAttribute("email");
        if (email == null) {
            email = "hj960419@naver.com"; // 임시 이메일 지정, 실제로는 세션에서 가져와야 함
        }

        List<CartDTO> cartItems = cartDao.cartList(email);

        ModelAndView mav = new ModelAndView("cart/cartList");
        mav.addObject("list", cartItems);

        System.out.println("mav :" + mav);

        return mav;
    }
    
    @PostMapping("/deleteSelected")
    public String cartDeleteSelected(@RequestParam(value = "selected", required = false) List<String> selectedCartItems, HttpSession session) {
        if (selectedCartItems == null || selectedCartItems.isEmpty()) {
            return "redirect:/cart/cartList"; // 선택된 항목이 없으면 그냥 목록 페이지로 리디렉션
        }

        String email = (String) session.getAttribute("email");
        if (email == null) {
            email = "hj960419@naver.com"; // 임시 이메일 지정, 실제로는 세션에서 가져와야 함
        }

        List<Integer> cartCodes = new ArrayList<>();
        for (String selectedCartItem : selectedCartItems) {
            String[] parts = selectedCartItem.split("-");
            int cartCode = Integer.parseInt(parts[0]);
            cartCodes.add(cartCode);
        }

        cartDao.deleteSelected(email, cartCodes);

        return "redirect:/cart/cartList";
    }
}
