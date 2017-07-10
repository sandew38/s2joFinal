package com.s2jo.khx.service.hjs;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import com.s2jo.khx.model.hjs.reviewBoardVO;
import com.s2jo.khx.model.hjs.reviewCommentVO;
  
//Service 단 인터페이스 선언
public interface InterHjsService {

	List<String> getStationList(); // 기차역목록 보여주기
	
	int addReview(reviewBoardVO rboardvo); // 파일첨부가 없는 글쓰기
	int addReview_withFile(reviewBoardVO rboardvo); // 파일첨부가 있는 글쓰기
	
	List<reviewBoardVO> getRboardList(HashMap<String, String> map); // 게시글목록 보여주기

	reviewBoardVO getView(String seq); // 게시글 1개 보여주기 (먼저 조회수 1 증가 후)
	reviewBoardVO getViewWithoutCount(String seq); // 게시글 1개 보여주기 (조회수 1 증가 없이)
	
	int editReview(HashMap<String, String> map); // 글수정하기
	int delReview(HashMap<String, String> map) throws Throwable; // 1개 글 삭제하기
	
	int addReviewComment(reviewCommentVO rcommentvo) throws Throwable; // 댓글쓰기
   	List<reviewCommentVO> listComment(String seq); // 댓글 보여주기
   	
   	int getTotalCount(HashMap<String, String> map); // 총 게시물 건수 구하기 
   	
   	int insertLike(HashMap<String, String> map); // 관광지 리뷰 추천하기
   	int insertDislike(HashMap<String, String> map); // 관광지 리뷰 비추천하기
   	
	String getLikeCnt(String seq); // 관광지 리뷰 추천수 알아오기
	String getDislikeCnt(String seq); // 관광지 리뷰 비추천수 알아오기
	
	List<HashMap<String, String>> getPrevNext(HashMap<String, String> map); // 이전글/다음글 보여주기
	
	int insertTourLike(HashMap<String, String> map); // 관광지 추천하기
	String getTourLikeCnt(HashMap<String, String> map); // 관광지 좋아요수 알아오기
	
	List<HashMap<String,String>> getHjsStatistics1(); // 관광지 통계1
}
