
package com.s2jo.khx.psc;


import java.util.HashMap;
import java.util.Random;

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

import com.s2jo.khx.model.jsb.resultAlarmVO;
import com.s2jo.khx.model.psc.khxpscMemberVO;
import com.s2jo.khx.model.psc.khxpscNonMemberVO;
import com.s2jo.khx.model.yyj.MemberVO;
import com.s2jo.khx.service.jsb.JsbService;
import com.s2jo.khx.service.psc.khxNonMemberService;



// ==== #31. 컨트롤러 선언 ====

@Controller
@Component
// XML에서 bean을 만드는 대신에
// 클래스명 앞에 @Component 어노테이션을 쓰면
// 해당 클래스는 bean으로 자동 등록된다.
// 그리고 bean의 id는 해당 클래스명이 된다. (첫 글자는 소문자)

public class KhxpscController {

// ====  의존객체 주입하기 (DI : Dependency Injection) ====
		@Autowired
		public khxNonMemberService service; 

		@Autowired
		public JsbService service2; 
		   
// =====  #1. 비회원 로그인 폼 페이지 요청 =====
	    @RequestMapping(value="/nonloginform.action", method={RequestMethod.GET, RequestMethod.POST})
	    public String header_nonloginEnd(HttpServletRequest req, HttpServletResponse res) 
 	    		throws Exception{
	    //	 System.out.println("비회원 로그인 폼");
	    	
	    	return "nonlogin/nonloginform.tiles";
	    	// /Board/src/main/webapp/WEB-INF/views/nonlogin/nonloginform.jsp 파일을 생성한다.
	    }
   
	    
	    // ===== #2. 비회원 로그인 완료 요청 =====
	    @RequestMapping(value="/nonloginEnd.action", method={RequestMethod.POST})
	    public String nonloginEnd(HttpServletRequest req, HttpServletResponse res ,khxpscNonMemberVO nonloginuser,  HttpSession session) 
 	    		throws Exception{

	    	String nhp = req.getParameter("nhp");
	    	String npwd = req.getParameter("npwd");
	    	String savenhp = req.getParameter("savenhp");
	    	
	    	HashMap<String, String> map = new HashMap<String, String>();
	    	map.put("nhp", nhp);
	    	map.put("npwd", npwd);
	    	map.put("savenhp", savenhp);
	    	
	    	//System.out.println("savenhp확인 : "+ savenhp);
/*	
  로그인을 하려면 아이디와 암호가 암호화 되어 DB에 저장되어진 것과 일치할때만 로그인이 되어지도록 해야 한다.
  서비스단에서 로그인 여부 결과를 int 타입(1 or 0 or -1)으로 받아오겠다.
*/ 
	    	
	    	 int n =service.nonloginEnd(map);
	    	 // 넘겨받은 n 값이 1 이면 아이디와 암호가 일치하는 경우
	    	 // 넘겨받은 n 값이 0 이면 암호가 틀리는 경우
	    	 // 넘겨받은 n 값이 -1 이면 아이디가 없는 경우
	    	 
	    	 // 로그인 결과(1 or 0 or -1)를 request 영역에 저장시켜서 view 단 페이지로 넘긴다.
	    	 req.setAttribute("n", n);
	    	 
	    	 
	    	 
	    	 //로그인 아이디가 존재하지않는 경우
	    	 if(n== -1 ){
	    		 
	    		 String url = (String)session.getAttribute("url");
	    		 req.setAttribute("url", url);
	    		// System.out.println("존재하지 않는 핸드폰번호 입니다!");
	    		 
	    	 }if(n == 0){
	    		 String url = (String)session.getAttribute("url");
	    		 req.setAttribute("url", url);
	    		// System.out.println("존재하지 않는 비밀번호입니다!");

	    	 }
	    	 //로그인되어진경우
	    	 if(n == 1) 
	    	 {
	    		 nonloginuser = service.getNonLoginEnd(nhp);
	    		 String nonno = null;
	    		 
	    		 nonno=nonloginuser.getNonno();
	    		 session.setAttribute("nonloginuser", nonloginuser);
	    		 	session.setAttribute("nonno", nonno);
	    		// System.out.println("비회원 로그인성공!");
	    		 // 로그인을 하지 않은 상태에서 글쓰기, 글수정, 글삭제를 했을때
	    		 // 현재 페이지의 주소를 세션에 "url" 이라는 키값으로
	    		 // 저장해둔 현재 페이지의 주소를 읽어온다.
	    		String url = (String)session.getAttribute("url");
	    		
	    		req.setAttribute("url", url);
	    		
	    		
	    		Cookie Cookie = new Cookie("savenhp", nhp);
	    		
	    		if(savenhp == null){
	    			
	    			Cookie.setMaxAge(7*24*60*60); //쿠키의 생존기간을 7일(단위 초로)설정했다. 이것이 쿠키의 저장이다.,
	    		}else{
	    			Cookie.setMaxAge(0); //쿠키의 생존기간을(0초)로 한다. 이것이 쿠키의 삭제이다.
	    		}
	    				
	    		Cookie.setPath("/");
				// 쿠키가 사용되어질 디렉토리 정보 설정은 cookie.setPath("사용되어질 경로"); 로 한다.
				// 만약에 "사용되어질 경로" 가 "/" 일 경우 해당 도메인의 모든 페이지에서 쿠키사용이 가능하다.
	    	
	    		res.addCookie(Cookie);
	    	 
	    	 }
	    	 
	    	 map.get("savenhp");
	    	//	System.out.println("savenhp보자 : "+ savenhp);
	    	return "nonlogin/nonloginEnd.tiles";
	    	// /Board/src/main/webapp/WEB-INF/views/login/loginEnd.jsp 파일을 생성한다.
	    }
		
  
	    // ===== #3. 비회원 로그아웃 완료 요청 =====
	    @RequestMapping(value="/nonlogout.action", method={RequestMethod.GET})
	    public String nonlogout(HttpServletRequest req, HttpSession session) 
 	    		throws Exception{ 
	    	session = req.getSession();
	    	session.invalidate();
	    	
	    	return "nonlogin/nonlogout.tiles";
	    	// /Board/src/main/webapp/WEB-INF/views/login/logout.jsp 파일을 생성한다.
	    }

