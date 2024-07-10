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
   public int getSale_price() {
      return sale_price;
   }
   public void setSale_price(int sale_price) {
      this.sale_price = sale_price;
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
   public String getBook_title() {
      return book_title;
   }
   public void setBook_title(String book_title) {
      this.book_title = book_title;
   }

   @Override
   public String toString() {
      return "CartDTO [cart_code=" + cart_code + ", email=" + email + ", book_number=" + book_number + ", book_title="
            + book_title + ", sale_price=" + sale_price
            + ", cart_amount=" + cart_amount + ", select_yn=" + select_yn + "]";
   }
   
   
   
}
