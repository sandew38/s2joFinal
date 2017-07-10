package com.s2jo.khx.model.kyj;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.s2jo.khx.model.psc.khxpscMemberVO;
import com.s2jo.khx.model.psc.khxpscNonMemberVO;

// ==== #28. DAO 선언 ====

@Repository
public class KhxDAO implements InterKhxDAO {

// ==== #29. 의존객체 주입하기 (DI : Dependency Injection) ====
	
	@Autowired
	private SqlSessionTemplate sqlsession;

// ==== #42. 메인 페이지용 이미지 파일 이름을 가져오는 모델단 public List<String> getImgfilenameList() 메소드 생성하기
//		이미지 파일명 가져오기
	@Override
	public List<String> getImgfilenameList() {
		
		List<String> list = sqlsession.selectList("khx.getImgfilenameList");
		
		return list;
		
	}
	
// ==== 출발지 리스트를 가져오는 메소드
	@Override
	public List<String> departureList() {

		List<String> departureList = sqlsession.selectList("khx.departureList");
		
		return departureList;
	}

// ==== 도착지 리스트를 가져오는 메소드
	@Override
	public List<String> arrivalList() {

		List<String> arrivalList = sqlsession.selectList("khx.arrivalList");
		
		return arrivalList;
	}
	
// ==== 열차 운행 정보를 가져오는 메소드 
/*	@Override
	public List<TrainviewVO> trainList(String traintype, String departure, String arrival) {
	
		
		
		List<TrainviewVO> trainList = sqlsession.selectList("khx.trainList",  traintype);
		
		return trainList;
	}
	*/
// ==== 열차 운행 정보를 가져오는 메소드 
	@Override
	public List<HashMap<String, Object>> trainList(HashMap<String, Object> map) {
		
		List<HashMap<String, Object>> trainList = sqlsession.selectList("khx.trainList",  map);
	
		return trainList;
	}

//	==== 남은 좌석 수 알아오기 
	@Override
	public int getremainseatcnt(HashMap<String, Object> map) {
		
		int remainseatcnt = sqlsession.selectOne("khx.remainseatcnt", map);
		
		return remainseatcnt;
	}

	
//	==== 팔린 좌석 목록 가져오기
	@Override
	public List<String> gettakenseatList(HashMap<String, Object> map) {

		List<String> takenseatList = sqlsession.selectList("khx.takenseatList",map);

		return takenseatList;
	}
	
	
//	==== 팔린 좌석 목록 가져오기 (좌석번호별)
	@Override
	public List<String> getseatList(HashMap<String, Object> map) {

		List<String> seatList = sqlsession.selectList("khx.seatList",map);
													// takenseatList
		return seatList;
	}

//	==== yj 회원 로그인하기!
	@Override
	public int loginEnd(HashMap<String, String> map) {
		
		int n = sqlsession.selectOne("khx.seatloginEnd", map);
									//xml이름.xml에서 불러다 쓸 ID
		return n;
	}

//	==== yj 회원 정보 가져오기!
	@Override
	public khxpscMemberVO getLoginEnd(String userid) {
		khxpscMemberVO loginuser = sqlsession.selectOne("khx.getLoginEnd", userid);
		return loginuser;
	}
	
//	==== yj 비회원 로그인하기!
	@Override
	public int nonloginEnd(HashMap<String, String> map) {
		
		int n = sqlsession.selectOne("khx.seatnonloginEnd", map);
		
	return n;
	}

//	==== yj 비회원 정보가져오기
	@Override
	public khxpscNonMemberVO getNonLoginEnd(String nhp) {
		
		khxpscNonMemberVO nonloginuser = sqlsession.selectOne("khx.getNonLoginEnd", nhp);
		
		return nonloginuser;
	}

//	==== 열차번호, 출발지, 도착지로 runinfoseq 가져오기
	@Override
	public int getruninfoseq(HashMap<String, Object> map) {
		
		int runinfoseq = sqlsession.selectOne("khx.getruninfoseq", map);
		
		return runinfoseq;
	}
	
//	==== 좌석 테이블(final_seat)에 예약한 좌석 넣어주기
	@Override
	public int insertseats(HashMap<String, Object> map) {

		int insertseats = sqlsession.insert("khx.insertseats", map);
		
		return insertseats;
	}

//	==== 티켓 개요 테이블에 INSERT 하기 
	@Override
	public int insertticketsum(HashMap<String, Object> map) {

		int n = sqlsession.insert("khx.insertticketsum", map);
		
		return n;
	}

//	==== 티켓 개요 테이블에 INSERT 하기 (비회원용)
	@Override
	public int noninsertticketsum(HashMap<String, Object> map) {

		int n = sqlsession.insert("khx.noninsertticketsum", map);			
				
		return n;
	}

	
//	결제 테이블에 INSERT 하기 
	@Override
	public int insertpaysum(HashMap<String, Object> map) {
		
		String userid = (String)map.get("userid");
		String nonno = String.valueOf((map.get("nonno")));
		
		int n = 0;
		
		if(!"null".equals(userid))
		{	//	회원인 경우
			n = sqlsession.insert("khx.insertpaysum", map);	
		}
		else if(!"null".equals(nonno))
		{
			n = sqlsession.insert("khx.noninsertpaysum", map);			
		}
		
		
		return n;
	}

//	티켓 개요 테이블에서 주문번호 시퀀스 갖고오기
	@Override
	public int getorderseq(HashMap<String, Object> map) {

		String userid = (String)map.get("userid");
		String nonno = String.valueOf((map.get("nonno")));
		
		int n = 0;
		
		if(!"null".equals(userid))
		{	//	회원인 경우
			n = sqlsession.selectOne("khx.getorderseq", map);
		}
		else if(!"null".equals(nonno))
		{
			n = sqlsession.selectOne("khx.nongetorderseq", map);	
		}
		
		return n;
	}

//	결제 테이블에서 결제코드번호 시퀀스 갖고오기
	@Override
	public int getpaymentcode(HashMap<String, Object> map) {

		String userid = (String)map.get("userid");
		String nonno = String.valueOf((map.get("nonno")));
		
		int n = 0;
		
		if(!"null".equals(userid))
		{	//	회원인 경우
			n = sqlsession.selectOne("khx.getpaymentcode", map);
		}
		else if(!"null".equals(nonno))
		{
			n = sqlsession.selectOne("khx.nongetpaymentcode", map);
		}
		
		return n;
		
	}

//	좌석번호시퀀스 seatseq 가져오기
	@Override
	public int getseatseq() {

		int getseatseq = sqlsession.selectOne("khx.getseatseq");
		
		return getseatseq;
		
	}
	
// 티켓 상세 테이블에 INSERT 하기 (final_ticketdetail)
	@Override
	public int insertticketdet(HashMap<String, Object> map) {

		String userid = (String)map.get("userid");
		String nonno = String.valueOf((map.get("nonno")));
		
		int n = 0;
		
		if(!"null".equals(userid))
		{	//	회원인 경우
			n = sqlsession.insert("khx.insertticketdet", map);
		}
		else if(!"null".equals(nonno))
		{
			n = sqlsession.insert("khx.noninsertticketdet", map);
		}
		
		return n;
		
	}

// TICKETNO 가져오기
	@Override
	public int getticketno() {

		int getticketno = sqlsession.selectOne("khx.getticketno");
		
		return getticketno;
	}

// 결제 상세 테이블에 INSERT 해주기
	@Override
	public int insertpaydet(HashMap<String, Object> map) {

		int insertpaydet = sqlsession.insert("khx.insertpaydet", map);
		
		return insertpaydet;
	}

// 비회원 INSERT 해주기
	@Override
	public int insertnonmember(HashMap<String, String> map) {

		int n = sqlsession.insert("khx.insertnonmember", map);
	
		return n;
	}

// 비회원번호 (nonno) 알아와서 session에 넣어둔다.
	@Override
	public String getnonno(String nhp) {

		String getnonno = sqlsession.selectOne("khx.getnonno", nhp);
		
		return getnonno;
		
	}

	
//	====	#150. Ajax로 검색어 입력시 자동글 완성하기 ⑤	====
	@Override
	public List<HashMap<String, String>> searchWordCompleteList(HashMap<String, String> map) {

		List<HashMap<String, String>> List = sqlsession.selectList("khx.searchWordCompleteList", map);
		
		return List;
		
	}

// ====	비회원 가입 가능한지 알아오기
	@Override
	public int noncheck(String nhp) {

		int noncheck = sqlsession.selectOne("khx.noncheck", nhp);
		
		return noncheck;
	}	
	
} // end of public class BoardDAO implements InterBoardDAO ----
