package kr.co.literal.product;


public class WishlistDTO {
	
	private int wishlist_code;
	private String email;
	private String book_number;
	private String wishlist_date;

	public WishlistDTO() {}

	public int getWishlist_code() {
		return wishlist_code;
	}

	public void setWishlist_code(int wishlist_code) {
		this.wishlist_code = wishlist_code;
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

	public String getWishlist_date() {
		return wishlist_date;
	}

	public void setWishlist_date(String wishlist_date) {
		this.wishlist_date = wishlist_date;
	}

	@Override
	public String toString() {
		return "WishlistDTO [wishlist_code=" + wishlist_code + ", email=" + email + ", book_number=" + book_number
				+ ", wishlist_date=" + wishlist_date + "]";
	}

	

    
} // public class ProductDTO end
