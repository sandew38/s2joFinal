package com.s2jo.khx.service.jsb;

import java.util.HashMap;
import java.util.List;

import com.s2jo.khx.model.jsb.AlarmVO;
import com.s2jo.khx.model.jsb.BoardVO;
import com.s2jo.khx.model.jsb.CommentVO;
import com.s2jo.khx.model.jsb.resultAlarmVO;

public interface InterJsbService {

	//recommend 게시판
	int recommendAdd(BoardVO boardvo); //추천게시판에 글 추가
	List<BoardVO> recommendBoardList(HashMap<String, String> map);//글보여주기
	BoardVO getRecommendView(String seq); //글 1개 보여주기(최초)
	BoardVO getRecViewWithNoAddCount(String seq); //조회수증가없이 글1개 보여주기
	int recommendEdit(HashMap<String, String> map); //글 수정하기
	int recommendDel(HashMap<String, String> map) throws Throwable; //글 삭제하기
	int recAddComment(CommentVO commentvo) throws Throwable;//댓글쓰기
	List<CommentVO> recListComment(String seq);//댓글 보이기
	int getRecTotalCount(HashMap<String, String> map);	// === 총 게시물 건수 구하기												//             총 게시물 건수는 검색조건이 없을때와 있을때로 나뉘어진다. ===== 
	int add_recWithFile(BoardVO boardvo);//데이터가 있는 글쓰기
	List<HashMap<String, String>> recSearchWordCompleteList(HashMap<String, String> map);//추천게시판 검색기능
	int Edit_recWithFile(HashMap<String, String> map);//파일 첨부시 글수정
	void rAlarmCommentAdd(HashMap<String, String> map);//rec알람 DB 추가
	int rAlarmCommentUpdate(AlarmVO alarmvo);//Alarm BoardSeq Update
	List<AlarmVO> rAlarmList();//알람리스트 보여주기
	List<HashMap<String, String>> rZeroAlarmCount(HashMap<String, String> map);//Alarm BoardSeq Update-->0
	int resultAlarm(HashMap<String, String> map); // resultAlarm DB 추가 
	int resultAlarmCntUpdate(String userid);//resultAlarm resultCount 수치 증감
	resultAlarmVO getResultAlarm(String userid); // result alarm 결과
	
	
	//together 게피판
	List<BoardVO> togetherBoardList(HashMap<String, String> map);//글보여주기
	int getTogTotalCount(HashMap<String, String> map);// === 총 게시물 건수 구하기	
	int togetherAdd(BoardVO boardvo);//글쓰기
	int add_togWithFile(BoardVO boardvo);//첨부파일 있는 글쓰기
	BoardVO getTogetherView(String seq);//글 1개 보여주기
	BoardVO getTogViewWithNoAddCount(String seq); //조회수 증가 없이 1개 글 보여주기
	List<CommentVO> togListComment(String seq);// =====  댓글내용 보여주기 =====
	int togetherEdit(HashMap<String, String> map);//	// =====  1개글 수정하기 ===== 
	int Edit_togWithFile(HashMap<String, String> map);//파일 첨부 시 글 수정
	int togetherDel(HashMap<String, String> map) throws Throwable;//  1개 글삭제하기 =====	
	int togAddComment(CommentVO commentvo) throws Throwable; //댓글추가하기
	List<HashMap<String, String>> togSearchWordCompleteList(HashMap<String, String> map);//검색하기
	void tAlarmCommentAdd(HashMap<String, String> map); // 함께해요게시판 알람 DB추가
	List<HashMap<String, String>> tZeroAlarmCount(HashMap<String, String> map);//Alarm BoardSeq Update-->0
	int tAlarmCommentUpdate(AlarmVO alarmvo); //t_alarm count 테이블 증감
	int t_resultAlarm(HashMap<String, String> map);//resultAlarm에 데이터 추가
	int t_resultAlarmCntUpdate(String writer); // togeter
	
	//worrying 게시판
	List<BoardVO> worryingBoardList(HashMap<String, String> map);//글목록보여주기
	int getWorTotalCount(HashMap<String, String> map);// ===== 총 게시물 건수 구하기 //       총 게시물 건수는 검색조건이 없을때와 있을때로 나뉘어진다. ===== 
	int worryingAdd(BoardVO boardvo);//글 추가하기
	int add_worWithFile(BoardVO boardvo);//파일이 있을 시 글 추가
	BoardVO getworryingView(String seq);//글 1개 보기
	BoardVO getWorViewWithNoAddCount(String seq);//조회수증가 없이
	List<CommentVO> worListComment(String seq);//댓글보여주기
	int worryingEdit(HashMap<String, String> map);//1개 글 수정하기
	int Edit_worWithFile(HashMap<String, String> map);//파일 첨부와 함께 글 수정
	int worryingDel(HashMap<String, String> map) throws Throwable; // 글 삭제
	int worAddComment(CommentVO commentvo) throws Throwable; //댓글 쓰기
	List<HashMap<String, String>> worSearchWordCompleteList(HashMap<String, String> map);// 검색하기
	void wAlarmCommentAdd(HashMap<String, String> map); // 위험해요게시판 알람 DB 추가
	int w_resultAlarm(HashMap<String, String> map);//resultAlarm DB 에 추가
	List<HashMap<String, String>> wZeroAlarmCount(HashMap<String, String> map);//Alarm BoardSeq Update-->0
	int w_resultAlarmCntUpdate(String writer); //worrying 게시판 count 에 따른 resultAlarm count 증감
	int wAlarmCommentUpdate(AlarmVO alarmvo); //worrying comment 증가시 count 1 증가
	
	List<BoardVO> rBoardList(); //추천게시판 간단히 정보 가져오기
	List<AlarmVO> tAlarmList(); //함께해요게시판 간단히 정보 가져오기
	List<AlarmVO> wAlarmList(); //위험해요게시판 간단히 정보 가져오기
	
	
	//이전글 다음글 불러오기
	List<HashMap<String, String>> getPrevNext(HashMap<String, String> pre_next_map);
	
	
	
	
	int rInsertLike(HashMap<String, String> map);//추천게시판 추천하기
	int rInsertDislike(HashMap<String, String> map);//추천게시판 비추천하기
	String getrLikeCnt(String seq);//추천수 알아오기
	String getrDislikeCnt(String seq);//비추천수 알아오기
	
	
	int tInsertLike(HashMap<String, String> map);//함께해요 게시판 추천하기
	int tInsertDislike(HashMap<String, String> map);//함께헤요 게시판 비추천하기
	String gettLikeCnt(String seq);//함께해요 게시판 추천수 가져오기
	String gettDislikeCnt(String seq);	//함께해요 게시판 비추천수 가져오기
	
	
	int wInsertLike(HashMap<String, String> map);//위험해요게시판 추천하기
	int wInsertDislike(HashMap<String, String> map);//위험해요게시판 비추천하기
	String getwLikeCnt(String seq);//위험해요게시판 좋아요 카운트세기
	String getwDislikeCnt(String seq);//위험해요게시판 비추천수 가져오기
	
	
	
	
	

	
	
	
	
	

	

	


	
	
	
	
		

	

}
