
package com.s2jo.khx.kyj;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.s2jo.khx.common.FileManager;
import com.s2jo.khx.model.kyj.RuninfoVO;
import com.s2jo.khx.model.kyj.TrainviewVO;
import com.s2jo.khx.model.psc.khxpscMemberVO;
import com.s2jo.khx.model.psc.khxpscNonMemberVO;
import com.s2jo.khx.service.kyj.KhxService;
import com.s2jo.khx.service.lsk.LskService;

import oracle.net.aso.b;

// ==== #31. 컨트롤러 선언 ====

@Controller
@Component
// XML에서 bean을 만드는 대신에
// 클래스명 앞에 @Component 어노테이션을 쓰면
// 해당 클래스는 bean으로 자동 등록된다.
// 그리고 bean의 id는 해당 클래스명이 된다. (첫 글자는 소문자)

public class KhxController {

// ==== #33. 의존객체 주입하기 (DI : Dependency Injection) ====
	@Autowired
	private KhxService service; 
	
	@Autowired
	private LskService lskservice;
		
// ==== #130. 파일 업로드 & 다운로드를 위한 FileManager 클래스 의존 객체 주입하기 		
	@Autowired
	private FileManager fileManager;	
			
// ==== #40. 메인 페이지 요청. ====	
	@RequestMapping(value="/khx.action", method={RequestMethod.GET})
	public String header_index(HttpServletRequest req, HttpServletResponse res)
	{
		// 출발지 목록 가져오기
		List<String> departureList = service.departureList();
		
		// 도착지 목록 가져오기
		List<String> arrivalList = service.arrivalList();
		
		req.setAttribute("departureList", departureList);
		req.setAttribute("arrivalList", arrivalList);
		
		return "main/khx.tiles";
//			└> /Board/src/main/webapp/WEB-INF/views/main/khx.jsp 파일을 생성한다.
		
	} // end of public String index(HttpServletRequest req) ----
	

// ==== #1. 예매 페이지 요청. ====	
	@RequestMapping(value="/booking.action", method={RequestMethod.POST})
	
	public String header_booking(HttpServletRequest req, HttpServletResponse res, HttpSession session)
	{
		
		String waytype = req.getParameter("waytype");
		String departure = req.getParameter("departure");
			session.setAttribute("departure", departure);
		String arrival = req.getParameter("arrival");
			session.setAttribute("arrival", arrival);
		String traintype = req.getParameter("traintype");
			session.setAttribute("traintype", traintype);
		String trainclass = req.getParameter("trainclass");
			session.setAttribute("trainclass", trainclass);
		String departuredate = req.getParameter("departuredate");
			session.setAttribute("departuredate", departuredate);
		String arrivaldate = req.getParameter("arrivaldate");
		
		int int_traintype = 0;
		
		if("KHX".equals(traintype)) {
			int_traintype = 1;
		}
		
		else if("무궁화호".equals(traintype)) {
			int_traintype = 2;
		}
				
		System.out.println("======================================");
		System.out.println("waytype : " + waytype);	
		System.out.println("departure : " + departure);	
		System.out.println("arrival : " + arrival);	
		System.out.println("traintype : " + traintype);	
		System.out.println("trainclass : " + trainclass);	
		System.out.println("departuredate : " + departuredate.substring(2));	
		System.out.println("arrivaldate : " + arrivaldate);	
		
		HashMap<String, Object> map = new HashMap<String, Object>(); 
		
		map.put("int_traintype", int_traintype);
		map.put("departure", departure);
		map.put("arrival", arrival);
		
		// 2. VO 클래스를 생성하지 않고, 그냥 HashMap 을 사용하는 경우 
		//    SQL구문이 JOIN 해서 나오는 SELECT 문일 경우
		//    JOIN 되어지는 테이블의 갯수가 많다라면
		//    VO 클래스를 만들지 않고 그냥 HashMap을 사용하는 것이 편하다.
		
		// 출/도착지, 출발일자에 해당하는 trainList 가져오기
		List<HashMap<String, Object>> trainList = service.trainList(map);
		
		req.setAttribute("waytype", waytype); // 편도, 왕복
		
		req.setAttribute("trainList", trainList);
		
		req.setAttribute("departure", departure);			// 출발지
		req.setAttribute("arrival", arrival);				// 도착지
		req.setAttribute("traintype", traintype);			// 열차종류
		req.setAttribute("trainclass", trainclass);			// 호차
//		req.setAttribute("departuredate", departuredate.substring(2));	// 출발일자
		session.setAttribute("departuredate", departuredate.substring(2)); // 출발일자
		
		req.setAttribute("arrivaldate", arrivaldate);		// 도착일자
				
		if(!trainList.isEmpty() && trainList.size() > 0)
		{
			int turnaroundrateint = Integer.parseInt(trainList.get(0).get("turnaroundrate").toString());
			int rateint = Integer.parseInt(trainList.get(0).get("rate").toString());
		
//			System.out.println("★★★ rate : " + rateint);
			
//			System.out.println("turnaroundrateint " + turnaroundrateint);
			
			String turnaroundrate = "";
			
			if (turnaroundrateint >= 60)
			{
				int turnaroundratehour = (turnaroundrateint / 60);
	//			System.out.println("turnaroundratehour " + turnaroundratehour);
				
				int turnaroundratemin = (turnaroundrateint % 60);
	//			System.out.println("turnaroundratemin " + turnaroundratemin);
				
				turnaroundrate = turnaroundratehour+ "시간 ";
				turnaroundrate += turnaroundratemin + "분 ";
				
	//			System.out.println("turnaroundrate : " + turnaroundrate);
			}
			
			else if (turnaroundrateint <60)
			{
				turnaroundrate = turnaroundrateint + "분 ";
			}
			
			
			
			req.setAttribute("turnaroundrateint", turnaroundrateint);
			req.setAttribute("turnaroundrate", turnaroundrate);
			
			session.setAttribute("tqty", rateint);
			req.setAttribute("rate", rateint);
		}
		
		return "khx/booking.tiles";
//					└> /s2jo/src/main/webapp/WEB-INF/views/khx/booking.jsp 파일을 생성한다.
		
	} // end of public String index(HttpServletRequest req) ----

	
// ==== 좌석 선택 페이지 요청. ====	
		@RequestMapping(value="/selectseat.action", method={RequestMethod.POST})
		
