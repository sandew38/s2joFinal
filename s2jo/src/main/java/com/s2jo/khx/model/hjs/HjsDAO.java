package com.s2jo.khx.model.hjs;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

  
//===== DAO 선언 =====
@Repository
public class HjsDAO implements InterHjsDAO {

//	===== 의존객체 주입하기(DI : Dependency Injection) =====
	@Autowired
	private SqlSessionTemplate sqlsession;

	
	// 기차역목록 보여주기
	@Override
	public List<String> getStationList() {
		List<String> stationList = sqlsession.selectList("hjs.getStationList");
		return stationList;
	}


	// 기차역 이용후기 쓰기 (첨부파일 x)
	@Override
	public int addReview(reviewBoardVO rboardvo) {
	   int n = sqlsession.insert("hjs.addReview", rboardvo);
	   return n;	
	}

	
	// 기차역 이용후기 쓰기 (첨부파일 o)
	@Override
	public int addReview_withFile(reviewBoardVO rboardvo) {
	   int n = sqlsession.insert("hjs.addReview_withFile", rboardvo);
	   return n;
	}
	
	

	// 기차역 이용후기 목록 보여주기
	@Override
	public List<reviewBoardVO> getRboardList(HashMap<String, String> map) {
		List<reviewBoardVO> rboardList = sqlsession.selectList("hjs.getRboardList", map);
		return rboardList;
	}


	// 글 조회수 1증가
	@Override
	public void setAddReadCount(String seq) {
		sqlsession.update("hjs.setAddReadCount", seq);
	}


	// 글 1개 보여주기
	@Override
	public reviewBoardVO getView(String seq) {
		reviewBoardVO rboardvo = sqlsession.selectOne("hjs.getView", seq);
		return rboardvo;
	}


	// 글 암호 일치여부 알아오기
	@Override
	public boolean checkPW(HashMap<String, String> map) {
		int n = sqlsession.selectOne("hjs.checkPW", map);
		boolean bool = false;
		
		if(n > 0) {
			bool = true;
		}
		
		return bool;
	}


	// 글 1개 수정하기 
	@Override
	public int updateContent(HashMap<String, String> map) {
		int n = sqlsession.update("hjs.updateContent", map);
		return n;
	}


	// 글 1개 삭제하기
	@Override
	public int delContent(HashMap<String, String> map) {
		int n = sqlsession.update("hjs.delContent", map);
		return n;
	}


	// 댓글쓰기
	@Override
	public int addReviewComment(reviewCommentVO rcommentvo) {
		int n = sqlsession.insert("hjs.addReviewComment", rcommentvo);
		return n;
	}


	// 댓글쓰기 이후에 댓글의 갯수(final_stationBoard 테이블의 commentCount 컬럼) 1 증가 하기
	@Override
	public int updateCommentCount(String parentSeq) {
		   int n = sqlsession.update("hjs.updateCommentCount", parentSeq);
		   return n;
	}


	// 댓글 보여주기
	@Override
	public List<reviewCommentVO> listComment(String parentSeq) {
		List<reviewCommentVO> list = sqlsession.selectList("hjs.listComment", parentSeq);
		return list;
	}


	// ===== 총 게시물 건수 구하기
	//       총 게시물 건수는 검색조건이 없을때와 있을때로 나뉘어진다. ===== 
	@Override
	public int getTotalCount(HashMap<String, String> map) {
		int count = sqlsession.selectOne("hjs.getTotalCount", map);
		return count;
	}


	// ===== 원게시글에 딸린 댓글이 있는지 없는지를 확인하기 =====
	@Override
	public int isExistsComment(HashMap<String, String> map) {
		int count = sqlsession.selectOne("hjs.isExistsComment", map); 
		return count;
	}


	// ===== 원게시글에 딸린 댓글들 삭제하기 =====
	@Override
	public int delComment(HashMap<String, String> map) {
		int result = sqlsession.update("hjs.delComment", map);
		return result;
	}


	// 관광지 리뷰 추천하기
	@Override
	public int insertLike(HashMap<String, String> map) {
		int result = sqlsession.insert("hjs.insertLike", map);
		return result;
	}


	// 관광지 리뷰 비추천하기
	@Override
	public int insertDislike(HashMap<String, String> map) {
		int result = sqlsession.insert("hjs.insertDislike", map);
		return result;
	}


	// 과거 추천 여부 알아오기
	@Override
	public int chkLike(HashMap<String, String> map) {
		int cnt = sqlsession.selectOne("hjs.chkLike", map);
		return cnt;
	}


	// 과거 비추천 여부 알아오기
	@Override
	public int chkDislike(HashMap<String, String> map) {
		int cnt = sqlsession.selectOne("hjs.chkDislike", map);
		return cnt;
	}


	// 관광지 리뷰 추천수 알아오기
	@Override
	public String getLikeCnt(String seq) {
		String likeCnt = sqlsession.selectOne("hjs.getLikeCnt", seq);
		return likeCnt;
	}


	// 관광지 리뷰 비추천수 알아오기
	@Override
	public String getDislikeCnt(String seq) {
		String dislikeCnt = sqlsession.selectOne("hjs.getDislikeCnt", seq);
		return dislikeCnt;
	}


	// 이전글/다음글 알아오기
	@Override
	public List<HashMap<String, String>> getPrevNext(HashMap<String, String> map) {
		List<HashMap<String, String>> prevNextList = sqlsession.selectList("hjs.getPrevNext", map);
		return prevNextList;
	}

	
	// 시도, 관광지 이름이 존재하는지 체크
	@Override
	public int chkTourLike(HashMap<String, String> map) {
		int result = sqlsession.selectOne("hjs.chkTourLike", map);
		return result;
	}
	
	// (DB에 없을시)시도, 관광지 이름 추가하기
	@Override
	public void insertTourName(HashMap<String, String> map) {
		sqlsession.insert("hjs.insertTourName", map);
	}
	
	
	// 관광지 추천하기(update)
	@Override
	public int insertTourLike(HashMap<String, String> map) {
		int result = sqlsession.update("hjs.insertTourLike", map);
		return result;
	}

	
	// 관광지 좋아요 수 알아오기
	@Override
	public String getTourLikeCnt(HashMap<String, String> map) {
		String likeCnt = sqlsession.selectOne("hjs.getTourLikeCnt", map);
		return likeCnt;
	}


	// 관광지 통계1
	@Override
	public List<HashMap<String, String>> getHjsStatistics1() {
		List<HashMap<String, String>> list = sqlsession.selectList("hjs.getHjsStatistics1");
		return list;
	}











}
