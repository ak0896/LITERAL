package kr.co.literal.admin;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.literal.product.ProductDAO;
import kr.co.literal.product.ProductDTO;
import kr.co.literal.readingroom.dao.BranchDAO;
import kr.co.literal.readingroom.dao.NonMemberDAO;
import kr.co.literal.readingroom.dao.ReservationDAO;
import kr.co.literal.readingroom.dao.SeatDAO;
import kr.co.literal.readingroom.dao.UseTimeDAO;
import kr.co.literal.readingroom.dto.BranchDTO;
import kr.co.literal.readingroom.dto.NonMemberDTO;
import kr.co.literal.readingroom.dto.ReservationDTO;
import kr.co.literal.readingroom.dto.SeatDTO;
import kr.co.literal.readingroom.dto.UseTimeDTO;
import kr.co.literal.admin.DailySalesDTO;

@Controller
public class BranchCont {

	@Autowired
	private BranchDAO branchDAO;

	@Autowired
	private ProductDAO productDao;

	@Autowired
	private AdminDAO adminDAO;
	
	@Autowired
	private NonMemberDAO nonMemberDAO;
	
	@Autowired
	private ReservationDAO reservationDAO;
	
	@Autowired
	private SeatDAO seatDAO;
	
	@Autowired
	private UseTimeDAO useTimeDAO;
	
	
	

	// 관리자페이지

	// 관리자 페이지 메인
	@GetMapping("/admin/branchRegister")
	public String branchDetailForm(Model model) {
		return "admin/branchRegister"; // JSP 파일의 경로를 반환
	}// branchDetailForm() end

	
	// 지점 등록
	@PostMapping("/admin/saveBranch")
	public String saveBranch(@RequestParam("branch_name") String branch_name,
			@RequestParam("branch_detail") String branch_detail, @RequestParam("branch_address") String branch_address,
			@RequestParam("latitude") String latitude, @RequestParam("longitude") String longitude,
			RedirectAttributes redirectAttributes, Model model) {

		// 중복 지점 이름 확인
		if (branchDAO.selectBranchByName(branch_name) != null) {
			model.addAttribute("branchNameError", "이미 존재하는 지점 이름입니다.");
			model.addAttribute("branch_name", branch_name);
			model.addAttribute("branch_detail", branch_detail);
			model.addAttribute("branch_address", branch_address);
			model.addAttribute("latitude", latitude);
			model.addAttribute("longitude", longitude);
			return "admin/branchRegister";
		}

		// branch_code 생성
		String lastCode = branchDAO.getLastBranchCode();
		int newCode = 1;
		if (lastCode != null) {
			newCode = Integer.parseInt(lastCode.substring(1)) + 1;
		}
		String branch_code = "L" + String.format("%02d", newCode);

		// branchDTO 생성
		BranchDTO branchDTO = new BranchDTO();
		branchDTO.setBranch_code(branch_code);
		branchDTO.setBranch_name(branch_name);
		branchDTO.setBranch_detail(branch_detail);
		branchDTO.setBranch_address(branch_address);
		branchDTO.setLatitude(latitude);
		branchDTO.setLongitude(longitude);

		// Insert branch
		branchDAO.insertBranch(branchDTO);

		// daily_sales에 초기 데이터 삽입
		DailySalesDTO dailySalesDTO = new DailySalesDTO();
		dailySalesDTO.setBranch_code(branch_code);
		dailySalesDTO.setDtotal_product(0);
		dailySalesDTO.setDtotal_room(0);

		// 현재 날짜를 Date 객체로 설정
		Date currentDate = new Date();
		dailySalesDTO.setSales_date(currentDate);

		// daily_sales 테이블에 데이터 삽입
		adminDAO.insertOrUpdateDailySales(dailySalesDTO);

		return "redirect:/admin/branchList"; // 데이터 저장 후 지점 목록 페이지로 리다이렉트
	}// saveBranch() end

	
	
	// 지점 정보 수정 폼을 보여주는 메서드
	@PostMapping("/admin/branchEdit")
	public String getBranchForUpdate(@RequestParam("branch_code") String branch_code, Model model) {
		System.out.println("branchEditForm: branch_code= " + branch_code);
		BranchDTO branch = branchDAO.selectBranchByCode(branch_code);
		model.addAttribute("branch", branch);
		System.out.println(branch);
		return "admin/branchEdit";
	}// getBranchForUpdate() end

	
	
