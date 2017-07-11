package com.s2jo.khx.lsk;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.s2jo.khx.model.psc.khxpscMemberVO;
import com.s2jo.khx.model.psc.khxpscNonMemberVO;
import com.s2jo.khx.service.lsk.LskService;

//==== 컨트롤러 선언 ====

@Controller
@Component
//XML에서 bean을 만드는 대신에
//클래스명 앞에 @Component 어노테이션을 쓰면
//해당 클래스는 bean으로 자동 등록된다.
//그리고 bean의 id는 해당 클래스명이 된다. (첫 글자는 소문자)

public class LskController {

// ==== 의존객체 주입하기 (DI : Dependency Injection) ====	
	
	@Autowired
	private LskService service;
	
	
	// ==== 회원과 비회원 예매확인 페이지 요청하기 ====
	@RequestMapping(value="/lsk/bookingcheck.action", method={RequestMethod.GET})
	public String main(HttpServletRequest req, HttpSession session) {
		
		khxpscNonMemberVO nonloginuser = (khxpscNonMemberVO)session.getAttribute("nonloginuser");
		
		khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");	
		
			
		if(nonloginuser == null) {
			
			String userid = loginuser.getUserid();
			
			List<HashMap<String, Object>> mbrBooking_map = service.getMbr_BookingList(userid);
			
			List<HashMap<String, Object>> nonCancel_map = service.getMbr_BookingCancelList(userid);
			
			req.setAttribute("bmap", mbrBooking_map);
			req.setAttribute("cmap", nonCancel_map);
			
		}
		else {
			
			String nhp = nonloginuser.getNhp();
			
			List<HashMap<String, Object>> nonBooking_map = service.getNon_BookingList(nhp);
			
			List<HashMap<String, Object>> nonCancel_map = service.getNon_BookingCancelList(nhp);
			
			req.setAttribute("bmap", nonBooking_map);
			req.setAttribute("cmap", nonCancel_map);
		}
		
		return "lsk/bookingcheck.tiles";
	
	}

	// === 1개의 예약내역 수정하는 페이지 요청하기 ===
	@RequestMapping(value="/lsk/bookingEdit.action", method={RequestMethod.GET})
	public String bookingEdit(HttpServletRequest req, HttpServletResponse res, HttpSession session) {
		
		// 수정해야 할 예약주문번호 가져오기
		String departuredate = req.getParameter("departuredate");
		String departure = req.getParameter("departure");
		String arrival = req.getParameter("arrival");
		String tqty = req.getParameter("tqty");
		String paymentcode = req.getParameter("paymentcode");
		
		String cancel_paymentcode = req.getParameter("paymentcode");
		session.setAttribute("cancel_paymentcode", cancel_paymentcode);
		
		String cancel_orderseq = req.getParameter("orderseq");
		session.setAttribute("cancel_orderseq", cancel_orderseq);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("departuredate", departuredate);
		map.put("departure", departure);
		map.put("arrival", arrival);
		map.put("tqty", tqty);
		map.put("paymentcode", paymentcode);
		
		// 2. HashMap으로 담기
		List<HashMap<String, Object>> list = service.getBookingModify(map);
		
		// 열차종류 리스트 가져오기
		List<String> traintypelist = service.traintypeList();

		// 3. Service단으로 생성된 HashMap 보내기
		req.setAttribute("list", list);
		req.setAttribute("traintypelist", traintypelist);
		req.setAttribute("departure", list.get(0).get("DEPARTURE"));
		req.setAttribute("arrival", list.get(0).get("ARRIVAL"));
		
		return "lsk/bookingEdit.tiles";
		
	}
	
	// === 열차종류 선택후 배차시간목록 가져오기 ===
	@RequestMapping(value="/lsk/bookingEdit_pic.action", method={RequestMethod.GET})
	@ResponseBody
	public List<HashMap<String, Object>> bookingEditEnd(HttpServletRequest req, HttpServletResponse res, HttpSession session) {
		
		String traintype_pic = req.getParameter("traintype_pic");
		String departure = req.getParameter("departure");
		String arrival = req.getParameter("arrival");
		String departuredate = req.getParameter("departuredate");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("traintype_pic", traintype_pic);
		map.put("departure", departure);
		map.put("arrival", arrival);
		
		List<HashMap<String, Object>> reSelectList = service.reSelectList(map);
		
		System.out.println("####################### reSelectList => " + reSelectList);
		
		req.setAttribute("departure", departure);
		req.setAttribute("arrival", arrival);
		req.setAttribute("traintype_pic", traintype_pic);
		req.setAttribute("departuredate", departuredate);
		req.setAttribute("reSelectList", reSelectList);
			
		return reSelectList;
		
	}


