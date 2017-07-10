package com.s2jo.khx.model.psc;

public class khxpscNonMemberVO {

	private String nonno;   /* 비회원번호, seq */
	private String nhp;		/* 핸드폰번호 */
	private String npwd; 	/* 임의비밀번호 */
	private String status;	/* 가입상태 */
	
	public khxpscNonMemberVO() { }

	public khxpscNonMemberVO(String nonno, String nhp, String npwd, String status) {
		this.nonno = nonno;
		this.nhp = nhp;
		this.npwd = npwd;
		this.status = status;
	}

	public String getNonno() {
		return nonno;
	}

	public void setNonno(String nonno) {
		this.nonno = nonno;
	}

	public String getNhp() {
		return nhp;
	}

	public void setNhp(String nhp) {
		this.nhp = nhp;
	}

	public String getNpwd() {
		return npwd;
	}

	public void setNpwd(String npwd) {
		this.npwd = npwd;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
	
	
}//end of public class khxpscNonMemberVO {
