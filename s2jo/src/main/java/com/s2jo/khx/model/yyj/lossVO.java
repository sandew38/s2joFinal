package com.s2jo.khx.model.yyj;

import org.springframework.web.multipart.MultipartFile;

//userid losskind finddate findplace note lossname article
public class lossVO {
	
	

	private String userid; //회원아이디
	private String losskind; // 분실물종류
	private String finddate1; // 습득일
	private String finddate2; // 습득일
	private String finddate3; // 습득일
	private String findplace; // 습득장소
	private String note; // 비고
	private String lossname; // 분실자명
	private String article; // 습득물명 
	private String seq;
	private String writepw; // 글비번	
	private String realfile;
	private String orgfile; // was에저장될 파일이미지네임
	private String filebyte;  // 파일크기
	
	
	private MultipartFile fileimg; // 원래파일이미지
	
 
	
	
	
	public lossVO (){};
	
	public lossVO(String userid, String losskind, String finddate1,String finddate2,String finddate3, String findplace, String note, String lossname,
			String article,String seq,String writepw,String realfile,String orgfile,String filebyte) {
		
		this.userid = userid;
		this.losskind = losskind;
		this.finddate1 = finddate1;
		this.finddate2 = finddate2;
		this.finddate3 = finddate3;
		this.findplace = findplace;
		this.note = note;
		this.lossname = lossname;
		this.article = article;
		this.seq = seq;
		this.writepw = writepw;
		this.realfile= realfile;
		this.orgfile = orgfile;
		this.filebyte = filebyte;
	   
	}


	public String getUserid() {
		return userid;
	}


	public void setUserid(String userid) {
		this.userid = userid;
	}


	public String getLosskind() {
		return losskind;
	}


	public void setLosskind(String losskind) {
		this.losskind = losskind;
	}


	public String getFinddate1() {
		return finddate1;
	}


	public void setFinddate1(String finddate1) {
		this.finddate1 = finddate1;
	}

	
	public String getFinddate2() {
		return finddate2;
	}


	public void setFinddate2(String finddate2) {
		this.finddate2 = finddate2;
	}

	
	public String getFinddate3() {
		return finddate3;
	}


	public void setFinddate3(String finddate3) {
		this.finddate3 = finddate3;
	}


	public String getFindplace() {
		return findplace;
	}


	public void setFindplace(String findplace) {
		this.findplace = findplace;
	}


	public String getNote() {
		return note;
	}


	public void setNote(String note) {
		this.note = note;
	}


	public String getLossname() {
		return lossname;
	}


	public void setLossname(String lossname) {
		this.lossname = lossname;
	}


	public String getArticle() {
		return article;
	}


	public void setArticle(String article) {
		this.article = article;
	}
	
	
	public String getSeq() {
		return seq;
	}


	public void setSeq(String seq) {
		this.seq = seq;
	}
	

	public String getWritepw() {
		return writepw;
	}

	public void setWritepw(String writepw) {
		this.writepw = writepw;
	}

	
	
	

	public String getRealfile() {
		return realfile;
	}

	public void setRealfile(String realfile) {
		this.realfile = realfile;
	}

	
	public String getOrgfile() {
		return orgfile;
	}

	public void setOrgfile(String orgfile) {
		this.orgfile = orgfile;
	}

	public String getFilebyte() {
		return filebyte;
	}

	public void setFilebyte(String filebyte) {
		this.filebyte = filebyte;
	}

	public MultipartFile getFileimg() {
		return fileimg;
	}

	public void setFileimg(MultipartFile fileimg) {
		this.fileimg = fileimg;
	}

	
	
	
	
	

	
	
	
}