	// === 시간대와 열차등급 선택후 좌석선택 페이지 넘어가기 ===
	@RequestMapping(value="/lsk/reselectseat.action", method={RequestMethod.POST})
	public String getReselectSeat(HttpServletRequest req, HttpServletResponse res, HttpSession session) {
	
		session.setAttribute("changeChk", "yes");
		
		String departure = req.getParameter("departure");
		session.setAttribute("departure", departure);
		String arrival = req.getParameter("arrival");
		session.setAttribute("arrival", arrival);
		String departuredate = req.getParameter("departuredate");
		session.setAttribute("departuredate", departuredate);
		
		
		String departuretime = req.getParameter("departuretime");
		if(departuretime == null) {
			departuretime = (String)session.getAttribute("departuretime");
		}
				
		session.setAttribute("departuretime", departuretime);
		
		String traintype_pic = req.getParameter("traintype_pic");
		session.setAttribute("traintype", traintype_pic);
		
		String paymentcode = req.getParameter("paymentcode");
		
		if(paymentcode == null) {
			paymentcode = (String)session.getAttribute("paymentcode");
		}
		
		session.setAttribute("paymentcode", paymentcode);
		
		
		String trainclass = req.getParameter("trainclass");
		session.setAttribute("classno", trainclass);
		
		System.out.println("##################### trainclass => " + trainclass);
		System.out.println("##################### departure => " + departure);
		System.out.println("##################### arrival => " + arrival);
		System.out.println("##################### departuredate => " + departuredate);
		System.out.println("##################### departuretime => " + departuretime);
		System.out.println("##################### traintype_pic => " + traintype_pic);
		System.out.println("##################### trainclass => " + trainclass);
		
		// 출/도착지, 출발일자에 해당하는 trainList 가져오기
		HashMap<String, Object> map2 = new HashMap<String, Object>();
		
		map2.put("departure", departure);
		map2.put("arrival", arrival);
		map2.put("departuretime", departuretime);
		map2.put("traintype_pic", traintype_pic);
		
		HashMap<String, Object> trainmap = service.trainmap(map2);
		
		// 다시예매할 그날의 열차번호 알아오기
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("departure", departure);			// 출발지 (select문으로 불러온 예약정보 고정값)
		map.put("arrival", arrival);				// 도착지 (select문으로 불러온 예약정보 고정값)
		map.put("departuredate", departuredate);	// 출발일자 (select문으로 불러온 예약정보 고정값)
		map.put("departuretime", departuretime);	// 새로 예약할 출발시간 (변경값)
		
		String retrainno = service.getretrainno(map);
		session.setAttribute("trainno", retrainno);
		
		System.out.println("##################### retrainno => " + retrainno);
		
		// 팔린좌석 수 알아오기!
		map = new HashMap<String, Object>();

		map.put("traintype_pic", traintype_pic);	// 기차등급(ex. ktx or 무궁화)
		map.put("classno", trainclass);				// 호차(ex. 1호~8호)	
		map.put("departure", departure);			// 출발지
		map.put("arrival", arrival);				// 도착지
		map.put("departuredate", departuredate);	// 출발일자
		map.put("retrainno", retrainno);			// 열차번호

		int remainseatcnt = service.getremainseatcnt(map);
		
		
		// 출발, 도착, 출발일, 열차번호로 좌석 선택 가능여부 알아오기 호차번호까지!!
		map = new HashMap<String, Object>();
		
		map.put("traintype_pic", traintype_pic);				// 기차등급(ex. ktx or 무궁화)
		map.put("classno", trainclass);				// 호차(ex. 1호~8호)		
		map.put("departure", departure);			// 출발지
		map.put("arrival", arrival);				// 도착지
		map.put("departuredate", departuredate);	// 출발일자
		map.put("retrainno", retrainno);			// 열차번호

		List<String> takenseatList = service.gettakenseatList(map);
		
		ArrayList<HashMap<String, String>> AllSeatlist = new ArrayList<HashMap<String, String>>();
		
		String[] keyArr = new String[takenseatList.size()];
		
		for(int i=0; i<keyArr.length; i++) {
			keyArr[i] = takenseatList.get(i);
		} 
		
		for (int i = 1; i <= 48; i++) {
			
			HashMap<String, String> seatmap = new HashMap<String, String>();
			
			int flag = 0;
			for(String yeyakseatno : keyArr) {
				if(i == Integer.parseInt(yeyakseatno)) {
					seatmap.put("soldout", String.valueOf(i));	 // 29, 30
					flag = 1;
					break;
				}
			}
			
			if(flag == 0) {
				seatmap.put("notsoldout", String.valueOf(i));	 // 1, 2, 3 ~~~ 28, 31, 32, ~~~ 48
			}
			
			AllSeatlist.add(seatmap);
		
		} // end of for-------
		
		req.setAttribute("AllSeatlist", AllSeatlist);
		
		String getAgeline_Stu = service.getAgeline_Stu(paymentcode);
		String getAgeline_Com = service.getAgeline_Com(paymentcode);
		String getAgeline_Old = service.getAgeline_Old(paymentcode);
		
		String rate = (String)trainmap.get("RATE");
		String turnaroundrate = (String)trainmap.get("TURNAROUNDRATE");
		int turnaroundrateint = Integer.parseInt((String)trainmap.get("TURNAROUNDRATE"));
		
		System.out.println("########################## rate = > " + rate);
		System.out.println("########################## turnaroundrate = > " + turnaroundrate);
		System.out.println("########################## turnaroundrateint = > " + turnaroundrateint);
		
		
		req.setAttribute("getAgeline_Stu", getAgeline_Stu);
		req.setAttribute("getAgeline_Com", getAgeline_Com);
		req.setAttribute("getAgeline_Old", getAgeline_Old);
		req.setAttribute("trainno", retrainno);
		
		req.setAttribute("turnaroundrate", turnaroundrate);
		req.setAttribute("turnaroundrateint", turnaroundrateint);
		req.setAttribute("traintype", traintype_pic);
		req.setAttribute("departuredate", departuredate);
		req.setAttribute("departure", departure);
		req.setAttribute("arrival", arrival);
		req.setAttribute("trainclass", trainclass);
		req.setAttribute("remainseatcnt", remainseatcnt);
		req.setAttribute("takenseatList", takenseatList);
		req.setAttribute("rate", rate);
		
		
		return "lsk/reselectseat.tiles";
	}
	

