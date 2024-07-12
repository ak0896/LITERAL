package kr.co.literal.pcomment;

public class PcommentDTO {
	
    private int pno;
    private String book_number;
    private String pcontent;
    private String email;
    private String pdate;
    
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
	}
	public String getBook_number() {
		return book_number;
	}
	public void setBook_number(String book_number) {
		this.book_number = book_number;
	}
	public String getPcontent() {
		return pcontent;
	}
	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPdate() {
		return pdate;
	}
	public void setPdate(String pdate) {
		this.pdate = pdate;
	}
	
	@Override
	public String toString() {
		return "PcommentDTO [pno=" + pno + ", book_number=" + book_number + ", pcontent=" + pcontent + ", email="
				+ email + ", pdate=" + pdate + "]";
	}

    
    
} // PcommentDTO end
