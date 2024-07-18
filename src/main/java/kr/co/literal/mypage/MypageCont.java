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
	        
	        return "redirect:/inquiry_list?email=" + inquiryDto.getEmail();
	        
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
	
	
/*	
	// wishlist 추가 및 삭제
	@PostMapping("/updateWishlist")
    public String updateWishlist(@RequestParam("book_number") String book_number,
                                 @RequestParam("wish") boolean wish,
                                 Model model, HttpSession session) {
        String email = (String) session.getAttribute("email");

        try {
	            // email이 member 테이블에 존재하는지 확인하는 코드
	            MemberDTO member = memberDao.getMemberByEmail(email);
	            if (member != null && member.getEmail().equals(email)) {
	                if (wish) {
	                    // DAO 메서드를 호출하여 wishlist 테이블에 데이터 삽입
	                    mypageDao.insertWishlist(email, book_number);
	                } else {
	                    // DAO 메서드를 호출하여 wishlist 테이블에서 데이터 삭제
	                    mypageDao.deleteWishlist(email, book_number);
	                }
	                model.addAttribute("successMessage", "찜 상태가 업데이트되었습니다.");
            } else {
                model.addAttribute("errorMessage", "존재하지 않는 이메일입니다.");
            }
        } catch (Exception e) {
            model.addAttribute("errorMessage", "찜 상태 변경에 실패했습니다.");
        }

        // 페이지를 다시 로드하여 변경사항을 반영
        return "redirect:/product/productlist"; // 리다이렉트할 경로를 정확히 지정하세요
    }
	
	
	@RequestMapping("/wishlist")
	public ModelAndView getWishlist() {
		
	   ModelAndView mav = new ModelAndView();
	   mav.addObject("list", mypageDao.getWishlist("email"));
	   
	   mav.setViewName("/mypage/wishlist");
	   return mav;
	 } // getWishlist() end
*/
	
	
}//class end
