package kr.co.literal.member;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.Properties;
import java.util.UUID;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/member")
public class MemberCont {


    @Autowired
    private MemberDAO memberDAO;

    @Autowired
    private KakaoService kakaoService;

		    
    	// 로그인 폼을 보여주는 메서드
	    @GetMapping("/login")
	    public String showLoginForm() {
	        return "member/loginForm"; // 로그인 폼 페이지로 이동
	    }//showLoginForm() end
   
	    
	    // 로그인 처리 메서드
	    @PostMapping("/login")
	    public String login(@RequestParam("email") String email, 
	                        @RequestParam("password") String password, 
	                        @RequestParam(value = "c_email", required = false) String c_email, 
	                        HttpServletRequest request, HttpServletResponse response, 
	                        Model model) {
	        System.out.println("로그인 시도: " + email);
	        MemberDTO memberDTO = memberDAO.getMemberByEmail(email);
	        if (memberDTO == null) {
	            // 회원 정보가 없으면 (탈퇴한 경우)
	            model.addAttribute("errorMessage", "회원이 아닙니다. 회원가입해 주세요.");
	            return "member/loginForm";
	        }//if end
	        if (memberDTO.getPassword().equals(password)) {
	        	 // 로그인 성공 시 세션에 멤버 정보를 저장
	               HttpSession session = request.getSession();
	               session.setAttribute("member", memberDTO);
	               session.setAttribute("email", memberDTO.getEmail());
	               session.setAttribute("isMember", true); // 세션에 회원 여부 저장
	               session.setAttribute("re_name", memberDTO.getName()); // 세션에 이름 저장
	               session.setAttribute("re_phone", memberDTO.getPhone_number()); // 세션에 전화번호 저장
	               
	               //System.out.println(memberDTO);
	               
	               // 이메일 저장 체크박스 처리
	               handleRememberMeCookie(c_email, email, response);
	               return "redirect:/"; // 로그인 성공 시 index 페이지로 리디렉션
	           } else {
	               model.addAttribute("errorMessage", "로그인에 실패했습니다.<br>이메일과 비밀번호를 확인하세요.");
	               return "member/loginForm"; // 로그인 실패 시 로그인 폼으로 리디렉션
	           }
	    }//login() end


	    // 이메일 저장 체크박스 처리 메서드
	    private void handleRememberMeCookie(String c_email, String email, HttpServletResponse response) {
	        if ("SAVE".equals(c_email)) {
	            Cookie cookie = new Cookie("c_email", email);
	            cookie.setMaxAge(60 * 60 * 24 * 30); // 쿠키 유효 기간: 30일
	            response.addCookie(cookie);
	        } else {
	            // 체크가 해제되어 있으면 쿠키를 제거
	            Cookie cookie = new Cookie("c_email", null);
	            cookie.setMaxAge(0);
	            response.addCookie(cookie);
	        }//if end
	    }//handleRememberMeCookie() end

	    //0721 애경 수정 시작
	    //카카오 로그인
	    @GetMapping("/kakaoLogin")
	    public String kakaoLogin() {
	        String kakaoAuthUrl = "https://kauth.kakao.com/oauth/authorize"
	                + "?client_id=" + kakaoService.getClientId()
	                + "&redirect_uri=" + kakaoService.getRedirectUri()
	                + "&response_type=code"
	        		+ "&scope=name,account_email,phone_number";
	        return "redirect:" + kakaoAuthUrl;
	    }//kakaoLogin() end

	    
	    @GetMapping("/kakaoCallback")
	    public String kakaoCallback(@RequestParam String code, HttpSession session) {
	        // 액세스 토큰 얻기
	        String accessToken = kakaoService.getKakaoAccessToken(code);
	        System.out.println("액세스 토큰: " + accessToken);
	        
	        // 사용자 정보 얻기
	        MemberDTO kakaoUser = kakaoService.getKakaoUserInfo(accessToken);
	        
	        // 로그인 처리
	        kakaoService.processKakaoLogin(kakaoUser, session);
	        
	        return "redirect:/";
	    }//kakaoCallback() end
	    //0721 애경 수정 끝
	    
	    
	    // 로그아웃 처리 메서드
	    @GetMapping("/logout")
	    public String logout(HttpServletRequest request) {
	        request.getSession().invalidate();
	        return "redirect:/member/login"; // 로그아웃 후 로그인 페이지로 리디렉션
	    }//logout() end
	    
	    
	    // 회원가입 약관 페이지를 보여주는 메서드
	    @GetMapping("/agreement")
	    public String showAgreementForm() {
	        return "member/agreementForm";
	    }//showAgreementForm() end
	    
	    
	    // 회원가입 폼을 보여주는 메서드
	    @GetMapping("/memberForm")
	    public String showMemberForm() {
	        return "member/memberForm";
	    }//showMemberForm() end
	    
	    
	    
