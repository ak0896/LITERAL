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
	private ProductDAO productDao;

	@RequestMapping("/eventlist")
	public ModelAndView eventlist() {
	    List<Map<String, Object>> events = eventDao.list();

	    ModelAndView mav = new ModelAndView();
	    mav.addObject("list", events);
	    mav.setViewName("/event/eventlist");
	    return mav;
	}


	// 상세
 	@GetMapping("/eventdetail/{event_code}")
 	public ModelAndView eventDetail(@PathVariable String event_code) {
 	    // event 정보를 가져옵니다: event_code를 사용하여 이벤트 정보를 조회
 	    Map<String, Object> event = eventDao.detail(event_code);
 	    
 	    ModelAndView mav = new ModelAndView();
 	    mav.setViewName("event/eventdetail");

 	    // 조회된 이벤트 정보를 ModelAndView 객체에 추가
 	    mav.addObject("event", event);
 	    mav.addObject("event_code", event_code);

 	    return mav;
 	} // public ModelAndView eventDetail() end
 	
 	
} // public class EventCont end
