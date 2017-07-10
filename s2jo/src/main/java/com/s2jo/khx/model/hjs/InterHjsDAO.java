package com.s2jo.khx.model.hjs;
  
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

//model단(DAO)의 인터페이스 생성
public interface InterHjsDAO {

	List<String> getStationList(); // 기차역목록 보여주기
	
	int addReview(reviewBoardVO rboardvo); // 파일첨부가 없는 글쓰기
	int addReview_withFile(reviewBoardVO rboardvo); // 파일첨부가 있는 글쓰기

	List<reviewBoardVO> getRboardList(HashMap<String, String> map); // 게시글목록 보여주기
	
	void setAddReadCount(String seq); // 글 조회수 1증가
	
	reviewBoardVO getView(String seq); // 글 1개 보여주기
	
	boolean checkPW(HashMap<String, String> map); // 글 암호 일치여부 알아오기
	
	int updateContent(HashMap<String, String> map); // 글 1개 수정하기 
	
	int delContent(HashMap<String, String> map); // 글 1개 삭제하기(수정으로 처리)
	
	int isExistsComment(HashMap<String, String> map); // 원게시글에 딸린 댓글이 있는지 없는지를 확인하기
	int delComment(HashMap<String, String> map); // 원게시글에 딸린 댓글들 삭제하기	
	
	int addReviewComment(reviewCommentVO rcommentvo); // 댓글쓰기
	int updateCommentCount(String parentSeq); // 댓글쓰기 이후에 댓글의 갯수(final_stationBoard 테이블의 commentCount 컬럼) 1 증가 하기 

	List<reviewCommentVO> listComment(String seq); // 댓글 내용 보여주기 
	
	int getTotalCount(HashMap<String, String> map); // 총 게시물 건수 구하기 
	
	int chkLike(HashMap<String, String> map); // 과거 추천 여부 알아오기
	int chkDislike(HashMap<String, String> map); // 과거 비추천 여부 알아오기
	
	List<HashMap<String,String>> getHjsStatistics1(); // 관광지 통계1
	
	int insertLike(HashMap<String, String> map); // 관광지 리뷰 추천하기
	int insertDislike(HashMap<String, String> map); // 관광지 리뷰 비추천하기
	
	String getLikeCnt(String seq); // 관광지 리뷰 추천수 알아오기
	String getDislikeCnt(String seq); // 관광지 리뷰 비추천수 알아오기
	
	List<HashMap<String, String>> getPrevNext(HashMap<String, String> map); // 이전글/다음글 보여주기
	
	
	int chkTourLike(HashMap<String, String> map); // 시도, 관광지 이름이 존재하는지 체크
	void insertTourName(HashMap<String, String> map); // (DB에 없을시)시도, 관광지 이름 추가하기
	
	int insertTourLike(HashMap<String, String> map); // 관광지 추천하기(update)
	String getTourLikeCnt(HashMap<String, String> map); // 관광지 좋아요수 알아오기
}
