package kr.co.literal.admin;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
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
import kr.co.literal.readingroom.dto.BranchDTO;
import kr.co.literal.readingroom.dto.NonMemberDTO;
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

		return "admin/branchEdit"; // 수정 후 수정된 정보를 다시 보여줌
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
	
	
}// class end
