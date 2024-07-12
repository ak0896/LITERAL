package kr.co.literal.notice;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.servlet.ModelAndView;






@Controller
@RequestMapping("/notice")
public class NoticeCont {
	public NoticeCont() {
		System.out.println("-----noticeCont() 객체생성");
	}
	@Autowired
	private NoticeDAO noticeDao;
	
	@GetMapping("/notice_list")
		public String notice_list(@RequestParam(defaultValue = "1") int page, Model model) {
	    int pageSize = 6; //페이지당 게시물 수
	    int offset = (page-1) * pageSize;
	    
	    Map<String, Object> params = new HashMap<>();
	    params.put(("pageSize"), pageSize);
	    params.put("offset", offset);
	    
	    List<NoticeDTO> noticeList = noticeDao.notice_list(params);
	    int totalnotice = noticeDao.notice_count();
	    int totalpage = (int) Math.ceil((double) totalnotice / pageSize);
	    
	    model.addAttribute("noticeList", noticeList);
	    model.addAttribute("totalpage", totalpage);
	    model.addAttribute("currentpage", page);
	    
	    return "notice/notice_list";
	}
	
	@GetMapping("/notice_write")
		public String write() {
			return "notice/notice_write";
	}
	
	@PostMapping("/notice_insert")
		public String notice_insert(@ModelAttribute NoticeDTO noticeDto) {
		noticeDao.notice_insert(noticeDto);
		return "redirect:/notice/notice_list";
	}
	
	
	

	@GetMapping("/notice_detail")
	public ModelAndView detail(@RequestParam("notice_code") int notice_code) {
		NoticeDTO noticeDto = noticeDao.selectNoticeById(notice_code);
		ModelAndView mav= new ModelAndView();
		mav.setViewName("notice/notice_detail");
		mav.addObject("notice_detail",noticeDao.notice_detail(notice_code));
		return mav;
	}
	
	@GetMapping("/notice_update")
    public ModelAndView update(@RequestParam("notice_code") int notice_code) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("notice/notice_update");
        mav.addObject("notice_update",noticeDao.notice_update(notice_code)); 
        //#{} 받는 값 저장! 그래서 프로트 단에서 ${} 안에 쓰는 건 addObject에서 선언해준 "" 안에 있는 변수명을 써주면 됨
        return mav;
    }

    @PostMapping("/notice_updateproc")
    public String update_notice(@ModelAttribute NoticeDTO noticeDto) {
        //public int update_notice(@RequestParam("notice_code") int notice_code, @RequestParam("notice_title") String notice_title,@RequestParam("board_writer") String board_writer, @RequestParam("notice_content") String notice_content) {
    	//NoticeDTO noticeDto = new NoticeDTO();
        //noticeDto.setNotice_code(notice_code);
        //noticeDto.setNotice_title(notice_title);
        //noticeDto.setBoard_writer(board_writer);
        //noticeDto.setNotice_content(notice_content);
        
        int cnt = noticeDao.noticeUpdateProc(noticeDto);
        return "redirect:/notice/notice_detail?notice_code="+ noticeDto.getNotice_code();
        //return "redirect:/notice/notice_list";
    }
	
    @PostMapping("/notice_delete")
    public String delete(@RequestParam("notice_code") int notice_code) {
    	int cnt = noticeDao.notice_delete(notice_code);
    	return "redirect:/notice/notice_list";
  }
//일반회원 페이지
    
    @GetMapping("/notice_list2")
	public String notice_list2(@RequestParam(defaultValue = "1") int page, Model model) {
    int pageSize = 6; //페이지당 게시물 수
    int offset = (page-1) * pageSize;
    
    Map<String, Object> params = new HashMap<>();
    params.put(("pageSize"), pageSize);
    params.put("offset", offset);
    
    List<NoticeDTO> noticeList = noticeDao.notice_list(params);
    int totalnotice = noticeDao.notice_count();
    int totalpage = (int) Math.ceil((double) totalnotice / pageSize);
    
    model.addAttribute("noticeList", noticeList);
    model.addAttribute("totalpage", totalpage);
    model.addAttribute("currentpage", page);
    
    return "notice/notice_list2";
}
	@GetMapping("/notice_detail2")
	public ModelAndView detail2(@RequestParam("notice_code") int notice_code) {
		NoticeDTO noticeDto = noticeDao.selectNoticeById(notice_code);
		ModelAndView mav= new ModelAndView();
		mav.setViewName("notice/notice_detail2");
		mav.addObject("notice_detail",noticeDao.notice_detail(notice_code));
		return mav;
	}

}