	    ////////////////////////////////////////////////////////////////////////////////////////////
	      		   
	 // =====  #4.정회원 로그인 폼 페이지 요청 =====
	 	    @RequestMapping(value="/loginform.action", method={RequestMethod.GET, RequestMethod.POST})
	 	    public String header_loginEnd(HttpServletRequest req, HttpServletResponse res) 
	 	    		throws Exception{
	 	    	
	 	    	//System.out.println("로그인 폼페이지 출력!!");
	 	   
	 	    	
	 	    	return "login/loginform.tiles";
	 	    	// /Board/src/main/webapp/WEB-INF/views/login/loginform.jsp 파일을 생성한다.
	 	    }
	    
	    
	 	    // ===== #5. 정회원 로그인 여부(아이디, 비밀번호) 확인 및 아이디 저장 =====
	 	    @RequestMapping(value="/loginEnd.action", method={RequestMethod.POST})
	 	    public String loginEnd(HttpServletRequest req, HttpServletResponse res , khxpscMemberVO loginuser,   resultAlarmVO getResultAlarm , HttpSession session) 
	 	    		throws Exception{

	 	    	String userid = req.getParameter("userid");
		    	String saveuserid = req.getParameter("saveuserid");	 	    	
	 	    	String pwd = req.getParameter("pwd");
	 	    	String email = req.getParameter("email");
	 	    	String hp = req.getParameter("hp");
	 	    	
	 	    	HashMap<String, String> map = new HashMap<String, String>();
	 	    	map.put("userid", userid);
	 	    	map.put("pwd", pwd);
		    	map.put("saveuserid", saveuserid);	 	 
		    	map.put("email", email);
		    	map.put("hp", hp);

	 	    	 int n =service.loginEnd(map);//그냥 로그인 되어있는지 0 또는 1로 확인한다.
	 	    	 // 넘겨받은 n 값이 1 이면 아이디와 암호가 일치하는 경우
	 	    	 // 넘겨받은 n 값이 0 이면 암호가 틀리는 경우
	 	    	 // 넘겨받은 n 값이 -1 이면 아이디가 없는 경우
	 	    	 
		 	    //	System.out.println("로그인여부 확인해오는 컨트롤러로 값을 가져오나??");
	 	    	 //여기에서 n에 담겨있는 것을 다시 db로 보내서 userid, pw값을 가져와서 아이디 저장을 실시하자.
	 	    	 req.setAttribute("n", n);
	 	    	 if(n == 1)//로그인이 가능한 경우 
	 	    	 {
	 	    		loginuser = service.getLoginEnd(map);
	 	    		getResultAlarm = service2.getResultAlarm(userid); //resultalarm 테이블 불러오기
	 	    		
	 	    		session.setAttribute("getResultAlarm", getResultAlarm);
	 	    		session.setAttribute("loginuser", loginuser);
	 	    		 //System.out.println("정회원 로그인성공! 세션 담은후");
	 	    		 // 로그인을 하지 않은 상태에서 글쓰기, 글수정, 글삭제를 했을때
	 	    		 // 현재 페이지의 주소를 세션에 "url" 이라는 키값으로
	 	    		 // 저장해둔 현재 페이지의 주소를 읽어온다.
	 	    		String url = (String)session.getAttribute("url");
	 	    		 req.setAttribute("url", url);
	 	    		Cookie Cookie = new Cookie("saveuserid", userid);
	 	    		if(saveuserid == null){
	 	    			Cookie.setMaxAge(7*24*60*60); //쿠키의 생존기간을 7일(단위 초로)설정했다. 이것이 쿠키의 저장이다.,
	 	    		}else{
	 	    			Cookie.setMaxAge(0); //쿠키의 생존기간을(0초)로 한다. 이것이 쿠키의 삭제이다.
	 	    		}
	 	    		Cookie.setPath("/");
	 				// 쿠키가 사용되어질 디렉토리 정보 설정은 cookie.setPath("사용되어질 경로"); 로 한다.
	 				// 만약에 "사용되어질 경로" 가 "/" 일 경우 해당 도메인의 모든 페이지에서 쿠키사용이 가능하다.
	 	    		res.addCookie(Cookie);
	 	    	 }
	 	    	 if(n == 0) //로그인이 불가능한 경우,암호가 틀리는 경우
	 	    	 {
	 	    		 
	 	    	//	 System.out.println("비밀번호가 틀렸습니다!");
	 	    		 // 로그인을 하지 않은 상태에서 글쓰기, 글수정, 글삭제를 했을때
	 	    		 // 현재 페이지의 주소를 세션에 "url" 이라는 키값으로
	 	    		 // 저장해둔 현재 페이지의 주소를 읽어온다.
	 	    		String url = (String)session.getAttribute("url");
	 	    		 req.setAttribute("url", url);
	 	    	 }	 	
	 	    	 if(n == -1) //로그인이 불가능한 경우,아이디가 없는 경우
	 	    	 {
	 	    		 
	 	    	//	 System.out.println("아이디가 없습니다.!");
	 	    		 // 로그인을 하지 않은 상태에서 글쓰기, 글수정, 글삭제를 했을때
	 	    		 // 현재 페이지의 주소를 세션에 "url" 이라는 키값으로
	 	    		 // 저장해둔 현재 페이지의 주소를 읽어온다.
	 	    		String url = (String)session.getAttribute("url");
	 	    		 req.setAttribute("url", url);

	 	    	 }
	 	    	 if(n == 2)
	 	    	 {
	 	    		 String url = (String)session.getAttribute("url");
	 	    		 req.setAttribute("url", url);
	 	    		 
	 	    	 }
		    	 map.get("saveuserid");
		    	//	System.out.println("saveuserid보자 : "+ saveuserid);
		    		
		    	req.setAttribute("loginuser", loginuser);
		    	
	 	    	return "login/loginEnd.tiles";
	 	    	// /Board/src/main/webapp/WEB-INF/views/login/loginEnd.jsp 파일을 생성한다.
	 	    }
	 	    
	 		
	
