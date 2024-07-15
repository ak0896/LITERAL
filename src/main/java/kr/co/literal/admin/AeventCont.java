package kr.co.literal.admin;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Pattern;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;

import ch.qos.logback.core.boolex.Matcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import kr.co.literal.event.EventDAO;
import kr.co.literal.product.ProductDAO;

@Controller
@RequestMapping("/admin")
public class AeventCont {
	
	public AeventCont()
	{
		System.out.println("---- AeventCont() 객체 생성");
	} // public EventCont() end
	
	
	@Autowired
	private EventDAO eventDao;
	
	@Autowired
	private ProductDAO productDao;
	
	// 관리자 페이지 메인
	@GetMapping("/aeventlist")
	public ModelAndView aeventlist() {
	    List<Map<String, Object>> adevents = eventDao.adlist();

	    ModelAndView mav = new ModelAndView();
	    mav.addObject("adlist", adevents);
	    mav.setViewName("/admin/aeventlist");
	    
	    return mav;
	    
	}// branchDetailForm() end

	
	// 이벤트 등록 폼
	@GetMapping("/aeventwrite")
	public String aeventwrite() 
	{
		return "admin/aeventwrite";
	} // public String write() end
	
	
    // insert
    @PostMapping("/insert")
    public String insert(@RequestParam Map<String, Object> map, HttpServletRequest req) 
    {
        String event_code = eventDao.eventcode();
        map.put("event_code", event_code);
        
        // 이벤트 삽입
        eventDao.insert(map);

        return "redirect:/admin/aeventlist";
    }

    
    // 사진 저장
    @PostMapping(value="/uploadFile", produces = "application/json")
    @ResponseBody
    public JsonObject uploadFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest req) {
        JsonObject jsonObject = new JsonObject();  // JSON 객체 생성

        // 파일 저장 경로 설정
        ServletContext application = req.getServletContext();
        String fileRoot = application.getRealPath("/storage/eventImages/");
        
        // 파일 이름 처리
        String o_poster = multipartFile.getOriginalFilename();  // 원본 파일명 가져오기
        String extension = o_poster.substring(o_poster.lastIndexOf("."));  // 파일 확장자 추출
        String savedFileName = UUID.randomUUID() + extension;  // 고유한 파일명 생성
        
        File file = new File(fileRoot + savedFileName);  // 저장할 파일 객체 생성

        try {
            // 파일 저장
            InputStream fileStream = multipartFile.getInputStream();
            FileUtils.copyInputStreamToFile(fileStream, file);  // 파일을 지정된 경로에 저장
            jsonObject.addProperty("url", req.getContextPath() + "/storage/eventImages/" + savedFileName);  // JSON 객체에 파일 URL 추가
            jsonObject.addProperty("bannerFileName", savedFileName);  // JSON 객체에 파일명 추가

            jsonObject.addProperty("responseCode", "success");  // JSON 객체에 성공 응답 코드 추가
        } catch (IOException e) {
            // 예외 발생 시 파일 삭제
            FileUtils.deleteQuietly(file);  // 저장된 파일 삭제
            jsonObject.addProperty("responseCode", "error");  // JSON 객체에 오류 응답 코드 추가
            e.printStackTrace();  // 예외 출력
        }
        return jsonObject;  // JSON 객체 반환
    }

    
	// 상세
 	@GetMapping("/aeventdetail/{event_code}")
 	public ModelAndView adeventDetail(@PathVariable String event_code)
 	{   // event 정보를 가져옵니다: event_code를 사용하여 이벤트 정보를 조회
 	    Map<String, Object> event = eventDao.addetail(event_code);
 	    
 	    ModelAndView mav = new ModelAndView();

 	    // 조회된 이벤트 정보를 ModelAndView 객체에 추가
 	    mav.addObject("event", event);
 	    mav.addObject("event_code", event_code);
 	    
	    mav.setViewName("admin/aeventdetail");

 	    return mav;
 	} // public ModelAndView eventDetail() end
 	
 	
 	
 	@PostMapping("/adupdate")
 	public String update(@RequestParam Map<String, Object> map, HttpServletRequest req)
 	{
 	    String event_code = (String) map.get("event_code");
 	    
 	    // 기존 이벤트 정보를 가져옴
 	    Map<String, Object> existingEvent = eventDao.addetail(event_code);
 	    String existingBanner = (String) existingEvent.get("event_banner");
 	    
 	    // 새로운 배너 URL 설정
 	    String newBannerUrl = (String) map.get("event_banner");

 	    // 새로운 배너 URL 설정
 	    if (newBannerUrl == null || newBannerUrl.isEmpty()) {
 	    	map.put("event_banner", existingBanner); // 기존 배너 유지 
 	    } else {
 	    	map.put("event_banner", newBannerUrl);	    
 	    }
 	    
 	    // 이벤트 정보 업데이트
 	    eventDao.adupdate(map);
 	   
 	    return "redirect:/admin/aeventlist";
 	}
} // public class AeventCont end
