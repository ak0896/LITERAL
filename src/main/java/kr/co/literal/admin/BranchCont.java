package kr.co.literal.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import kr.co.literal.readingroom.dao.BranchDAO;
import kr.co.literal.readingroom.dto.BranchDTO;

@Controller
public class BranchCont {
 
	@Autowired
	private BranchDAO branchDAO;

	// 관리자페이지

	// 관리자 페이지 메인
	@GetMapping("/admin/branchRegister")
	public String branchDetailForm(Model model) {
		return "admin/branchRegister"; // JSP 파일의 경로를 반환
	}// branchDetailForm() end

	

	//지점 등록
	@PostMapping("/admin/saveBranch")
	public String saveBranch(@RequestParam("branch_name") String branch_name,
							 @RequestParam("branch_detail") String branch_detail, 
							 @RequestParam("branch_address") String branch_address,
							 @RequestParam("latitude") String latitude, 
							 @RequestParam("longitude") String longitude,
							 RedirectAttributes redirectAttributes,
							 Model model) {

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

		return "redirect:/admin/branchList"; // 데이터 저장 후 지점 목록 페이지로 리다이렉트
	}// saveBranch() end


	
	//지점 정보 수정 폼을 보여주는 메서드
	 @PostMapping("/admin/branchEdit")
	 public String getBranchForUpdate(@RequestParam("branch_code") String branch_code, Model model) {
	     System.out.println("branchEditForm: branch_code= " + branch_code);
		 BranchDTO branch = branchDAO.selectBranchByCode(branch_code);
	     model.addAttribute("branch", branch);
	     System.out.println(branch); 
	     return "admin/branchEdit";
	 }//getBranchForUpdate() end
	
	
	
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

	
	
	//지점 상세 보기
	@GetMapping("/admin/branchDetail")
	public String branchDetail(@RequestParam("branch_code") String branch_code, Model model) {
		BranchDTO branch = branchDAO.selectBranchByCode(branch_code);
		System.out.println("선택된 branch: " + branch);
	    model.addAttribute("branch", branch);
	    return "admin/branchDetail_admin";
	}//branchDetail() end
	
	
///////////////////////////////////////////////////////////////	

	
	
	//일반 사용자 페이지
	

	
	// 지점 목록을 동적으로 JSP에 전달
    @GetMapping("/branch/branchDetail")
    public String dynamicTabs(Model model) {
        List<BranchDTO> branch = branchDAO.selectAllBranches();
        System.out.println("선택된 branchDTO: "+ branch);
        model.addAttribute("branchList", branch);
        return "branch/branchDetail";
    }//dynamicTabs() end
	

}// class end
