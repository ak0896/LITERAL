package kr.co.literal.mypage;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.literal.member.MemberDAO;
import kr.co.literal.member.MemberDTO;
import kr.co.literal.product.ProductDAO;
import kr.co.literal.product.ProductDTO;
import kr.co.literal.product.WishlistDTO;


@Controller
@RequestMapping("/mypage")
public class MypageCont {
	
	@Autowired
    private MypageDAO mypageDao;
	
	@Autowired
    private MemberDAO memberDao;
	
	
	// main 폼을 보여주는 메서드
    @GetMapping("/mypage_main")
    public String showMypageForm() {
        return "mypage/mypage_main"; //메인 페이지로 이동
    }
    
	@RequestMapping("/inquiry_list")
	public ModelAndView list(HttpSession session) {
		//로그인 했다면
		String s_id = (String) session.getAttribute("email");
		System.out.println("Session email: " + s_id);
		
		ModelAndView mav = new ModelAndView();
		if (s_id != null) {
	        mav.setViewName("mypage/inquiry_list");
	        mav.addObject("inquiry_list", mypageDao.inquiry_list(s_id));
	    } else {
	    	mav.setViewName("redirect:/member/login"); // 세션에 이메일이 없는 경우 로그인 페이지로 리다이렉트
	    }
		return mav;
		
	}
	
	@GetMapping("/inquiry_write")
	public String write() {
		return "mypage/inquiry_write";
	}
	
	@PostMapping("/inquiry_insert")
	public String inquiryInsert(@ModelAttribute InquiryDTO inquiryDto, HttpSession session) {
		  //로그인 기능을 구현했다면 session.getAttribute() 활용
	    String email = (String) session.getAttribute("email");
	    
	    
	    if (email != null) {
	        
	    	inquiryDto.setEmail(email);
	        int cnt=mypageDao.inquiry_insert(inquiryDto);
	        
	        if (cnt > 0) {
                System.out.println("인서트 성공, 이메일 전송 준비");
                // 업데이트 성공 시 이메일 전송
                sendEmail_inquiry_member(inquiryDto);
            } else {
                System.out.println("인서트 실패, 이메일 전송 안함");
            }
	        
	        return "redirect:/mypage/inquiry_list?email=" + inquiryDto.getEmail();
	        
	    } else {
	        return "redirect:/login"; // 세션에 이메일이 없는 경우 로그인 페이지로 리다이렉트
	    }
	}
	 
	private void sendEmail_inquiry_member(InquiryDTO inquiryDto) {
        // 이메일 전송 로직
        try {
            String mailServer = "smtp.gmail.com"; // Gmail SMTP 서버
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
            props.put("mail.smtp.host", mailServer);
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");

            // Gmail 계정 인증 정보
            final String username = "aekyung0896@gmail.com";
            final String password = "kphszxcjoerrbvyf";

            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });
            
            System.out.println("Sending email to: " + inquiryDto.getEmail());

            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(username));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(inquiryDto.getEmail()));
            msg.setSubject("[literal] 문의");
            msg.setContent("고객님의 문의글이 저장 되었습니다<br> 확인이 되는대로 바로 답글 남기겠습니다.<br>바쁘시겠지만, 시간을 갖고 기다려 주세요.", "text/html; charset=UTF-8");
            msg.setSentDate(new Date());
            Transport.send(msg);
            
            System.out.println("메일이 성공적으로 전송되었습니다.");
            
        } catch (Exception e) {
            System.out.println("문의 답변 이메일 전송 실패: " + e);
            e.printStackTrace(); // 예외 로그 출력
        }//try end
    }
	
	@PostMapping("/inquiry_delete")
	public String delete(HttpServletRequest req, HttpSession session) {
		int inquiry_code = Integer.parseInt(req.getParameter("inquiry_code"));
		
		InquiryDTO inquiryDto = new InquiryDTO();
		inquiryDto.setInquiry_code(inquiry_code);
		inquiryDto.setEmail((String) session.getAttribute("email"));
		mypageDao.inquiry_delete(inquiryDto);
	
		return "redirect:/inquiry_list?email=" + inquiryDto.getEmail();		
	}
	
	
    @PostMapping("/wishlist/add")
    public Map<String, Object> addWishlist(@RequestBody Map<String, String> payload) {
        String bookNumber = payload.get("bookNumber");
        // 찜 목록에 책 추가 로직 구현
        // 예시: wishlistService.addWishlist(bookNumber);
        Map<String, Object> response = new HashMap<>();
        response.put("status", "success");
        response.put("message", "Book added to wishlist");
        return response;
    }

    @PostMapping("/wishlist/remove")
    public Map<String, Object> removeWishlist(@RequestBody Map<String, String> payload) {
        String bookNumber = payload.get("bookNumber");
        // 찜 목록에서 책 제거 로직 구현
        // 예시: wishlistService.removeWishlist(bookNumber);
        Map<String, Object> response = new HashMap<>();
        response.put("status", "success");
        response.put("message", "Book removed from wishlist");
        return response;
    }
    
	
  //찜하기	

  	@GetMapping("/wishlist")
      public ModelAndView viewWishlist(HttpSession session) {
      	String s_id = (String) session.getAttribute("email");
  		System.out.println("Session email: " + s_id);
  		
  		ModelAndView mav = new ModelAndView();
  		if (s_id != null) {
  	        mav.setViewName("mypage/wishlist");
  	        mav.addObject("wishlist", mypageDao.wishlist(s_id));
  	    } else {
  	    	mav.setViewName("redirect:/member/login");
  	    }
  		return mav;
      }
  	
  	
  	@PostMapping("/wishlist_delete")
	public String wishlist_delete(HttpServletRequest req, HttpSession session) {
		int wishlist_code = Integer.parseInt(req.getParameter("wishlist_code"));
		
		WishlistDTO wishlistDto = new WishlistDTO();
		wishlistDto.setWishlist_code(wishlist_code);
		wishlistDto.setEmail((String) session.getAttribute("email"));
		mypageDao.wishlist_delete(wishlistDto);
	
		
		return "redirect:/mypage/wishlist?email=" + wishlistDto.getEmail();		
	}
  	
}//class end
