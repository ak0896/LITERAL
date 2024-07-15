package kr.co.literal.admin;

import java.io.File;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import kr.co.literal.member.MemberDAO;
import kr.co.literal.member.MemberDTO;
import kr.co.literal.mypage.InquiryDTO;
import kr.co.literal.product.ProductDAO;
import net.utility.Utility;
import org.springframework.web.bind.annotation.RequestBody;


@Controller
@RequestMapping("/admin")
public class AdminCont {

		
		@Autowired
		private MemberDAO memberDAO;
		
		@Autowired
		private AdminDAO adminDao;
		
		
		// 관리자 메인 페이지
	    @GetMapping("")
	    public String showAdminForm() {
	        return "admin/ad_main"; 
	    }

	    // 회원 목록 조회
	    @GetMapping("/memberList")
	    public String showMemberList(Model model) {
	        List<MemberDTO> members = memberDAO.getAllMembers();
	        System.out.println("showMemberList: members size = " + members.size());
	        model.addAttribute("members", members);
	        return "admin/memberList"; 
	    }
	    

	    // 회원 삭제 처리 메서드
	    @PostMapping("/deleteMember")
	    public String deleteMember(@RequestParam("email") String email) {
	    	memberDAO.deleteMember(email);
	        return "redirect:/admin/memberList";
	    }

	    // 회원 type_code 수정 처리 메서드
	    @PostMapping("/updateMemberType")
	    public String updateMemberType(@RequestParam("email") String email, @RequestParam("type_code") int type_code) {
	    	System.out.println("updateMemberType: email = " + email + ", type_code = " + type_code);
	    	memberDAO.updateMemberType(email, type_code);
	        return "redirect:/admin/memberList";
	    }
	    
	    
	    // 상품
	    // 상품 목록 조회
		@RequestMapping("/productlist_admin")
		public ModelAndView productlist() {
		   ModelAndView mav = new ModelAndView();
		   mav.addObject("list", adminDao.list());
		   mav.setViewName("/admin/productlist");
		   return mav;
		 } // list() end
	
	
		// 상품 상세
		@GetMapping("/aproductdetail/{book_number}")
		public ModelAndView productdetail(@PathVariable String book_number)
		{
			ModelAndView mav = new ModelAndView();
			mav.setViewName("/admin/aproductdetail");
			mav.addObject("product", adminDao.detail(book_number));
			
			return mav;
		} // public ModelAndView detail() end
		
