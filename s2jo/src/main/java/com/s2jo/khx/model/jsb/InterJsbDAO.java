package com.s2jo.khx.model.jsb;

import java.util.HashMap;
import java.util.List;

public interface InterJsbDAO {

	//recommend 게시판
	int recommendAdd(BoardVO boardvo); //글쓰기 (최초)
	List<BoardVO> recommendBoardList(HashMap<String, String> map);//글목록보여주기
	void setRecAddReadCount(String seq);// 글 1개를 볼때 조회수(readCount) 1증가 시키기 =====
	BoardVO getRecommendView(String seq);//글 1개 보여주는 BoardVO getView(String seq) 메소드 생성하기
	int recUpdateContent(HashMap<String, String> map); //글 수정하기
	int recDelContent(HashMap<String, String> map);//글 삭제하기
	int recAddComment(CommentVO commentvo); //댓글쓰기
	int recUpdateCommentCount(String parentSeq);//댓글카운트 추가하기
	List<CommentVO> recListComment(String parentSeq);//댓글보여주기
	int recIsExistsComment(HashMap<String, String> map);//글 삭제시 댓글 여부확인
	int recDelComment(HashMap<String, String> map);// 글 삭제시 댓글 포함 삭제
	int getRecTotalCount(HashMap<String, String> map);// ===== 총 게시물 건수 구하기													//       총 게시물 건수는 검색조건이 없을때와 있을때로 나뉘어진다. ===== 
	int add_recWithFile(BoardVO boardvo);//첨부파일이 있는 글쓰기
	List<HashMap<String, String>> recSearchWordCompleteList(HashMap<String, String> map);//추천게시판 검색하기
	int Edit_recWithFile(HashMap<String, String> map);// 글 수정시 파일첨부
	void rAlarmCommentAdd(HashMap<String, String> map);//알람 DB 추가
	int rAlarmCommentUpdate(AlarmVO alarmvo); //알람 boardSeq Update
	List<AlarmVO> rAlarmList(); //rec 알람목록 보여주기
	List<HashMap<String, String>> rZeroAlarmCount(HashMap<String, String> map);//recAlarm count update-->0
	int resultAlarm(HashMap<String, String> map);//resultAlarm DB 추가
	int resultAlarmCntUpdate(String userid); //resultAlarm resultCount 증감
	resultAlarmVO getResultAlarm(String userid); //알람창 결과 띄우기
	
	
	//together 게시판
	List<BoardVO> togetherBoardList(HashMap<String, String> map);//글 목록보여주기
	int getTogTotalCount(HashMap<String, String> map);// ===== 총 게시물 건수 구하기	
	int togetherAdd(BoardVO boardvo);//글쓰기
	int add_togWithFile(BoardVO boardvo);//첨부파일이 있는 글쓰기
	void setTogAddReadCount(String seq);//글 1개볼 때 조회수 증가
	BoardVO getTogetherView(String seq);// 1개글 보기
	List<CommentVO> togListComment(String parentSeq);//댓글추가
	int togUpdateContent(HashMap<String, String> map);//글 수정하기
	int Edit_togWithFile(HashMap<String, String> map);//글 수정시 파일첨부
	int togIsExistsComment(HashMap<String, String> map);//원 게시글에 딸린 댓글 여부확인
	int togDelContent(HashMap<String, String> map);// 글 1개 삭제(수정으로 처리)하기
	int togDelComment(HashMap<String, String> map);// ===== 원게시글에 딸린 댓글들 삭제하기 ===== 
	int togAddComment(CommentVO commentvo);//댓글쓰기
	int togUpdateCommentCount(String parentSeq);// 댓글쓰기 이후에 댓글의 갯수(commentCount 컬럼) 1 증가 하기 =====
	List<HashMap<String, String>> togSearchWordCompleteList(HashMap<String, String> map);//추천게시판 검색하기
	void tAlarmCommentAdd(HashMap<String, String> map); //함께해요 게시판 알람 DB 추가
	List<HashMap<String, String>> tZeroAlarmCount(HashMap<String, String> map);//togetherAlarm count update-->0
	int tAlarmCommentUpdate(AlarmVO alarmvo); //t_alarm count 증감
	int t_resultAlarm(HashMap<String, String> map); //resultAlarm에 추가
	int t_resultAlarmCntUpdate(String writer);
	
	
	//worrying 게시판
	List<BoardVO> worryingBoardList(HashMap<String, String> map);//글 목록 보여주기
	int getWorTotalCount(HashMap<String, String> map);// ===== 총 게시물 건수 구하기//       총 게시물 건수는 검색조건이 없을때와 있을때로 나뉘어진다. =====
	int worryingAdd(BoardVO boardvo);//글쓰기
	int add_worWithFile(BoardVO boardvo);//파일이 있을시 글 추가
	BoardVO getWorryingView(String seq); //글 1개 보여주기
	void setWorAddReadCount(String seq);//글 카우트 올려주기
	List<CommentVO> worListComment(String parentSeq);// 댓글보여주기
	int worUpdateContent(HashMap<String, String> map);//1개글 수정하기
	int Edit_worWithFile(HashMap<String, String> map);//파일 첨부와 함께 글 수정
	int worIsExistsComment(HashMap<String, String> map); // 댓글이 잇는지 없는지 확인
	int worDelContent(HashMap<String, String> map); //글 삭제
	int worDelComment(HashMap<String, String> map);//글 삭제시 댓글 삭제
	int worAddComment(CommentVO commentvo);//댓글쓰기
	int worUpdateCommentCount(String parentSeq);	 // 댓글쓰기 이후에 댓글의 갯수(commentCount 컬럼) 1 증가 하기 =====
	List<HashMap<String, String>> worSearchWordCompleteList(HashMap<String, String> map);//검색하기
	void wAlarmCommentAdd(HashMap<String, String> map);//위험해요 게시판 알람 DB 추가
	int w_resultAlarm(HashMap<String, String> map);//worrying 내용물 resultAlarm DB 추가
	List<HashMap<String, String>> wZeroAlarmCount(HashMap<String, String> map); //worrying Alarm 카운트 0
	int w_resultAlarmCntUpdate(String writer); //worrying count 에 따른 result count 증감
	int wAlarmCommentUpdate(AlarmVO alarmvo); //worrying 게시판 작성시 count 1 증가
	
	
	List<BoardVO> rBoardList();//추천게시판 정보 간단히 가져오기
	List<AlarmVO> tAlarmList();//함께해요게시판 간간하게 가져오기
	List<AlarmVO> wAlarmList();//위험해요 게시판 간단하게 정보 가져오기
	
