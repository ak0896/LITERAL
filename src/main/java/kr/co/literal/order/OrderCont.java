package kr.co.literal.order;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/order")
public class OrderCont {
	
	public OrderCont() {
		System.out.println("-----OrderCont() 객체생성");
		
	}
	
	 @GetMapping("/orderDetail")
	    public String orderDetail() {

	        return "order/orderDetail";
	    }
	
}
