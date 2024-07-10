package kr.co.literal.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.literal.member.MemberDAO;
import kr.co.literal.member.MemberDTO;

@Service
public class AdminService {

	// @Autowired
	// private AdminDAO adminDAO;

	@Autowired
	private MemberDAO memberDAO;

	//회원 목록
	public List<MemberDTO> getAllMembers() {
		return memberDAO.getAllMembers();
	}

	//회원 삭제
	public void deleteMember(String email) {
		memberDAO.deleteMember(email);
	}

	//회원타입수정
	public void updateMemberType(String email, int type_code) {
		memberDAO.updateMemberType(email, type_code);
	}

}// class end
