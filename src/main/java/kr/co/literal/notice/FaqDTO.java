package kr.co.literal.notice;

public class FaqDTO {
	private int faq_code;
 	private String faq_title;
 	private String faq_answer;
 	
 	
 	public FaqDTO() {}


	public int getFaq_code() {
		return faq_code;
	}


	public void setFaq_code(int faq_code) {
		this.faq_code = faq_code;
	}


	public String getFaq_title() {
		return faq_title;
	}


	public void setFaq_title(String faq_title) {
		this.faq_title = faq_title;
	}


	public String getFaq_answer() {
		return faq_answer;
	}


	public void setFaq_answer(String faq_answer) {
		this.faq_answer = faq_answer;
	}


	@Override
	public String toString() {
		return "FaqDTO [faq_code=" + faq_code + ", faq_title=" + faq_title + ", faq_answer=" + faq_answer + "]";
	}


	
	
}
