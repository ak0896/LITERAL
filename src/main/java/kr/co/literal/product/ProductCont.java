package kr.co.literal.product;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.tomcat.util.net.openssl.ciphers.Authentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import net.utility.Utility;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.literal.member.MemberDTO;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@Controller
@RequestMapping("/product")
public class ProductCont {
	public ProductCont()
	{
		System.out.println("---- ProductCont() 객체 생성");
	} // public ProductCont() end
	
	@Autowired
	private ProductDAO productDao;
	
	//결과확인
	//-> http://localhost:8080/product/productlist

	// 상품 리스트 시작
//	@RequestMapping("/productlist")
//	public ModelAndView productlist() {
//	   ModelAndView mav = new ModelAndView();
//	   mav.addObject("list", productDao.list());
//	   mav.setViewName("/product/productlist");
//	   return mav;
//	 } // list() end
	
	@RequestMapping("/productlist")
	public ModelAndView productList(@RequestParam(value = "book_code", required = false) String book_code) {
	    ModelAndView mav = new ModelAndView();
	    if (book_code != null && !book_code.isEmpty()) {
	        mav.addObject("list", productDao.selectAll(book_code));
	    } else {
	        // book_title이 없을 때는 모든 상품을 표시
	        mav.addObject("list", productDao.list());
	    }
	    mav.setViewName("/product/productlist");
	    return mav;
	} // list() end
	
	@RequestMapping("/G_productlist")
	public ModelAndView G_productlist() {
	   ModelAndView mav = new ModelAndView();
	   mav.addObject("list", productDao.list_G());
	   mav.setViewName("/product/G_productlist");
	   return mav;
	 } // list_G() end

	@RequestMapping("/M_productlist")
	public ModelAndView M_productlist() {
	   ModelAndView mav = new ModelAndView();
	   mav.addObject("list", productDao.list_M());
	   mav.setViewName("/product/M_productlist");
	   return mav;
	 } // list_M() end
		
	@RequestMapping("/H_productlist")
	public ModelAndView H_productlist() {
	   ModelAndView mav = new ModelAndView();
	   mav.addObject("list", productDao.list_H());
	   mav.setViewName("/product/M_productlist");
	   return mav;
	 } // list_H() end
		
	@RequestMapping("/S_productlist")
	public ModelAndView S_productlist() {
	   ModelAndView mav = new ModelAndView();
	   mav.addObject("list", productDao.list_S());
	   mav.setViewName("/product/M_productlist");
	   return mav;
	 } // list_S() end
	
	@RequestMapping("/R_productlist")
	public ModelAndView R_productlist() {
	   ModelAndView mav = new ModelAndView();
	   mav.addObject("list", productDao.list_R());
	   mav.setViewName("/product/M_productlist");
	   return mav;
	 } // list_R() end
	
	@RequestMapping("/P_productlist")
	public ModelAndView P_productlist() {
	   ModelAndView mav = new ModelAndView();
	   mav.addObject("list", productDao.list_P());
	   mav.setViewName("/product/M_productlist");
	   return mav;
	 } // list_P() end
	
	@RequestMapping("/T_productlist")
	public ModelAndView T_productlist() {
	   ModelAndView mav = new ModelAndView();
	   mav.addObject("list", productDao.list_T());
	   mav.setViewName("/product/M_productlist");
	   return mav;
	 } // list_T() end
	
	@RequestMapping("/W_productlist")
	public ModelAndView W_productlist() {
	   ModelAndView mav = new ModelAndView();
	   mav.addObject("list", productDao.list_W());
	   mav.setViewName("/product/M_productlist");
	   return mav;
	 } // list_W() end
	// 상품 리스트 끝
	
