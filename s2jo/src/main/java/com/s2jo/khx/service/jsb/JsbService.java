package com.s2jo.khx.service.jsb;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.s2jo.khx.model.jsb.AlarmVO;
import com.s2jo.khx.model.jsb.BoardVO;
import com.s2jo.khx.model.jsb.CommentVO;
import com.s2jo.khx.model.jsb.JsbDAO;
import com.s2jo.khx.model.jsb.resultAlarmVO;


@Service
public class JsbService implements InterJsbService{

//	=====  의존객체 주입하기(DI : Dependency Injection) =====
	@Autowired
	private JsbDAO dao;
	
	//글 추가하기(최초)
	@Override
	public int recommendAdd(BoardVO boardvo) {
		
		
		int n = dao.recommendAdd(boardvo);
		return n;
	}

	//글보여주기(중간)	
	@Override
	public List<BoardVO> recommendBoardList(HashMap<String, String> map) {
		List<BoardVO> recommendBoardList = dao.recommendBoardList(map);
		return recommendBoardList;
	}

	//글1개 보여주기
	@Override
	public BoardVO getRecommendView(String seq) {
		dao.setRecAddReadCount(seq); // 글 조회수 1증가
		BoardVO boardvo = dao.getRecommendView(seq); // 글 1개를 보여주는것
		
		return boardvo;
	}

	//  글 1개를 보여주는(조회수 1증가 없이) 서비스단 BoardVO getView(String seq) 메소드 생성하기 =====
	@Override
	public BoardVO getRecViewWithNoAddCount(String seq) {
			BoardVO boardvo = dao.getRecommendView(seq); // 글 1개를 보여주는것
		
		return boardvo;
	}

	// =====  1개글 수정하기 ===== 
	@Override
	public int recommendEdit(HashMap<String, String> map) {
			
			
			int n = 0;
			
		
			n = dao.recUpdateContent(map); // 글 1개 수정하기 
	
			
			return n;
			
		}

	//  1개 글삭제하기 =====	
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int recommendDel(HashMap<String, String> map) throws Throwable {
		int n = 0;
		int result2 = 0;
		
		int count = dao.recIsExistsComment(map); // =====  원게시글에 딸린 댓글이 있는지 없는지를 확인하기 =====
		
		int result1 = dao.recDelContent(map); // 글 1개 삭제(수정으로 처리)하기
		
		if(count > 0) {
				result2 = dao.recDelComment(map); // ===== 원게시글에 딸린 댓글들 삭제하기 ===== 
			
		
		}
		if( (result1 > 0 && (count > 0 && result2 > 0) ) || 
	        (result1 > 0 && count == 0)	) {
			n = 1;
		}
					
		return n;		
		
	}

	//댓글쓰기
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int recAddComment(CommentVO commentvo) 
		throws Throwable {
		
		int n = 0;
		n = dao.recAddComment(commentvo);
		
		int result = 0;
		
		if(n==1) {
		    result = dao.recUpdateCommentCount(commentvo.getParentSeq());
		}
		
		return result;
	}

	// =====  댓글내용 보여주기 =====
		@Override
		public List<CommentVO> recListComment(String seq) {
			List<CommentVO> list = dao.recListComment(seq);
			return list;
		}

		// ===== 총 게시물 건수 구하기
		//       총 게시물 건수는 검색조건이 없을때와 있을때로 나뉘어진다. ===== 
		@Override
		public int getRecTotalCount(HashMap<String, String> map) {
			int count = dao.getRecTotalCount(map);
			return count;
		}

		
		//첨부파일이 있는 글쓰기
		@Override
		public int add_recWithFile(BoardVO boardvo) {
		
				int n = dao.add_recWithFile(boardvo); // 첨부파일이 있는 경우 
				return n;
		}
		//파일 첨부 시 글 수정
		@Override
		public int Edit_recWithFile(HashMap<String, String> map) {
			int n = dao.Edit_recWithFile(map); // 첨부파일이 있는 경우 
			return n;
		}
		
		//검색하기
		@Override
		public List<HashMap<String, String>> recSearchWordCompleteList(HashMap<String, String> map) {
			if(!map.get("search").trim().isEmpty()) {
				List<HashMap<String, String>> list = dao.recSearchWordCompleteList(map);
				return list;
			}
			else {
				return null;
			}
		}
		
		//Alarm DB 추가
		@Override
		
		public void rAlarmCommentAdd(HashMap<String, String> map)  {
			dao.rAlarmCommentAdd(map);
			
			
		}