	 	    // ===== #6. 정회원 로그아웃 완료 요청 =====
	 	    @RequestMapping(value="/logout.action", method={RequestMethod.GET})
	 	    public String logout(HttpServletRequest req, HttpSession session)
	 	    		throws Exception{ 
	 	    	
	 	    	session.invalidate();
	 	    	
	 	    	return "login/logout.tiles";
	 	    	// /Board/src/main/webapp/WEB-INF/views/login/logout.jsp 파일을 생성한다.
	 	    }

	 	    // ===== #7. 회원가입 폼페이지 요청 =====	 	
	 	    @RequestMapping(value="/memberRegister.action", method={RequestMethod.GET})
	 	    public String header_memberRegister(HttpServletRequest req, HttpServletResponse res, khxpscMemberVO loginuser) 
	 	    		throws Exception{

		    	// System.out.println("회원가입 페이지 뜨나?");
	 	    	 
	 	    	return "member/memberRegister.tiles";
	 	    	
			}//end of 회원가입

	 	    
	 	    // ===== #8. 회원가입 완료 폼페이지 요청 =====	 	
	 	    @RequestMapping(value="/memberRegisterEnd.action", method={RequestMethod.GET, RequestMethod.POST})
	 	    public String memberRegisterEnd(HttpServletRequest req, HttpServletResponse res, khxpscMemberVO kmvo) 
	 	    		throws Exception{

		 	    	HashMap<String, Object> membermap = new HashMap<String, Object>();
		 	    
		 	    	String userid = req.getParameter("userid");
		 	    	
		 	    	
//		 	    	membermap.put("userid", kmvo.getUserid());
		 	    	membermap.put("userid", userid);
		 	    	membermap.put("name", kmvo.getName());
		 	    	membermap.put("pwd", kmvo.getPwd());
		 	    	membermap.put("email", kmvo.getEmail());
		 	    	membermap.put("hp", kmvo.getHp());
		 	    	membermap.put("post", kmvo.getPost());
		 	    	membermap.put("addr1", kmvo.getAddr1());
		 	    	membermap.put("addr2", kmvo.getAddr2());
		 	    	membermap.put("joindate", kmvo.getJoindate());
		 	    	membermap.put("status", kmvo.getStatus());
		 	    	membermap.put("birthday", kmvo.getBirthday());
		 	    	membermap.put("gender", kmvo.getGender());

		 	    	//System.out.println("membermap"+membermap);
		 	    	Object n =service.memberRegisterEnd(membermap);

	 	    	 req.setAttribute("n", n);
	 	    	 
	 	    	 req.setAttribute("userid", kmvo.getUserid()); 
	 	    	 req.setAttribute("name", kmvo.getName()); 
	 	    	 req.setAttribute("pwd", kmvo.getPwd()); 
	 	    	 req.setAttribute("email", kmvo.getEmail()); 
	 	    	 req.setAttribute("hp", kmvo.getHp()); 
	 	    	 req.setAttribute("post", kmvo.getPost()); 
	 	    	 req.setAttribute("addr1", kmvo.getAddr1()); 
	 	    	 req.setAttribute("addr2", kmvo.getAddr2()); 
	 	    	 req.setAttribute("joindate", kmvo.getJoindate()); 	
	 	    	 req.setAttribute("status", kmvo.getStatus()); 	
	 	    	 req.setAttribute("birthday", kmvo.getBirthday()); 
	 	    	 req.setAttribute("gender", kmvo.getGender());  
	 	    	 
		    	// System.out.println("회원가입 완료인가?? 페이지 뜨나?");
		    	 
	 	 	    return "main/khx.tiles";
	 
	 	    		 
			}//end of 회원가입

	 	    
	 	    //  ==> jackson JSON 라이브러리와 함께 @ResponseBoady 사용하여 JSON 파싱하기 === //
	 		
