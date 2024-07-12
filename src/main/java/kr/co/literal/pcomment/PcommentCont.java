package kr.co.literal.pcomment;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/comment")
public class PcommentCont {
	
	public PcommentCont()
	{
		System.out.println("-----PcommentCont()객체생성됨");
	} // public PcommentCont() end
	
	@Autowired
	private PcommentDAO pcommentDao;
	
	
    @PostMapping("/insert")
    @ResponseBody
    public Map<String, Object> pCommentServiceInsert(@RequestParam("book_number") String book_number
                                    ,@RequestParam("pcontent") String pcontent
                                    ,HttpSession session) throws Exception
    {
    	 Map<String, Object> response = new HashMap<>();
    	    
	    System.out.println("book_number: " + book_number); // 디버깅용 로그
	    System.out.println("pcontent: " + pcontent); // 디버깅용 로그

	    String email = (String) session.getAttribute("email"); // 세션에서 이메일 가져오기
	    if (email == null) {
	        // 사용자가 로그인하지 않은 경우에 대한 처리
	        response.put("status", "redirect");
	        response.put("url", "/member/login");
	        return response;
	    }

	    PcommentDTO pcommentDto = new PcommentDTO();
	    pcommentDto.setBook_number(book_number);
	    pcommentDto.setPcontent(pcontent);
	    pcommentDto.setEmail(email);

	    System.out.println("email: " + email); // 디버깅용 로그

	    int cnt = pcommentDao.commentInsert(pcommentDto);
	    System.out.println("cnt: " + cnt); // 디버깅용 로그

	    response.put("status", "success");
	    response.put("count", cnt);

	    return response;
	    
    }//pCommentServiceInsert() end
    
    
    @GetMapping("/list")
    @ResponseBody
    public List<PcommentDTO> CommentServiceList(@RequestParam("book_number") String book_number) throws Exception 
    {
        List<PcommentDTO> list = pcommentDao.commentList(book_number);
        return list;
    }//pCommentServiceList() end
	
	
	
} // public class PcommentCont end