	// === 예매내역 취소하기 ===
	@RequestMapping(value="/lsk/bookingCancel.action", method={RequestMethod.GET})
	public String bookingCancel(HttpServletRequest req, HttpServletResponse res, HttpSession session) {
		
		khxpscNonMemberVO nonloginuser = (khxpscNonMemberVO)session.getAttribute("nonloginuser");
		
		khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");	
		
		String paymentcode = req.getParameter("paymentcode");
		session.setAttribute("paymentcode", paymentcode);
		
		System.out.println("########################## paymentcode ==> " + paymentcode);
		
		String orderseq = req.getParameter("orderseq");
		if(orderseq == null) {
			orderseq = (String)session.getAttribute("orderseq");
		}
		session.setAttribute("orderseq", orderseq);
		
		System.out.println("########################## orderseq ==> " + orderseq);
		
		if(nonloginuser == null && loginuser != null) {
			
			int mbr_setpay = service.getMbr_BookingCancel1(paymentcode);
			
			int mbr_setorder = service.getMbr_BookingCancel2(orderseq);
			
			System.out.println("##################### mbr_setpay => " + mbr_setpay);
			System.out.println("##################### mbr_setorder => " + mbr_setorder);
			
			req.setAttribute("mbr_setpay", mbr_setpay);
			req.setAttribute("mbr_setorder", mbr_setorder);
			
		}
		else {

			int non_setpay = service.getNon_BookingCancel1(paymentcode);
			
			int non_setorder = service.getNon_BookingCancel2(orderseq);
			
			System.out.println("##################### non_setpay => " + non_setpay);
			System.out.println("##################### non_setorder => " + non_setorder);
			
			req.setAttribute("non_setpay", non_setpay);
			req.setAttribute("non_setorder", non_setorder);
			
		}
		
		return "lsk/bookingCancel.tiles";
	}

	
}
 