package kr.co.literal.readingroom;

import kr.co.literal.readingroom.dto.*;
import kr.co.literal.member.MemberDAO;
import kr.co.literal.member.MemberDTO;
import kr.co.literal.readingroom.dao.BranchDAO;
import kr.co.literal.readingroom.dao.MyCouponDAO;
import kr.co.literal.readingroom.dao.ReadingRoomDAO;
import kr.co.literal.readingroom.dao.ReservationDAO;
import kr.co.literal.readingroom.dao.SeatDAO;
import kr.co.literal.readingroom.dao.UseTimeDAO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import javax.mail.Session;

@Controller
public class ReadingRoomCont {
   private SqlSession session;
   
   @Autowired
   private MemberDAO memberDAO;

   @Autowired
    private BranchDAO branchDAO;

    @Autowired
    private MyCouponDAO myCouponDAO;

    @Autowired
    private ReadingRoomDAO readingRoomDAO;

    @Autowired
    private ReservationDAO reservationDAO;

    @Autowired
    private SeatDAO seatDAO;

    @Autowired
    private UseTimeDAO useTimeDAO;
    
    
    //열람실 예약 메인페이지
    @GetMapping("/reading_main")
    public String reserveSeat(Model model) {
        return "readingroom/reservationForm";
    }
    
    
    // 지점 선택 처리
    @PostMapping("/selectBranch")
    public String selectBranchByCode(@RequestParam("branch_code") String branch_code, HttpSession session, Model model) {
       
       // 선택한 지점과 이름을 세션에 저장
        BranchDTO branch = branchDAO.selectBranchByCode(branch_code);
       session.setAttribute("branch_code", branch_code);
       session.setAttribute("branch_name", branch.getBranch_name()); // 지점 이름 가져오기
       
        System.out.println("선택된 Branch_code: " + branch_code);
        System.out.println("선택된 Branch_name: " + branch.getBranch_name());
        
        // 지점별 좌석 레이아웃을 가져오는 메서드
        List<String> seatLayout = getSeatLayoutByBranch(branch_code);
        model.addAttribute("seatLayout", seatLayout);
        return "readingroom/seatSelection";
    }//selectBranch() end
    
    
    private String selectBranchByCode(String branch_code) {
        // 지점 코드를 받아 지점 이름을 반환하는 로직
        switch (branch_code) {
            case "L01": return "강남점";
            case "L02": return "연희점";
            case "L03": return "종로점";
            default: return "";
        }
    }//selectBranchByCode() end
    
    
    
    
    private List<String> getSeatLayoutByBranch(String branch_code) {
        // 지점별 좌석 레이아웃을 반환하는 로직
        // "hidden" 값을 사용하여 빈 자리를 나타냅니다.
        List<String> seatLayout = Arrays.asList(
            "1", "2", "3", "4", "5",
            "hidden", "hidden", "hidden", "hidden", "6",
            "hidden", "10", "11", "hidden", "7",
            "hidden", "12", "13", "hidden", "8",
            "hidden", "14", "15", "hidden", "9"
        );

        // seat_code 포맷 변경
        for (int i = 0; i < seatLayout.size(); i++) {
            if (!seatLayout.get(i).equals("hidden")) {
                seatLayout.set(i, branch_code + "-" + String.format("%02d", Integer.parseInt(seatLayout.get(i))));
            }
        }// for end
        return seatLayout;
    }//getSeatLayoutByBranch() end
    

   


