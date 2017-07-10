package com.s2jo.khx.model.lsk;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//=== #28. DAO 선언 ===

@Repository
public class LskDAO {

	// === #29. 의존객체 주입하기 (DI : Dependency Injection) ===
	@Autowired
	private SqlSessionTemplate sqlsession;


	// === 비회원 예약정보 확인하기 ===
	public List<HashMap<String, Object>> getNon_BookingList(String nhp) {
		
		List<HashMap<String, Object>> nonBooking_map = sqlsession.selectList("lsk.getNon_BookingList", nhp);
		
		return nonBooking_map;
		
	}
	
	// === 회원 예약정보 확인하기 ===
	public List<HashMap<String, Object>> getMbr_BookingList(String userid) {

		List<HashMap<String, Object>> mbrBooking_map = sqlsession.selectList("lsk.getMbr_BookingList", userid);
		
		return mbrBooking_map;
	}

	// === 회원 예약취소정보 확인하기 === 
	public List<HashMap<String, Object>> getMbr_BookingCancelList(String userid) {
		
		List<HashMap<String, Object>> mbrCancel_map = sqlsession.selectList("lsk.getMbr_BookingCancelList", userid);
		
		return mbrCancel_map;
	}

	// === 비회원 예약취소정보 확인하기 === 
	public List<HashMap<String, Object>> getNon_BookingCancelList(String nhp) {
		
		List<HashMap<String, Object>> nonCancel_map = sqlsession.selectList("lsk.getNon_BookingCancelList", nhp);
		
		return nonCancel_map;
	}
	
	// === 1개의 예약내역 수정하는 페이지 요청하기 ===
	public List<HashMap<String, Object>> getBookingModify(HashMap<String, Object> map) {

		List<HashMap<String, Object>> list = sqlsession.selectList("lsk.getBookingModify", map);
		
		return list;
	}


	// === 열차종류 가져오는 메소드 ===
	public List<String> traintypeList() {
		
		List<String> traintypeList = sqlsession.selectList("lsk.traintypeList");
		
		return traintypeList;
	}

	// === 출발시간 리스트 가져오는 메소드 ===
	public List<HashMap<String, Object>> departuretimeList(HashMap<String, Object> map) {
		
		List<HashMap<String, Object>> departuretimeList = sqlsession.selectList("lsk.departuretimeList");
		
		return departuretimeList;
	}

	// ===
	public List<HashMap<String, Object>> reSelectList(HashMap<String, Object> map) {
		
		List<HashMap<String, Object>> reSelectList = sqlsession.selectList("lsk.reSelectList", map);
		
		return reSelectList;
	}

	// === 예약인원(학생) 가져오는 메소드 ===
	public String getAgeline_Stu(String paymentcode) {
		
		String getAgeline_Stu = sqlsession.selectOne("lsk.getAgeline_Stu", paymentcode);
		
		return getAgeline_Stu;
	}

	// === 예약인원(일반) 가져오는 메소드 ===
	public String getAgeline_Com(String paymentcode) {
		
		String getAgeline_Com = sqlsession.selectOne("lsk.getAgeline_Com", paymentcode);
		
		return getAgeline_Com;
	}

	// === 예약인원(노약자) 가져오는 메소드 ===
	public String getAgeline_Old(String paymentcode) {

		String getAgeline_Old = sqlsession.selectOne("lsk.getAgeline_Old", paymentcode);
		
		return getAgeline_Old;
	}

	// === 예매내역(회원) 취소하기 ===
	public int getMbr_BookingCancel1(String paymentcode) {
		
		int mbr_setpay = sqlsession.update("lsk.getMbr_BookingCancel1", paymentcode);
		
		return mbr_setpay;
	}
	
	// === 예매내역(회원) 취소하기 ===
	public int getMbr_BookingCancel2(String orderseq) {
		
		int mbr_setorder = sqlsession.update("lsk.getMbr_BookingCancel2", orderseq);
		
		return mbr_setorder;
	}

	// === 예매내역(비회원) 취소하기 ===
	public int getNon_BookingCancel1(String paymentcode) {
		
		int non_setpay = sqlsession.update("lsk.getNon_BookingCancel1", paymentcode);
		
		return non_setpay;
	}

	// === 예매내역(비회원) 취소하기 ===
	public int getNon_BookingCancel2(String orderseq) {
		
		int non_setorder = sqlsession.update("lsk.getNon_BookingCancel2", orderseq);
		
		return non_setorder;
	}

	// === 팔린좌석 수 알아오기!
	public int getremainseatcnt(HashMap<String, Object> map) {

		int remainseatcnt = sqlsession.selectOne("lsk.remainseatcnt", map);
		
		return remainseatcnt;
	}

	// === 출발, 도착, 출발일, 열차번호로 좌석 선택 가능여부 알아오기 호차번호도 가져가야하지 않을까??? 
	public List<String> gettakenseatList(HashMap<String, Object> map) {
		
		List<String> takenseatList = sqlsession.selectList("lsk.takenseatList", map);

		return takenseatList;
	}
	
	// === 다시예매할 그날의 열차번호 알아오기
	public String getretrainno(HashMap<String, Object> map) {

		String retrainno = sqlsession.selectOne("lsk.getretrainno", map);
		
		return retrainno;
	}

	public HashMap<String, Object> trainmap(HashMap<String, Object> map2) {
		
		HashMap<String, Object> trainmap = sqlsession.selectOne("lsk.gettrainmap", map2);
		
		return trainmap;
	}




	

	
/*
	public List<HashMap<String, Object>> getRebooking(HashMap<String, Object> map) {
		
		sqlsession.getSqlSessionFactory().openSession(false);
		
		int trainList = sqlsession.update("lsk.reBooking", map);
		
		
		if(trainList == 1) {
			sqlsession.commit(true);
		}
		
		else {
			sqlsession.rollback(true);
		}
		
		return trainList;
	}
*/
	
}