	public String header_selectseat(HttpServletRequest req, HttpServletResponse res, HttpSession session)
	{
		String waytype = req.getParameter("waytype");
		String going = req.getParameter("going");
		String coming = req.getParameter("coming");
		
		
				
				
		String str_trainno = (String)req.getParameter("trainno");
			session.setAttribute("trainno", str_trainno);
		
		String departure = req.getParameter("departure");
			session.setAttribute("departure", departure);
	
		String departuretime = req.getParameter("departuretime");
			session.setAttribute("departuretime", departuretime);
			
		String arrival = req.getParameter("arrival");
			session.setAttribute("arrival", arrival);

		String arrivaltime = req.getParameter("arrivaltime");
			session.setAttribute("arrivaltime", arrivaltime);
			
		String trainclass = req.getParameter("trainclass");
			
		String turnaroundrate = req.getParameter("turnaroundrate");
			session.setAttribute("turnaroundrate", turnaroundrate);
		String turnaroundrateint = req.getParameter("turnaroundrateint");
			session.setAttribute("turnaroundrateint", turnaroundrateint);
		String departuredate = (String)session.getAttribute("departuredate");

//		System.out.println("departuredate 여기서는 어떻게 나오지? : " + departuredate);
		
		String arrivaldate = req.getParameter("arrivaldate");
			session.setAttribute("arrivaldate", arrivaldate);
		String rate = req.getParameter("rate");
			session.setAttribute("rate", rate);
		
		/*	확인용	*/
//		System.out.println("str_trainno : " + str_trainno);
//		System.out.println("departure : " + departure);
//		System.out.println("arrival : " + arrival);
//		System.out.println("trainclass : " + trainclass);
//		System.out.println("turnaroundrateint : " + turnaroundrateint);
//		System.out.println("turnaroundrate : " + turnaroundrate);
//		System.out.println("arrivaldate : " + arrivaldate);
		
		if (trainclass.equals("normal"))
		{
			trainclass = "4";
		}
		else if (trainclass.equals("vip"))
		{
			trainclass = "1";
		}
		
//		System.out.println("trainclass : " + trainclass);
		
		session.setAttribute("trainclass", trainclass);
		
		HashMap<String, Object> map = new HashMap<String, Object>(); 
		
		int trainno = Integer.parseInt(str_trainno);
		
//		session.setAttribute("trainno", trainno);
		map.put("trainno", trainno);
		map.put("departure", departure);
		map.put("arrival", arrival);
		map.put("trainclass", trainclass);
		map.put("departuredate", departuredate);
		
//			map.put("trainclass", trainclass); // vip : 1~3호차 normal : 4~8호차

//			일단 남은좌석부터 알아온다.
		int remainseatcnt = service.getremainseatcnt(map);
		
//			System.out.println("남은좌석 remainseatcnt : " + remainseatcnt);
		
//			출발, 도착, 출발일, 열차번호로 좌석 선택 가능여부 알아오기 
//			호차번호도 가져가야하지 않을까???
		map = new HashMap<String, Object>();
		
//		departuredate = departuredate.replaceAll("/","");
	
		map.put("departuredate", departuredate);
//			System.out.println("departuredate from map : " + map.get("departuredate"));
		map.put("departure", departure);
//			System.out.println("departure from map : " + map.get("departure"));
		map.put("arrival", arrival);
//			System.out.println("arrival from map : " + map.get("arrival"));
		map.put("trainno", trainno);
//			System.out.println("trainno from map : " + map.get("trainno"));		
		map.put("trainclass", trainclass);
//			System.out.println("trainclass from map : " + map.get("trainclass"));

		
		List<String> takenseatList = service.gettakenseatList(map);
		
		ArrayList<HashMap<String,String>> AllSeatlist = new ArrayList<HashMap<String,String>>();
		
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
			
		}// end of for----------------------------------------------
		
