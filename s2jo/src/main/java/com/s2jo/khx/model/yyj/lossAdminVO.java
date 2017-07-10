package com.s2jo.khx.model.yyj;

import org.springframework.web.multipart.MultipartFile;

public class lossAdminVO {
 
	
	private String lostno;
	private int losthave;
	private String storageplace;
	private String losttype;
	private String lostdate1;
	private String lostdate2;
	private String lostdate3;
	private String itemimg;
	private String lostplace;
	private String lostcontent;
	private String article;
	private String lostname;
	private String orgfilename;
	private String middleFilename;
	private String thumbnailFileName;
	private MultipartFile lostimg;
	public lossAdminVO(){};
	
	public lossAdminVO(String lostno, int losthave, String storageplace, String losttype, String lostdate1,String lostdate2,String lostdate3,String itemimg,
		 String lostplace, String lostcontent, String article, String lostname,String orgfilename,String middleFilename,String thumbnailFileName) {
		
		this.lostno = lostno;
		this.losthave = losthave;
		this.storageplace = storageplace;
		this.losttype = losttype;
		this.lostdate1 = lostdate1;
		this.lostdate2 = lostdate2;
		this.lostdate3 = lostdate3;
		this.itemimg = itemimg;
		this.lostplace = lostplace;
		this.lostcontent = lostcontent;
		this.article = article;
		this.lostname = lostname;
        this.orgfilename = orgfilename;
        this.middleFilename = middleFilename;
        this.thumbnailFileName = thumbnailFileName;
	}

	public String getLostno() {
		return lostno;
	}

	public void setLostno(String lostno) {
		this.lostno = lostno;
	}

	public int getLosthave() {
		return losthave;
	}

	public void setLosthave(int losthave) {
		this.losthave = losthave;
	}

	public String getStorageplace() {
		return storageplace;
	}

	public void setStorageplace(String storageplace) {
		this.storageplace = storageplace;
	}

	public String getLosttype() {
		return losttype;
	}

	public void setLosttype(String losttype) {
		this.losttype = losttype;
	}

	public String getLostdate1() {
		return lostdate1;
	}

	public void setLostdate1(String lostdate1) {
		this.lostdate1 = lostdate1;
	}

	
	public String getLostdate2() {
		return lostdate2;
	}

	public void setLostdate2(String lostdate2) {
		this.lostdate2 = lostdate2;
	}
	
	public String getLostdate3() {
		return lostdate3;
	}

	public void setLostdate3(String lostdate3) {
		this.lostdate3 = lostdate3;
	}
	
	
	
	public String getItemimg() {
		return itemimg;
	}

	public void setItemimg(String itemimg) {
		this.itemimg = itemimg;
	}
	
	
	public String getLostplace() {
		return lostplace;
	}

	public void setLostplace(String lostplace) {
		this.lostplace = lostplace;
	}

	public String getLostcontent() {
		return lostcontent;
	}

	public void setLostcontent(String lostcontent) {
		this.lostcontent = lostcontent;
	}

	public String getArticle() {
		return article;
	}

	public void setArticle(String article) {
		this.article = article;
	}

	public String getLostname() {
		return lostname;
	}

	public void setLostname(String lostname) {
		this.lostname = lostname;
	}

	public String getOrgfilename() {
		return orgfilename;
	}

	public void setOrgfilename(String orgfilename) {
		this.orgfilename = orgfilename;
	}

	public String getMiddleFilename() {
		return middleFilename;
	}

	public void setMiddleFilename(String middleFilename) {
		this.middleFilename = middleFilename;
	}

	
	public String getthumbnailFileName() {
		return thumbnailFileName;
	}

	public void setthumbnailFileName(String thumbnailFileName) {
		this.thumbnailFileName = thumbnailFileName;
	}


	
	
	
	
	public MultipartFile getLostimg() {
		return lostimg;
	}

	public void setLostimg(MultipartFile lostimg) {
		this.lostimg = lostimg;
	}

	
	
	

}
