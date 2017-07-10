package com.s2jo.khx.model.jsb;

public class AlarmVO {

	private String seq;  //      number            not null -- p.k
	private String userid;//     varchar2(20)      not null -- 글쓴이
	private String boardSeq;//   number            not null -- 글번호
	private String count; //      number default 0  not null -- 댓글수
	private String boardSubject; //글제목
	
	
	public AlarmVO(){}
	public AlarmVO(String seq, String userid, String boardSeq, String count, String boardSubject) {
	
		this.seq = seq;
		this.userid = userid;
		this.boardSeq = boardSeq;
		this.count = count;
	}
	public String getBoardSubject() {
		return boardSubject;
	}
	public void setBoardSubject(String boardSubject) {
		this.boardSubject = boardSubject;
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
	public String getBoardSeq() {
		return boardSeq;
	}
	public void setBoardSeq(String boardSeq) {
		this.boardSeq = boardSeq;
	}
	public String getCount() {
		return count;
	}
	public void setCount(String count) {
		this.count = count;
	}
	
	
	
	
	
}
