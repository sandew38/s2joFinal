package com.s2jo.khx.service.lsk;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.s2jo.khx.model.lsk.LskDAO;

//===== Service 선언 =====
@Service
public class LskService implements InterLskService {
	 
	// 의존객체 주입(DI : Dependency Injection)
	@Autowired
	private LskDAO dao;

	
	// === 비회원 예약정보를 불러와주는 서비스단 생성하기 === 
	public List<HashMap<String, Object>> getNon_BookingList(String nhp) {
		
		List<HashMap<String, Object>> nonBooking_map = dao.getNon_BookingList(nhp);
		
		return nonBooking_map;
		
	}
	
	// === 회원 예약정보를 불러와주는 서비스단 생성하기 === 
	public List<HashMap<String, Object>> getMbr_BookingList(String userid) {

		List<HashMap<String, Object>> mbrBooking_map = dao.getMbr_BookingList(userid);
		
		return mbrBooking_map;
	}

	
	// === 회원 예약취소정보를 불러와주는 서비스단 생성하기 === 
	public List<HashMap<String, Object>> getMbr_BookingCancelList(String userid) {
		
		List<HashMap<String, Object>> mbrCancel_map = dao.getMbr_BookingCancelList(userid);
		
		return mbrCancel_map;
	}

	// === 비회원 예약취소정보를 불러와주는 서비스단 생성하기 === 
	public List<HashMap<String, Object>> getNon_BookingCancelList(String nhp) {
		
		List<HashMap<String, Object>> nonCancel_map = dao.getNon_BookingCancelList(nhp);
		
		return nonCancel_map;
	}
	
	// === 1개의 예약내역 수정하는 페이지 요청하기 ===
	public List<HashMap<String, Object>> getBookingModify(HashMap<String, Object> map) {

		List<HashMap<String, Object>> list = dao.getBookingModify(map);
		
		return list;
	}
	
	// === 열차종류 리스트 가져오는 메소드 ===
	public List<String> traintypeList() {
		
		List<String> traintypeList = dao.traintypeList();
		
		return traintypeList;
	}

	// === 출발시간 리스트 가져오는 메소드 ===
	public List<HashMap<String, Object>> departuretimeList(HashMap<String, Object> map) {
		
		List<HashMap<String, Object>> departuretimeList = dao.departuretimeList(map);
		
		return departuretimeList;
	}

	// === 예매변경시 새로운 출발시간 가져오는 리스트 
	public List<HashMap<String, Object>> reSelectList(HashMap<String, Object> map) {
		
		List<HashMap<String, Object>> reSelectList = dao.reSelectList(map);
		
		return reSelectList;
	}

	// === 예약인원(학생) 가져오는 메소드 ===
	public String getAgeline_Stu(String paymentcode) {
		
		String getAgeline_Stu = dao.getAgeline_Stu(paymentcode);
		
		return getAgeline_Stu;
	}

	// === 예약인원(일반) 가져오는 메소드 ===
	public String getAgeline_Com(String paymentcode) {
		
		String getAgeline_Com = dao.getAgeline_Com(paymentcode);
		
		return getAgeline_Com;
	}

	// === 예약인원(노약자) 가져오는 메소드 ===
	public String getAgeline_Old(String paymentcode) {
		
		String getAgeline_Old = dao.getAgeline_Old(paymentcode);
		
		return getAgeline_Old;
	}

	// === 예매내역(회원)_PAYSTATUS 취소하기 ===
	public int getMbr_BookingCancel1(String paymentcode) {
		
		int mbr_setpay = dao.getMbr_BookingCancel1(paymentcode);
		
		return mbr_setpay;
	}
	
	// === 예매내역(회원)_ORDERSEQ 취소하기 ===
	public int getMbr_BookingCancel2(String orderseq) {
		
		int mbr_setorder = dao.getMbr_BookingCancel2(orderseq);
		
		return mbr_setorder;
	}

	// === 예매내역(비회원)_PAYSTATUS 취소하기 ===
	public int getNon_BookingCancel1(String paymentcode) {

		int non_setpay = dao.getNon_BookingCancel1(paymentcode);
		
		return non_setpay;
	}

	// === 예매내역(비회원)_PAYSTATUS 취소하기 ===
	public int getNon_BookingCancel2(String orderseq) {

		int non_setorder = dao.getNon_BookingCancel2(orderseq);
		
		return non_setorder;
	}
	
	// === 팔린좌석 수 알아오기!
	public int getremainseatcnt(HashMap<String, Object> map) {
		
		int n = dao.getremainseatcnt(map);
		
		return n ;
	}

	// === 출발, 도착, 출발일, 열차번호로 좌석 선택 가능여부 알아오기 호차번호도 가져가야하지 않을까??? 
	public List<String> gettakenseatList(HashMap<String, Object> map) {

		List<String> takenseatList = dao.gettakenseatList(map);
		
		return takenseatList;
	}

	// === 다시예매할 그날의 열차번호 알아오기
	public String getretrainno(HashMap<String, Object> map) {

		String retrainno = dao.getretrainno(map);
		
		return retrainno;
	}

	// === 가격 알아오기! ===
	public HashMap<String, Object> trainmap(HashMap<String, Object> map2) {
		
		HashMap<String, Object> trainmap = dao.trainmap(map2);
		
		return trainmap;
	}	

	
	

	
	

	
	
	
}