		req.setAttribute("AllSeatlist", AllSeatlist);
		
	//	System.out.println(">>> 확인용 AllSeatlist 크기 : " + AllSeatlist.size());
		
	/*
		for(int i=0; i<AllSeatlist.size(); i++) {
			if(AllSeatlist.get(i).get("soldout") != null) {
				System.out.println(">>> 확인용 매진 : " + AllSeatlist.get(i).get("soldout"));	
			}
			else if(AllSeatlist.get(i).get("notsoldout") != null) {
				System.out.println(">>> 확인용 판매중 : " + AllSeatlist.get(i).get("notsoldout"));
			}
			
		}
	*/	
	/*	
		khxpscMemberVO loginuser = null;
		loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
		
		khxpscNonMemberVO nonloginuser = null;		
		
		nonloginuser = (khxpscNonMemberVO)session.getAttribute("nonloginuser");

		System.out.println("로그인 했으면 이게 보여야함 : " + loginuser.getUserid());		
		System.out.println("비회원일 경우 이 번호 " + nonloginuser.getNonno());

		req.setAttribute("nonno", nonloginuser.getNonno());
		req.setAttribute("userid", loginuser.getUserid());
		
		*/
		
		req.setAttribute("turnaroundrateint", turnaroundrateint);
		req.setAttribute("turnaroundrate", turnaroundrate);
		
		req.setAttribute("trainno", str_trainno);
		req.setAttribute("departuredate", departuredate);//
		req.setAttribute("arrivaldate", arrivaldate);//
		req.setAttribute("departure", departure);//
		req.setAttribute("arrival", arrival);//
		req.setAttribute("trainclass", trainclass);
		req.setAttribute("remainseatcnt", remainseatcnt);
		req.setAttribute("takenseatList", takenseatList);
		req.setAttribute("rate", rate);
		

//		편도인 경우 그냥 진행
		return "khx/selectseat.tiles";
//		└> /Board/src/main/webapp/WEB-INF/views/khx/selectseat.jsp 파일을 생성한다.			
		
	} // end of public String index(HttpServletRequest req) ----

	
	
