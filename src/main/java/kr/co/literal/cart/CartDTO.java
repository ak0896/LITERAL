package kr.co.literal.cart;

public class CartDTO {
   
   private int cart_code;
   private String email;   
   private String book_number; 
   private String book_title; 
   private int sale_price;
   private boolean event_yn;
   private int cart_amount;
   private boolean select_yn;
   private String img;
   private int original_price;   

   
   public CartDTO() {}


	public int getCart_code() {
		return cart_code;
	}
	
	
	public void setCart_code(int cart_code) {
		this.cart_code = cart_code;
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
	
	
	public String getBook_title() {
		return book_title;
	}
	
	
	public void setBook_title(String book_title) {
		this.book_title = book_title;
	}
	
	
	public int getSale_price() {
		return sale_price;
	}
	
	
	public void setSale_price(int sale_price) {
		this.sale_price = sale_price;
	}
	
	
	public boolean isEvent_yn() {
		return event_yn;
	}
	
	
	public void setEvent_yn(boolean event_yn) {
		this.event_yn = event_yn;
	}
	
	
	public int getCart_amount() {
		return cart_amount;
	}
	
	
	public void setCart_amount(int cart_amount) {
		this.cart_amount = cart_amount;
	}
	
	
	public boolean isSelect_yn() {
		return select_yn;
	}
	
	
	public void setSelect_yn(boolean select_yn) {
		this.select_yn = select_yn;
	}
	
	
	public String getImg() {
		return img;
	}


	public void setImg(String img) {
		this.img = img;
	}


	public int getOriginal_price() {
		return original_price;
	}
	
	
	public void setOriginal_price(int original_price) {
		this.original_price = original_price;
	}

	
	@Override
	public String toString() {
		return "CartDTO [cart_code=" + cart_code + ", email=" + email + ", book_number=" + book_number + ", book_title="
				+ book_title + ", sale_price=" + sale_price + ", event_yn=" + event_yn + ", cart_amount=" + cart_amount
				+ ", select_yn=" + select_yn + ", img=" + img + ", original_price=" + original_price + "]";
	}
	
	
	
	
	   
	
   
}