		// 상품 검색
	    @GetMapping("/search")
	    public ModelAndView search(@RequestParam(defaultValue = "") String book_title) {
	        ModelAndView mav = new ModelAndView();
	        mav.setViewName("admin/productlist");
	        mav.addObject("list", adminDao.search(book_title));
	        mav.addObject("book_title", book_title);//검색어
	        return mav;
	    }//search() end
	
	    
	    // 상품 수정
	    @PostMapping("/update")
	     public String productupdate(@RequestParam Map<String, Object> map
	                      ,@RequestParam(value = "img") MultipartFile img, @RequestParam String book_number
	                       ,HttpServletRequest req) 
	    {

	        Map<String, Object> oldaProduct = adminDao.detail(book_number);
	        map.put("original_book_number", book_number);

	        // 기존 값이 null인 경우 기본값 설정
	        String original_genre_code = (String) oldaProduct.get("genre_code");
	        String original_book_code = (String) oldaProduct.get("book_code");
	        String original_book_number = (String) oldaProduct.get("book_number");

	        
	        // 새로운 장르 코드와 책 제목을 가져옴
	        String genre_code = (String) map.get("genre_code");
	        String book_title = (String) map.get("book_title");
	        
	        String book_code;
	        String new_book_number;
	        
	        if (!original_genre_code.equals(genre_code)) {
	            // 새로운 장르 코드에 따른 책 코드와 책 번호 생성
	            book_code = adminDao.generateBookCode(genre_code, book_title);
	            new_book_number = adminDao.generateBookNumber(genre_code, book_code, book_title);
	        } else {
	            // 기존 장르 코드와 같은 경우 책 코드와 책 번호를 유지
	            book_code = original_book_code;
	            new_book_number = adminDao.generateBookNumber(genre_code, book_code, book_title);
	        }
	        
	        map.put("book_code", book_code);
	        map.put("book_number", new_book_number);	        

			String img_name = "-";
			long img_size= 0;
	        
	        if(img.getSize()>0 && img!=null && !img.isEmpty()) {
	           //첨부된 파일이 존재한다면
	           ServletContext application = req.getServletContext();
	           String imageBasePath = application.getRealPath("/storage/images");
	           
	           try {
	        	   	  img_size = img.getSize();
		              String o_poster = img.getOriginalFilename();
		              img_name = o_poster;
		              
		              File file = new File(imageBasePath, o_poster); //파일클래스에 해당파일 담기
		              int i = 1;
		              
		              while(file.exists()) //파일이 존재한다면
		              {
		                  int lastDot = o_poster.lastIndexOf(".");
		                  img_name = o_poster.substring(0, lastDot) + "_" + i + o_poster.substring(lastDot); 
		                  file = new File(imageBasePath, img_name);
		                  i++;
		              }//while end
	               
	               img.transferTo(file); // 신규 파일 저장
	               
	               Utility.deleteFile(imageBasePath, oldaProduct.get("img").toString()); //기존 파일 삭제
	               
	            }catch(Exception e) {
	               System.out.println(e);
	            }//try end
	           
	        }else {
	           //첨부된 파일이 없다면
	        	img_name=oldaProduct.get("img").toString();
	        	img_size=Long.parseLong(oldaProduct.get("img_size").toString());
	        }//if end
	        
	        map.put("img", img_name);
	        map.put("img_size", img_size);
	        
	        //System.out.println("Final map for update: " + map); // 디버깅 로그 추가
	        
	        adminDao.update(map);
	        
	        return "redirect:/admin/productlist_admin";
	        
	     }//update() end		 
	    
	    
	    //1:1문의
	    @GetMapping("/ad_inquiry_list")
	    public String showInquiryList(@RequestParam(defaultValue = "1") int page,Model model) {
	    	int pageSize = 6; //페이지당 게시물 수
		    int offset = (page-1) * pageSize;
	    	
		    Map<String, Object> params = new HashMap<>();
		    params.put(("pageSize"), pageSize);
		    params.put("offset", offset);
	    	
	    	List<InquiryDTO> inquiryList = adminDao.ad_inquiry_list(params);
	    	int totalinquiry = adminDao.inquiry_list_count();
		    int totalpage = (int) Math.ceil((double) totalinquiry / pageSize);
	    	
	    	model.addAttribute("ad_inquiry",inquiryList);
	    	model.addAttribute("totalpage", totalpage);
	 	    model.addAttribute("currentpage", page);
	    	return "admin/ad_inquiry_list";
	    			
	    }
	    
	    @GetMapping("/ad_inquiry_detail")
	    public ModelAndView showInquiryDetail(@RequestParam("inquiry_code") int inquiry_code) {
	    	ModelAndView mav = new ModelAndView();
	    	mav.setViewName("admin/ad_inquiry_detail");
	    	mav.addObject("inquiry",adminDao.ad_inquiry_detail(inquiry_code));
	    	return mav;
	    }
	    
	    @PostMapping("/ad_inquiry_update")
	    public String adInquiryUpdate(@ModelAttribute InquiryDTO inquiryDto) {
	    	try {
	            // InquiryDTO에서 inquiry_answer가 null이면 빈 문자열로 설정
	            if (inquiryDto.getInquiry_answer() == null) {
	                inquiryDto.setInquiry_answer("");
	            }
	            
	            int cnt = adminDao.ad_inquiry_update(inquiryDto);
	            System.out.println("업데이트 결과: " + cnt);
	            
	            if (cnt > 0) {
	                System.out.println("업데이트 성공, 이메일 전송 준비");
	                // 업데이트 성공 시 이메일 전송
	                sendEmail_inquiry(inquiryDto);
	            } else {
	                System.out.println("업데이트 실패, 이메일 전송 안함");
	            }
	        } catch (Exception e) {
	            System.out.println("오류 발생: " + e.getMessage());
	            e.printStackTrace();
	        }
	    	 return "redirect:/admin/ad_inquiry_detail?inquiry_code=" + inquiryDto.getInquiry_code();
	    }
	    
	    private void sendEmail_inquiry(InquiryDTO inquiryDto) {
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
	            msg.setSubject("[literal] 문의 답변");
	            msg.setContent("고객님 문의글에 답글이 달렸습니다.<br>답글을 확인해주세요", "text/html; charset=UTF-8");
	            msg.setSentDate(new Date());
	            Transport.send(msg);
	            
	            System.out.println("메일이 성공적으로 전송되었습니다.");
	            
	        } catch (Exception e) {
	            System.out.println("문의 답변 이메일 전송 실패: " + e);
	            e.printStackTrace(); // 예외 로그 출력
	        }//try end
	    }
	    
	    
}//AdminCont() end
