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
import java.time.Duration;

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
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
        LocalTime now = LocalTime.now();
        StringBuilder seatTimeBuilder = new StringBuilder();

        for (ReservationDTO reservation : reservations) {
            String endTimeStr = reservation.getEnd_time();
            LocalTime endTime = LocalTime.parse(endTimeStr, formatter);
            String startTimeStr = getStartTimeByTimeCode(reservation.getTime_code());
            LocalTime startTime = LocalTime.parse(startTimeStr, formatter);

            if (startTime.isBefore(now) && endTime.isAfter(now)) {
                Duration duration = Duration.between(now, endTime);
                long hours = duration.toHours();
                long minutes = duration.toMinutes() % 60;
                seatTimeBuilder.append(String.format("%02d:%02d", hours, minutes)).append(", ");
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
                              HttpSession session, Model model) {

        // room_amount를 String으로 받아서 int로 변환(오류방지)
        int room_amount;
        try {
            room_amount = Integer.parseInt(room_amountStr);
        } catch (NumberFormatException e) {
            System.out.println("Invalid room_amount: " + room_amountStr);
            throw new IllegalArgumentException("Invalid room_amount: " + room_amountStr);
        }

        // 종료 시간을 계산
        String end_time = calculateEndTime(start_time, duration);

        // 좌석 사용 가능 여부 확인
        if (!isSeatAvailable(seat_code, start_time, end_time)) {
            model.addAttribute("errorMessage", "선택하신 좌석은 선택한 시간에 이미 예약되어 있습니다.");
            return "redirect:/selectBranch?error=true"; // 예약 페이지로 리다이렉트
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

            // 비회원일 경우 비회원 정보 저장
            if (!isMember) {
                NonMemberDTO existingNonMember = nonMemberDAO.findNonMemberByNameAndPhone(re_name, re_phone);
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

            // 결과 페이지로 이동
            return "readingroom/reservationSuccess";
        } catch (Exception e) {
            e.printStackTrace();
            return "error"; // 에러 발생 시 error 페이지로 이동
        }
    }

    
    
    private boolean isSeatAvailable(String seatCode, String startTime, String endTime) {
        List<ReservationDTO> reservations = reservationDAO.getReservationsBySeatCode(seatCode);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
        LocalTime start = LocalTime.parse(startTime, formatter);
        LocalTime end = LocalTime.parse(endTime, formatter);

        for (ReservationDTO reservation : reservations) {
            String existingStartTime = getStartTimeByTimeCode(reservation.getTime_code());
            LocalTime existingStart = LocalTime.parse(existingStartTime, formatter);
            LocalTime existingEnd = LocalTime.parse(reservation.getEnd_time(), formatter);

            // Check if the new reservation starts exactly when an existing reservation ends
            if (start.equals(existingEnd)) {
                continue; // New reservation starts exactly when the existing reservation ends, so it is allowed
            }

            // Check for time overlap
            if (start.isBefore(existingEnd) && end.isAfter(existingStart)) {
                return false; // 시간이 겹치면 사용 불가
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
}