    // 좌석 선택 
    @PostMapping("/paymentForm")
    public String paymentForm(@RequestParam("seat_code") String seat_code,
                              @RequestParam("room_code") String room_code, 
                              @RequestParam("room_amount") String room_amountStr,
                              @RequestParam("duration") String duration,
                              @RequestParam("time_code") String time_code, 
                              @RequestParam("start_time") String start_time,
                              HttpSession session, Model model) {
        
       // room_amount를 String으로 받아서 int로 변환(오류방지)
        int room_amount;
        try {
            room_amount = Integer.parseInt(room_amountStr);
        } catch (NumberFormatException e) {
            System.out.println("Invalid room_amount: " + room_amountStr);
            throw new IllegalArgumentException("Invalid room_amount: " + room_amountStr);
        }

        // 선택된 정보를 세션에 저장
        session.setAttribute("seat_code", seat_code);
        session.setAttribute("room_code", room_code);
        session.setAttribute("room_amount", room_amount);
        session.setAttribute("duration", duration);
        session.setAttribute("time_code", time_code);
        session.setAttribute("start_time", start_time);

  
        // 종료 시간을 계산하여 세션에 저장
        String end_time = calculateEndTime(start_time, duration);
        session.setAttribute("end_time", end_time);

        // Null 체크 추가
        String branch_code = (String) session.getAttribute("branch_code");
        String branch_name = (String) session.getAttribute("branch_name");

        if (branch_code == null || branch_name == null || seat_code == null || room_code == null || start_time == null || duration == null) {
            throw new IllegalStateException("Missing session attribute");
        }

        // 로그 추가
        System.out.println("선택된 branch_code: " + branch_code);
        System.out.println("선택된 branch_name: " + branch_name);
        System.out.println("선택된 seat_code: " + seat_code);
        System.out.println("선택된 room_code: " + room_code);
        System.out.println("선택된 room_amount: " + room_amount);
        System.out.println("선택된 start_time: " + start_time);
        System.out.println("선택된 duration: " + duration);

        model.addAttribute("branch_code", branch_code);
        model.addAttribute("branch_name", branch_name);
        model.addAttribute("seat_code", seat_code);
        model.addAttribute("room_code", room_code);
        model.addAttribute("room_amount", room_amount);
        model.addAttribute("start_time", start_time);
        model.addAttribute("duration", duration);
        model.addAttribute("end_time", end_time);

        // 현재 날짜를 reservation_date로 추가
        String reservation_date = java.time.LocalDate.now().toString();
        model.addAttribute("reservation_date", reservation_date); // reservation_date 추가
        System.out.println("reservation_date: " + reservation_date);

        // 관리자페이지에서 사용(확인해야함)
        // using_seat 값 추가 (예: "Y"로 고정 / 취소여부)
        String using_seat = "Y";
        model.addAttribute("using_seat", using_seat); // using_seat 추가
        System.out.println("using_seat: " + using_seat);

        // 회원 여부를 세션에서 확인
        Boolean isMember = (Boolean) session.getAttribute("isMember");
        model.addAttribute("isMember", isMember != null ? isMember : false);

        // 세션에서 이름과 전화번호를 가져와서 추가
        if (Boolean.TRUE.equals(isMember)) {
            String re_name = (String) session.getAttribute("re_name");
            String re_phone = (String) session.getAttribute("re_phone");
            model.addAttribute("re_name", re_name);
            model.addAttribute("re_phone", re_phone);
            System.out.println("회원 이름: " + re_name);
            System.out.println("회원 전화번호: " + re_phone);
        }

        return "readingroom/submitReservation"; // 결제 페이지로 이동
    }//paymentForm() end

    
    // 종료 시간을 계산하는 메서드
    private String calculateEndTime(String start_time, String duration) {
        int durationInHours = parseDuration(duration);

        String[] parts = start_time.split(":");
        int hours = Integer.parseInt(parts[0]);
        int minutes = Integer.parseInt(parts[1]);

        hours += durationInHours;
        if (hours >= 24) {
            hours -= 24;
        }

        return String.format("%02d:%02d", hours, minutes);
    }

    // duration 문자열을 정수 시간으로 변환하는 메서드
    private int parseDuration(String duration) {
        switch (duration) {
            case "2시간":
                return 2;
            case "4시간":
                return 4;
            case "6시간":
                return 6;
            case "종일권":
                return 10;
            default:
                throw new IllegalArgumentException("Invalid duration: " + duration);
        }
    }//calculateEndTime() end
    
    
  
    @PostMapping("/submitReservation")
    public String submitReservation(@RequestParam("branch_code") String branch_code,
                              @RequestParam("seat_code") String seat_code,
                              @RequestParam("room_code") String room_code,
                              @RequestParam("time_code") String time_code,
                              @RequestParam("start_time") String start_time,
                              @RequestParam("end_time") String end_time,
                              @RequestParam("reservation_total") int reservation_total,
                              @RequestParam("re_name") String re_name,
                              @RequestParam("re_phone") String re_phone,
                              @RequestParam(value = "mycoupon_number", required = false) String mycoupon_number,
                               @RequestParam("reservation_payment") String reservation_payment,
                              @RequestParam("reservation_date") String reservation_date,
                              @RequestParam("using_seat") String using_seat,
                              @RequestParam("isMember") boolean isMember,
                              HttpSession session,
                              Model model) {
        try {
            // 로그 추가
            System.out.println("re_name: " + re_name);
            System.out.println("re_phone: " + re_phone);

            // ReservationDTO 객체 생성 및 데이터 설정
            ReservationDTO reservation = new ReservationDTO();
            reservation.setSeat_code(seat_code);
            reservation.setRoom_code(room_code);
            reservation.setTime_code(time_code);
            reservation.setEnd_time(end_time);
            reservation.setReservation_total(reservation_total);
            reservation.setRe_name(re_name);
            reservation.setRe_phone(re_phone);
            reservation.setMycoupon_number(mycoupon_number != null && !mycoupon_number.isEmpty() ? mycoupon_number : null);
            reservation.setReservation_payment(reservation_payment);
            reservation.setReservation_date(reservation_date);
            reservation.setUsing_seat(using_seat);
            
         // isMember가 true일 경우 'RP', false일 경우 'NRP'를 예약 코드의 첫 글자로 설정
            String reservationCodePrefix = isMember ? "RP" : "NRP";

            // 예약 코드의 숫자 부분을 결정 (예: 000001)
            int nextCodeNumber = reservationDAO.getNextReservationCodeNumber(reservationCodePrefix);

            // 전체 예약 코드 생성
            String reservationCode = reservationCodePrefix + String.format("%06d", nextCodeNumber);
            reservation.setReservation_code(reservationCode);
            System.out.println("reservation: " + reservation);

            // 세션에서 이메일 가져오기 (회원일 경우)
            String email = isMember ? (String) session.getAttribute("email") : null;

            // 서비스 메서드를 통해 데이터베이스에 저장
            reservationDAO.insertReservation(reservation);

            // 결과 페이지로 이동
            return "readingroom/reservationSuccess";
        } catch (Exception e) {
            e.printStackTrace();
            return "error"; // 에러 발생 시 error 페이지로 이동
        }
    }

   
 
}//ReadingRoomCont() end
