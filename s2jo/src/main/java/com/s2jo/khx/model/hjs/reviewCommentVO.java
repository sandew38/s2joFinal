package com.s2jo.khx.model.hjs;


public class reviewCommentVO {
	
	private String seq;       // 댓글번호
	private String userid;    // 사용자ID
	private String name;      // 성명
	private String content;   // 댓글내용
	private String regDate;   // 작성일자
	private String parentSeq; // 원게시물 글번호
	private String status;    // 글삭제여부
	
	public reviewCommentVO() { }
	
	public reviewCommentVO(String seq, String userid, String name, String content, String regDate, String parentSeq, String status) {
		this.seq = seq;
		this.userid = userid;
		this.name = name;
		this.content = content;
		this.regDate = regDate;
		this.parentSeq = parentSeq;
		this.status = status;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getParentSeq() {
		return parentSeq;
	}

	public void setParentSeq(String parentSeq) {
		this.parentSeq = parentSeq;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
