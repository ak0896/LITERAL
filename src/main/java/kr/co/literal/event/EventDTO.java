package kr.co.literal.event;

public class EventDTO {
	
	private String event_code;
	private String event_title;
	private String event_content;
	private String start_date;
	private String end_date;
	private float event_discount;
	private String book_number;
	private String book_code;
	private String event_date;
	
	public EventDTO() {}

	public String getEvent_code() {
		return event_code;
	}

	public void setEvent_code(String event_code) {
		this.event_code = event_code;
	}

	public String getEvent_title() {
		return event_title;
	}

	public void setEvent_title(String event_title) {
		this.event_title = event_title;
	}

	public String getEvent_content() {
		return event_content;
	}

	public void setEvent_content(String event_content) {
		this.event_content = event_content;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public float getEvent_discount() {
		return event_discount;
	}

	public void setEvent_discount(float event_discount) {
		this.event_discount = event_discount;
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

	public String getEvent_date() {
		return event_date;
	}

	public void setEvent_date(String event_date) {
		this.event_date = event_date;
	}

	@Override
	public String toString() {
		return "EventDTO [event_code=" + event_code + ", event_title=" + event_title + ", event_content="
				+ event_content + ", start_date=" + start_date + ", end_date=" + end_date + ", event_discount="
				+ event_discount + ", book_number=" + book_number + ", book_code=" + book_code + ", event_date="
				+ event_date + "]";
	}

} // class EventDTO end