		//Alarm BoardSeq Update
		@Override
		public int rAlarmCommentUpdate(AlarmVO alarmvo) {
			int n = dao.rAlarmCommentUpdate(alarmvo);
			return n;
		}

		
		////////////////////////////////////////////////// together ////////////////////////////////////////////////////////////
		//together 게시판 보여주기
		@Override
		public List<BoardVO> togetherBoardList(HashMap<String, String> map) {
			List<BoardVO> togetherBoardList = dao.togetherBoardList(map);
			return togetherBoardList;
		}

		
		// ===== 총 게시물 건수 구하기
		//       총 게시물 건수는 검색조건이 없을때와 있을때로 나뉘어진다. ===== 
		@Override
		public int getTogTotalCount(HashMap<String, String> map) {
			int count = dao.getTogTotalCount(map);
			return count;
		}

		//글쓰기
		@Override
		public int togetherAdd(BoardVO boardvo) {
			int n = dao.togetherAdd(boardvo);
			return n;
		}

		//첨부파일이 있는 글쓰기
		@Override
		public int add_togWithFile(BoardVO boardvo) {
			int n = dao.add_togWithFile(boardvo); // 첨부파일이 있는 경우 
			return n;
		}
		
		//글 1개 보여주기
		@Override
		public BoardVO getTogetherView(String seq) {
			dao.setTogAddReadCount(seq); // 글 조회수 1증가
			BoardVO boardvo = dao.getTogetherView(seq); // 글 1개를 보여주는것
			
			return boardvo;
		}

		//조회수 증가 없이 1개글 보여주기
		@Override
		public BoardVO getTogViewWithNoAddCount(String seq) {
			BoardVO boardvo = dao.getTogetherView(seq); // 글 1개를 보여주는것
			
			return boardvo;
		}

		// =====  댓글내용 보여주기 =====
		@Override
		public List<CommentVO> togListComment(String seq) {
			List<CommentVO> list = dao.togListComment(seq);
			return list;
		}

		// =====  1개글 수정하기 ===== 
		@Override
		public int togetherEdit(HashMap<String, String> map) {
			int n = 0;

			n = dao.togUpdateContent(map); // 글 1개 수정하기 
	
			
			return n;
		}

		//파일 첨부 시 글 수정
		@Override
		public int Edit_togWithFile(HashMap<String, String> map) {
			int n = dao.Edit_togWithFile(map); // 첨부파일이 있는 경우 
			return n;
		}

	//  1개 글삭제하기 =====	
		@Override
		@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
		public int togetherDel(HashMap<String, String> map) throws Throwable {
			
			
			int n = 0;
			int result2 = 0;
			
			int count = dao.togIsExistsComment(map); // =====  원게시글에 딸린 댓글이 있는지 없는지를 확인하기 =====
			
			int result1 = dao.togDelContent(map); // 글 1개 삭제(수정으로 처리)하기
			
			if(count > 0) {
					result2 = dao.togDelComment(map); // ===== 원게시글에 딸린 댓글들 삭제하기 ===== 
				
			
			}
			if( (result1 > 0 && (count > 0 && result2 > 0) ) || 
		        (result1 > 0 && count == 0)	) {
				n = 1;
			}
						
			return n;
		}

		//댓글쓰기
		@Override
		@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
		public int togAddComment(CommentVO commentvo) throws Throwable {
				
				int n = 0;
				n = dao.togAddComment(commentvo);
				
				int result = 0;
				
				if(n==1) {
				    result = dao.togUpdateCommentCount(commentvo.getParentSeq());
				}
				
				return result;
		}

		//검색하기
		@Override
		public List<HashMap<String, String>> togSearchWordCompleteList(HashMap<String, String> map) {
			if(!map.get("search").trim().isEmpty()) {
				List<HashMap<String, String>> list = dao.togSearchWordCompleteList(map);
				return list;
			}
			else {
				return null;
			}
		}

		//글목록보여주기
		@Override
		public List<BoardVO> worryingBoardList(HashMap<String, String> map) {
			List<BoardVO> worryingBoardList = dao.worryingBoardList(map);
			return worryingBoardList;
		}

		// ===== 총 게시물 건수 구하기
		//       총 게시물 건수는 검색조건이 없을때와 있을때로 나뉘어진다. ===== 
		@Override
		public int getWorTotalCount(HashMap<String, String> map) {
			int count = dao.getWorTotalCount(map);
			return count;
		}

		//글 추가하기
		@Override
		public int worryingAdd(BoardVO boardvo) {
			int n = dao.worryingAdd(boardvo);
			return n;
		}

		//파일이 있을 시 글 추가하기
		@Override
		public int add_worWithFile(BoardVO boardvo) {
			int n = dao.add_worWithFile(boardvo); // 첨부파일이 있는 경우 
			return n;
		}

		//글 1개 보기, 조회수 증가
		@Override
		public BoardVO getworryingView(String seq) {
			dao.setWorAddReadCount(seq); // 글 조회수 1증가
			BoardVO boardvo = dao.getWorryingView(seq); // 글 1개를 보여주는것
			
			return boardvo;
		}

