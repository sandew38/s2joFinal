package com.s2jo.khx.model.jsb;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class JsbDAO implements InterJsbDAO{
//	 의존객체 주입하기(DI : Dependency Injection) =====
	@Autowired
	private SqlSessionTemplate sqlsession;
	

	//글쓰기를 해주는 int add(BoardVO boardvo) 메소드 생성하기 =====(최초)
	@Override
	public int recommendAdd(BoardVO boardvo) {
		int n = sqlsession.insert("jsb.recommendAdd", boardvo);
		return n;	
	}

	//글목록보여주기(중간)
	@Override
	public List<BoardVO> recommendBoardList(HashMap<String, String> map) {
		List<BoardVO> recommendBoardList = sqlsession.selectList("jsb.recommendBoardList",map);
		return recommendBoardList;
	}
	
	//글 1개를 볼때 조회수(readCount) 1증가 시키기 =====
	@Override
	public void setRecAddReadCount(String seq) {
		sqlsession.update("jsb.setRecAddReadCount", seq);
	}

	// 글 1개 보여주는 BoardVO getRecommendView(String seq) 메소드 생성하기 =====
	@Override
	public BoardVO getRecommendView(String seq) {
		BoardVO boardvo = sqlsession.selectOne("jsb.getRecommendView", seq);
		return boardvo;
	
	}

	//글 수정하기
	@Override
	public int recUpdateContent(HashMap<String, String> map) {
		int n = sqlsession.update("jsb.recUpdateContent", map);
		return n;
	}
	//글 수정시 파일 첨부
	@Override
	public int Edit_recWithFile(HashMap<String, String> map) {
		int n = sqlsession.insert("jsb.Edit_recWithFile", map);
		return n;
	}

	// =====  1개 글삭제하기 =====
	@Override
	public int recDelContent(HashMap<String, String> map) {
		int n = sqlsession.update("jsb.recDelContent", map);
		return n;
	}

	
	// ===== . 댓글쓰기 =====
	@Override
	public int recAddComment(CommentVO commentvo) {
		int n = sqlsession.insert("jsb.recAddComment", commentvo);
		return n;
	}

	
	
	 // 댓글쓰기 이후에 댓글의 갯수(commentCount 컬럼) 1 증가 하기 =====
		@Override
		public int recUpdateCommentCount(String parentSeq) {
		   int n = sqlsession.update("jsb.recUpdateCommentCount", parentSeq);
		   return n;
		}

		
		
	// ====== 댓글내용 보여주기 ======
	@Override
	public List<CommentVO> recListComment(String parentSeq) {
		List<CommentVO> list = sqlsession.selectList("jsb.recListComment", parentSeq);
		return list;
	}

	//원 게시글에 딸린 댓글 여부확인
	@Override
	public int recIsExistsComment(HashMap<String, String> map) {
		int count = sqlsession.selectOne("jsb.recIsExistsComment", map); 
		return count; 
	}

	//글삭제시 댓글삭제
	@Override
	public int recDelComment(HashMap<String, String> map) {
		int result = sqlsession.update("jsb.recDelComment", map);
		return result;
	}

	// ===== 총 게시물 건수 구하기
	//       총 게시물 건수는 검색조건이 없을때와 있을때로 나뉘어진다. ===== 	
	@Override
	public int getRecTotalCount(HashMap<String, String> map) {
		int count = sqlsession.selectOne("jsb.getRecTotalCount", map);
		return count;
	}

	//첨부파일이 잇는 글쓰기
	@Override
	public int add_recWithFile(BoardVO boardvo) {
		int n = sqlsession.insert("jsb.add_recWithFile", boardvo);
		return n;
	}

	
	//추천게시판 검색하기
	@Override
	public List<HashMap<String, String>> recSearchWordCompleteList(HashMap<String, String> map) {
		List<HashMap<String, String>> list = sqlsession.selectList("jsb.recSearchWordCompleteList", map);
		return list;
	}
	
	//알람 DB 추가
	@Override
	public void rAlarmCommentAdd(HashMap<String, String> map) {
		sqlsession.insert("jsb.rAlarmCommentAdd", map);
	}
	
	 //알람 boardSeq Update
	@Override
	public int rAlarmCommentUpdate(AlarmVO alarmvo) {
		int n=sqlsession.update("jsb.rAlarmCommentUpdate", alarmvo);
		return n;
	}
	//recAlarm 목록 보여주기
	@Override
	public List<AlarmVO> rAlarmList() {
		List<AlarmVO> rAlarmList = sqlsession.selectList("jsb.rAlarmList");
		return rAlarmList;
	}

	//recAlarm count update==>0
	@Override
	public List<HashMap<String, String>> rZeroAlarmCount(HashMap<String, String> map) {
		List<HashMap<String, String>> list = sqlsession.selectList("jsb.rZeroAlarmCount",map);
		return list;
	}
	
	//resultAlert DB 추가
	@Override
	public int resultAlarm(HashMap<String, String> map) {
		int n = sqlsession.insert("jsb.resultAlarm", map);
		return n;
	}
	
	//resultAlarm 증감
	@Override
	public int resultAlarmCntUpdate(String writer) {
		int n =	sqlsession.update("jsb.resultAlarmCntUpdate", writer);
		return n;	
	}
	//알람 창 숫자 띄우기
	@Override 
	public resultAlarmVO getResultAlarm(String userid) {
		resultAlarmVO getResultAlarm = sqlsession.selectOne("jsb.getResultAlarm" , userid);
		return getResultAlarm;
	}
		
	
	
	/////////////////////////////////////////////////////////////////// together ///////////////////////////////////////////////////////////////
	//together 게시판 보여주기
	@Override
	public List<BoardVO> togetherBoardList(HashMap<String, String> map) {
		List<BoardVO> togetherBoardList = sqlsession.selectList("jsb.togetherBoardList",map);
		return togetherBoardList;
	}

	// ===== together총 게시물 건수 구하기
	//       총 게시물 건수는 검색조건이 없을때와 있을때로 나뉘어진다. ===== 	
	@Override
	public int getTogTotalCount(HashMap<String, String> map) {
		int count = sqlsession.selectOne("jsb.getTogTotalCount", map);
		return count;
	}

	//together 글쓰기
	@Override
	public int togetherAdd(BoardVO boardvo) {
		int n = sqlsession.insert("jsb.togetherAdd", boardvo);
		return n;	
	}
	
	//together 첨부파일이 있는 글쓰기
	@Override
	public int add_togWithFile(BoardVO boardvo) {
		int n = sqlsession.insert("jsb.add_togWithFile", boardvo);
		return n;
	}

	//글 조회시 카운트 증가
	@Override
	public void setTogAddReadCount(String seq) {
		sqlsession.update("jsb.setTogAddReadCount", seq);
		
	}
	
	//1개글 내용 보기
	@Override
	public BoardVO getTogetherView(String seq) {
		BoardVO boardvo = sqlsession.selectOne("jsb.getTogetherView", seq);
		return boardvo;
	}

	//댓글추가
	@Override
	public List<CommentVO> togListComment(String parentSeq) {
		List<CommentVO> list = sqlsession.selectList("jsb.togListComment", parentSeq);
		return list;
	}

	//글 수정하기
	@Override
	public int togUpdateContent(HashMap<String, String> map) {
		int n = sqlsession.update("jsb.togUpdateContent", map);
		return n;
	}
	
	//파일 첨부 시 글 수정
	@Override
	public int Edit_togWithFile(HashMap<String, String> map) {
		int n = sqlsession.insert("jsb.Edit_togWithFile", map);
		return n;
	}

	//원 게시글에 딸린 댓글 여부확인
	@Override
	public int togIsExistsComment(HashMap<String, String> map) {
		int count = sqlsession.selectOne("jsb.togIsExistsComment", map); 
		return count; 
	}
	
	// 글 1개 삭제(수정으로 처리)하기
	@Override
	public int togDelContent(HashMap<String, String> map) {
		int n = sqlsession.update("jsb.togDelContent", map);
		return n;
	}

	// ===== 원게시글에 딸린 댓글들 삭제하기 ===== 
	@Override
	public int togDelComment(HashMap<String, String> map) {
		int result = sqlsession.update("jsb.togDelComment", map);
		return result;
	}

	//댓글쓰기
	@Override
	public int togAddComment(CommentVO commentvo) {
		int n = sqlsession.insert("jsb.togAddComment", commentvo);
		return n;
	}

	// 댓글쓰기 이후에 댓글의 갯수(commentCount 컬럼) 1 증가 하기 =====
	@Override
	public int togUpdateCommentCount(String parentSeq) {
		int n = sqlsession.update("jsb.togUpdateCommentCount", parentSeq);
		 return n;
	}
	
	//추천게시판 검색하기
	@Override
	public List<HashMap<String, String>> togSearchWordCompleteList(HashMap<String, String> map) {
		List<HashMap<String, String>> list = sqlsession.selectList("jsb.togSearchWordCompleteList", map);
		return list;
	}
	
	
	//////////////////////////////////////////////////////////주의해요 게시판/////////////////////////////////
	//글목록 보여주기
	@Override
	public List<BoardVO> worryingBoardList(HashMap<String, String> map) {
		List<BoardVO> worryingBoardList = sqlsession.selectList("jsb.worryingBoardList",map);
		return worryingBoardList;
	}

	// ===== 총 게시물 건수 구하기
		//       총 게시물 건수는 검색조건이 없을때와 있을때로 나뉘어진다. =====
	@Override
	public int getWorTotalCount(HashMap<String, String> map) {
		int count = sqlsession.selectOne("jsb.getWorTotalCount", map);
		return count;
	}

	//글 쓰기
	@Override
	public int worryingAdd(BoardVO boardvo) {
		int n = sqlsession.insert("jsb.worryingAdd", boardvo);
		return n;	
	}

	//파일이 있을시 글추가
	@Override
	public int add_worWithFile(BoardVO boardvo) {
		int n = sqlsession.insert("jsb.add_worWithFile", boardvo);
		return n;
	}

	//카운트 1 올려주기
	@Override
	public void setWorAddReadCount(String seq) {
		sqlsession.update("jsb.setWorAddReadCount", seq);
		
	}

	//글 1개 보여주기
	@Override
	public BoardVO getWorryingView(String seq) {
		BoardVO boardvo = sqlsession.selectOne("jsb.getWorryingView", seq);
		return boardvo;
	}

	//댓글 보여주기
	@Override
	public List<CommentVO> worListComment(String parentSeq) {
		List<CommentVO> list = sqlsession.selectList("jsb.worListComment", parentSeq);
		return list;
	}

	//1개 글 수정하기
	@Override
	public int worUpdateContent(HashMap<String, String> map) {
		int n = sqlsession.update("jsb.worUpdateContent", map);
		return n;
	}
	
	//파일 첨부와 함께 글 수정
	@Override
	public int Edit_worWithFile(HashMap<String, String> map) {
		int n = sqlsession.insert("jsb.Edit_worWithFile", map);
		return n;
	}

	//댓글이 있는 글인지 아닌지 확인
	@Override
	public int worIsExistsComment(HashMap<String, String> map) {
		int count = sqlsession.selectOne("jsb.worIsExistsComment", map); 
		return count; 
	}

	//글 삭제
	@Override
	public int worDelContent(HashMap<String, String> map) {
		int n = sqlsession.update("jsb.worDelContent", map);
		return n;
	}

	//글삭제시 댓글삭제
	@Override
	public int worDelComment(HashMap<String, String> map) {
			int result = sqlsession.update("jsb.worDelComment", map);
			return result;
	}

	//댓글쓰기
	@Override
	public int worAddComment(CommentVO commentvo) {
		int n = sqlsession.insert("jsb.worAddComment", commentvo);
		return n;
	}

	 // 댓글쓰기 이후에 댓글의 갯수(commentCount 컬럼) 1 증가 하기 =====
	@Override
	public int worUpdateCommentCount(String parentSeq) {
		int n = sqlsession.update("jsb.worUpdateCommentCount", parentSeq);
		 return n;
	}

	//검색하기
	@Override
	public List<HashMap<String, String>> worSearchWordCompleteList(HashMap<String, String> map) {
		List<HashMap<String, String>> list = sqlsession.selectList("jsb.worSearchWordCompleteList", map);
		return list;
	}

	//추천게시판 정보 간단히 가져오기
	@Override
	public List<BoardVO> rBoardList() {
		List<BoardVO> rBoardList= sqlsession.selectList("jsb.rBoardList");
		return rBoardList;
	}
	
	//함께해요 게시판 알람 DB 추가
	@Override
	public void tAlarmCommentAdd(HashMap<String, String> map) {
		sqlsession.insert("jsb.tAlarmCommentAdd", map);
		
	}

	//함께해요 게시판 DB count -> 0
	@Override
	public List<HashMap<String, String>> tZeroAlarmCount(HashMap<String, String> map) {
		List<HashMap<String, String>> list = sqlsession.selectList("jsb.tZeroAlarmCount",map);
		return list;
	}
	
	//r_alarm count 증감
	@Override
	public int tAlarmCommentUpdate(AlarmVO alarmvo) {
		int n=sqlsession.update("jsb.tAlarmCommentUpdate", alarmvo);
		return n;
	}

	//함께해요 게시판 간단히 가져오기
	@Override
	public List<AlarmVO> tAlarmList() {
		List<AlarmVO> tAlarmList = sqlsession.selectList("jsb.tAlarmList");
		return tAlarmList;
	}
	
	//함께해요내용 resultAlarm에 추가
	@Override
	public int t_resultAlarm(HashMap<String, String> map) {
		int n = sqlsession.insert("jsb.t_resultAlarm", map);
		return n;
	}

	@Override
	public int t_resultAlarmCntUpdate(String writer) {
		int n =	sqlsession.update("jsb.t_resultAlarmCntUpdate", writer);
		return n;
	}

	//위험해요 게시판 알람 추가
	@Override
	public void wAlarmCommentAdd(HashMap<String, String> map) {
		sqlsession.insert("jsb.wAlarmCommentAdd", map);
		
	}

	//resultAlarm Worrying 내용 추가
	@Override
	public int w_resultAlarm(HashMap<String, String> map) {
		int n = sqlsession.insert("jsb.w_resultAlarm", map);
		return n;
	}

	//worrying count make 0
	@Override
	public List<HashMap<String, String>> wZeroAlarmCount(HashMap<String, String> map) {
		List<HashMap<String, String>> list = sqlsession.selectList("jsb.wZeroAlarmCount",map);
		return list;
	}

	//worrying count 에 따른 result count 증감
	@Override
	public int w_resultAlarmCntUpdate(String writer) {
		int n =	sqlsession.update("jsb.w_resultAlarmCntUpdate", writer);
		return n;
	}

	@Override
	public int wAlarmCommentUpdate(AlarmVO alarmvo) {
		int n=sqlsession.update("jsb.wAlarmCommentUpdate", alarmvo);
		return n;
	}

	//위험해요 게시판 정보 간단히 가져오기
	@Override
	public List<AlarmVO> wAlarmList() {
		List<AlarmVO> wAlarmList = sqlsession.selectList("jsb.wAlarmList");
		return wAlarmList;
	}

	//이전글 다음글
	@Override
	public List<HashMap<String, String>> getPrevNext(HashMap<String, String> pre_next_map) {
		List<HashMap<String, String>> getPrevNext = sqlsession.selectList("jsb.getPrevNext", pre_next_map);
		return getPrevNext;
	}

	//추천게시판 기존 추천여부 확인
	@Override
	public int rchkLike(HashMap<String, String> map) {
		int cnt = sqlsession.selectOne("jsb.rchkLike", map);
		return cnt;
	}
	//추천하기
	@Override
	public int rinsertLike(HashMap<String, String> map) {
		int result = sqlsession.insert("jsb.rinsertLike", map);
		return result;
	}

	//추천게시판 기존 비추천 확인
	@Override
	public int rChkDislike(HashMap<String, String> map) {
		int cnt = sqlsession.selectOne("jsb.rChkDislike", map);
		return cnt;
	}
	//비추천하기
	@Override
	public int rInsertDislike(HashMap<String, String> map) {
		int result = sqlsession.insert("jsb.rInsertDislike", map);
		return result;
	}

	//추천수 알아오기
	@Override
	public String getrLikeCnt(String seq) {
		String likeCnt = sqlsession.selectOne("jsb.getrLikeCnt", seq);
		return likeCnt;
	
	}

	//비추천수 알아오기
	@Override
	public String getrDislikeCnt(String seq) {
		String dislikeCnt = sqlsession.selectOne("jsb.getrDislikeCnt", seq);
		return dislikeCnt;
	}

	
	
	
	//함께해요게시판 추천체크
	@Override
	public int tChkLike(HashMap<String, String> map) {
		int cnt = sqlsession.selectOne("jsb.tChkLike", map);
		return cnt;
	}

	//함께해요 추천하기
	@Override
	public int tInsertLike(HashMap<String, String> map) {
		int result = sqlsession.insert("jsb.tInsertLike", map);
		return result;
	}

	//함께해요 비추천확인
	@Override
	public int tChkDislike(HashMap<String, String> map) {
		int cnt = sqlsession.selectOne("jsb.tChkDislike", map);
		return cnt;
	}

	//함께해요 비추천하기
	@Override
	public int tInsertDislike(HashMap<String, String> map) {
		int result = sqlsession.insert("jsb.tInsertDislike", map);
		return result;
	}

	//함께해요게시판 추천수 가져오기
	@Override
	public String gettLikeCnt(String seq) {
		String likeCnt = sqlsession.selectOne("jsb.gettLikeCnt", seq);
		return likeCnt;
	}

	//함께해요게시판 비추천수 가져오기
	@Override
	public String gettDislikeCnt(String seq) {
		String dislikeCnt = sqlsession.selectOne("jsb.gettDislikeCnt", seq);
		return dislikeCnt;
	}

	//위험해요게시판 추천 확인
	@Override
	public int wChkLike(HashMap<String, String> map) {
		int cnt = sqlsession.selectOne("jsb.wChkLike", map);
		return cnt;
	}

	//위험해요게시판 추천하기
	@Override
	public int wInsertLike(HashMap<String, String> map) {
		int cnt = sqlsession.selectOne("jsb.wInsertLike", map);
		return cnt;
	}

	//위험해요게시판 비추천 체크
	@Override
	public int wChkDislike(HashMap<String, String> map) {
		int cnt = sqlsession.selectOne("jsb.wChkDislike", map);
		return cnt;
	}

	//위험해요게시판 비추천하기
	@Override
	public int wInsertDislike(HashMap<String, String> map) {
		int result = sqlsession.insert("jsb.wInsertDislike", map);
		return result;
	}

	//위험해요게시판 비추천수 가져오기
	@Override
	public String getwDislikeCnt(String seq) {
		String dislikeCnt = sqlsession.selectOne("jsb.getwDislikeCnt", seq);
		return dislikeCnt;
	}

	//위험해요게시판 추천수 가져오기
	@Override
	public String getwLikeCnt(String seq) {
		String likeCnt = sqlsession.selectOne("jsb.getwLikeCnt", seq);
		return likeCnt;
	}
	



	


	
	


	
	
	

}