// ===== yj 회원 로그인 완료 요청 =====
 	    @RequestMapping(value="/seatloginEnd.action", method={RequestMethod.POST})
 	    @ResponseBody
    public khxpscMemberVO loginEnd(HttpServletRequest req, HttpServletResponse res ,khxpscMemberVO loginuser,  HttpSession session) 
    		throws Exception{

    	String userid = req.getParameter("userid");
//    	String saveuserid = req.getParameter("saveuserid");	 	    	
    	String pwd = req.getParameter("pwd");
    	
    	HashMap<String, String> map = new HashMap<String, String>();
    	map.put("userid", userid);
    	map.put("pwd", pwd);
//    	map.put("saveuserid", saveuserid);	 	    	
    /*	 	   	
    	  로그인을 하려면 아이디와 암호가 암호화 되어 DB에 저장되어진 것과 일치할때만 로그인이 되어지도록 해야 한다.
    	  서비스단에서 로그인 여부 결과를 int 타입(1 or 0 or -1)으로 받아오겠다.
    */	
 //   	System.out.println("영주 정회원 로그인");
    	 int n =service.loginEnd(map);
    	 // 넘겨받은 n 값이 1 이면 아이디와 암호가 일치하는 경우
    	 // 넘겨받은 n 값이 0 이면 암호가 틀리는 경우
    	 // 넘겨받은 n 값이 -1 이면 아이디가 없는 경우
    	 
    	 // 로그인 결과(1 or 0 or -1)를 request 영역에 저장시켜서 view 단 페이지로 넘긴다.
   // 	 req.setAttribute("n", n);
    	 
    	loginuser = null;
    	
    	 if(n == 1) 
    	 {
    		loginuser = service.getLoginEnd(userid);
    		session.setAttribute("loginuser", loginuser);
    		session.setAttribute("userid", loginuser.getUserid());
    		 
 //   		 System.out.println("영주 정회원 로그인성공!");
    		 // 로그인을 하지 않은 상태에서 글쓰기, 글수정, 글삭제를 했을때
    		 // 현재 페이지의 주소를 세션에 "url" 이라는 키값으로
    		 // 저장해둔 현재 페이지의 주소를 읽어온다.
    		String url = (String)session.getAttribute("url");
    		 req.setAttribute("url", url);
    		
    	 }
    	 if(n == 0) 
    	 { 	    		 
//    		 System.out.println("비밀번호가 틀렸다!");
    		 // 로그인을 하지 않은 상태에서 글쓰기, 글수정, 글삭제를 했을때
    		 // 현재 페이지의 주소를 세션에 "url" 이라는 키값으로
    		 // 저장해둔 현재 페이지의 주소를 읽어온다.
    		String url = (String)session.getAttribute("url");
    		 req.setAttribute("url", url);
    	 }	 	
    	 if(n == -1) 
    	 {
//    		System.out.println("아이디가 없습니다.!");
    		 // 로그인을 하지 않은 상태에서 글쓰기, 글수정, 글삭제를 했을때
    		 // 현재 페이지의 주소를 세션에 "url" 이라는 키값으로
    		 // 저장해둔 현재 페이지의 주소를 읽어온다.
    		String url = (String)session.getAttribute("url");
    		 req.setAttribute("url", url);

    	 }
    	
  //  	req.setAttribute("userid", loginuser.getUserid());
	 
//	 System.out.println("회원 아이디" + loginuser.getUserid());
    	return loginuser;
    	
    } // end of yj 회원 로그인 완료 ----

   
// 비회원 가입 가능한지 알아오기
 	    
    @RequestMapping(value="/noncheck.action", method={RequestMethod.POST})
    @ResponseBody
    public int noncheck(HttpServletRequest req, HttpServletResponse res, HttpSession session) 
    		throws Exception
    {
    	String nhp = req.getParameter("nhp");
    	
    	int noncheck = service.noncheck(nhp);	
    	
//		noncheck 이 1이면 이미 존재하는 번호이므로 예매 진행불가
//					0이면 테이블에 존재하지 않는 번호이므로 예매 진행 가능!

    	
    	 if(noncheck == 1) 
    	 {	// 이미 존재하는 번호이므로 예매 진행불가
    		System.out.println("이미 존재하는 번호이므로 예매 진행불가");
    	 }
    	 
    	 else if(noncheck == 0) 
    	 { 	// 테이블에 존재하지 않는 번호이므로 예매 진행 가능!	 
    		 System.out.println("테이블에 존재하지 않는 번호이므로 예매 진행 가능!");
    	 }	 	
    	 
    	 
    	 return noncheck;
    	
    } // end of yj 회원 로그인 완료 ----

    
    
