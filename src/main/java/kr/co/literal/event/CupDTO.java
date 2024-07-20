package kr.co.literal.event;

import java.util.Date;

public class CupDTO {
	private String worldcup_code;
    private int round;
    private String wc_title;
    private String genre_code;
    private String book_number;
    private String book_code;
    private String book_title;
    private Date cupstart_date;
    private Date cupend_date;
    private String wc_discount;
    private String wc_content;
    private String wcevent_date;
    private String wc_banner;
    
	public String getWorldcup_code() {
		return worldcup_code;
	}
	public void setWorldcup_code(String worldcup_code) {
		this.worldcup_code = worldcup_code;
	}
	public int getRound() {
		return round;
	}
	public void setRound(int round) {
		this.round = round;
	}
	public String getWc_title() {
		return wc_title;
	}
	public void setWc_title(String wc_title) {
		this.wc_title = wc_title;
	}
	public String getGenre_code() {
		return genre_code;
	}
	public void setGenre_code(String genre_code) {
		this.genre_code = genre_code;
	}
	public String getBook_number() {
		return book_number;
	}
	public void setBook_number(String book_number) {
		this.book_number = book_number;
	}
	public String getBook_code() {
		return book_code;
	}
	public void setBook_code(String book_code) {
		this.book_code = book_code;
	}
	public String getBook_title() {
		return book_title;
	}
	public void setBook_title(String book_title) {
		this.book_title = book_title;
	}
	public Date getCupstart_date() {
		return cupstart_date;
	}
	public void setCupstart_date(Date cupstart_date) {
		this.cupstart_date = cupstart_date;
	}
	public Date getCupend_date() {
		return cupend_date;
	}
	public void setCupend_date(Date cupend_date) {
		this.cupend_date = cupend_date;
	}
	public String getWc_discount() {
		return wc_discount;
	}
	public void setWc_discount(String wc_discount) {
		this.wc_discount = wc_discount;
	}
	public String getWc_content() {
		return wc_content;
	}
	public void setWc_content(String wc_content) {
		this.wc_content = wc_content;
	}
	public String getWcevent_date() {
		return wcevent_date;
	}
	public void setWcevent_date(String wcevent_date) {
		this.wcevent_date = wcevent_date;
	}
	public String getWc_banner() {
		return wc_banner;
	}
	public void setWc_banner(String wc_banner) {
		this.wc_banner = wc_banner;
	}
	
	@Override
	public String toString() {
		return "CupDTO [worldcup_code=" + worldcup_code + ", round=" + round + ", wc_title=" + wc_title
				+ ", genre_code=" + genre_code + ", book_number=" + book_number + ", book_code=" + book_code
				+ ", book_title=" + book_title + ", cupstart_date=" + cupstart_date + ", cupend_date=" + cupend_date
				+ ", wc_discount=" + wc_discount + ", wc_content=" + wc_content + ", wcevent_date=" + wcevent_date
				+ ", wc_banner=" + wc_banner + "]";
	}

    
} // public class CupDTO end
