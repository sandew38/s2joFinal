package com.s2jo.khx.model.jsb;

import org.springframework.web.multipart.MultipartFile;

// ===== #55. VO 생성하기 =====
//       먼저, 오라클에서 spring_tblBoard 테이블을 생성해야 한다.
public class BoardVO {

 	private String seq;         // 글번호
 	private String userid;      // 사용자ID
 	private String name;        // 글쓴이
 	private String subject;     // 글제목
 	private String content;     // 글내용  
 	private String pw;          // 글암호
 	private String readCount;   // 글조회수
 	private String regDate;     // 글쓴시간
 	private String status;      // 글삭제여부  1:사용가능한글,  0:삭제된글  
	
// 	===== #94. commentCount 프로퍼티 추가하기
// 	            먼저 spring_tblBoard 테이블에 commentCount 컬럼을 추가한 다음에 해야 한다. =====
 	private String commentCount; // 댓글수
 	
//  ===== #116. 답변형 게시판을 위한 멤버변수 추가하기
//              먼저, spring_tblBoard 테이블과 spring_tblComment 테이블을 기존것은 제거한후 
//              새로이 만든 다음에 아래와 같이 한다. 
 	private String groupno;
 	/*
 	 답변글쓰기에 있어서 그룹번호
      원글(부모글)과 답변글은 동일한 groupno 를 가진다. 
      답변글이 아닌 원글(부모글)인 경우 groupno 의 값은 groupno 컬럼의 최대값(max)+1 로 한다. 
 	 */
 	
 	private String fk_seq;
 /*
    fk_seq 컬럼은 절대로 foreign key가 아니다.
    fk_seq 컬럼은 자신의 글(답변글)에 있어서 
    원글(부모글)이 누구인지에 대한 정보값이다.
    답변글쓰기에 있어서 답변글이라면 fk_seq 컬럼의 값은 
    원글(부모글)의 seq 컬럼의 값을 가지게 되며,
    답변글이 아닌 원글일 경우 0 을 가지도록 한다. 	
  */
 	
 	private String depthno;
 /*
    답변글쓰기에 있어서 답변글 이라면                                                
    원글(부모글)의 depthno + 1 을 가지게 되며,
    답변글이 아닌 원글일 경우 0 을 가지도록 한다. 	
  */
 
/* 	
 ===== #131. 파일첨부를 하도록 VO 수정하기
              먼저, 오라클에서 spring_tblBoard 테이블에
            3개 컬럼(fileName, orgFilename, fileSize)을 추가한 다음에
              아래의 작업을 해야 한다. ======
*/
 	
 	private String fileName;    // WAS(톰캣)에 저장될 파일명(20161121324325454354353333432.png)
 	private String orgFilename; // 진짜 파일명(강아지.png)  사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
 	private String fileSize;    // 파일크기
 	
 	private MultipartFile attach; // 진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
 	    // MultipartFile attach 는 오라클 데이터베이스 spring_tblBoard 테이블의 컬럼이 아니다.!!!!!
 	
 	
 	private String rLikeCnt;
 	private String rDisLikeCnt;
 	
 	private String tLikeCnt;
 	private String tDisLikeCnt;
 	
 	private String wLikeCnt;
 	private String wDisLikeCnt;
 	
 	private String resultLike;
 	
 	 	
 	public BoardVO() { }
 	
 	public BoardVO(String seq, String userid, String name, String subject, String content, String pw, String readCount, String regDate,
			String status, String commentCount,
			String groupno, String fk_seq, String depthno,
			String fileName, String orgFilename, String fileSize,String rLikeCnt,String rDisLikeCnt,String tLikeCnt,String tDisLikeCnt,
			String wLikeCnt,String wDisLikeCnt, String resultLike) {
		this.seq = seq;
		this.userid = userid;
		this.name = name;
		this.subject = subject;
		this.content = content;
		this.pw = pw;
		this.readCount = readCount;
		this.regDate = regDate;
		this.status = status;
		
		this.commentCount = commentCount;
		
		this.groupno = groupno;
		this.fk_seq = fk_seq;
		this.depthno = depthno;
		
		this.fileName = fileName;
		this.orgFilename = orgFilename;
		this.fileSize = fileSize;
		
		this.rLikeCnt = rLikeCnt;
		this.rDisLikeCnt = rDisLikeCnt;
		this.tLikeCnt = tLikeCnt;
		this.tDisLikeCnt = tDisLikeCnt;
		this.wLikeCnt = rLikeCnt;
		this.wDisLikeCnt = wDisLikeCnt;
		
		this.resultLike = resultLike;
		
		
	}
 	
		


	public String getResultLike() {
		return resultLike;
	}

	public void setResultLike(String resultLike) {
		this.resultLike = resultLike;
	}

	public String gettLikeCnt() {
		return tLikeCnt;
	}

	public void settLikeCnt(String tLikeCnt) {
		this.tLikeCnt = tLikeCnt;
	}

	public String gettDisLikeCnt() {
		return tDisLikeCnt;
	}

	public void settDisLikeCnt(String tDisLikeCnt) {
		this.tDisLikeCnt = tDisLikeCnt;
	}

	public String getwLikeCnt() {
		return wLikeCnt;
	}

	public void setwLikeCnt(String wLikeCnt) {
		this.wLikeCnt = wLikeCnt;
	}

	public String getwDisLikeCnt() {
		return wDisLikeCnt;
	}

	public void setwDisLikeCnt(String wDisLikeCnt) {
		this.wDisLikeCnt = wDisLikeCnt;
	}

	public String getrLikeCnt() {
		return rLikeCnt;
	}

	public void setrLikeCnt(String rLikeCnt) {
		this.rLikeCnt = rLikeCnt;
	}

	public String getrDisLikeCnt() {
		return rDisLikeCnt;
	}

	public void setrDisLikeCnt(String rDisLikeCnt) {
		this.rDisLikeCnt = rDisLikeCnt;
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

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}	
	
}