		//조회수 증가 없이 
		@Override
		public BoardVO getWorViewWithNoAddCount(String seq) {
			BoardVO boardvo = dao.getWorryingView(seq); // 글 1개를 보여주는것
			
			return boardvo;
		}
		
		//댓글 보여주기
		@Override
		public List<CommentVO> worListComment(String seq) {
			List<CommentVO> list = dao.worListComment(seq);
			return list;
		}

		//1개글 수정하기
		@Override
		public int worryingEdit(HashMap<String, String> map) {
			int n = 0;
			
			
			n = dao.worUpdateContent(map); // 글 1개 수정하기 
	
			
			return n;
		}

		//파일첨부와 함께 글 수정
		@Override
		public int Edit_worWithFile(HashMap<String, String> map) {
			int n = dao.Edit_worWithFile(map); // 첨부파일이 있는 경우 
			return n;
		}

		//글 삭제
	//  1개 글삭제하기 =====	
		@Override
		@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
		public int worryingDel(HashMap<String, String> map) throws Throwable {
			int n = 0;
			int result2 = 0;
			
			int count = dao.worIsExistsComment(map); // =====  원게시글에 딸린 댓글이 있는지 없는지를 확인하기 =====
			
			int result1 = dao.worDelContent(map); // 글 1개 삭제(수정으로 처리)하기
			
			if(count > 0) {
					result2 = dao.worDelComment(map); // ===== 원게시글에 딸린 댓글들 삭제하기 ===== 
				
			
			}
			if( (result1 > 0 && (count > 0 && result2 > 0) ) || 
		        (result1 > 0 && count == 0)	) {
				n = 1;
			}
						
			return n;		
		}

		//댓글쓰기
		@Override
		@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
		public int worAddComment(CommentVO commentvo) throws Throwable {
			int n = 0;
			n = dao.worAddComment(commentvo);
			
			int result = 0;
			
			if(n==1) {
			    result = dao.worUpdateCommentCount(commentvo.getParentSeq());
			}
			
			return result;
		}

		//검색하기
		@Override
		public List<HashMap<String, String>> worSearchWordCompleteList(HashMap<String, String> map) {
			if(!map.get("search").trim().isEmpty()) {
				List<HashMap<String, String>> list = dao.worSearchWordCompleteList(map);
				return list;
			}
			else {
				return null;
			}
		}

		
		//recAlarm 목록 보여주기
		@Override
		public List<AlarmVO> rAlarmList() {
			List<AlarmVO> rAlarmList = dao.rAlarmList();
			return rAlarmList;
		}

		//recAlarm count 0으로 만들기
		@Override
		public List<HashMap<String, String>> rZeroAlarmCount(HashMap<String, String> map) {
			List<HashMap<String, String>> list = dao.rZeroAlarmCount(map);
			return list;
		}

		//resultAlarm DB 추가
		@Override
		public int  resultAlarm(HashMap<String, String> map) {
			int n = dao.resultAlarm(map);
			return n;
		}

		@Override
		public int resultAlarmCntUpdate(String writer) {
			int n= dao.resultAlarmCntUpdate(writer);
			return n;
		}

		//resultAlarm DB 가져오기
		@Override
		public resultAlarmVO getResultAlarm(String userid) {
			resultAlarmVO getResultAlarm = dao.getResultAlarm(userid);
			return getResultAlarm;
		}

		//recommendBoard DB 가져오기
		@Override
		public List<BoardVO> rBoardList() {
			List<BoardVO> rBoardList = dao.rBoardList();
			return rBoardList;
		}

		//함께해요게시판 알람 댓글 DB추가 
		@Override
		public void tAlarmCommentAdd(HashMap<String, String> map) {
			dao.tAlarmCommentAdd(map);
			
		}

		//함께해요게시판 알람 DB 0으로 업데이트
		@Override
		public List<HashMap<String, String>> tZeroAlarmCount(HashMap<String, String> map) {
			List<HashMap<String, String>> list = dao.tZeroAlarmCount(map);
			return list;
		}

		//r_alarm table 증감
		@Override
		public int tAlarmCommentUpdate(AlarmVO alarmvo) {
			int n = dao.tAlarmCommentUpdate(alarmvo);
			return n;
		}

