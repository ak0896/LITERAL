package kr.co.literal.readingroom.dto;

import java.sql.Date;
import java.sql.Timestamp;

import javax.xml.crypto.Data;

public class MyCouponDTO {
	
	public MyCouponDTO() {}
	
    private String email;
    private String mycoupon_number;
    private String room_code;
    private Date issue_date;
    private Date expiry_date;
    private Timestamp usage_date;
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMycoupon_number() {
		return mycoupon_number;
	}
	public void setMycoupon_number(String mycoupon_number) {
		this.mycoupon_number = mycoupon_number;
	}
	public String getRoom_code() {
		return room_code;
	}
	public void setRoom_code(String room_code) {
		this.room_code = room_code;
	}
	public Date getIssue_date() {
		return issue_date;
	}
	public void setIssue_date(Date issue_date) {
		this.issue_date = issue_date;
	}
	public Date getExpiry_date() {
		return expiry_date;
	}
	public void setExpiry_date(Date expiry_date) {
		this.expiry_date = expiry_date;
	}
	public Timestamp getUsage_date() {
		return usage_date;
	}
	public void setUsage_date(Timestamp usage_date) {
		this.usage_date = usage_date;
	}
	@Override
	public String toString() {
		return "MyCouponDTO [email=" + email + ", mycoupon_number=" + mycoupon_number + ", room_code=" + room_code
				+ ", issue_date=" + issue_date + ", expiry_date=" + expiry_date + ", usage_date=" + usage_date + "]";
	}


    
    
    
}