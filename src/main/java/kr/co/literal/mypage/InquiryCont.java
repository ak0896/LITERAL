package kr.co.literal.mypage;



import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping("/inquiry")
public class InquiryCont {
	public InquiryCont() {
		System.out.println("-----InquiryCont() 객체생성");
		
	}
	@Autowired
	InquiryDAO inquiryDao;
	
	 @GetMapping("/inquiry_list")
	 public ModelAndView inquiry_list(@RequestParam("email") String email,  HttpSession session) {
	 	 ModelAndView mav = new ModelAndView();
	 	 mav.setViewName("mypage/inquiry_list");
	 	 mav.addObject("list", inquiryDao.inquiry_list(email));
	 	 return mav;
	 }
	 
	 
//	 @GetMapping("/faq_write")
//	 	public String write() {
//		 return "notice/faq_write";
//	 }
//	 
//	 @PostMapping("/faq_insert")
//	 	public String faq_insert(@ModelAttribute FaqDTO faqDto) {
//		 faqDao.faq_insert(faqDto);
//		 return "redirect:/notice/faq_list";
//	 }
//	 
//	 @PostMapping("/faq_delete")
//	 	public String delete(@RequestParam("faq_code") int faq_code) {
//		 faqDao.faq_delete(faq_code);
//		 return "redirect:/notice/faq_list";
//	 }
//	 
//	 @GetMapping("faq_update")
//	 	public ModelAndView update(@RequestParam("faq_code") int faq_code) {
//		 ModelAndView mav= new ModelAndView();
//		 FaqDTO faq = faqDao.faq_update(faq_code);
//		 mav.addObject("faq",faq);
//		 return mav;
//	 }
//	 
//	 @PostMapping("/faq_updateproc")
//	 	public String updateproc(@ModelAttribute FaqDTO faqDto) {
//		 int cnt=faqDao.faq_updateproc(faqDto);
//		 return "redirect:/notice/faq_list";
//	 }
	
	
}//class
