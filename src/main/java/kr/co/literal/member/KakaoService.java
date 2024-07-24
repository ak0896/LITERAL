package kr.co.literal.member;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import jakarta.servlet.http.HttpSession;

@Service
public class KakaoService {

	
	@Autowired
    private MemberDAO memberDAO;
	
	

    private final String CLIENT_ID = "8f9dec329968d9694db0f7ef13e6d56b"; //JavaScript 키
    private final String CLIENT_SECRET = "cQYd9ukN5k6WD0UfohrurdOMPlNbM6r5"; //토큰발급시 받는 키
    private final String REDIRECT_URI = "http://localhost:8080/member/kakaoCallback";

    
    public String getClientId() {
        return CLIENT_ID;
    }

    public String getRedirectUri() {
        return REDIRECT_URI;
    }
    
    public String getKakaoAccessToken(String code) {
        String accessToken = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=" + CLIENT_ID);
            sb.append("&client_secret=" + CLIENT_SECRET);
            sb.append("&redirect_uri=" + REDIRECT_URI);
            sb.append("&code=" + code);
            bw.write(sb.toString());
            bw.flush();

            int responseCode = conn.getResponseCode();
            if (responseCode == 200) {
                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                String line = "";
                String result = "";

                while ((line = br.readLine()) != null) {
                    result += line;
                }

                System.out.println("카카오 API 응답: " + result);  // 전체 응답 출력
                
                JsonParser parser = new JsonParser();
                JsonElement element = parser.parse(result);

                accessToken = element.getAsJsonObject().get("access_token").getAsString();

                br.close();
            }
            bw.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return accessToken;
    }

    public MemberDTO getKakaoUserInfo(String accessToken) {
        MemberDTO memberDTO = new MemberDTO();
        String reqURL = "https://kapi.kakao.com/v2/user/me";

        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);

            int responseCode = conn.getResponseCode();
            if (responseCode == 200) {
                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                String line = "";
                String result = "";

                while ((line = br.readLine()) != null) {
                    result += line;
                }

                System.out.println("카카오 API 응답: " + result);
                
                JsonParser parser = new JsonParser();
                JsonElement element = parser.parse(result);
                JsonObject kakaoAccount = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

                String name = kakaoAccount.has("name") ? kakaoAccount.get("name").getAsString() : "카카오사용자";
                String email = kakaoAccount.has("email") ? kakaoAccount.get("email").getAsString() : "";
                String phone_number = kakaoAccount.has("phone_number") ? kakaoAccount.get("phone_number").getAsString().replace("+82 ", "0") : "";

                memberDTO.setName(name);
                memberDTO.setEmail(email);
                memberDTO.setPassword("KAKAO_" + element.getAsJsonObject().get("id").getAsString());
                memberDTO.setPhone_number(phone_number);
                memberDTO.setType_code(1);
                
                
                
                System.out.println("name: " + name);  // nickname 출력
                System.out.println("Email: " + email);  // email 출력
                System.out.println("Phone Number: " + phone_number);  // phone_number 출력
                
                
                
                memberDTO.setName(name);
                memberDTO.setEmail(email);
                memberDTO.setPassword("KAKAO_" + element.getAsJsonObject().get("id").getAsString());
                memberDTO.setPhone_number(phone_number != null ? phone_number : "");  // 전화번호 설정
                memberDTO.setType_code(1); //일반 회원으로 설정

                // 다른 필드들은 기본값 또는 null로 설정
                memberDTO.setZipcode("");
                memberDTO.setAddress1("");
                memberDTO.setAddress2("");
                memberDTO.setBirth_date("");
                memberDTO.setBank("");
                memberDTO.setAccount_number("");
                memberDTO.setPoints(1000);	
                
                System.out.println("Kakao 사용자정보 = " + memberDTO);
                
                br.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return memberDTO;
    }

    public void processKakaoLogin(MemberDTO kakaoUser, HttpSession session) {
        MemberDTO existingMember = memberDAO.getMemberByEmail(kakaoUser.getEmail());
        if (existingMember == null) {
            // 새로운 회원이면 member 테이블에 insert
            memberDAO.insertMember(kakaoUser);
            existingMember = kakaoUser;
        }

        // 세션에 사용자 정보 저장
        session.setAttribute("member", existingMember);
        session.setAttribute("email", existingMember.getEmail());
        session.setAttribute("isMember", true);
        session.setAttribute("name", existingMember.getName());
        session.setAttribute("phone_number", existingMember.getPhone_number());
    }
	
	
}// class end