	 	    /*   @ResponseBody란?
	 		     메소드에 @ResponseBody Annotation이 되어 있으면 return 되는 값은 View 단을 통해서 출력되는 것이 아니라 
	 		     HTTP Response Body에 바로 직접 쓰여지게 된다. 
	 			
	 		     그리고 jackson JSON 라이브러리를 사용할때 주의해야할 점은 
	 		     메소드의 리턴타입은 행이 1개 일경우 HashMap<K,V> 이거나 
	 		                                    Map<K,V> 이고 
	 			                    행이 2개 이상일 경우 List<HashMap<K,V>> 이거나
	 			                                    List<Map<K,V>> 이어야 한다.
	 			                    행이 2개 이상일 경우  ArrayList<HashMap<K,V>> 이거나
	 			                                     ArrayList<Map<K,V>> 이면 안된다.!!!
	 		     
	 		     이와같이 jackson JSON 라이브러리를 사용할때의 장점은 View 단이 필요없게 되므로 간단하게 작성하는 장점이 있다. 
	 		*/
	 	    
	 	    // ====== #9.아이디 중복확인 하기!!
	 	    @RequestMapping(value="/idDuplicateCheck.action", method={RequestMethod.GET, RequestMethod.POST})
	 	    @ResponseBody
	 	    public int idDuplicateCheck(HttpServletRequest req)
	 	    {
	 	   // 	System.out.println("아이디 중복검사 잘되나?");
	 	    	
	 	    	 String useridforcheck = req.getParameter("useridforcheck");
	 	    	 
		 	    int n = service.idDuplicateCheck(useridforcheck);
		 	    	
		 	    
	 	    	return n;
	 	    }//end of public List<HashMap<String,Object>> idDuplicateCheck(HttpServletRequest req){

