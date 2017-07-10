package com.s2jo.khx.model.hjs;

import org.springframework.web.multipart.MultipartFile;

/**
 * @author user1
 *
 */
public class reviewBoardVO {
	
 	private String seq;         // 글고유번호
 	private String station;		// 역이름
 	private String userid;      // 사용자ID
 	private String name;        // 글쓴이
 	private String subject;     // 글제목
 	private String content;     // 글내용  
 	private String pw;          // 글암호
 	private String readCount;   // 글조회수
 	private String recCount;	// 추천수
 	private String regDate;     // 글쓴시간
 	private String status;      // 글삭제여부  1:사용가능한글,  0:삭제된글  
 	private String commentCount; // 댓글수
 	private String groupno;
 	private String fk_seq;
 	private String depthno;
 	private String fileName;    // WAS(톰캣)에 저장될 파일명(20161121324325454354353333432.png)
 	private String orgFilename; // 진짜 파일명(강아지.png)  사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
 	private String fileSize;    // 파일크기
 	
 	private String thumbnailFileName; // 썸네일 파일명
 	
 	private MultipartFile attach; // 진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
 	    // MultipartFile attach 는 오라클 데이터베이스 spring_tblBoard 테이블의 컬럼이 아니다.!!!!!
 	
 	
 	public reviewBoardVO() {  }


	public reviewBoardVO(String seq, String station, String userid, String name, String subject, String content,
			String pw, String readCount, String recCount, String regDate, String status, String commentCount,
			String groupno, String fk_seq, String depthno, String fileName, String orgFilename, String fileSize, String thumbnailFileName,
			MultipartFile attach) {

		this.seq = seq;
		this.station = station;
		this.userid = userid;
		this.name = name;
		this.subject = subject;
		this.content = content;
		this.pw = pw;
		this.readCount = readCount;
		this.recCount = recCount;
		this.regDate = regDate;
		this.status = status;
		this.commentCount = commentCount;
		this.groupno = groupno;
		this.fk_seq = fk_seq;
		this.depthno = depthno;
		this.fileName = fileName;
		this.orgFilename = orgFilename;
		this.fileSize = fileSize;
		this.thumbnailFileName = thumbnailFileName;
		this.attach = attach;
	}


	public String getSeq() {
		return seq;
	}


	public void setSeq(String seq) {
		this.seq = seq;
	}


	public String getStation() {
		return station;
	}


	public void setStation(String station) {
		this.station = station;
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


	public String getSubject() {
		return subject;
	}


	public void setSubject(String subject) {
		this.subject = subject;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getPw() {
		return pw;
	}


	public void setPw(String pw) {
		this.pw = pw;
	}


	public String getReadCount() {
		return readCount;
	}


	public void setReadCount(String readCount) {
		this.readCount = readCount;
	}


	public String getRecCount() {
		return recCount;
	}


	public void setRecCount(String recCount) {
		this.recCount = recCount;
	}


	public String getRegDate() {
		return regDate;
	}


	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getCommentCount() {
		return commentCount;
	}


	public void setCommentCount(String commentCount) {
		this.commentCount = commentCount;
	}


	public String getGroupno() {
		return groupno;
	}


	public void setGroupno(String groupno) {
		this.groupno = groupno;
	}


	public String getFk_seq() {
		return fk_seq;
	}


	public void setFk_seq(String fk_seq) {
		this.fk_seq = fk_seq;
	}


	public String getDepthno() {
		return depthno;
	}


	public void setDepthno(String depthno) {
		this.depthno = depthno;
	}


	public String getFileName() {
		return fileName;
	}


	public void setFileName(String fileName) {
		this.fileName = fileName;
	}


	public String getOrgFilename() {
		return orgFilename;
	}


	public void setOrgFilename(String orgFilename) {
		this.orgFilename = orgFilename;
	}


	public String getFileSize() {
		return fileSize;
	}


	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}


	public String getThumbnailFileName() {
		return thumbnailFileName;
	}


	public void setThumbnailFileName(String thumbnailFileName) {
		this.thumbnailFileName = thumbnailFileName;
	}


	public MultipartFile getAttach() {
		return attach;
	}


	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
 	
	
	
 	
}
