package kr.co.literal.order;

public class OrderDTO {
	
	private String payment_code;   
	private String email;
	private String payment_method;
	private int cart_code;
	private int used_points;
	private int total_amount;
	private String recipient_phone;
	private String shipping_address;
	private String recipient_name;
	private String shipping_message;
	private int save_points;
	private String payment_date;
	private String delivery_status;
	private String tracking_number;
	
	
	public OrderDTO() {}


	public String getPayment_code() {
		return payment_code;
	}


	public void setPayment_code(String payment_code) {
		this.payment_code = payment_code;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getPayment_method() {
		return payment_method;
	}


	public void setPayment_method(String payment_method) {
		this.payment_method = payment_method;
	}


	public int getCart_code() {
		return cart_code;
	}


	public void setCart_code(int cart_code) {
		this.cart_code = cart_code;
	}


	public int getUsed_points() {
		return used_points;
	}


	public void setUsed_points(int used_points) {
		this.used_points = used_points;
	}


	public int getTotal_amount() {
		return total_amount;
	}


	public void setTotal_amount(int total_amount) {
		this.total_amount = total_amount;
	}


	public String getRecipient_phone() {
		return recipient_phone;
	}


	public void setRecipient_phone(String recipient_phone) {
		this.recipient_phone = recipient_phone;
	}


	public String getShipping_address() {
		return shipping_address;
	}


	public void setShipping_address(String shipping_address) {
		this.shipping_address = shipping_address;
	}


	public String getRecipient_name() {
		return recipient_name;
	}


	public void setRecipient_name(String recipient_name) {
		this.recipient_name = recipient_name;
	}


	public String getShipping_message() {
		return shipping_message;
	}


	public void setShipping_message(String shipping_message) {
		this.shipping_message = shipping_message;
	}


	public int getSave_points() {
		return save_points;
	}


	public void setSave_points(int save_points) {
		this.save_points = save_points;
	}


	public String getPayment_date() {
		return payment_date;
	}


	public void setPayment_date(String payment_date) {
		this.payment_date = payment_date;
	}


	public String getDelivery_status() {
		return delivery_status;
	}


	public void setDelivery_status(String delivery_status) {
		this.delivery_status = delivery_status;
	}


	public String getTracking_number() {
		return tracking_number;
	}


	public void setTracking_number(String tracking_number) {
		this.tracking_number = tracking_number;
	}


	@Override
	public String toString() {
		return "OrderDTO [payment_code=" + payment_code + ", email=" + email + ", payment_method=" + payment_method
				+ ", cart_code=" + cart_code + ", used_points=" + used_points + ", total_amount=" + total_amount
				+ ", recipient_phone=" + recipient_phone + ", shipping_address=" + shipping_address
				+ ", recipient_name=" + recipient_name + ", shipping_message=" + shipping_message + ", save_points="
				+ save_points + ", payment_date=" + payment_date + ", delivery_status=" + delivery_status
				+ ", tracking_number=" + tracking_number + "]";
	}
	
	
	
}