//	==== 예매 컨펌 페이지 요청
    @RequestMapping(value="/orderConfirm.action", method={RequestMethod.POST})
	public String header_orderConfirm(HttpServletRequest req, HttpServletResponse res, HttpSession session)
	{
		String trainclass = req.getParameter("trainclass");	// 객실 등급
			session.setAttribute("trainclass", trainclass);
		String tqty = req.getParameter("tqty"); // 티켓 구매 장 수 
			session.setAttribute("tqty", tqty);
		String normal = req.getParameter("normal"); // 일반 탑승인 수 
			session.setAttribute("normal", normal);
		String students = req.getParameter("students"); // 중고생 탑승인 수 
			session.setAttribute("students", students);
		String older = req.getParameter("older"); // 65세 이상 탑승인 수 
			session.setAttribute("older", older);
			
		String departuredate = req.getParameter("departuredate");	// 가는 날 
			session.setAttribute("departuredate", departuredate);
		String rate = req.getParameter("rate"); // 기준요금
			session.setAttribute("rate", rate);
		String totalPrice = req.getParameter("totalPrice"); // 총 가격 
			session.setAttribute("totalPrice", totalPrice);
		String selectedSeatList = req.getParameter("selectedSeatList");
			session.setAttribute("selectedSeatList", selectedSeatList);
		
		
		
    	
		
		return "khx/orderConfirm.tiles";
//			└> /Board/src/main/webapp/WEB-INF/views/main/khx.jsp 파일을 생성한다.
		
	} // end of public String index(HttpServletRequest req) ----
    
    
    
//	==== 결제 페이지 요청
    @RequestMapping(value="/pay.action", method={RequestMethod.POST})
	public String header_pay(HttpServletRequest req, HttpServletResponse res,  HttpSession session)
	{
		String userid = req.getParameter("userid");
//		System.out.println("결제하기 전 확인 userid : " + userid);
		
		String nhp = req.getParameter("nhp");
		boolean boolnhp = nhp != null;
		String npwd = req.getParameter("npwd");
		
//		System.out.println("★★nhp : " + nhp);
//		System.out.println("★★npwd : " + npwd);
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		if(boolnhp)
		{			
			map.put("nhp", nhp);
			map.put("npwd", npwd);
			
			// 비회원 테이블에 INSERT 해주기
			service.insertnonmember(map);
		
			// 비회원번호 (nonno) 알아와서 session에 넣어둔다.
			String nonno = service.getnonno(nhp);
			session.setAttribute("nonno", nonno);
			
			// 비회원의 핸드폰 번호도 session에 넣어둔다.
			session.setAttribute("nhp", nhp);
		}	

		return "khx/pay.tiles";
//			└> /Board/src/main/webapp/WEB-INF/views/khx/pay.jsp 파일을 생성한다.
		
	} // end of public String pay(HttpServletRequest req) ----
    
    
    
