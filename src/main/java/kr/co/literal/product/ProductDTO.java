package kr.co.literal.product;

import java.sql.Timestamp;

public class ProductDTO {
	
    private String genre_code;         // 장르 코드
    private String book_code;          // 책 코드
    private String book_number;        // 책 번호
    private String book_title;         // 책 제목
    private String author;             // 작가
    private String press;              // 출판사
    private String publishing_date;    // 출판일
    private String intro_book;         // 판매자 책 소개
    private String img;                // 이미지 이름
    private int img_size;              // 이미지 사이즈
    private int grade_code;            // 상품 등급 코드
    private int original_price;        // 정가
    private int sale_price;            // 판매가
    private String email;              // 이메일
    private int availability;          // 판매 여부
    private Timestamp registration_date; // 등록날짜
    private String branch_code;         // 지점코드
    private boolean wish;        		// 찜
    private int book_view;
    
    public ProductDTO() {}

	public String getGenre_code() {
		return genre_code;
	}

	public void setGenre_code(String genre_code) {
		this.genre_code = genre_code;
	}

	public String getBook_code() {
		return book_code;
	}

	public void setBook_code(String book_code) {
		this.book_code = book_code;
	}

	public String getBook_number() {
		return book_number;
	}

	public void setBook_number(String book_number) {
		this.book_number = book_number;
	}

	public String getBook_title() {
		return book_title;
	}

	public void setBook_title(String book_title) {
		this.book_title = book_title;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPress() {
		return press;
	}

	public void setPress(String press) {
		this.press = press;
	}

	public String getPublishing_date() {
		return publishing_date;
	}

	public void setPublishing_date(String publishing_date) {
		this.publishing_date = publishing_date;
	}

	public String getIntro_book() {
		return intro_book;
	}

	public void setIntro_book(String intro_book) {
		this.intro_book = intro_book;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public int getImg_size() {
		return img_size;
	}

	public void setImg_size(int img_size) {
		this.img_size = img_size;
	}

	public int getGrade_code() {
		return grade_code;
	}

	public void setGrade_code(int grade_code) {
		this.grade_code = grade_code;
	}

	public int getOriginal_price() {
		return original_price;
	}

	public void setOriginal_price(int original_price) {
		this.original_price = original_price;
	}

	public int getSale_price() {
		return sale_price;
	}

	public void setSale_price(int sale_price) {
		this.sale_price = sale_price;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getAvailability() {
		return availability;
	}

	public void setAvailability(int availability) {
		this.availability = availability;
	}

	public Timestamp getRegistration_date() {
		return registration_date;
	}

	public void setRegistration_date(Timestamp registration_date) {
		this.registration_date = registration_date;
	}

	public String getBranch_code() {
		return branch_code;
	}

	public void setBranch_code(String branch_code) {
		this.branch_code = branch_code;
	}

	public boolean isWish() {
		return wish;
	}

	public void setWish(boolean wish) {
		this.wish = wish;
	}

	
	@Override
	public String toString() {
		return "ProductDTO [genre_code=" + genre_code + ", book_code=" + book_code + ", book_number=" + book_number
				+ ", book_title=" + book_title + ", author=" + author + ", press=" + press + ", publishing_date="
				+ publishing_date + ", intro_book=" + intro_book + ", img=" + img + ", img_size=" + img_size
				+ ", grade_code=" + grade_code + ", original_price=" + original_price + ", sale_price=" + sale_price
				+ ", email=" + email + ", availability=" + availability + ", registration_date=" + registration_date
				+ ", branch_code=" + branch_code + ", wish=" + wish + "]";
	}

    
} // public class ProductDTO end
