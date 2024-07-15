package kr.co.literal.worldcup;

public class CupDTO {
	
	private String worldcup_code;
	private int  round;
	private String  wc_title;	
	private String  genre_code;
	
	
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
	
	
	@Override
	public String toString() {
		return "CupDTO [worldcup_code=" + worldcup_code + ", round=" + round + ", wc_title=" + wc_title
				+ ", genre_code=" + genre_code + "]";
	}

} // public class CupDTO end