	    //이메일 중복확인
	    @GetMapping("/emailCheckForm")
	    public String showEmailCheckForm() {
	        return "member/emailCheckForm";
	    }//showEmailCheckForm() end
	    
	    
	    @PostMapping("/emailCheck")
	    public String emailCheck(@RequestParam("email") String email, Model model) {
	        int cnt = memberDAO.duplicateEmail(email);  // 이메일 중복 확인을 위한 메서드
	        model.addAttribute("email", email);
	        model.addAttribute("cnt", cnt);
	        return "member/emailCheckResult"; // 결과를 보여줄 JSP 페이지로 이동
	    }//emailCheck() end
	    

	    
	   
	    
	    // 회원가입 처리 메서드
	    @PostMapping("/register")
	    public String register(MemberDTO memberDTO, Model model) {
	        System.out.println("-----register() 호출됨");
	        System.out.println("MemberDTO: " + memberDTO);
	        try {
	        	int member_count = memberDAO.duplicateEmail(memberDTO.getEmail());
	        	System.out.println("member_count: "+ member_count);
	        	if (member_count > 0) {
	        		System.out.println("member_count");
	        		// exception 을 임의로 발생시킴
	        		throw new Exception("이미 회원가입된 이메일이 존재함: "+ memberDTO.getEmail());
	        	}
	        	memberDAO.insertMember(memberDTO);
	            model.addAttribute("member", memberDTO); // 회원 정보를 모델에 추가해줘야 welcome창에 정보출력가능
	            return "member/welcome"; // 회원가입 성공 후 환영페이지
	        } catch (Exception e) {
	            e.printStackTrace();
	            model.addAttribute("errorMessage", "회원가입 중 오류가 발생했습니다.");
	            return "member/error";
	        }//try end
	    }//register() end
	    

	    //아이디 찾기 폼을 보여주는 메서드
	    @GetMapping("/findID")
	    public String showFindIDForm() {
	        return "member/findID";
	    }//showFindIDForm() end
	    
	    
	    
	    //아이디 찾기 처리 메서드
	    @PostMapping("/findIDProc")
	    public String findIDProc(@RequestParam("name") String name, @RequestParam("phone_number") String phone_number, Model model) {
	        MemberDTO member = new MemberDTO();
	        member.setName(name);
	        member.setPhone_number(phone_number);
	        System.out.println("name" + name+ ", phone_number" + phone_number);

	        MemberDTO foundMember = memberDAO.findByNameAndPhone(member.getName(), member.getPhone_number());
	        System.out.println("foundMember"+ foundMember);
	        
	        if (foundMember != null) {
	            String message = "이메일 : " + foundMember.getEmail();
	            model.addAttribute("message", message);
	            model.addAttribute("foundMember", foundMember);
	            return "member/findIDProc"; // 찾은 이메일을 보여주는 JSP 페이지로 이동
	        } else {
	            model.addAttribute("errorMessage", "아이디 찾기를 실패했습니다.");
	            return "member/findIDProc";
	        }//if end
	    }//findIDProc() end
	    