	 	    ////////////////////////////////////////////////////////////////////////////////////////
	 	// #10.비밀번호 찾기
	 	    @RequestMapping(value="/pwdFind.action", method={RequestMethod.GET, RequestMethod.POST})
	 	      public String pwdFind(HttpServletRequest req) {
	 	    //   System.out.println("비밀번호찾기 컨트롤 시작");
	 	       
	 	       String method = req.getMethod();
	 	       
	 	       if (method.equalsIgnoreCase("POST")) { // 찾기 버튼을 눌렀을때만 실행!!

	 	    	  String userid = req.getParameter("userid");
	 	          String email = req.getParameter("email");

	 	          HashMap<String, String> map = new HashMap<String, String>();
	 	          map.put("userid", userid);
	 	          map.put("email", email);

	 	          int n = service.pwdFind(map);
	 	          
	 	          if (n == 1) { // 이메일이 존재하면

	 	             // ***** 인증메일 발송 ******
	 	             GoogleMail mail = new GoogleMail();

	 	             // 인증키를 생성한다.
	 	             Random rnd = new Random();

	 	             try {
	 	                char randchar = ' ';
	 	                int randnum = 0;
	 	                String certificationCode = "";

	 	                for (int i = 0; i < 5; i++) {
	 	                   // min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면
	 	                   // int rndnum = rnd.nextInt(max - min + 1) + min;

	 	                   randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
	 	                   certificationCode += randchar;
	 	                }

	 	                for (int i = 0; i < 7; i++) {
	 	                   randnum = rnd.nextInt(9 - 0 + 1) + 0;
	 	                   certificationCode += randnum;
	 	                }

	 	                mail.sendmail(email, certificationCode);
	 	                req.setAttribute("certificationCode", certificationCode);

	 	             } catch (Exception e) {
	 	                e.printStackTrace();

	 	                n = -1;
	 	                req.setAttribute("n", n);
	 	                req.setAttribute("sendFailmsg", "메일발송이 실패했습니다.");

	 	             } // end of try ~ catch---------------------

	 	          } else { // 이메일이 존재하지 않으면
	 	             n = 0;
	 	          }
	 	          req.setAttribute("method", "POST");
	 	          req.setAttribute("n", n);
	 	          req.setAttribute("userid", userid);
	 	          req.setAttribute("email", email);

	 	       }

	 	       return "pwdFind.notiles";
	 	    }
	 	    
	 	    
	 	    
	 	    
	 	   // ===== #11.비밀번호인증하고 비번변경하기  =====
	 	    @RequestMapping(value="/pwdConfirm.action", method={RequestMethod.GET,RequestMethod.POST})
	 	    public String pwdConfirm(HttpServletRequest req) {
	 	    //	System.out.println("비밀번호변경 컨트롤 시작");
	 	    	
	 	       String method = req.getMethod();
	 	      req.setAttribute("method", method);
	 	      
	 	      String email = req.getParameter("email");
	 	      req.setAttribute("email", email);
	 	      
	 	      if("POST".equalsIgnoreCase(method)) {  // 비밀번호 변경하기를 클릭했으면
	 	         String pwd = req.getParameter("pwd");
	 	         String pwd2 = req.getParameter("pwd2");
	 	         
	 	         
	 	         HashMap<String, String> map = new HashMap<String, String>();
	 	         map.put("email", email);
	 	         map.put("pwd", pwd);
	 	         
	 	         int n = 0;
	 	         if(email != null && pwd != null) {
	 	            n = service.updatePwdUser(map);
	 	            
	 	         }
	 	         req.setAttribute("n", n);
	 	         req.setAttribute("method", "POST");
	 	         req.setAttribute("email", email);
	 	         req.setAttribute("pwd", pwd);
	 	         req.setAttribute("pwd2", pwd2);

	 	      }
	 	       
	 	       return "pwdConfirm.notiles";
	 	       // /hajota/src/main/webapp/WEB-INF/notiles/pwdConfirm.jsp 파일을 생성한다.
	 	    }
	 	    //////////////////////////////////////////////////////////////////////////////////////////
	 	    
	 	    
		    // ===== #12. 마이페이지 폼페이지 요청 =====	
	 	    @RequestMapping(value="/Mypage.action", method={RequestMethod.GET})
	 	    public String requireLogin_Mypage(HttpServletRequest req, HttpServletResponse res) 
	 	    		throws Exception{

	 	    	  System.out.println("마이페이지 페이지 뜨나?");
	 	   
	 	          return "/member/Mypage.tiles";
	 	    	
			}//end of 마이페이지 폼페이지 요청
	 	    
	 	    
	 	    // ===== #13. 마이페이지에서 이메일 발송으로 비밀번호 변경
	 	    @RequestMapping(value="/MypagePwdFind.action", method={RequestMethod.GET, RequestMethod.POST})
	 	      public String MypagePwdFind(HttpServletRequest req) {
	 	       System.out.println("마이페이지에서 비밀번호찾기 컨트롤 시작");
	 	    	
	 	       
	 	       String method = req.getMethod();
	 	       
	 	       if (method.equalsIgnoreCase("POST")) { // 찾기 버튼을 눌렀을때만 실행!!

	 	    	  String userid = req.getParameter("userid");
	 	          String email = req.getParameter("email");

	 	          HashMap<String, String> map = new HashMap<String, String>();
	 	          map.put("userid", userid);
	 	          map.put("email", email);

	 	          int n = service.MypagePwdFind(map);
	 	          
	 	          if (n == 1) { // 이메일이 존재하면

	 	             // ***** 인증메일 발송 ******
	 	             GoogleMail mail = new GoogleMail();

	 	             // 인증키를 생성한다.
	 	             Random rnd = new Random();

	 	             try {
	 	                char randchar = ' ';
	 	                int randnum = 0;
	 	                String certificationCode = "";

	 	                for (int i = 0; i < 5; i++) {
	 	                   // min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면
	 	                   // int rndnum = rnd.nextInt(max - min + 1) + min;

	 	                   randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
	 	                   certificationCode += randchar;
	 	                }

	 	                for (int i = 0; i < 7; i++) {
	 	                   randnum = rnd.nextInt(9 - 0 + 1) + 0;
	 	                   certificationCode += randnum;
	 	                }

	 	                mail.sendmail(email, certificationCode);
	 	                req.setAttribute("certificationCode", certificationCode);

	 	             } catch (Exception e) {
	 	                e.printStackTrace();

	 	                n = -1;
	 	                req.setAttribute("n", n);
	 	                req.setAttribute("sendFailmsg", "메일발송이 실패했습니다.");

	 	             } // end of try ~ catch---------------------

	 	          } else { // 이메일이 존재하지 않으면
	 	             n = 0;
	 	          }
	 	          req.setAttribute("method", "POST");
	 	          req.setAttribute("n", n);
	 	          req.setAttribute("userid", userid);
	 	          req.setAttribute("email", email);

	 	       }
	 	       return "/modal/MypagePwdFind.tiles";
	 	    }//end of	 마이페이지에서 비밀번호 변경을위한 이메일로 인증번호 발송
	 	    	
	 	    
	 	    
	 	    
	 	    
