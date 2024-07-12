package kr.co.literal.event;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.literal.member.MemberDTO;

@Controller
@RequestMapping("/event")
public class EventCont {
	
	public EventCont()
	{
		System.out.println("---- EventCont() 객체 생성");
	} // public EventCont() end
	
	
	@Autowired
	private EventDAO eventDao;
	
	
	@RequestMapping("/eventlist")
	public ModelAndView eventlist() {
	   ModelAndView mav = new ModelAndView();
	   mav.addObject("list", eventDao.list());
	   mav.setViewName("/event/eventlist");
	   return mav;
	 } // eventlist() end
	
    @GetMapping("/NewEventCode")
    public String NewEventCode() {
        return eventDao.NewEventCode();
    }
	
    
    //  insert
 	@PostMapping("/insert")
 	public String insert (@RequestParam Map<String, Object> map, HttpServletRequest req)
 	{
 		// 세션에서 현재 로그인한 사용자의 이메일 가져오기
         HttpSession session = req.getSession();
         MemberDTO member = (MemberDTO) session.getAttribute("member");
         if (member == null) {
             // 사용자가 로그인하지 않은 경우에 대한 처리
             return "redirect:/member/login";
         }
         map.put("email", member.getEmail());

         eventDao.insert(map);
 		
 		return "redirect:/product/productlist";
 	} // public String insert end
	

} // public class EventCont end
