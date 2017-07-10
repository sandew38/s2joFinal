package com.s2jo.khx.model.yyj;

public class PaysummaryVO {

	
	private String paymentcode;
	private int paydate;
	private String totalprice;
	private String userid;
	private String nonno;
	private int paystatus;
	
	 public PaysummaryVO (){};
	 
	 
	public PaysummaryVO(String paymentcode, int paydate, String totalprice, String userid, String nonno,
			int paystatus) {
		
		this.paymentcode = paymentcode;
		this.paydate = paydate;
		this.totalprice = totalprice;
		this.userid = userid;
		this.nonno = nonno;
		this.paystatus = paystatus;
	}


	public String getPaymentcode() {
		return paymentcode;
	}


	public void setPaymentcode(String paymentcode) {
		this.paymentcode = paymentcode;
	}


	public int getPaydate() {
		return paydate;
	}


	public void setPaydate(int paydate) {
		this.paydate = paydate;
	}


	public String getTotalprice() {
		return totalprice;
	}


	public void setTotalprice(String totalprice) {
		this.totalprice = totalprice;
	}


	public String getUserid() {
		return userid;
	}


	public void setUserid(String userid) {
		this.userid = userid;
	}


	public String getNonno() {
		return nonno;
	}


	public void setNonno(String nonno) {
		this.nonno = nonno;
	}


	public int getPaystatus() {
		return paystatus;
	}


	public void setPaystatus(int paystatus) {
		this.paystatus = paystatus;
	}
	
	
	
	
	
	
	
	
	
	
}
