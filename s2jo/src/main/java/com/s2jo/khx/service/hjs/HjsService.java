package com.s2jo.khx.service.hjs;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.s2jo.khx.model.hjs.HjsDAO;
import com.s2jo.khx.model.hjs.reviewBoardVO;
import com.s2jo.khx.model.hjs.reviewCommentVO;


//===== Service 선언 =====
@Service
public class HjsService implements InterHjsService {

	//	=====  의존객체 주입하기(DI : Dependency Injection) =====
	@Autowired
	private HjsDAO dao;
	
	
	// 기차역목록 보여주기
	@Override
	public List<String> getStationList() {
		
		List<String> stationList = dao.getStationList();
		return stationList;
	}

	
	// 기차역 이용후기 쓰기 (첨부파일 x)
	@Override
	public int addReview(reviewBoardVO rboardvo) {
		
		int n = dao.addReview(rboardvo);
		return n;
	}

	
	// 기차역 이용후기 쓰기 (첨부파일 o)
	@Override
	public int addReview_withFile(reviewBoardVO rboardvo) {

		int n = dao.addReview_withFile(rboardvo); // 첨부파일이 있는 경우 
		return n;
	}

	 
	// 기차역 이용후기 목록 보여주기 
	@Override
	public List<reviewBoardVO> getRboardList(HashMap<String, String> map) {

		List<reviewBoardVO> rboardList = dao.getRboardList(map);
		return rboardList;
	}


	// (먼저 조회수 1 증가한 후) 게시글 1개 보여주기
	@Override
	public reviewBoardVO getView(String seq) {
		
		dao.setAddReadCount(seq); // 글 조회수 1증가
		reviewBoardVO rboardvo = dao.getView(seq); // 글 1개를 보여주는것
		
		return rboardvo;
	}


	// 게시글 1개 보여주기 (조회수 1 증가 없이)
	@Override
	public reviewBoardVO getViewWithoutCount(String seq) {

		reviewBoardVO rboardvo = dao.getView(seq); // 글 1개를 보여주는것
		return rboardvo;
	}


	// 글 수정하기
	@Override
	public int editReview(HashMap<String, String> map) {
		
		// 폼에서 입력받은 글번호 및 암호가 
		// DB에 저장되어진 글번호의 암호와 같은지
		// 판단해야 한다.
		// 일치하면 true 반환할 것이고,
		// 일치하지 않으면 false 를 반환해주는
		// DAO 의 checkPW() 메소드를 호출한다.
		
		boolean bool = dao.checkPW(map);
		// 글번호에 대한 암호가 일치하면 true 반환.
		// 글번호에 대한 암호가 일치하지 않으면 false 반환. 
		
		int n = 0;
		
		if(bool) {
			n = dao.updateContent(map); // 글 1개 수정하기 
		}
		return n;
	}

	
	// 글 삭제하기 
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int delReview(HashMap<String, String> map) 
		throws Throwable {
		
		boolean checkpw = dao.checkPW(map);
		// 글번호에 대한 암호가 일치하면 true 반환.
		// 글번호에 대한 암호가 일치하지 않으면 false 반환. 

		int count = 0;
		int result1 = 0;
		int result2 = 0;
		
		int n = 0;
		
		if(checkpw){
			count = dao.isExistsComment(map); // ===== #97. 원게시글에 딸린 댓글이 있는지 없는지를 확인하기 =====
			
			result1 = dao.delContent(map); // 글 1개 삭제(수정으로 처리)하기
		
			if(count > 0) {
				result2 = dao.delComment(map); // ===== #98. 원게시글에 딸린 댓글들 삭제하기 ===== 
			}
		}
		
		if( (result1 > 0 && (count > 0 && result2 > 0) ) || 
	        (result1 > 0 && count == 0)	) {
			n = 1;
		}
					
		return n;		
		
	}

	
	// 댓글쓰기 
	/*
	   spring_tblComment 테이블에 insert 된 다음에
	   spring_tblBoard 테이블에 commentCount 컬럼이 1증가(update) 되도록 요청한다.
	   즉, 2개 이상의 DML 처리를 해야하므로 Transaction 처리를 해야 한다.
	   >>>> 트랜잭션처리를 해야할 메소드에 @Transactional 어노테이션을 설정하면 된다.
	   // rollbackFor={Throwable.class} 은 롤백을 해야할 범위를 말하는데 Throwable.class 은 error 및 exception 을 포함한 최상위 루트이다. 
	      즉, 해당 메소드 실행시 발생하는 모든 error 및 exception 에 대해서 롤백을 하겠다는 말이다. 
	 */
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int addReviewComment(reviewCommentVO rcommentvo) throws Throwable {
		int n = 0;
		n = dao.addReviewComment(rcommentvo);
		
		int result = 0;
		
		if(n==1) {
		    result = dao.updateCommentCount(rcommentvo.getParentSeq());
		}
		
		return result;
	}


