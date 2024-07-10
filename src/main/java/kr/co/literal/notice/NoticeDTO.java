package kr.co.literal.notice;

public class NoticeDTO {
	private int notice_code;
	private String notice_title;
	private String notice_content;
	private String board_writer;
	private String notice_date;
	private int view_count;
	
	public NoticeDTO() {}

	public int getNotice_code() {
		return notice_code;
	}

	public void setNotice_code(int notice_code) {
		this.notice_code = notice_code;
	}

	public String getNotice_title() {
		return notice_title;
	}

	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}

	public String getNotice_content() {
		return notice_content;
	}

	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}

	public String getBoard_writer() {
		return board_writer;
	}

	public void setBoard_writer(String board_writer) {
		this.board_writer = board_writer;
	}

	public String getNotice_date() {
		return notice_date;
	}

	public void setNotice_date(String notice_date) {
		this.notice_date = notice_date;
	}

	public int getView_count() {
		return view_count;
	}

	public void setView_count(int view_count) {
		this.view_count = view_count;
	}

	@Override
	public String toString() {
		return "NoticeDTO [notice_code=" + notice_code + ", notice_title=" + notice_title + ", notice_content="
				+ notice_content + ", board_writer=" + board_writer + ", notice_date=" + notice_date + ", view_count="
				+ view_count + "]";
	}

	
	
	
}
