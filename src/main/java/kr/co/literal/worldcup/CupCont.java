package kr.co.literal.worldcup;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class CupCont {
	public CupCont()
	{
		System.out.println("---- CupCont() 객체 생성");
	} // public CupCont() end
	
	@Autowired
	CupDAO cupDao;
	
	// 월그컵 리스트
	@RequestMapping("/acuplist")
	public ModelAndView acuplist() {
	   ModelAndView mav = new ModelAndView();
	    
	   mav.addObject("list", cupDao.acuplist());
	   mav.setViewName("/admin/acuplist");
	    
	    return mav;
	} // acuplist() end

	
	// 모달 라운드 선택 → write 폼
    @GetMapping("/createWorldCup")
    public ModelAndView createWorldCup(@RequestParam("round") String round)
    {
      	ModelAndView mav = new ModelAndView();

        if (round.equals("8")) {
            mav.setViewName("admin/aeventwrite_8");
        } else if (round.equals("16")) {
            mav.setViewName("admin/aeventwrite_16");
        } else if (round.equals("32")) {
            mav.setViewName("admin/aeventwrite_32");
        } else {
            mav.setViewName("error");
        }
        return mav;
    } // public ModelAndView createWorldCup end
    
	
    // write 페이지에서 장르 선택 후 월드컵 시작
    @PostMapping("/startWorldCup")
    public ModelAndView startWorldCup(@RequestParam("round") String round, 
    								  @RequestParam("genre_code") String genre_code, 
    								  HttpSession session)
    {
        ModelAndView mav = new ModelAndView();

        // 선택한 장르의 책 목록을 가져옴
        List<Map<String, Object>> books = cupDao.getgenrelist(genre_code);
        // 책 목록을 랜덤으로 섞음
        Collections.shuffle(books);
/*
        // 필요한 라운드에 맞는 책 목록을 전달
        if (round.equals("8")) {
            mav.setViewName("admin/aeventwrite_8");
            mav.addObject("books", books.subList(0, 8));
        } else if (round.equals("16")) {
            mav.setViewName("admin/aeventwrite_16");
            mav.addObject("books", books.subList(0, 16));
        } else if (round.equals("32")) {
            mav.setViewName("admin/aeventwrite_32");
            mav.addObject("books", books.subList(0, 32));
        } else {
            mav.setViewName("error");
        }
*/       
        
     // 필요한 라운드에 맞는 책 목록을 전달
        mav.addObject("round", round); // 라운드 값을 추가
        mav.addObject("books", books.subList(0, Integer.parseInt(round)));

        // 책 목록과 라운드 정보를 세션에 저장
        List<String> bookNumbers = new ArrayList<>();
        for (Map<String, Object> book : books) {
            bookNumbers.add((String) book.get("book_number")); // 각 책의 book_number를 리스트에 추가
        }
        
        session.setAttribute("bookNumbers", bookNumbers); // bookNumbers 리스트를 세션에 저장
        session.setAttribute("round", round);

        mav.setViewName("admin/worldcup_match");
        return mav;
    } // public ModelAndView startWorldCup end
    
    
 	// 투표 처리 메서드
    @PostMapping("/vote")
    public String vote(@RequestParam("round") String round, 
    				   @RequestParam("selected_book") String selectedBook, HttpSession session) 
    {
        // 현재 라운드의 책 번호 목록을 세션에서 가져옴
        List<String> bookNumbers = (List<String>) session.getAttribute("bookNumbers");

        // 다음 라운드로 넘어가기 위해 선택된 책만 남김
        List<String> getBookNumbers = new ArrayList<>();
        for (String bookNumber : bookNumbers) {
            if (bookNumber.equals(selectedBook)) {
            	getBookNumbers.add(bookNumber);
            }
        }

        // 다음 라운드 설정
        int nextRound = Integer.parseInt(round) / 2;
        session.setAttribute("bookNumbers", getBookNumbers);
        session.setAttribute("round", String.valueOf(nextRound));

        // 마지막 라운드 결과 저장
        if (nextRound == 1) {
            // 사용자 이메일과 월드컵 코드 가져오기
            String email = (String) session.getAttribute("email");
            String worldcupCode = (String) session.getAttribute("worldcup_code");

            // 책 정보를 데이터베이스에서 가져오기
            Map<String, Object> bookInfo = cupDao.getBookyNumber(selectedBook);
            String selectedBookTitle = (String) bookInfo.get("book_title");

            // 결과 데이터 생성
            Map<String, Object> resultData = Map.of(
                "email", email,
                "worldcup_code", worldcupCode,
                "book_code", (String) bookInfo.get("book_code"),
                "book_title", selectedBookTitle
            );
            
            // 결과 저장
            cupDao.insertResult(resultData);
        }

        // 다음 라운드로 이동
        return "redirect:/admin/nextRound";
    }

    
    // 다음 라운드 화면을 표시하는 메서드
    @RequestMapping("/nextRound")
    public ModelAndView nextRound(HttpSession session) 
    {
        ModelAndView mav = new ModelAndView();

        // 세션에서 현재 라운드와 책 번호 목록을 가져옴
        String round = (String) session.getAttribute("round");
        List<String> bookNumbers = (List<String>) session.getAttribute("book_number");

        if (round.equals("1")) {
            // 마지막 라운드 결과 페이지로 이동
            Map<String, Object> winner = cupDao.getBookyNumber(bookNumbers.get(0));
            mav.setViewName("admin/worldcup_result");
            mav.addObject("winner", winner);
        } else {
            // 다음 라운드 매치 페이지로 이동
            List<Map<String, Object>> books = new ArrayList<>();
            for (String bookNumber : bookNumbers) {
                books.add(cupDao.getBookyNumber(bookNumber));
            }
            mav.setViewName("admin/worldcup_match");
            mav.addObject("round", round);
            mav.addObject("books", books);
        }
        
        return mav;
    }
    
/*   
    // insert
    @PostMapping("/cupinsert")
    public String insert(@RequestParam Map<String, Object> map, HttpServletRequest req) 
    {
        String[] bookNumbers = req.getParameterValues("bookNumbers[]");
        if (bookNumbers == null) {
            // bookNumbers가 null인 경우 처리
            // 예를 들어, 에러 메시지를 로그에 기록하고 폼 페이지로 리다이렉트할 수 있습니다.
        	System.out.println("bookNumbers is null");
            return "redirect:/admin/acuplist?error=missing_book_numbers";
        }
        
        System.out.println("bookNumbers: " + Arrays.toString(bookNumbers));
        String worldcup_code = cupDao.worldcupcode();
        map.put("worldcup_code", worldcup_code);

        // 책 번호들을 리스트로 변환하여 map에 추가
        List<String> bookList = Arrays.asList(bookNumbers);
        map.put("bookNumbers", bookList);

        // 이벤트 삽입
        cupDao.insert(map);

        return "redirect:/admin/acuplist";
    } // public String insert end
*/
    
    @PostMapping("/cupinsert")
    public String insert(HttpServletRequest req) 
    {
        String[] bookNumbers = req.getParameterValues("bookNumbers");
        if (bookNumbers == null) {
            System.out.println("bookNumbers is null");
            return "redirect:/admin/acuplist?error=missing_book_numbers";
        } else {
            System.out.println("bookNumbers: " + Arrays.toString(bookNumbers));
        }

        // 나머지 로직
        return "redirect:/admin/acuplist";
    }

    
    // 결과 저장하기
    @PostMapping("/insertResult")
    public String insertResult(@RequestParam Map<String, Object> resultData, HttpSession session) 
    {
        // 세션에서 이메일과 월드컵 코드 가져오기
        String email = (String) session.getAttribute("email");
        String worldcupCode = (String) session.getAttribute("worldcup_code");

        // resultData에 이메일과 월드컵 코드 추가
        resultData.put("email", email);
        resultData.put("worldcup_code", worldcupCode);
        
        // 결과 저장
        cupDao.insertResult(resultData);
        
        // 리스트 페이지로 리다이렉트
        return "redirect:/admin/acuplist";
    }
    
    
	// 저장된 결과 리스트
	@RequestMapping("/aresultlist")
	public ModelAndView aresultlist() {
	   ModelAndView mav = new ModelAndView();
	    
	   mav.addObject("list", cupDao.aresultlist());
	   mav.setViewName("/admin/aresultlist");
	    
	    return mav;
	} // acuplist() end
  
} // public class CupCont end