//	==== 결제 완료페이지 요청
    @RequestMapping(value="/payEnd.action", method={RequestMethod.GET})
	public String header_payEnd(HttpServletRequest req, HttpServletResponse res,  HttpSession session)
	{
//    	System.out.println("payEnd 까지 왔다!");
    	
    	String userid = (String)session.getAttribute("userid");
    	   	
    	khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
    	
    	String nhp = (String)session.getAttribute("nhp");
    	
    	if(loginuser!= null)
    	{
    	   	userid = loginuser.getUserid();
    	}
    	
    	boolean booluserid = userid != null;
    	
//    	System.out.println("★ userid : " + userid);
    	
    	String nonno = (String)session.getAttribute("nonno");
    	
    	boolean boolnonno = nonno != null;
    	
//   	System.out.println("★ nonno : " + nonno);
    	
    	
		String totalPrice = (String)session.getAttribute("totalPrice");
		String ppt = (String)session.getAttribute("rate");
		
		String departure = (String)session.getAttribute("departure");
		String departuretime = (String)session.getAttribute("departuretime");
		String departuredate = (String)session.getAttribute("departuredate");
		String arrival = (String)session.getAttribute("arrival");
		String arrivaltime = (String)session.getAttribute("arrivaltime");
		String arrivaldate = (String)session.getAttribute("arrivaldate");
		
		String trainclass = (String)session.getAttribute("trainclass");
		String trainno = (String)session.getAttribute("trainno");
		String traintype = (String)session.getAttribute("traintype");
		
		String selectedSeatList = (String)session.getAttribute("selectedSeatList");
		
		String tqty = (String)session.getAttribute("tqty");
	
		String normal = (String)(session.getAttribute("normal"));
		String students = (String)(session.getAttribute("students"));
		String older = (String)(session.getAttribute("older"));
		
/*		
		System.out.println("★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★");
		System.out.println("결제 후 확인 userid : " + userid);
		System.out.println("총 결제 금액 : " + totalPrice);
		System.out.println("departure" + departure );
		System.out.println("departuretime" + departuretime );
		System.out.println("departuredate" + departuredate );
		System.out.println("arrival" + arrival );
		System.out.println("arrivaltime" + arrivaltime );
		System.out.println("arrivaldate" + arrivaldate );
		System.out.println("trainclass" + trainclass );
		System.out.println("trainno" + trainno );
*/		
		
		HashMap<String, Object> map = new HashMap<String, Object>(); 
		
// 		일단 runinfoseq 를 가져와야한다. 
//		(기차번호, 출발지, 도착지로!)
		
		map.put("trainno", trainno);
		map.put("departure", departure);
		map.put("departuredate", departuredate);
		map.put("arrival", arrival);
		
		int runinfoseq = service.getruninfoseq(map);
//		System.out.println("runinfoseq ★★ : " + runinfoseq);

		if(boolnonno)
		{	// 비회원인 경우
	//		System.out.println("★★★ userid.isEmpty()!!!!");
			map.put("userid", "null");
			map.put("nonno", nonno);			
		} 		
		else if(booluserid)
		{
//			System.out.println("★★★ nonno.isEmpty()!!!!!!!!");
			map.put("userid", userid);
			map.put("nonno", 8);			
		}

			
			
		
//		map.put("userid", userid);
//		map.put("nonno", nonno);		
		
		map.put("runinfoseq", runinfoseq);
		map.put("classno", trainclass);
		map.put("tqty", tqty);
		map.put("totalPrice", totalPrice);
		
//		티켓 개요 테이블에 INSERT 하기 
		int n = service.insertticketsum(map);
		
//		결제 테이블에 INSERT 하기 
		int m = service.insertpaysum(map);
		
//		티켓 개요 테이블에서 주문번호 시퀀스 갖고오기 
		int orderseq = service.getorderseq(map);
//		System.out.println("orderseq 가져옵니다 : " + orderseq);
		
//		결제 테이블에서 결제코드번호 시퀀스 갖고오기
		int paymentcode = service.getpaymentcode(map);
		System.out.println("★paymentcode 갖고옵니다 : " + paymentcode);
		
		map.put("orderseq", orderseq);
		map.put("paymentcode", paymentcode);
		
		if ( n == 1 && m == 1)
		{	// 티켓 개요 테이블에 INSERT 성공
			// 결제 테이블에 INSERT 성공
			
//			System.out.println("티켓 개요 테이블 & 결제 테이블 INSERT 성공 ! ");
		
//			좌석번호 가져오기 
			int cnt = 1;
			int insertint = 0;
			int insertpaydet = 0;
			
			for (int i = 0; i<48; i++)
			{
				if (selectedSeatList.indexOf("번") != -1)
				{	
//					System.out.println("selectedSeatList 바꾸기 전 : " + selectedSeatList);
					String seatwithcnt = "";
					seatwithcnt = "seat"+cnt;
					
					int index = selectedSeatList.indexOf("번");
					
					String seat = selectedSeatList.substring(0, index);
					selectedSeatList = selectedSeatList.substring(index+1);
					
//					System.out.println("★ seatwithcnt : "+seatwithcnt);
//					System.out.println("★★ 바꿔준 값 : " + selectedSeatList.substring(index+1));				
//					System.out.println("★★★ seat : "+seat.trim());
					
					map.put("seatno", seat.trim());
					
//					좌석 테이블(final_seat)에 예약한 좌석 넣어주기				
					int insertseats = service.insertseats(map);
					
					if (insertseats==1)
					{	// insert 성공한 경우
						insertint++;
						
						// 예약한 좌석에 대한 좌석 시퀀스 가져오기
						int seatseq = service.getseatseq();
//						System.out.println("예약한 좌석에 대한 좌석시퀀스 : " + seatseq);
						
						map.put("seatseq", seatseq);
						
						int t = 0;
						
						// 티켓 상세 테이블에 INSERT 하기 (final_ticketdetail)
						if( Integer.parseInt(normal) >0 ) 
						{	// 일반이 존재하는 경우
							map.put("ageline", "일반");
							map.put("ppt", ppt);
							
							t = service.insertticketdet(map);
							normal = String.valueOf(( (Integer.parseInt(normal))-1 ));
							
//							System.out.println("일반 좌석 선택한 경우 INSERT : " + t);
						}
						else if (Integer.parseInt(students) >0 )
						{	// 중고생이 존재하는 경우
							map.put("ageline", "중고생");
							map.put("ppt", Math.round((Integer.parseInt(ppt)*0.8)));
							
							t = service.insertticketdet(map);
							students = String.valueOf(( (Integer.parseInt(students))-1 ));
							
//							System.out.println("중고생 좌석 선택한 경우 INSERT : " + t);
						}
						else if (Integer.parseInt(older) >0 )
						{	// 65세 이상이 존재하는 경우
							map.put("ageline", "65세이상");
							map.put("ppt", Math.round((Integer.parseInt(ppt)*0.75)));
							
							t = service.insertticketdet(map);
							older = String.valueOf(( (Integer.parseInt(older))-1 ));
							
//							System.out.println("65세이상 좌석 선택한 경우 INSERT : " + t);
						}
						
						// TICKETNO 가져오기
						int ticketno = service.getticketno();
//						System.out.println("★ticketno : " + ticketno);
						map.put("ticketno", ticketno);
						
						// 결제 상세 테이블에 INSERT 해주기
						insertpaydet = service.insertpaydet(map);
//						System.out.println("★결제 상세 테이블에 insert 됐나? : " + insertpaydet);
					}
					
					cnt++;
					insertpaydet++;
				}
				
				/* TICKETNO 가져오기
				int ticketno = service.getticketno();
				System.out.println("★지금 이것때문인것 같은ㄴ데 ticketno : " + ticketno);
				map.put("ticketno", ticketno);*/
				
				/* 결제 상세 테이블에 INSERT 해주기
				int insertpaydet = service.insertpaydet(map);
				System.out.println("★결제 상세 테이블에 insert 됐나? : " + insertpaydet);*/
			}
			
			if( (cnt-1) == insertint )
			{
//				System.out.println("다 들어갔다!♥♥♥♥♥♥♥♥");
				
				session.removeAttribute("departure");
				session.removeAttribute("arrival");
				session.removeAttribute("trainclass");
				session.removeAttribute("departuredate");
				session.removeAttribute("traintype");
			}
		}

		// 비회원인경우 세션 삭제	
		if(session.getAttribute("nonno") != null)
		{
			session.removeAttribute("nonno");	
			session.removeAttribute("nhp");
		}
		
		
		req.setAttribute("nhp", nhp);
		req.setAttribute("departure", departure);
		req.setAttribute("arrival", arrival);
		req.setAttribute("trainclass", trainclass);
		req.setAttribute("departuredate", departuredate);
		req.setAttribute("traintype", traintype);
		
		
		String cancel = (String)session.getAttribute("changeChk");
		
		if("yes".equalsIgnoreCase(cancel)) {
			
			khxpscNonMemberVO nonloginuser = (khxpscNonMemberVO)session.getAttribute("nonloginuser");
			
			loginuser = (khxpscMemberVO)session.getAttribute("loginuser");	
			
			String cancel_paymentcode = (String)session.getAttribute("cancel_paymentcode");
			
//			System.out.println("########################## cancel_paymentcode ==> " + cancel_paymentcode);
			
			String cancel_orderseq = (String)session.getAttribute("orderseq");
			
			if(cancel_orderseq == null) {
				cancel_orderseq = (String)session.getAttribute("cancel_orderseq");
			}
			
//			System.out.println("########################## cancel_orderseq ==> " + cancel_orderseq);
			
			if(nonloginuser == null && loginuser != null) {
				
				int mbr_setpay = lskservice.getMbr_BookingCancel1(cancel_paymentcode);
				
				int mbr_setorder = lskservice.getMbr_BookingCancel2(cancel_orderseq);
				
//				System.out.println("##################### mbr_setpay => " + mbr_setpay);
//				System.out.println("##################### mbr_setorder => " + mbr_setorder);
				
				req.setAttribute("mbr_setpay", mbr_setpay);
				req.setAttribute("mbr_setorder", mbr_setorder);
				
			}
			else {

				int non_setpay = lskservice.getNon_BookingCancel1(cancel_paymentcode);
				
				int non_setorder = lskservice.getNon_BookingCancel2(cancel_orderseq);
				
//				System.out.println("##################### non_setpay => " + non_setpay);
//				System.out.println("##################### non_setorder => " + non_setorder);
				
				req.setAttribute("non_setpay", non_setpay);
				req.setAttribute("non_setorder", non_setorder);
				
			}
			
			
		}
		
		
		return "khx/payEnd.tiles";
//			└> /Board/src/main/webapp/WEB-INF/views/main/khx.jsp 파일을 생성한다.
		
	} // end of public String payEnd(HttpServletRequest req) ----    
    
    
    
    
 /* ==== #148. Ajax로 검색어 입력시 자동글 완성하기 ③ ====
    ==> jackson JSON 라이브러리와 함께 @ResponseBoady 사용하여 JSON 파싱하기 === //
  
@ResponseBody란?
메소드에 @ResponseBody Annotation이 되어 있으면 return 되는 값은 View 단을 통해서 출력되는 것이 아니라 
HTTP Response Body에 바로 직접 쓰여지게 된다. 
그리고 jackson JSON 라이브러리를 사용할때 주의해야할 점은 
메소드의 리턴타입은 행이 1개 일경우 HashMap<K,V> 이거나 Map<K,V> 이고 
행이 2개 이상일 경우 List<HashMap<K,V>> 이거나 List<Map<K,V>> 이어야 한다.
행이 2개 이상일 경우  ArrayList<HashMap<K,V>> 이거나  ArrayList<Map<K,V>> 이면 안된다.!!!
	     
	        이와같이 jackson JSON 라이브러리를 사용할때의 장점은 View 단이 필요없게 되므로 간단하게 작성하는 장점이 있다. 
	*/

	@RequestMapping(value="/wordSearchShow.action", method={RequestMethod.GET})
	@ResponseBody
	public List<HashMap<String, Object>> wordSearchShow(HttpServletRequest req)
	{			
		System.out.println("wordSearchShow.action 왔다 ");
		
		List<HashMap<String, Object>> returnmapList = new ArrayList<HashMap<String, Object>>();
		
		String colname = req.getParameter("colname");
		String search = req.getParameter("search");
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		map.put("colname", colname);
		map.put("search", search);
		
//		System.out.println("★★ colname : " + colname);
//		System.out.println("★★ search : " + search);
		
		List<HashMap<String,String>> searchWordCompleteList =  service.searchWordCompleteList(map);

		if(searchWordCompleteList != null)
		{
			for (HashMap<String, String> datamap: searchWordCompleteList)
			{
				HashMap<String, Object> submap = new HashMap<String, Object>();
				submap.put("RESULTDATA", datamap.get("SEARCHDATA"));
				
				returnmapList.add(submap);
			}
			
		} // end of if ----
		
		return returnmapList;
		
		
	} // end of public String wordSearchShow() ----
 
    
	
	
// ==== sitemap 사이트맵 ====	
	@RequestMapping(value="/sitemap.action", method={RequestMethod.GET})
	public String header_sitemap(HttpServletRequest req, HttpServletResponse res)
	{
				
		return "khx/sitemap.tiles";
//				└> /Board/src/main/webapp/WEB-INF/views/khx/sitemap.jsp 파일을 생성한다.
		
	} // end of public String index(HttpServletRequest req) ----
	
	
	
// ==== 오늘 하루 그만보기
	@RequestMapping(value="/dontshow.action", method={RequestMethod.GET})
	@ResponseBody
	public int dontshow(HttpServletRequest req, HttpServletResponse res, HttpSession session)
	{
		int n = 0;
		
		String dontshow = req.getParameter("dontshow");
		
//		System.out.println("★☆★☆★"+dontshow);
		
		
		if ("dontshowtrue".equalsIgnoreCase(dontshow))
		{
//			System.out.println("true 이다.....");
			n = 1;
			session.setAttribute("dontshowpop", "dontshowtrue");
		}
		else
		{
			n = 0;
		}
		
		return n;
		
	} // end of public int dontshow() ----
	
	
	
    
}
