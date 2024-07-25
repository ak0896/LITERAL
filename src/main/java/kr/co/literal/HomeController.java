package kr.co.literal;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.literal.product.ProductDTO;

@Controller
public class HomeController {
	
	public HomeController() {
	      System.out.println("-----HomeController()객체생성됨");
	}//end

	@Autowired
	HomeDAO homeDao;
	
   @GetMapping("/index")
   public ModelAndView index() {
       List<ProductDTO> topBooks = homeDao.best_book();
       List<ProductDTO> today_book = homeDao.today_book();
       
       ModelAndView mav = new ModelAndView();
       mav.setViewName("index");
       mav.addObject("topBooks", topBooks);  // "topBooks"와 JSP의 키 일치
       mav.addObject("today_book", today_book);

       return mav;
   }
   


}
