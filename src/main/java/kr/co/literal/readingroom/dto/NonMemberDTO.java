package kr.co.literal.readingroom.dto;

public class NonMemberDTO {
	
	private int nonmember_code;
	private String reservation_code;
	private String non_name;
	private String non_phone;
	
	public NonMemberDTO() {}

	public int getNonmember_code() {
		return nonmember_code;
	}

	public void setNonmember_code(int nonmember_code) {
		this.nonmember_code = nonmember_code;
	}

	public String getReservation_code() {
		return reservation_code;
	}

	public void setReservation_code(String reservation_code) {
		this.reservation_code = reservation_code;
	}

	public String getNon_name() {
		return non_name;
	}

	public void setNon_name(String non_name) {
		this.non_name = non_name;
	}

	public String getNon_phone() {
		return non_phone;
	}

	public void setNon_phone(String non_phone) {
		this.non_phone = non_phone;
	}

	@Override
	public String toString() {
		return "NonMemberDTO [nonmember_code=" + nonmember_code + ", reservation_code=" + reservation_code
				+ ", non_name=" + non_name + ", non_phone=" + non_phone + "]";
	}
	
	

}//class end
