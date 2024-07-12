package kr.co.literal.mypage;

public class InquiryDTO {
	
	private int inquiry_code;
	private String inquiry_answer;
    private String inquiry_content;
    private String email;
    private String inquiry_date;

    public InquiryDTO() {}

	public int getInquiry_code() {
		return inquiry_code;
	}

	public void setInquiry_code(int inquiry_code) {
		this.inquiry_code = inquiry_code;
	}

	public String getInquiry_answer() {
		return inquiry_answer;
	}

	public void setInquiry_answer(String inquiry_answer) {
		this.inquiry_answer = inquiry_answer;
	}

	public String getInquiry_content() {
		return inquiry_content;
	}

	public void setInquiry_content(String inquiry_content) {
		this.inquiry_content = inquiry_content;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getInquiry_date() {
		return inquiry_date;
	}

	public void setInquiry_date(String inquiry_date) {
		this.inquiry_date = inquiry_date;
	}

	@Override
	public String toString() {
		return "InquiryDTO [inquiry_code=" + inquiry_code + ", inquiry_answer=" + inquiry_answer + ", inquiry_content="
				+ inquiry_content + ", email=" + email + ", inquiry_date=" + inquiry_date + "]";
	}

}//class end
