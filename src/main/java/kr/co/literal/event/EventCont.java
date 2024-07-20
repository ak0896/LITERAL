package kr.co.literal.event;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import kr.co.literal.product.ProductDAO;

@Controller
@RequestMapping("/event")
public class EventCont {
	
	public EventCont()
	{
		System.out.println("---- EventCont() 객체 생성");
	} // public EventCont() end
	
	
	@Autowired
	private EventDAO eventDao;
	
    @Autowired
    private CupDAO cupDao;
	
	@Autowired
	private ProductDAO productDao;

	
    // 사용자용 이벤트 리스트
    @GetMapping("/eventlist")
    public ModelAndView eventlist() {
        List<Map<String, Object>> event_list = eventDao.event_list();
        List<Map<String, Object>> cup_list = cupDao.cup_list();

        ModelAndView mav = new ModelAndView();
        mav.addObject("event_list", event_list);
        mav.addObject("cup_list", cup_list);
        
        mav.setViewName("/event/eventlist");
        return mav;
    }
    
    
    // 사용자용 이달의 작가 상세
    @GetMapping("/eventdetail/{event_code}")
    public ModelAndView eventDetail(@PathVariable String event_code) {
        Map<String, Object> event = eventDao.event_detail(event_code);

        ModelAndView mav = new ModelAndView();
        mav.setViewName("event/eventdetail");
        mav.addObject("event", event);
        return mav;
    }
    
    
    // 사용자용 책 월드컵 상세
    @GetMapping("/cup_detail/{worldcup_code}")
    public ModelAndView cup_detail(@PathVariable String worldcup_code) {
        Map<String, Object> cup_detail = cupDao.cup_detail(worldcup_code);

        ModelAndView mav = new ModelAndView();
        mav.setViewName("event/cup_detail");
        mav.addObject("event", cup_detail);
        return mav;
    }
    
    
    
} // public class EventCont end