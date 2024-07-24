package kr.co.literal.readingroom;

import kr.co.literal.readingroom.dto.*;
import kr.co.literal.member.MemberDAO;
import kr.co.literal.member.MemberDTO;
import kr.co.literal.readingroom.dao.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.Duration;
import java.time.LocalDate;

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
    
    @Autowired
    private NonMemberDAO nonMemberDAO;
    
    //열람실 예약 메인페이지
    @GetMapping("/reading_main")
    public String reserveSeat(Model model) {
        return "readingroom/reservationForm";
    }
    
    // 지점 선택 처리
    @RequestMapping(value = "/selectBranch", method = {RequestMethod.GET, RequestMethod.POST})
    public String selectBranchByCode(@RequestParam(value = "branch_code", required = false) String branch_code, HttpSession session, Model model) {
        if (branch_code == null) {
            // branch_code가 없는 경우 세션에서 가져옴
            branch_code = (String) session.getAttribute("branch_code");
        }
        
        if (branch_code == null) {
            // 여전히 branch_code가 없는 경우 오류 처리
            model.addAttribute("errorMessage", "지점 코드가 누락되었습니다. 다시 시도해주세요.");
            return "error"; // 에러 페이지로 이동
        }

        BranchDTO branch = branchDAO.selectBranchByCode(branch_code);
        session.setAttribute("branch_code", branch_code);
        session.setAttribute("branch_name", branch.getBranch_name());

        List<String> seatLayout = getSeatLayoutByBranch(branch_code);
        model.addAttribute("seatLayout", seatLayout);

        Map<String, String> seatTimes = new HashMap<>();
        for (String seatCode : seatLayout) {
            if (!seatCode.equals("hidden")) {
                String remainingTime = getSeatTime(seatCode);
                seatTimes.put(seatCode, remainingTime);
            }
        }
        model.addAttribute("seatTimes", seatTimes);

        return "readingroom/seatSelection";
    }

    private List<String> getSeatLayoutByBranch(String branch_code) {
        List<String> seatLayout = Arrays.asList(
            "1", "2", "3", "4", "5",
            "hidden", "hidden", "hidden", "hidden", "6",
            "hidden", "10", "11", "hidden", "7",
            "hidden", "12", "13", "hidden", "8",
            "hidden", "14", "15", "hidden", "9"
        );

        for (int i = 0; i < seatLayout.size(); i++) {
            if (!seatLayout.get(i).equals("hidden")) {
                seatLayout.set(i, branch_code + "-" + String.format("%02d", Integer.parseInt(seatLayout.get(i))));
            }
        }
        return seatLayout;
    }

    private String getSeatTime(String seatCode) {
        List<ReservationDTO> reservations = reservationDAO.getReservationsBySeatCode(seatCode);
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime now = LocalDateTime.now();
        StringBuilder seatTimeBuilder = new StringBuilder();

        for (ReservationDTO reservation : reservations) {
            String endTimeStr = reservation.getEnd_time();
            LocalTime endTime = LocalTime.parse(endTimeStr, timeFormatter);
            String startTimeStr = getStartTimeByTimeCode(reservation.getTime_code());
            LocalTime startTime = LocalTime.parse(startTimeStr, timeFormatter);

            // 예약 날짜를 LocalDate로 변환
            LocalDate reservationDate = LocalDate.parse(reservation.getReservation_date(), dateTimeFormatter);

            // 현재 날짜와 예약 날짜가 같은지 확인
            if (reservationDate.isEqual(now.toLocalDate())) {
                if (startTime.isBefore(now.toLocalTime()) && endTime.isAfter(now.toLocalTime())) {
                    Duration duration = Duration.between(now.toLocalTime(), endTime);
                    long hours = duration.toHours();
                    long minutes = duration.toMinutes() % 60;
                    seatTimeBuilder.append(String.format("%02d:%02d", hours, minutes)).append(", ");
                }
            }
        }

        if (seatTimeBuilder.length() == 0) {
            return "00:00";
        }

        seatTimeBuilder.setLength(seatTimeBuilder.length() - 2);
        return seatTimeBuilder.toString();
    }



    @GetMapping("/api/getSeatTimes")
    @ResponseBody
    public Map<String, String> getSeatTimes(@RequestParam("branch_code") String branch_code) {
        List<String> seatLayout = getSeatLayoutByBranch(branch_code);
        Map<String, String> seatTimes = new HashMap<>();
        for (String seatCode : seatLayout) {
            if (!seatCode.equals("hidden")) {
                String remainingTime = getSeatTime(seatCode);
                seatTimes.put(seatCode, remainingTime);
            }
        }
        return seatTimes;
    }

    @PostMapping("/api/checkSeatAvailability")
    @ResponseBody
    public Map<String, Boolean> checkSeatAvailability(@RequestParam("seat_code") String seatCode,
                                                      @RequestParam("start_time") String startTime,
                                                      @RequestParam("end_time") String endTime) {
        boolean isAvailable = isSeatAvailable(seatCode, startTime, endTime);
        Map<String, Boolean> response = new HashMap<>();
        response.put("available", isAvailable);
        return response;
    }

 // 좌석 선택 
    @PostMapping("/paymentForm")
    public String paymentForm(@RequestParam("seat_code") String seat_code,
                              @RequestParam("room_code") String room_code, 
                              @RequestParam("room_amount") String room_amountStr,
                              @RequestParam("duration") String duration,
                              @RequestParam("time_code") String time_code, 
                              @RequestParam("start_time") String start_time,
                              @RequestParam(value = "mycoupon_number", required = false) String mycoupon_number,
                              @RequestParam(value = "use_coupon", required = false, defaultValue = "false") boolean useCoupon,
                              HttpSession session, Model model, RedirectAttributes redirectAttributes) {


        // room_amount를 String으로 받아서 int로 변환(오류방지)
        int room_amount;
        try {
            room_amount = Integer.parseInt(room_amountStr);
        } catch (NumberFormatException e) {
            System.out.println("Invalid room_amount: " + room_amountStr);
            throw new IllegalArgumentException("Invalid room_amount: " + room_amountStr);
        }
        
        // 쿠폰 적용 여부 확인 및 결제 금액 조정
        if (useCoupon) {
            room_amount -= 4000; // 쿠폰 적용 시 4000원 할인
            if (room_amount < 0) room_amount = 0;
        }

        // 종료 시간을 계산
        String end_time = calculateEndTime(start_time, duration);

        // 좌석 사용 가능 여부 확인
        if (!isSeatAvailable(seat_code, start_time, end_time)) {
            redirectAttributes.addFlashAttribute("errorMessage", "이미 예약된 좌석입니다. 다른 좌석을 선택해주세요.");
            return "redirect:/selectBranch?error=already_reserved"; // 예약 페이지로 리다이렉트
        }

        // 선택된 정보를 세션에 저장
        session.setAttribute("seat_code", seat_code);
        session.setAttribute("room_code", room_code);
        session.setAttribute("room_amount", room_amount);
        session.setAttribute("duration", duration);
        session.setAttribute("time_code", time_code);
        session.setAttribute("start_time", start_time);
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
            
            //쿠폰 번호를 세션에서 가져와서 추가
            /*String coupon_number = (String) session.getAttribute("coupon_number");
            model.addAttribute("coupon_number", coupon_number);
            System.out.println("회원 쿠폰 번호: " + coupon_number);
        }*/
         // 사용되지 않은 쿠폰 목록을 가져와서 세션에 저장
            List<MyCouponDTO> couponList = myCouponDAO.getAllUnusedCouponsByEmail((String) session.getAttribute("email"));
            session.setAttribute("couponList", couponList);
        }

        return "readingroom/submitReservation"; // 결제 페이지로 이동
    }

    
    private String calculateEndTime(String start_time, String duration) {
        int durationInHours = parseDuration(duration);

        String[] parts = start_time.split(":");
        int hours = Integer.parseInt(parts[0]);
        int minutes = Integer.parseInt(parts[1]);

        // 종료 시간 계산
        hours += durationInHours;

        // 종료 시간이 19시를 넘는 경우
        if (hours >= 19) {
            hours = 19;
            minutes = 0;
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
    
    
    
    
    // 예약 제출 메서드
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
                                    @RequestParam("imp_uid") String imp_uid,
                                    HttpSession session,
                                    RedirectAttributes redirectAttributes) {
        try {
            // 실제 결제 금액 계산
            int actualPayment = reservation_total;
			/*
			 * if (mycoupon_number != null && !mycoupon_number.isEmpty()) { MyCouponDTO
			 * coupon = myCouponDAO.selectMyCouponByNumber(mycoupon_number); if (coupon !=
			 * null && coupon.getExpiry_date() != null) { LocalDate expiryDate =
			 * coupon.getExpiry_date().toLocalDate(); // `expiry_date`를 `LocalDate`로 변환 if
			 * (expiryDate.isAfter(LocalDate.now())) { if (mycoupon_number.contains("D1")) {
			 * actualPayment -= 4000; } else if (mycoupon_number.contains("D2")) {
			 * actualPayment -= 6000; } else if (mycoupon_number.contains("D3")) {
			 * actualPayment -= 8000; } else if (mycoupon_number.contains("D4")) {
			 * actualPayment -= 10000; } if (actualPayment < 0) actualPayment = 0; } } }
			 */
            // 로그 추가
            System.out.println("Calculated actualPayment: " + actualPayment);
            
            // 쿠폰 사용 날짜 업데이트
            if (mycoupon_number != null && !mycoupon_number.isEmpty()) {
                MyCouponDTO usedCoupon = new MyCouponDTO();
                usedCoupon.setMycoupon_number(mycoupon_number);
                usedCoupon.setUsage_date(Timestamp.valueOf(LocalDateTime.now())); // Timestamp로 변경
                myCouponDAO.updateMyCouponUsageDate(usedCoupon);
            }

            // ReservationDTO 객체 생성 및 데이터 설정
            ReservationDTO reservation = new ReservationDTO();
            reservation.setSeat_code(seat_code);
            reservation.setRoom_code(room_code);
            reservation.setTime_code(time_code);
            reservation.setEnd_time(end_time);
            reservation.setReservation_total(actualPayment);
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

            // 서비스 메서드를 통해 데이터베이스에 저장
            reservationDAO.insertReservation(reservation);

            // 비회원일 경우 비회원 정보 저장
            if (!isMember) {
                NonMemberDTO existingNonMember = nonMemberDAO.findNonMember(reservationCode, re_name, re_phone);
                if (existingNonMember == null) {
                    NonMemberDTO nonMember = new NonMemberDTO();
                    nonMember.setReservation_code(reservationCode);
                    nonMember.setNon_name(re_name);
                    nonMember.setNon_phone(re_phone);
                    nonMemberDAO.insertNonMember(nonMember);
                } else {
                    // 기존 비회원 정보가 있을 경우, 해당 정보와 현재 예약 코드를 연결
                    existingNonMember.setReservation_code(reservationCode);
                    nonMemberDAO.updateNonMember(existingNonMember);
                }
            }

            // 리다이렉트 설정
            redirectAttributes.addFlashAttribute("reservation", reservation);
            session.setAttribute("actualPayment", actualPayment);
            redirectAttributes.addFlashAttribute("actualPayment", actualPayment);  // 실제 결제 금액을 모델에 저장

            
            // 로그 추가
            System.out.println("Stored actualPayment in session: " + session.getAttribute("actualPayment"));
            
            
            // 사용된 쿠폰을 제외한 사용자의 모든 쿠폰을 다시 가져와서 세션에 저장
            if (isMember) {
                String email = (String) session.getAttribute("email");
                List<MyCouponDTO> couponList = myCouponDAO.getAllUnusedCouponsByEmail(email);
                session.setAttribute("couponList", couponList);
            }
            

            // 결과 페이지로 리다이렉트
            return "redirect:/reservation/confirmation";
        } catch (Exception e) {
            e.printStackTrace();
            return "error"; // 에러 발생 시 error 페이지로 이동
        }
    }


    
    
    // 예약 확인 페이지 메서드
	/*
	 * @GetMapping("/reservation/confirmation") public String
	 * showReservationConfirmation(Model model) { return
	 * "readingroom/reservationSuccess"; // reservationSuccess.jsp 페이지로 이동 }
	 */
    // 예약 확인 페이지 메서드
    @GetMapping("/reservation/confirmation")
    public String showReservationConfirmation(HttpSession session, Model model) {
        Integer actualPayment = (Integer) session.getAttribute("actualPayment");
        model.addAttribute("actualPayment", actualPayment);
        return "readingroom/reservationSuccess"; // reservationSuccess.jsp 페이지로 이동
    }

    
    
    private boolean isSeatAvailable(String seatCode, String startTime, String endTime) {
        List<ReservationDTO> reservations = reservationDAO.getReservationsBySeatCode(seatCode);
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalTime start = LocalTime.parse(startTime, timeFormatter);
        LocalTime end = LocalTime.parse(endTime, timeFormatter);
        LocalDate today = LocalDate.now();

        for (ReservationDTO reservation : reservations) {
            LocalDate reservationDate = LocalDate.parse(reservation.getReservation_date(), dateTimeFormatter);
            LocalTime existingStart = LocalTime.parse(getStartTimeByTimeCode(reservation.getTime_code()), timeFormatter);
            LocalTime existingEnd = LocalTime.parse(reservation.getEnd_time(), timeFormatter);

            // 현재 날짜와 예약 날짜가 같을 경우에만 예약 시간 겹침 여부를 확인
            if (reservationDate.isEqual(today)) {
                // Check if the new reservation starts exactly when an existing reservation ends
                if (start.equals(existingEnd)) {
                    continue; // New reservation starts exactly when the existing reservation ends, so it is allowed
                }

                // Check for time overlap
                if (start.isBefore(existingEnd) && end.isAfter(existingStart)) {
                    return false; // 시간이 겹치면 사용 불가
                }
            }
        }
        return true;
    }

    
    
    

    private String getStartTimeByTimeCode(String time_code) {
        switch (time_code) {
            case "T01":
                return "09:00";
            case "T02":
                return "10:00";
            case "T03":
                return "11:00";
            case "T04":
                return "12:00";
            case "T05":
                return "13:00";
            case "T06":
                return "14:00";
            case "T07":
                return "15:00";
            case "T08":
                return "16:00";
            case "T09":
                return "17:00";
            default:
                throw new IllegalArgumentException("Invalid time code: " + time_code);
        }
    }
    
    
    
    //0719이용권구매 추가
    // 이용권 구매 페이지 접근 제어
    @GetMapping("/buyTicket")
    public String buyTicket(HttpSession session, RedirectAttributes redirectAttributes) {
        Boolean isMember = (Boolean) session.getAttribute("isMember");
        if (isMember == null || !isMember) {
            redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
            return "redirect:/member/login"; // 로그인 페이지로 리디렉션
        }
        return "readingroom/buyTicket";
    }

    
    // 이용권 구매 처리
    @PostMapping("/buyTicket")
    public String buyTicket(@RequestParam("ticketType") String ticketType,
                            @RequestParam("imp_uid") String impUid,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        System.out.println("imp_uid: " + impUid);

        // 세션에서 사용자 정보 가져오기
        String email = (String) session.getAttribute("email");
        String name = (String) session.getAttribute("name");
        String phone = (String) session.getAttribute("phone");

        // MyCouponDTO 객체 생성 및 데이터 설정
        MyCouponDTO myCoupon = new MyCouponDTO();
        myCoupon.setEmail(email);
        String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyMMdd"));
        int count = myCouponDAO.getNextCouponCount(date, ticketType);
        String countStr = String.format("%03d", count);
        String mycoupon_number = date + ticketType + countStr;
        myCoupon.setMycoupon_number(mycoupon_number);
        myCoupon.setRoom_code(ticketType);

        // LocalDate를 java.sql.Date로 변환하여 설정
        myCoupon.setIssue_date(Date.valueOf(LocalDate.now()));
        myCoupon.setExpiry_date(Date.valueOf(LocalDate.now().plusMonths(1))); // 한 달 유효

        // MyCouponDAO를 통해 데이터베이스에 저장
        myCouponDAO.insertMyCoupon(myCoupon);

        // 사용자의 모든 쿠폰을 다시 가져와서 세션에 저장
        List<MyCouponDTO> couponList = myCouponDAO.getAllCouponsByEmail(email);
        session.setAttribute("couponList", couponList);

        // 리다이렉트 설정
        redirectAttributes.addFlashAttribute("myCoupon", myCoupon);

        // 결과 페이지로 리다이렉트
        return "redirect:/ticket/confirmation";
    }


    // 예약 확인 페이지 메서드
    @GetMapping("/ticket/confirmation")
    public String showTicketConfirmation(Model model) {
        return "readingroom/ticketConfirmation"; // ticketConfirmation.jsp 페이지로 이동
    }
    
    
    //서버에서 쿠폰 검증 엔드포인트 수정
    @RequestMapping(value = "/validateCoupon", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> validateCoupon(@RequestParam("couponNumber") String couponNumber) {
        Map<String, Object> response = new HashMap<>();
        MyCouponDTO coupon = myCouponDAO.selectMyCouponByNumber(couponNumber);

        if (coupon != null) {
            LocalDate expiryDate = coupon.getExpiry_date().toLocalDate();
            if (expiryDate.isAfter(LocalDate.now())) {
                response.put("valid", true);
                // 쿠폰 유형에 따라 할인 금액 설정
                int discountAmount = 0;
                if (couponNumber.contains("D1")) {
                    discountAmount = 4000;
                } else if (couponNumber.contains("D2")) {
                    discountAmount = 6000;
                } else if (couponNumber.contains("D3")) {
                    discountAmount = 8000;
                } else if (couponNumber.contains("D4")) {
                    discountAmount = 10000;
                }
                response.put("discountAmount", discountAmount);
            } else {
                response.put("valid", false);
            }
        } else {
            response.put("valid", false);
        }

        return response;
    }

    
}