	// 댓글 보여주기
	@Override
	public List<reviewCommentVO> listComment(String seq) {
		List<reviewCommentVO> list = dao.listComment(seq);
		return list;
	}


	// ===== 총 게시물 건수 구하기
	//       총 게시물 건수는 검색조건이 없을때와 있을때로 나뉘어진다. ===== 
	@Override
	public int getTotalCount(HashMap<String, String> map) {
		int count = dao.getTotalCount(map);
		return count;
	}


	// 관광지 리뷰 추천하기
	@Override
	public int insertLike(HashMap<String, String> map) {
		int n = 0;
		int cnt = dao.chkLike(map);
		
		if(cnt == 0){
			n = dao.insertLike(map);
		}
		
		return n;
	}


	// 관광지 리뷰 비추천하기
	@Override
	public int insertDislike(HashMap<String, String> map) {
		int n = 0;
		int cnt = dao.chkDislike(map);
		
		if(cnt == 0){
			n = dao.insertDislike(map);
		}
		
		return n;
	}


	// 관광지 리뷰 추천수 알아오기
	@Override
	public String getLikeCnt(String seq) {
		String likeCnt = dao.getLikeCnt(seq);
		return likeCnt;
	}


	// 관광지 리뷰 비추천수 알아오기
	@Override
	public String getDislikeCnt(String seq) {
		String dislikeCnt = dao.getDislikeCnt(seq);
		return dislikeCnt;
	}


	// 이전글/다음글 알아오기
	@Override
	public List<HashMap<String, String>> getPrevNext(HashMap<String, String> map) {
		
		List<HashMap<String, String>> prevNextList = dao.getPrevNext(map);
		return prevNextList;
	}


	// 관광지 추천하기
	@Override
	public int insertTourLike(HashMap<String, String> map) {
		
		// 시도, 관광지 이름이 테이블에 있는지 알아오기
		int cnt = dao.chkTourLike(map);
		int n = 0;
		
		if(cnt == 0){ // 시도, 관광지 이름이 테이블에 없는 경우
			dao.insertTourName(map);
			n = dao.insertTourLike(map); // 관광지 추천하기(update)
		}
		else{ // 시도, 관광지 이름이 테이블에 있는 경우
			n = dao.insertTourLike(map); // 관광지 추천하기(update)
		}
		
		return n;
	}

  
	// 관광지 좋아요 수 알아오기
	@Override
	public String getTourLikeCnt(HashMap<String, String> map) {
		
		// 시도, 관광지 이름이 테이블에 있는지 알아오기
		int cnt = dao.chkTourLike(map);
		
		if(cnt == 0){ // 시도, 관광지 이름이 테이블에 없는 경우
			dao.insertTourName(map);
		}
		String likeCnt = dao.getTourLikeCnt(map);
		
		return likeCnt;
	}


	// 관광지 통계1
	@Override
	public List<HashMap<String, String>> getHjsStatistics1() {
		List<HashMap<String,String>> list = dao.getHjsStatistics1(); // 관광지 통계1
		
		return list;
	}






}
