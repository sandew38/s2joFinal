package com.s2jo.khx.service.kyj;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.annotation.SessionScope;

import com.s2jo.khx.model.kyj.KhxDAO;
import com.s2jo.khx.model.kyj.RuninfoVO;
import com.s2jo.khx.model.kyj.TrainviewVO;
import com.s2jo.khx.model.psc.khxpscMemberVO;
import com.s2jo.khx.model.psc.khxpscNonMemberVO;

//	==== #30. Service 선언 ====

@Service
public class KhxService implements InterKhxService {

//	==== #31. 의존객체 주입하기 (DI : Dependency Injection) ====
	
	@Autowired
	private KhxDAO kdao;

	
//	==== #41. 메인 페이지용 이미지 파일 이름을 가져오는 서비스단 public List<String> getImgfilenameList() 메소드 생성하기
// 			이미지 파일명 가져오기
	@Override
	public List<String> getImgfilenameList() {
		
		 List<String> list = kdao.getImgfilenameList();
		 
		 return list;
	
		 
	}

// ==== 출발지 리스트를 알아오는 메소드 
	@Override
	public List<String> departureList() {
		
		 List<String> departureList = kdao.departureList();
		 
		 return departureList;
	}	
	
	
// ==== 도착지 리스트를 알아오는 메소드 
	@Override
	public List<String> arrivalList() {
		
		 List<String> arrivalList = kdao.arrivalList();
		 
		 return arrivalList;
	}	

	
// ==== 열차 운행 정보 알아오는 메소드
/*
	@Override
	public List<TrainviewVO> trainList(String traintype, String departure, String arrival) {

		List<TrainviewVO> trainList = kdao.trainList(traintype, departure, arrival);
		
		return trainList;
	}
	*/

// ==== 열차 운행 정보 알아오는 메소드
	@Override
	public List<HashMap<String, Object>> trainList(HashMap<String, Object> map) {
		
		List<HashMap<String, Object>> trainList = kdao.trainList(map);
		
		return trainList;
	}

//	==== 남은 좌석 수 알아오기 
	@Override
	public int getremainseatcnt(HashMap<String, Object> map) {

		int n = kdao.getremainseatcnt(map);
		
		return n ;

	}

//	==== 팔린 좌석 목록 가져오기
	@Override
	public List<String> gettakenseatList(HashMap<String, Object> map) {

		List<String> takenseatList = kdao.gettakenseatList(map);
		
		return takenseatList;
	}
	
//	==== 팔린 좌석 목록 가져오기 (좌석번호별)
	@Override
	public List<String> getseatList(HashMap<String, Object> map) {

		List<String> seatList = kdao.getseatList(map);
		
		return seatList;
	}
	
//	==== yj 회원 로그인 여부 확인
	@Override
	public int loginEnd(HashMap<String, String> map) {
		
		int n= kdao.loginEnd(map);
		
		return n;
	}
	
//	==== yj 회원 로그인완료 요청
	@Override
	public khxpscMemberVO getLoginEnd(String userid) {
		khxpscMemberVO loginuser = kdao.getLoginEnd(userid);
		return loginuser;
	}
	
//	==== 비회원 로그인여부 확인
	@Override
	public int nonloginEnd(HashMap<String, String> map) {
		int n= kdao.nonloginEnd(map);
		return n;
	}
	
//	==== 비회원 정보 가져오기
	@Override
	public khxpscNonMemberVO getNonLoginEnd(String nhp) {
		khxpscNonMemberVO nonloginuser = kdao.getNonLoginEnd(nhp);
		return nonloginuser;
	}

//	==== 열차번호, 출발지, 도착지로 runinfoseq 가져오기 
	@Override
	public int getruninfoseq(HashMap<String, Object> map) {
		
		int runinfoseq = kdao.getruninfoseq(map);
		
		return runinfoseq;

	}

//	==== 좌석 테이블(final_seat)에 예약한 좌석 넣어주기	
	@Override
	public int insertseats(HashMap<String, Object> map) {

		int insertseats = kdao.insertseats(map);
		
		return insertseats;
	}
	
//	==== 티켓 개요 테이블에 INSERT 하기 
	@Override
	public int insertticketsum(HashMap<String, Object> map) {
		
		String userid = (String)map.get("userid");
		String nonno = String.valueOf((map.get("nonno")));
		
		int n = 0;
		
		if(!"null".equals(userid))
		{	//	회원인 경우
			n =  kdao.insertticketsum(map);			
		}
		else if(!"null".equals(nonno))
		{
			n =  kdao.noninsertticketsum(map);			
		}
		
		
		return n;
		
	}
	
//	결제 테이블에 INSERT 하기 
	@Override
	public int insertpaysum(HashMap<String, Object> map) {
		
		int insertpaysum = kdao.insertpaysum(map);
		
		return insertpaysum;
	}
	
//	티켓 개요 테이블에서 주문번호 시퀀스 갖고오기
	@Override
	public int getorderseq(HashMap<String, Object> map) {
		
		int getorderseq = kdao.getorderseq(map);
		
		return getorderseq;

	}

//	결제 테이블에서 결제코드번호 시퀀스 갖고오기
	@Override
	public int getpaymentcode(HashMap<String, Object> map) {
		
		int getpaymentcode = kdao.getpaymentcode(map);
		
		return getpaymentcode;
		
	}

//	좌석번호시퀀스 seatseq 가져오기
	@Override
	public int getseatseq() {

		int getseatseq = kdao.getseatseq();
		
		return getseatseq;
	}

// 티켓 상세 테이블에 INSERT 하기 (final_ticketdetail)
	@Override
	public int insertticketdet(HashMap<String, Object> map) {

		int insertticketdet = kdao.insertticketdet(map);
		
		return insertticketdet;
	}

// TICKETNO 가져오기
	@Override
	public int getticketno() {
		
		int getticketno = kdao.getticketno();
		
		return getticketno;
	}
	
// 결제 상세 테이블에 INSERT 해주기
	@Override
	public int insertpaydet(HashMap<String, Object> map) {
		
		int insertpaydet = kdao.insertpaydet(map);
		
		return insertpaydet;
		
	}

// 비회원 테이블에 INSERT 해주기
	@Override
	public int insertnonmember(HashMap<String, String> map) {

		int n = kdao.insertnonmember(map);
		
		return n;
	}

// 비회원번호 (nonno) 알아와서 session에 넣어둔다.
	@Override
	public String getnonno(String nhp) {

		String getnonno = kdao.getnonno(nhp);
		
		return getnonno;
	}

	
//	====	#149. Ajax로 검색어 입력시 자동글 완성하기 ④	====
	@Override
	public List<HashMap<String, String>> searchWordCompleteList(HashMap<String, String> map) {

		System.out.println("★★★ : "+ map.get("search"));
		
		if(!map.get("search").trim().isEmpty())
		{
			List<HashMap<String, String>> List = kdao.searchWordCompleteList(map);
			 
			return List;			
		}
		else
		{
			return null;
		}
		
	}

// ====	비회원 가입 가능한지 알아오기
	@Override
	public int noncheck(String nhp) {
		
		int noncheck = kdao.noncheck(nhp);
		
		return noncheck;
	}

	
} // end of public class BoardService implements InterBoardService ----