	// 상품 등록 폼
	@GetMapping("/productwrite")
	public String prductwrite() 
	{
		return "product/productwrite";
	} // public String write() end
	
	
	// 상품 insert
	@PostMapping("/insert")
	public String insert (@RequestParam Map<String, Object> map, @RequestParam("img") MultipartFile img, HttpServletRequest req)
	{
		// 이미지 파일 저장 폴더의 실제 물리적인 경로 가져오기
	    ServletContext application = req.getServletContext();
	    String imageBasePath = application.getRealPath("/storage/images");
	    //String pdfBasePath = application.getRealPath("/storage/previews");
		
		// 업로드 파일은 /storage 폴더에 저장
		String img_name = "-";
		long img_size= 0;
		if (img.getSize()>0 && img!=null && !img.isEmpty())			// 파일이 존재한다면
		{	img_size = img.getSize();
			// 전송된 파일이 /storage 파일에 존재한다면 파일명 리네임 후 filename 변수에 저장 / spring05_mymelon 참조
			try
			{
				String o_poster = img.getOriginalFilename();
				img_name = o_poster;
				
				File file = new File(imageBasePath, o_poster);	// 파일클래스에 해당 파일 담기
				
				int i = 1;
				while (file.exists()) 		// 파일이 존재한다면 
				{
					int lastDot = o_poster.lastIndexOf(".");
					img_name = o_poster.substring(0, lastDot) + "_" + i + o_poster.substring(lastDot);	// sky_1.png
					file = new File(imageBasePath, img_name);
					i++;
				} // while end
				
				img.transferTo(file);	// 파일 저장		
			} catch (Exception e)
			{
				System.out.println(e);
			}		
		} // if end
		
		map.put("img", img_name);
		map.put("img_size", img_size);

        // 세션에서 현재 로그인한 사용자의 이메일 가져오기
        HttpSession session = req.getSession();
        MemberDTO member = (MemberDTO) session.getAttribute("member");
        if (member == null) {
            // 사용자가 로그인하지 않은 경우에 대한 처리
            return "redirect:/member/login";
        }
        map.put("email", member.getEmail());

        // 지점 코드 설정
        String branchCode = "null"; // 필요에 따라 지점 코드를 가져오는 로직 추가
        map.put("branch_code", branchCode);
        
        // 판매 여부 설정
        String availability = "2"; // 판매여부 2로 설정
        map.put("availability", availability);
		
        
        // genre_code로 book_code와 book_number 생성
        String genre_code = (String) map.get("genre_code");
        String book_title = (String) map.get("book_title");

        // book_code 생성
        String book_code = productDao.generateBookCode(genre_code, book_title);

        // book_number 생성 및 중복 피하기
        String book_number = productDao.generateBookNumber(genre_code, book_code);

        // 중복된 book_number를 피하기 위해 검증 및 재생성 로직 추가
        while (productDao.bookNumberExists(genre_code, book_number)) {
            book_number = productDao.generateBookNumber(genre_code, book_code);
        }
        
        map.put("book_code", book_code);
        map.put("book_number", book_number);
	    
		productDao.insert(map);
		
		return "redirect:/product/productlist";
	} // public String insert end

    
	// 상품 상단바 검색
    @GetMapping("/search")
    public ModelAndView search(@RequestParam(defaultValue = "") String book_title) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("product/productlist");
        mav.addObject("list", productDao.search(book_title));
        mav.addObject("book_title", book_title);//검색어
        return mav;
    }//search() end
    
    
	

	
    // 상품 상세
	@GetMapping("/productdetail/{book_number}")
	public ModelAndView productdetail(@PathVariable String book_number) 
	{	// product 정보를 가져옵니다: book_number를 사용하여 제품 정보를 조회
	    Map<String, Object> product = productDao.detail(book_number);
	    
	    // product 정보를 가져옵니다: book_number를 사용하여 제품 정보를 조회
	    Map<String, Object> debook = productDao.detail(book_number);
	    
	    // book_code를 설정: 조회된 제품 정보에서 book_code를 가져옵니다
	    String book_code = debook != null ? debook.get("book_code").toString() : null;
	    
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName("product/productdetail");
	    
	    // 조회된 제품 정보를 ModelAndView 객체에 추가
	    mav.addObject("product", product);

	    // productList를 설정: book_code가 null이 아니면 해당 book_code로 제품 목록을 조회, 그렇지 않으면 전체 제품 목록을 조회
	    List<Map<String, Object>> productList;
	    
	    if (book_code != null && !book_code.isEmpty()) {
	        productList = productDao.selectTop3(book_code);
	    } else {
	        productList = productDao.list();
	    }

	    mav.addObject("productList", productList);
	    mav.addObject("book_code", book_code); 

	    return mav;
	}// public ModelAndView detail() end
	
	
	
} // public class ProductCont end