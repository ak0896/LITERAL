package kr.co.literal.mypage;

public class ReviewDTO {
	
	private int review_id;
	private String email;
	private String book_number;
	private int rating;
	private String delivery_condition;
	private String book_condition;
	private String price_appropriateness;
	private String seller_question;
	private String treview;
	private String review_date;
	public int getReview_id() {
		return review_id;
	}
	public void setReview_id(int review_id) {
		this.review_id = review_id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getBook_number() {
		return book_number;
	}
	public void setBook_number(String book_number) {
		this.book_number = book_number;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getDelivery_condition() {
		return delivery_condition;
	}
	public void setDelivery_condition(String delivery_condition) {
		this.delivery_condition = delivery_condition;
	}
	public String getBook_condition() {
		return book_condition;
	}
	public void setBook_condition(String book_condition) {
		this.book_condition = book_condition;
	}
	public String getPrice_appropriateness() {
		return price_appropriateness;
	}
	public void setPrice_appropriateness(String price_appropriateness) {
		this.price_appropriateness = price_appropriateness;
	}
	public String getSeller_question() {
		return seller_question;
	}
	public void setSeller_question(String seller_question) {
		this.seller_question = seller_question;
	}
	public String getTreview() {
		return treview;
	}
	public void setTreview(String treview) {
		this.treview = treview;
	}
	public String getReview_date() {
		return review_date;
	}
	public void setReview_date(String review_date) {
		this.review_date = review_date;
	}
	
	
	@Override
	public String toString() {
		return "ReviewDTO [review_id=" + review_id + ", email=" + email + ", book_number=" + book_number + ", rating="
				+ rating + ", delivery_condition=" + delivery_condition + ", book_condition=" + book_condition
				+ ", price_appropriateness=" + price_appropriateness + ", seller_question=" + seller_question
				+ ", treview=" + treview + ", review_date=" + review_date + "]";
	}

} // public class ReviewDTO end