	 	   // ===== #11.비밀번호인증하고 비번변경하기  =====
	 	    @RequestMapping(value="/MypagePwdConfirm.action", method={RequestMethod.GET,RequestMethod.POST})
	 	    public String MypagePwdConfirm(HttpServletRequest req) {
	 	    //	System.out.println("비밀번호변경 컨트롤 시작");
	 	    	
	 	       String method = req.getMethod();
	 	      req.setAttribute("method", method);
	 	      
	 	      String email = req.getParameter("email");
	 	      req.setAttribute("email", email);
	 	      
	 	      if("POST".equalsIgnoreCase(method)) {  // 비밀번호 변경하기를 클릭했으면
	 	         String pwd = req.getParameter("pwd");
	 	         String pwd2 = req.getParameter("pwd2");
	 	         
	 	         
	 	         HashMap<String, String> map = new HashMap<String, String>();
	 	         map.put("email", email);
	 	         map.put("pwd", pwd);
	 	         
	 	         int n = 0;
	 	         if(email != null && pwd != null) {
	 	            n = service.updateMypagePwdUser(map);
	 	            
	 	         }
	 	         req.setAttribute("n", n);
	 	         req.setAttribute("method", "POST");
	 	         req.setAttribute("email", email);
	 	         req.setAttribute("pwd", pwd);
	 	         req.setAttribute("pwd2", pwd2);

	 	      }
	 	       
	 	       return "/modal/MypagePwdConfirm.tiles";
	 	       // /hajota/src/main/webapp/WEB-INF/notiles/pwdConfirm.jsp 파일을 생성한다.
	 	    }
	 	    //////////////////////////////////////////////////////////////////////////////////////////
	 	    
	 	    
	 	    
	 	    
	 	    
	 	    //회원탈퇴
	 		@RequestMapping(value = "/UserIDDelete.action", method = { RequestMethod.GET, RequestMethod.POST })
	 		public String UserIDDelete(HttpServletRequest req, khxpscMemberVO knmvo, HttpSession session) {
	 			HashMap<String, String> map = new HashMap<String, String>();

	 			String deleteuserid = req.getParameter("deleteuserid");

	 	//		System.out.println("@@@@@@@@@@@@@@@@@deleteuserid" + deleteuserid);

	 			map.put("deleteuserid", deleteuserid);

	 			int n = service.getDeleteUserID(map);

	 			req.setAttribute("n", n);
	 			req.removeAttribute("loginuser");
	 			
	 			session.invalidate();
	 			return "/member/UserIDDelete.tiles";
	 			

	 		} // end of public String index(HttpServletRequest req) ----
	 	    			
	 	    			
	 	    			
	 	   
	 		
	 		
	 		
	 		
	 		
	 		
	 		
	 		
	 		
	 		
	 		
	 		
	 		
	 		
	 		
	 		
}//end of public class KhxpscController {
