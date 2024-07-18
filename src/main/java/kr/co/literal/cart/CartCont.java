package kr.co.literal.cart;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.literal.member.MemberDTO;
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
	public String cartInsert(@ModelAttribute CartDTO cartDto, HttpServletRequest req,
							 RedirectAttributes redirectAttributes) // 리다이렉트 시에 사용할 속성을 주입받습니다.
	{	// 세션에서 "member" 값을 가져옵니다.
        HttpSession session = req.getSession();
        MemberDTO member = (MemberDTO) session.getAttribute("member");
        if (member == null) {
            // 사용자가 로그인하지 않은 경우 로그인 페이지로 리다이렉트합니다.
            redirectAttributes.addFlashAttribute("message", "로그인이 필요합니다.");
            return "redirect:/member/login";
        }

        cartDto.setEmail(member.getEmail()); // 로그인한 사용자의 이메일을 설정합니다.

		cartDao.cartInsert(cartDto);
		
		return "redirect:/cart/list";	// 장바구니 목록 페이지 호출
	} // public String cartInsert() end
	
    
	@RequestMapping("/cartList")
	public ModelAndView cartlist(HttpSession session)
	{	// 세션에서 "email" 값을 가져옵니다.
        String email = (String) session.getAttribute("email");
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("cart/cartList");	// WEB-INF/views/cart/list.jsp
		mav.addObject("cartlist", cartDao.cartlist(email));

		return mav;
	} // public ModelAttribute cartlist() end


    
	@GetMapping("/delete")
	public String delete(HttpServletRequest req, HttpSession session) 
	{	// DELETE FROM cart WHERE cartno = ? AND id = ?
		int cart_code = Integer.parseInt(req.getParameter("cart_code"));
		
		// MAP을 사용한 경우
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("cart_code", cart_code);
		
	    // session에서 email 값을 가져와서 map에 추가
	    String email = (String) session.getAttribute("email");
	    if (email != null) {
	        map.put("email", email);
	    } else {
	        // email이 null인 경우 처리 (예: 로그인 페이지로 리다이렉트)
	        return "redirect:/member/login";
	    }
	    
		cartDao.cartDelete(map);
		
		return "redirect:/cart/list";
	} // public String delete() end
	
	
    
    // 로그인 상태를 확인하는 엔드포인트 추가
    @GetMapping("/checkLogin")
    public ResponseEntity<Map<String, Boolean>> checkLogin(HttpSession session) {
        String email = (String) session.getAttribute("email");
        Map<String, Boolean> response = new HashMap<>();
        response.put("isLoggedIn", email != null);
        return ResponseEntity.ok(response);
    }
    
} // public class CartCont end
