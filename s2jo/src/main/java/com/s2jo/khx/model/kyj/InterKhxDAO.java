package com.s2jo.khx.model.kyj;

import java.util.HashMap;
import java.util.List;

import com.s2jo.khx.model.psc.khxpscMemberVO;
import com.s2jo.khx.model.psc.khxpscNonMemberVO;


// model 단 (DAO)의 인터페이스 생성

public interface InterKhxDAO {

	List<String> getImgfilenameList();	// 이미지 파일명 가져오기
	
	List<String> departureList();	// 출발지 목록 가져오기 
	
	List<String> arrivalList();	// 도착지 목록 가져오기 
	
	List<HashMap<String, Object>> trainList(HashMap<String, Object> map);	// 기차 운행 정보 가져오기

	int getremainseatcnt(HashMap<String, Object> map); // 남은 좌석 수 알아오기
	
	List<String> gettakenseatList(HashMap<String, Object> map); // 팔린 좌석 목록 가져오기
	
	List<String> getseatList(HashMap<String, Object> map); // 팔린 좌석 목록 가져오기 (좌석번호별)
	
	int loginEnd(HashMap<String, String> map);	//	yj 정회원 로그인 여부 확인
	
	khxpscMemberVO getLoginEnd(String userid); // yj 로그인한 정회원 아이디 가져오기
	
	int getruninfoseq(HashMap<String, Object> map); // 출발지, 도착지, 열차번호로 runinfoseq 가져오기

	khxpscNonMemberVO getNonLoginEnd(String nhp);

	int nonloginEnd(HashMap<String, String> map);
	
	int insertseats(HashMap<String, Object> map); //	좌석 테이블(final_seat)에 예약한 좌석 넣어주기	
	
	int insertticketsum(HashMap<String, Object> map);	//	티켓 개요 테이블에 INSERT 하기 

	int insertpaysum(HashMap<String, Object> map);	//	결제 테이블에 INSERT 하기 
	
	int getorderseq(HashMap<String, Object> map);	//	티켓 개요 테이블에서 주문번호 시퀀스 갖고오기 

	int getpaymentcode(HashMap<String, Object> map);	//	결제 테이블에서 결제코드번호 시퀀스 갖고오기
	
	int getseatseq();	// 좌석번호 시퀀스 가져오기 
	
	int insertticketdet(HashMap<String, Object> map);	// 티켓 상세 테이블에 INSERT 하기 (final_ticketdetail)
	
	int getticketno(); 	// TICKETNO 가져오기
	
	int insertpaydet(HashMap<String, Object> map);	// 결제 상세 테이블에 INSERT 해주기
	
	int insertnonmember(HashMap<String, String> map); // 비회원 테이블에 INSERT 하기 
	
	String getnonno(String nhp); // 비회원번호 (nonno) 알아와서 session에 넣어둔다.

	int noninsertticketsum(HashMap<String, Object> map);

	List<HashMap<String, String>> searchWordCompleteList(HashMap<String, String> map);
	
	int noncheck(String nhp);	// 비회원 가입 가능한지 알아오기
	
} // end of public interface InterBoardDAO ----
