package kr.co.literal.mypage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class MypageCont {
	
	@Autowired
    private MypageDAO mypageDAO;

		    
    	// main 폼을 보여주는 메서드
	    @GetMapping("/mypage_main")
	    public String showMypageForm() {
	        return "mypage/mypage_main"; //메인 페이지로 이동
	    }

	    
}//class end
