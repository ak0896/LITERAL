package kr.co.literal.admin;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
import kr.co.literal.product.ProductDAO;
import net.utility.Utility;

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
	                       ,HttpServletRequest req) {

	        Map<String, Object> oldaProduct = adminDao.detail(book_number);
	       
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
	        
	        adminDao.update(map);
	        
	        return "redirect:/admin/productlist_admin";
	        
	     }//update() end
		 
		 
}//AdminCont() end