		//함께해요 게시판 DB 가져오기
		@Override
		public List<AlarmVO> tAlarmList() {
			List<AlarmVO> tAlarmList = dao.tAlarmList();
			return tAlarmList;
		}
		//together Alarm DB 추가
		@Override
		public int t_resultAlarm(HashMap<String, String> map) {
			int n = dao.t_resultAlarm(map);
			return n;
		}
		//together Alarm => resultAlarm 에 추가(count 증감)
		@Override
		public int t_resultAlarmCntUpdate(String writer) {
			int n= dao.t_resultAlarmCntUpdate(writer);
			return n;
		}

		
		
		
		//worring Alarm DB 생성
		@Override
		public void wAlarmCommentAdd(HashMap<String, String> map) {
			dao.wAlarmCommentAdd(map);
			
		}

		//resultAlarm에 worryingAlarm DB 추가
		@Override
		public int w_resultAlarm(HashMap<String, String> map) {
			int n = dao.w_resultAlarm(map);
			return n;
		}

		//worrying count 0 만들기
		@Override
		public List<HashMap<String, String>> wZeroAlarmCount(HashMap<String, String> map) {
			List<HashMap<String, String>> list = dao.wZeroAlarmCount(map);
			return list;
		}

		//resultAlarm에 worrying count 0 만들기
		@Override
		public int w_resultAlarmCntUpdate(String writer) {
			int n= dao.w_resultAlarmCntUpdate(writer);
			return n;
		}
		
		//worrying 게시판 comment 작성시 count 1증가
		@Override
		public int wAlarmCommentUpdate(AlarmVO alarmvo) {
			int n = dao.wAlarmCommentUpdate(alarmvo);
			return n;
		}

		//간단하게 worrying 게시판 정보 가저오기
		@Override
		public List<AlarmVO> wAlarmList() {
			List<AlarmVO> wAlarmList = dao.wAlarmList();
			return wAlarmList;
		}

		//이전글 다음글
		@Override
		public List<HashMap<String, String>> getPrevNext(HashMap<String, String> pre_next_map) {
			List<HashMap<String, String>> getPrevNext = dao.getPrevNext(pre_next_map);
			return getPrevNext;
		}

		//추천게시판 추천하기
		@Override
		public int rInsertLike(HashMap<String, String> map) {
			int n = 0;
			int cnt = dao.rchkLike(map);
			
			if(cnt == 0){
				n = dao.rinsertLike(map);
			}
			
			return n;
		}

		//추천게시판 비추천하기
		@Override
		public int rInsertDislike(HashMap<String, String> map) {
			int n = 0;
			int cnt = dao.rChkDislike(map);
			
			if(cnt == 0){
				n = dao.rInsertDislike(map);
			}
			
			return n;
		}

		//추천수 알아오기
		@Override
		public String getrLikeCnt(String seq) {
			String likeCnt = dao.getrLikeCnt(seq);
			return likeCnt;
		}
		//비추천수 알아오기
		@Override
		public String getrDislikeCnt(String seq) {
			String rdislikeCnt = dao.getrDislikeCnt(seq);
			return rdislikeCnt;
		}

		
		//함께해요 추천하기
		@Override
		public int tInsertLike(HashMap<String, String> map) {
			int n = 0;
			int cnt = dao.tChkLike(map);
			
			if(cnt == 0){
				n = dao.tInsertLike(map);
			}
			
			return n;
		}

		//함께해요 비추천하기
		@Override
		public int tInsertDislike(HashMap<String, String> map) {
			int n = 0;
			int cnt = dao.tChkDislike(map);
			
			if(cnt == 0){
				n = dao.tInsertDislike(map);
			}
			
			return n;
		}

		//함께해요 게시판 추천수 가져오기
		@Override
		public String gettLikeCnt(String seq) {
			String likeCnt = dao.gettLikeCnt(seq);
			return likeCnt;
		}
		
		//함께해요 게시판 비추천수 가져오기
		@Override
		public String gettDislikeCnt(String seq) {
			String rdislikeCnt = dao.gettDislikeCnt(seq);
			return rdislikeCnt;
		}


		//위험해요 게시판 추천하기
		@Override
		public int wInsertLike(HashMap<String, String> map) {
			int n = 0;
			int cnt = dao.wChkLike(map);
			
			if(cnt == 0){
				n = dao.wInsertLike(map);
			}
			
			return n;
		}

		//위험해요게시판 비추천하기
		@Override
		public int wInsertDislike(HashMap<String, String> map) {
			int n = 0;
			int cnt = dao.wChkDislike(map);
			
			if(cnt == 0){
				n = dao.wInsertDislike(map);
			}
			
			return n;
		}

		//위험해요게시판 좋아요 카운트세기
		@Override
		public String getwLikeCnt(String seq) {
			String likeCnt = dao.getwLikeCnt(seq);
			return likeCnt;
		}

		//위험해요게시판 비추천수 가져오기
		@Override
		public String getwDislikeCnt(String seq) {
			String rdislikeCnt = dao.getwDislikeCnt(seq);
			return rdislikeCnt;
		}



		
		

}
