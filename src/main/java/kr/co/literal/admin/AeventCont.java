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
import kr.co.literal.event.CupDAO;
import kr.co.literal.event.EventDAO;
import kr.co.literal.product.ProductDAO;

@Controller
@RequestMapping("/admin")
public class AeventCont {
	
	public AeventCont() {
        System.out.println("---- AdminCont() 객체 생성");
    }

    @Autowired
    private EventDAO eventDao;

    @Autowired
    private CupDAO cupDao;

    @Autowired
    private ProductDAO productDao;

    // 관리자용 이벤트 리스트
    @GetMapping("/aeventlist")
    public ModelAndView aeventlist() {
        List<Map<String, Object>> aevent_list = eventDao.aevent_list();
        List<Map<String, Object>> acup_list = cupDao.acup_list();

        ModelAndView mav = new ModelAndView();
        mav.addObject("aevent_list", aevent_list);
        mav.addObject("acup_list", acup_list);
        mav.setViewName("/admin/aeventlist");
        return mav;
    }

    // 이벤트 등록 폼
    @GetMapping("/aeventwrite")
    public String aeventwrite() {
        return "/admin/aeventwrite";
    }

    // 월드컵 이벤트 등록 폼
    @GetMapping("/acup_write")
    public String acup_write() {
        return "/admin/acup_write";
    }

    // 이벤트 insert
    @PostMapping("/aevent_insert")
    public String aevent_insert(@RequestParam Map<String, Object> map, HttpServletRequest req) {
        String event_code = eventDao.eventcode();
        map.put("event_code", event_code);

        // 이벤트 삽입
        eventDao.aevent_insert(map);

        return "redirect:/admin/aeventlist";
    }

    // 월드컵 이벤트 insert
    @PostMapping("/acup_insert")
    public String acup_insert(@RequestParam Map<String, Object> map, HttpServletRequest req) {
        String worldcup_code = cupDao.worldcupcode();
        map.put("worldcup_code", worldcup_code);
        
        // 배너 이미지 파일명 저장
        String wc_banner = (String) map.get("wc_banner");
        if (wc_banner == null || wc_banner.isEmpty()) {
            wc_banner = "default.jpg"; // 기본 이미지 파일명 설정
        }
        map.put("wc_banner", wc_banner);
        
        // 월드컵 이벤트 삽입
        cupDao.acup_insert(map);

        return "redirect:/admin/aeventlist";
    }

    // 사진 저장
    @PostMapping(value = "/uploadFile", produces = "application/json")
    @ResponseBody
    public JsonObject uploadFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest req) {
        JsonObject jsonObject = new JsonObject(); // JSON 객체 생성

        // 파일 저장 경로 설정
        ServletContext application = req.getServletContext();
        String fileRoot = application.getRealPath("/storage/eventImages/");

        // 파일 이름 처리
        String o_poster = multipartFile.getOriginalFilename(); // 원본 파일명 가져오기
        String extension = o_poster.substring(o_poster.lastIndexOf(".")); // 파일 확장자 추출
        String savedFileName = UUID.randomUUID() + extension; // 고유한 파일명 생성

        File file = new File(fileRoot + savedFileName); // 저장할 파일 객체 생성

        try {
            // 파일 저장
            InputStream fileStream = multipartFile.getInputStream();
            FileUtils.copyInputStreamToFile(fileStream, file); // 파일을 지정된 경로에 저장
            jsonObject.addProperty("url", req.getContextPath() + "/storage/eventImages/" + savedFileName); // JSON 객체에 파일 URL 추가
            jsonObject.addProperty("bannerFileName", savedFileName); // JSON 객체에 파일명 추가

            jsonObject.addProperty("responseCode", "success"); // JSON 객체에 성공 응답 코드 추가
        } catch (IOException e) {
            // 예외 발생 시 파일 삭제
            FileUtils.deleteQuietly(file); // 저장된 파일 삭제
            jsonObject.addProperty("responseCode", "error"); // JSON 객체에 오류 응답 코드 추가
            e.printStackTrace(); // 예외 출력
        }
        return jsonObject; // JSON 객체 반환
    }
    
    
    // 이달의 작가 상세
    @GetMapping("/aeventdetail/{event_code}")
    public ModelAndView aevent_detail(@PathVariable String event_code) {
        Map<String, Object> aevent_detail = eventDao.aevent_detail(event_code);

        ModelAndView mav = new ModelAndView();
        mav.setViewName("admin/aeventdetail");
        mav.addObject("event", aevent_detail);
        return mav;
    }
    
    
    // 책 월드컵 상세
    @GetMapping("/acup_detail/{worldcup_code}")
    public ModelAndView acup_detail(@PathVariable String worldcup_code) {
        Map<String, Object> acup_detail = cupDao.acup_detail(worldcup_code);

        ModelAndView mav = new ModelAndView();
        mav.setViewName("admin/acup_detail");
        mav.addObject("event", acup_detail);
        return mav;
    }
    
} // public class AeventCont end