	// 수정 폼을 제출할 때 호출
	@PostMapping("/admin/updateBranch")
	public String updateBranch(BranchDTO branchDTO, Model model) {
		System.out.println("1수정된 branch: " + branchDTO);
		branchDAO.updateBranch(branchDTO);

		// 수정된 정보를 다시 가져와서 모델에 추가
		BranchDTO updateBranch = branchDAO.selectBranchByCode(branchDTO.getBranch_code());
		System.out.println("2수정된 branch: " + branchDTO);
		model.addAttribute("branch", updateBranch);

		//0724 애경 수정
		return "redirect:/admin/branchList";  // 수정 후 수정된 정보를 다시 보여줌
	}// updateBranch() end

	
	
	// 지점 삭제
	@PostMapping("/admin/deleteBranch")
	public String deleteBranch(@RequestParam("branch_code") String branch_code) {
		branchDAO.deleteBranch(branch_code); // 데이터베이스에서 지점 정보 삭제
		return "redirect:/admin/branchList"; // 삭제 후 관리자 지점 목록 페이지로 이동
	}// deleteBranch() end

	
	
	// 지점 목록 조회
	@GetMapping("/admin/branchList")
	public String selectAllBranches(Model model) {
		List<BranchDTO> branch = branchDAO.selectAllBranches();
		System.out.println("지점등록현황 = " + branch.size());
		model.addAttribute("branch", branch);
		return "admin/branchList";
	}// selectAllBranches() end

	
	
	// 지점 상세 보기
	@GetMapping("/admin/branchDetail")
	public String branchDetail(@RequestParam("branch_code") String branch_code, Model model) {
		BranchDTO branch = branchDAO.selectBranchByCode(branch_code);
		System.out.println("선택된 branch: " + branch);
		model.addAttribute("branch", branch);
		return "admin/branchDetail_admin";
	}// branchDetail() end

	
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////

	
	// 일반 사용자 페이지에서 보여지는 부분

	
	// 오늘의 책 출력
	// 지점 목록을 동적으로 JSP에 전달
	@GetMapping("/branch/branchDetail")
	public String dynamicTabs(Model model) {
		List<BranchDTO> branches = branchDAO.selectAllBranches();
		Map<String, List<ProductDTO>> todayBooks = new HashMap<>();

		for (BranchDTO branch : branches) {
			List<ProductDTO> books = productDao.getTodayBookListByBranch(branch.getBranch_code());
			todayBooks.put(branch.getBranch_code(), books);
		}

		model.addAttribute("branchList", branches);
		model.addAttribute("todayBooks", todayBooks);
		System.out.println("Today's books: " + todayBooks);

		ObjectMapper objectMapper = new ObjectMapper();
		try {
			String todayBooksJson = objectMapper.writeValueAsString(todayBooks);
			model.addAttribute("todayBooksJson", todayBooksJson);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
			model.addAttribute("todayBooksJson", "{}"); // 오류 시 빈 객체 전달
		}

		return "branch/branchDetail";
	}//dynamicTabs() end

	
	
	@GetMapping("/get-today-books-by-branch")
	@ResponseBody
	public List<ProductDTO> getTodayBookListByBranch(@RequestParam("branch_code") String branch_code) {
		return productDao.getTodayBookListByBranch(branch_code);
	}//getTodayBookListByBranch() end

	
	
	@GetMapping("/get-branch-list")
	@ResponseBody
	public List<BranchDTO> getBranchList() {
		return branchDAO.selectAllBranches();
	}//getBranchList() end

	
	
	////////////////////////////////////////////////////////////////////////////////////////////////

	
	
	// 지점매출 관련 부분
	// 지점 매출 페이지
	@GetMapping("/admin/dailySales")
	public String showDailySales(Model model) {
		List<BranchDTO> branchesList = branchDAO.selectAllBranches();
		model.addAttribute("branchesList", branchesList);
		System.out.println("branchesList size: " + branchesList.size()); // 디버깅 로그
		return "admin/dailySalesDetail";
	}// showDailySales() end

	
	