	//이전글 다음글
	List<HashMap<String, String>> getPrevNext(HashMap<String, String> pre_next_map);
	
	
	
	int rchkLike(HashMap<String, String> map);//기존 추천여부 확인
	int rinsertLike(HashMap<String, String> map);//추천게시판 추천하기
	int rChkDislike(HashMap<String, String> map);//추천게시판 비추천 여부 확인
	int rInsertDislike(HashMap<String, String> map);//추천게시판 비추천하기
	String getrLikeCnt(String seq);//추천수 알아오기
	String getrDislikeCnt(String seq);//비추천수 알아오기
	
	
	int tChkLike(HashMap<String, String> map);//함께해요 게시판 추천체크
	int tInsertLike(HashMap<String, String> map);//함께해요 추천하기
	int tChkDislike(HashMap<String, String> map);//함께해요 비추천체크
	int tInsertDislike(HashMap<String, String> map);//함께해요 비추천하기
	String gettLikeCnt(String seq);//함께해요게시판 추천수 가져오기
	String gettDislikeCnt(String seq);//함께해요게시판 비추천수 가져오기
	
	
	int wChkLike(HashMap<String, String> map);//위험해요게시판 추천체크
	int wInsertLike(HashMap<String, String> map);//위험해요게시판 추천하기
	int wChkDislike(HashMap<String, String> map);//위험해요게시판 비추천 체크
	int wInsertDislike(HashMap<String, String> map);//위험해요게시판 비추천하기
	String getwDislikeCnt(String seq);//위험해요게시판 추천수 가져오기
	String getwLikeCnt(String seq);//위험해요게시판 추천수 가져오기
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	
	

}
