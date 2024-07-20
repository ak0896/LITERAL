package kr.co.literal.admin;

import java.util.Date;

public class DailySalesDTO {

	 	private String branch_code; // 지점 코드
	    private int dtotal_product; // 당일 상품판매 수입액
	    private int dtotal_room; // 당일 열람실 수입액
	    private Date sales_date; // 매출 날짜
	    
	    public DailySalesDTO() {
			// TODO Auto-generated constructor stub
		}

		

		@Override
		public String toString() {
			return "DailySalesDTO [branch_code=" + branch_code + ", dtotal_product=" + dtotal_product + ", dtotal_room="
					+ dtotal_room + ", sales_date=" + sales_date + "]";
		}


		public String getBranch_code() {
			return branch_code;
		}

		public void setBranch_code(String branch_code) {
			this.branch_code = branch_code;
		}

		public int getDtotal_product() {
			return dtotal_product;
		}

		public void setDtotal_product(int dtotal_product) {
			this.dtotal_product = dtotal_product;
		}

		public int getDtotal_room() {
			return dtotal_room;
		}

		public void setDtotal_room(int dtotal_room) {
			this.dtotal_room = dtotal_room;
		}

		public Date getSales_date() {
			return sales_date;
		}

		public void setSales_date(Date sales_date) {
			this.sales_date = sales_date;
		}

		



		
		
	    
	
	
}//class end
