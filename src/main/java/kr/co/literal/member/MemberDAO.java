package kr.co.literal.member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class MemberDAO {
	
	
		public MemberDAO() {
		    System.out.println("----- MemberDAO() 객체 생성");
		} 
	
		@Autowired
		private SqlSession sqlSession;
	
		private static final String NAMESPACE = "kr.co.literal.member.MemberMapper";
		    
	
	    //member 등록
	    public void insertMember(MemberDTO member) {
	        sqlSession.insert(NAMESPACE + ".insertMember", member);
	    }
	    
	    //이메일 중복확인
        public int duplicateEmail(String email) {
            return sqlSession.selectOne(NAMESPACE + ".duplicateEmail", email); // 이메일 중복 확인 메서드 추가
        }
	
        
	    //DB에서 이메일을 기준으로 회원정보 조회
	    public MemberDTO getMemberByEmail(String email) {
	        return sqlSession.selectOne(NAMESPACE + ".getMemberByEmail", email);
	    }


	    //전체 회원 목록
	    public List<MemberDTO> getAllMembers() {
	        return sqlSession.selectList(NAMESPACE + ".getAllMembers");
	    }
	    
	    
	    //회원삭제
	    public void deleteMember(String email) {
	        sqlSession.delete(NAMESPACE + ".deleteMember", email);
	    }

	    
	    //회원정보수정
	    public void updateMember(MemberDTO memberDTO) {
	        sqlSession.update(NAMESPACE + ".updateMember", memberDTO);
	    }

	    
	    //회원 타입수정
	    public void updateMemberType(String email, int type_code) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("email", email);
	        params.put("type_code", type_code);
	        sqlSession.update(NAMESPACE + ".updateMemberType", params);
	    }//updateMemberType() end
	    
   
	    //이메일찾기
	    public MemberDTO findByNameAndPhone(String name, String phone_number) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("name", name);
	        params.put("phone_number", phone_number);
	        return sqlSession.selectOne(NAMESPACE + ".findByNameAndPhone", params);
	    }//findByNameAndPhone() end
	    

	    // 기존 findByNameAndEmail 메서드
	    public MemberDTO findByNameAndEmail(String name, String email) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("name", name);
	        params.put("email", email);
	        return sqlSession.selectOne(NAMESPACE + ".findByNameAndEmail", params);
	    }//findByNameAndEmail() end
	    
	    
	    // 비밀번호 업데이트
	    public void updatePassword(MemberDTO member) {
	        sqlSession.update(NAMESPACE + ".updatePassword", member);
	    }//updatePassword() end

	    
	    //카카오 로그인
		public void kakaoJoin(MemberDTO member) {
			sqlSession.insert(NAMESPACE + ".insertMember", member);
		}//kakaoJoin() end
		
	   
		// 포인트
	    public MemberDTO getPoints(String email) {
	        return sqlSession.selectOne(NAMESPACE + ".getPoints", email);
	    }

	    public void updatePoints(String email, int points) {
	        MemberDTO member = new MemberDTO();
	        member.setEmail(email);
	        member.setPoints(points);
	        sqlSession.update(NAMESPACE + ".updatePoints", member);
	    }
}//class end