	// 지점 코드와 매출 날짜로 daily_sales 데이터를 조회
	@GetMapping("/admin/dailySalesDetail")
	public String getSalesDetail(@RequestParam("branch_code") String branch_code,
			@RequestParam("start_date") @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
			@RequestParam(value = "end_date", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate,
			Model model) {

		List<DailySalesDTO> salesData = new ArrayList<>();
		BranchDTO selectedBranch = branchDAO.selectBranchByCode(branch_code);

		if (endDate == null || endDate.equals(startDate)) {
			endDate = startDate;// 단일 날짜 조회 시 종료 날짜를 시작 날짜와 동일하게 설정
			// 단일 날짜 조회
			DailySalesDTO dailySales = branchDAO.selectDailySales(branch_code, startDate);
			if (dailySales == null) {
				dailySales = new DailySalesDTO();
				dailySales.setBranch_code(branch_code);
				dailySales.setSales_date(startDate);
				dailySales.setDtotal_product(0);
				dailySales.setDtotal_room(0);
			}
			salesData.add(dailySales);

		} else {
			// 기간 조회
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(startDate);

			while (!calendar.getTime().after(endDate)) {
				Date currentDate = calendar.getTime();
				DailySalesDTO dailySales = branchDAO.selectDailySales(branch_code, currentDate);
				if (dailySales == null) {
					dailySales = new DailySalesDTO();
					dailySales.setBranch_code(branch_code);
					dailySales.setSales_date(currentDate);
					dailySales.setDtotal_product(0);
					dailySales.setDtotal_room(0);
				}
				salesData.add(dailySales);
				calendar.add(Calendar.DAY_OF_MONTH, 1);
			}
		}

		int totalProductSales = salesData.stream().mapToInt(DailySalesDTO::getDtotal_product).sum();
		int totalRoomSales = salesData.stream().mapToInt(DailySalesDTO::getDtotal_room).sum();

		model.addAttribute("salesData", salesData);
		model.addAttribute("selectedBranch", selectedBranch);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("totalProductSales", totalProductSales);
		model.addAttribute("totalRoomSales", totalRoomSales);

		System.out.println("선택된 지점코드 :" + selectedBranch);
		System.out.println("선택된 시작날짜 :" + startDate);
		System.out.println("선택된 종료날짜 :" + endDate);
		System.out.println("추가된 상품매출 : " + totalProductSales);
		System.out.println("추가된 열람실매출 : " + totalRoomSales);

		// 지점 목록 계속 출력
		List<BranchDTO> branchesList = branchDAO.selectAllBranches();
		model.addAttribute("branchesList", branchesList);

		return "admin/dailySalesDetail";
	}// getSalesDetail() end

	
	
	
	@PostMapping("/updateDailySales")
	public String updateDailySales(@RequestParam("date") @DateTimeFormat(pattern = "yyyy-MM-dd") Date salesDate) {
		try {
			// 모든 지점의 목록을 조회
			List<BranchDTO> branches = branchDAO.selectAllBranches();

			// 각 지점에 대해 매출 데이터를 업데이트
			for (BranchDTO branch : branches) {
				updateDailySalesForBranch(branch.getBranch_code(), salesDate);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("에러 메시지: " + e.getMessage());
		}
		return "redirect:/admin/dailySalesAll";
	}// updateDailySales() end

	
	
	// 개별 지점 업데이트를 위한 private 메서드
	private void updateDailySalesForBranch(String branchCode, Date salesDate) {
		// 해당 지점과 날짜의 상품 매출 합계 계산
		int dtotalProduct = adminDAO.calculateDtotalProduct(branchCode, salesDate);
		// 해당 지점과 날짜의 예약 매출 합계 계산
		int dtotalRoom = adminDAO.calculateDtotalRoom(branchCode, salesDate);

		// DailySalesDTO 객체를 생성하여 매출 데이터를 설정
		DailySalesDTO dailySalesDTO = new DailySalesDTO();
		dailySalesDTO.setBranch_code(branchCode);
		dailySalesDTO.setSales_date(salesDate);
		dailySalesDTO.setDtotal_product(dtotalProduct);
		dailySalesDTO.setDtotal_room(dtotalRoom);

		// 매출 데이터를 데이터베이스에 삽입하거나 업데이트
		adminDAO.insertOrUpdateDailySales(dailySalesDTO);
	}// updateDailySalesForBranch() end

	
	/*
	// 모든 daily_sales 데이터를 조회
	@GetMapping("/admin/dailySalesAll")
	public String getAllDailySales(Model model) {
		List<DailySalesDTO> dailySalesList = adminDAO.selectAllDailySales();
		model.addAttribute("dailySalesList", dailySalesList);
		System.out.println("dailySalesList size: " + dailySalesList.size());
		return "admin/dailySalesList";
	}// getAllDailySales() end
	*/
	
	
	// 지점 코드와 매출 날짜로 daily_sales 데이터를 삭제
	@PostMapping("/dailySalesDelete")
	public String deleteDailySales(@RequestParam("branch_code") String branch_code,
			@RequestParam("sales_date") @DateTimeFormat(pattern = "yyyy-MM-dd") Date sales_date) {
		adminDAO.deleteDailySales(branch_code, sales_date);
		return "redirect:/admin/dailySalesAll";
	}// deleteDailySales() end

	
	
	
	///////////////////////////////////////////////////////////////////////////////
	
	
	//0717 추가사항(애경)
	//비회원 목록
	@GetMapping("/admin/nonMemberList")
    public String nonMemberList(Model model) {
        List<NonMemberDTO> nonMembers = nonMemberDAO.selectAllNonMembers();
        model.addAttribute("nonMembers", nonMembers);
        return "admin/nonMemberList";
    }//nonMemberList() end
	
	
	//비회원 수정
	@PostMapping("/updateNonMember")
	public String updateNonMember(@RequestParam("nonmember_code") int nonmember_code, 
	                              @RequestParam("non_name") String non_name, 
	                              @RequestParam("non_phone") String non_phone) {
	    System.out.println("updateNonMember: nonmember_code = " + nonmember_code + 
	                       ", non_name = " + non_name + ", non_phone = " + non_phone);
	    
	    NonMemberDTO nonMember = new NonMemberDTO();
	    nonMember.setNonmember_code(nonmember_code);
	    nonMember.setNon_name(non_name);
	    nonMember.setNon_phone(non_phone);
	    
	    nonMemberDAO.updateNonMember(nonMember);
	    return "redirect:/admin/nonMemberList";
	}//updateNonMember() end

	
	
	//수정해 함 (0717) -> 결제안됨
	//비회원 삭제
	@PostMapping("/deleteNonMember")
	public String deleteNonMember(@RequestParam("nonmember_code") int nonmember_code) {
		nonMemberDAO.deleteNonMember(nonmember_code);
	    return "redirect:/admin/nonMemberList";
	}//deleteNonMember() end
	
	
	////////////////////////////////////////////////////////////////////////////////
	// 열람실 관리자 페이지'

	@GetMapping({"/admin", "/admin/reservation"})
    public String adminReservationList(Model model) {
        List<ReservationDTO> reservations = reservationDAO.getAllReservations();
        int totalSeats = seatDAO.getTotalSeatsCount();
        
        Map<String, String> seatStatuses = calculateSeatStatuses(reservations);

        model.addAttribute("reservations", reservations);
        model.addAttribute("totalSeats", totalSeats);
        model.addAttribute("seatStatuses", seatStatuses);

        addSeatLayoutToModel(model);

        return "admin/ad_main";
    }
	
	 private void addSeatLayoutToModel(Model model) {
	        String[] branchCodes = {"L01", "L02", "L03"};
	        Map<String, List<String>> seatLayouts = new HashMap<>();

	        for (String branchCode : branchCodes) {
	            List<String> layout = getSeatLayoutByBranch(branchCode);
	            seatLayouts.put(branchCode, layout);
	        }

	        model.addAttribute("seatLayouts", seatLayouts);
	    }
	
	
	
    private Map<String, String> calculateSeatStatuses(List<ReservationDTO> reservations) {
        Map<String, String> seatStatuses = new HashMap<>();
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        for (ReservationDTO reservation : reservations) {
            String seatCode = reservation.getSeat_code();
            LocalDateTime reservationDate = LocalDateTime.parse(reservation.getReservation_date(), formatter);
            LocalTime startTime = LocalTime.parse(getStartTimeByTimeCode(reservation.getTime_code()));
            LocalTime endTime = LocalTime.parse(reservation.getEnd_time());
            
            LocalDateTime reservationStart = reservationDate.with(startTime);
            LocalDateTime reservationEnd = reservationDate.with(endTime);

            if (now.isAfter(reservationStart) && now.isBefore(reservationEnd)) {
                seatStatuses.put(seatCode, "occupied");
            } else if (now.isBefore(reservationStart)) {
                seatStatuses.put(seatCode, "reserved");
            }
        }

        return seatStatuses;
    }
	
/*
    private int calculateOccupiedSeats(List<ReservationDTO> reservations) {
        LocalDateTime now = LocalDateTime.now();
        return (int) reservations.stream()
            .filter(r -> isCurrentlyOccupied(r, now))
            .count();
    }

    private boolean isCurrentlyOccupied(ReservationDTO reservation, LocalDateTime now) {
        LocalDateTime start = parseDateTime(reservation.getReservation_date(), getStartTimeByTimeCode(reservation.getTime_code()));
        LocalDateTime end = parseDateTime(reservation.getReservation_date(), reservation.getEnd_time());
        return now.isAfter(start) && now.isBefore(end);
    }
*/
    private int calculateOccupiedSeats(List<ReservationDTO> reservations) {
        LocalDateTime now = LocalDateTime.now();
        return (int) reservations.stream()
            .filter(r -> isCurrentlyOccupied(r, now))
            .count();
    }
    
    private boolean isCurrentlyOccupied(ReservationDTO reservation, LocalDateTime now) {
        LocalDateTime start = parseDateTime(reservation.getReservation_date(), getStartTimeByTimeCode(reservation.getTime_code()));
        LocalDateTime end = parseDateTime(reservation.getReservation_date(), reservation.getEnd_time());
        return now.isAfter(start) && now.isBefore(end);
    }
    
    /*
    private LocalDateTime parseDateTime(String date, String time) {
        String dateTimeString = date + " " + time;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        
        try {
            return LocalDateTime.parse(dateTimeString, formatter);
        } catch (DateTimeParseException e) {
            // HH:mm 형식의 시간을 처리
            formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
            try {
                return LocalDateTime.parse(dateTimeString, formatter);
            } catch (DateTimeParseException e2) {
                // 날짜와 시간을 개별적으로 파싱
                LocalDate datePart = LocalDate.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                LocalTime timePart = LocalTime.parse(time, DateTimeFormatter.ofPattern("HH:mm"));
                return LocalDateTime.of(datePart, timePart);
            }
        }
    }*/
    
    
    private LocalDateTime parseDateTime(String date, String time) {
        String dateTimeString = date + " " + time;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        
        try {
            return LocalDateTime.parse(dateTimeString, formatter);
        } catch (DateTimeParseException e) {
            // HH:mm 형식의 시간을 처리
            formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
            try {
                return LocalDateTime.parse(dateTimeString, formatter);
            } catch (DateTimeParseException e2) {
                // 날짜와 시간을 개별적으로 파싱
                LocalDate datePart = LocalDate.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                LocalTime timePart = LocalTime.parse(time, DateTimeFormatter.ofPattern("HH:mm"));
                return LocalDateTime.of(datePart, timePart);
            }
        }
    }



    private void addSeatStatusToModel(Model model) {
        String[] branchCodes = {"L01", "L02", "L03"};
        Map<String, Map<String, Map<String, String>>> seatStatuses = new HashMap<>();
        Map<String, List<String>> seatLayouts = new HashMap<>();

        for (String branchCode : branchCodes) {
            Map<String, Map<String, String>> branchSeats = new HashMap<>();
            List<String> layout = getSeatLayoutByBranch(branchCode);
            seatLayouts.put(branchCode, layout);
            
            for (String seat : layout) {
                if (!seat.equals("hidden")) {
                    Map<String, String> seatInfo = getIndividualSeatStatus(seat);
                    branchSeats.put(seat, seatInfo);
                }
            }
            seatStatuses.put(branchCode, branchSeats);
        }

        model.addAttribute("seatStatuses", seatStatuses);
        model.addAttribute("seatLayouts", seatLayouts);
    }

    private Map<String, String> getIndividualSeatStatus(String seatCode) {
        List<ReservationDTO> reservations = reservationDAO.getReservationsBySeatCode(seatCode);
        Map<String, String> seatInfo = new HashMap<>();
        LocalDateTime now = LocalDateTime.now();
        
        for (ReservationDTO reservation : reservations) {
            LocalDateTime start = parseDateTime(reservation.getReservation_date(), getStartTimeByTimeCode(reservation.getTime_code()));
            LocalDateTime end = parseDateTime(reservation.getReservation_date(), reservation.getEnd_time());
            
            if (now.isAfter(start) && now.isBefore(end)) {
                return createSeatInfo("occupied", start, end);
            } else if (now.isBefore(start)) {
                return createSeatInfo("reserved", start, end);
            }
        }
        
        seatInfo.put("status", "available");
        return seatInfo;
    }

    private Map<String, String> createSeatInfo(String status, LocalDateTime start, LocalDateTime end) {
        Map<String, String> seatInfo = new HashMap<>();
        seatInfo.put("status", status);
        seatInfo.put("reservationTime", start.toString());
        seatInfo.put("endTime", end.toString());
        return seatInfo;
    }

    @GetMapping("/admin/reservation/{id}")
    public String getReservation(@PathVariable String id, Model model) {
        ReservationDTO reservation = reservationDAO.getReservationById(id);
        String branchCode = reservation.getSeat_code().substring(0, 3);
        List<SeatDTO> availableSeats = seatDAO.getAvailableSeats(branchCode, reservation.getReservation_date(), reservation.getTime_code());
        List<UseTimeDTO> availableTimes = useTimeDAO.getAvailableTimes();
        
        model.addAttribute("reservation", reservation);
        model.addAttribute("availableSeats", availableSeats);
        model.addAttribute("availableTimes", availableTimes);
        
        return "admin/reservationDetail";
    }

    @PostMapping("/admin/reservation/update")
    public String updateReservation(@ModelAttribute ReservationDTO reservation, RedirectAttributes redirectAttributes) {
        try {
            if (reservation.getRoom_code() == null) {
                throw new IllegalArgumentException("room_code가 null입니다.");
            }
            
            String startTime = getStartTimeByTimeCode(reservation.getTime_code());
            String endTime = calculateEndTime(startTime, reservation.getRoom_code());
            reservation.setEnd_time(endTime);
            reservationDAO.updateReservation(reservation);
            
            redirectAttributes.addFlashAttribute("message", "예약이 성공적으로 수정되었습니다.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "예약 수정 중 오류가 발생했습니다: " + e.getMessage());
            e.printStackTrace();
        }
        return "redirect:/admin/reservation";
    }

    @PostMapping("/admin/reservation/delete")
    public String deleteReservation(@RequestParam("reservation_code") String reservationCode, RedirectAttributes redirectAttributes) {
        try {
            reservationDAO.deleteReservation(reservationCode);
            redirectAttributes.addFlashAttribute("message", "예약이 성공적으로 삭제되었습니다.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "예약 삭제 중 오류가 발생했습니다: " + e.getMessage());
            e.printStackTrace();
        }
        return "redirect:/admin/reservation";
    }
  
    @GetMapping("/api/serverTime")
    @ResponseBody
    public Map<String, String> getServerTime() {
        Map<String, String> response = new HashMap<>();
        response.put("serverTime", new Date().toString());
        return response;
    }


    @GetMapping("/api/seatStatus")
    @ResponseBody
    public ResponseEntity<?> getSeatStatusForApi() {
        try {
            Model model = new ExtendedModelMap();
            addSeatStatusToModel(model);
            Map<String, Map<String, Map<String, String>>> seatStatuses = 
                (Map<String, Map<String, Map<String, String>>>) model.getAttribute("seatStatuses");
            return ResponseEntity.ok(seatStatuses);
        } catch (Exception e) {
            e.printStackTrace();
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    private String calculateEndTime(String startTime, String roomCode) {
        int durationInHours = parseDuration(roomCode);
        LocalTime start = LocalTime.parse(startTime);
        LocalTime end = start.plusHours(durationInHours);
        return end.isAfter(LocalTime.of(19, 0)) ? "19:00" : end.toString();
    } 

    private int parseDuration(String roomCode) {
        switch (roomCode) {
            case "D1": return 2;
            case "D2": return 4;
            case "D3": return 6;
            case "D4": return 10;
            default: throw new IllegalArgumentException("Invalid room_code: " + roomCode);
        }
    }

    private String getStartTimeByTimeCode(String timeCode) {
        switch (timeCode) {
            case "T01": return "09:00";
            case "T02": return "10:00";
            case "T03": return "11:00";
            case "T04": return "12:00";
            case "T05": return "13:00";
            case "T06": return "14:00";
            case "T07": return "15:00";
            case "T08": return "16:00";
            case "T09": return "17:00";
            default: throw new IllegalArgumentException("Invalid time code: " + timeCode);
        }
    }

    private List<String> getSeatLayoutByBranch(String branchCode) {
        List<String> seatLayout = Arrays.asList(
            "1", "2", "3", "4", "5",
            "hidden", "hidden", "hidden", "hidden", "6",
            "hidden", "10", "11", "hidden", "7",
            "hidden", "12", "13", "hidden", "8",
            "hidden", "14", "15", "hidden", "9"
        );

        return seatLayout.stream()
            .map(seat -> seat.equals("hidden") ? seat : branchCode + "-" + String.format("%02d", Integer.parseInt(seat)))
            .collect(Collectors.toList());
    }

    
}// class end