	    // 비밀번호 찾기 폼을 보여주는 메서드
	    @GetMapping("/findPW")
	    public String showFindPWForm() {
	        return "member/findPW";
	    }//showFindPWForm() end

	    
		 // 비밀번호 찾기 처리 메서드
		 @PostMapping("/findPWProc") 
		 public String findPWProc(@RequestParam("name") String name, 
				 				  @RequestParam("email") String email, Model model) { 
		 MemberDTO member = new MemberDTO(); member.setName(name); member.setEmail(email);
		 System.out.println("name: " + name + ", email: " + email);
		 
		 MemberDTO foundMember =  memberDAO.findByNameAndEmail(member.getName(), member.getEmail());
			 if (foundMember != null) { 
				 // 임시 비밀번호 생성
		         String tempPassword = generateTempPassword();
		         // 임시 비밀번호를 데이터베이스에 업데이트 (평문)
		         foundMember.setPassword(tempPassword);
		         memberDAO.updatePassword(foundMember);
		         System.out.println("tempPassword: " + tempPassword);
		         // 임시 비밀번호를 이메일로 전송
		         sendEmailWithTempPassword(foundMember, tempPassword);
				 
		         String message = "임시 비밀번호가 이메일로 전송되었습니다. <br>임시 비밀번호는 로그인 후 <br>회원정보수정에서 수정하시기 바랍니다.";
				 model.addAttribute("message", message); 
				 return "member/findPWProc"; // 임시비밀번호 전송 메시지를 보여주는 JSP 페이지로 이동 
			 } else { 
				model.addAttribute("errorMessage","비밀번호 찾기를 실패했습니다."); 
				return "member/findPWProc"; 
			}//if end
		}//findPWProc() end
		
		 
		 
		 private String generateTempPassword() {
		        // 임시 비밀번호 생성 로직
		        // 8자리의 임시 비밀번호를 생성하는 코드 
		        // UUID는 범용 고유 식별자
		        return UUID.randomUUID().toString().substring(0, 8);
		    }//generateTempPassword() end
		    
		    
		    
		    private void sendEmailWithTempPassword(MemberDTO member, String tempPassword) {
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

		            Message msg = new MimeMessage(session);
		            msg.setFrom(new InternetAddress(username));
		            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(member.getEmail()));
		            msg.setSubject("임시 비밀번호 안내");
		            msg.setContent("임시 비밀번호는 " + tempPassword + " 입니다.<br>로그인 후 비밀번호를 변경해주세요.", "text/html; charset=UTF-8");
		            msg.setSentDate(new Date());
		            Transport.send(msg);
		        } catch (Exception e) {
		            System.out.println("임시 비밀번호 이메일 전송 실패: " + e);
		        }//try end
		    }//sendEmailWithTempPassword() end 
		 
		 
		 
	    
	    // 회원 정보 수정 폼을 보여주는 메서드(mypage_main에서 경로설정함)
	    @GetMapping("/editMember")
	    public String editMemberForm(@RequestParam("email") String email, Model model) {
	    	System.out.println("editMemberForm: email = " + email);
	    	MemberDTO member = memberDAO.getMemberByEmail(email);
	        System.out.println("editMemberForm: member = " + member);
	        model.addAttribute("member", member);
	        return "member/editMember";
	    }//editMemberForm() end

	    
	    
	    // 회원 정보 수정 처리 메서드
	    @PostMapping("/updateMember")
	    public String updateMember(MemberDTO memberDTO, Model model) {
	        System.out.println("updateMember: memberDTO = " + memberDTO);
	        memberDAO.updateMember(memberDTO);

	        // 수정된 정보를 다시 가져와서 모델에 추가
	        MemberDTO updatedMember = memberDAO.getMemberByEmail(memberDTO.getEmail());
	        System.out.println("updateMember: memberDTO = " + memberDTO);
	        model.addAttribute("member", updatedMember);

	        return "member/editMember"; // 수정 후 수정된 정보를 다시 보여줌
	    }//updateMember() end

	    
	    
	    // 일반회원 탈퇴 처리 메서드
	    @PostMapping("/deleteMember")
	    public String deleteMember(@RequestParam("email") String email, HttpServletRequest request) {
	    	memberDAO.deleteMember(email);  // 데이터베이스에서 회원 정보 삭제
	        request.getSession().invalidate();  // 세션 무효화하여 로그아웃 상태로 만들기
	        return "redirect:/";  // 삭제 후 메인 페이지로 이동
	    }//deleteMember() end
	    
	    
	    
	    //관리자페이지에서 회원 삭제 
	    @PostMapping("/admin/deleteMember")
	    public String adminDeleteMember(@RequestParam("email") String email) {
	    	memberDAO.deleteMember(email);  // 데이터베이스에서 회원 정보 삭제
	        return "redirect:/admin/memberList";  // 삭제 후 관리자 회원 목록 페이지로 이동
	    }//adminDeleteMember() end

	    
	
	}//class end
