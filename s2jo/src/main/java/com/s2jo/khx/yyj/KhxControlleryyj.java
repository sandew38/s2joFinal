

package com.s2jo.khx.yyj;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.mail.search.IntegerComparisonTerm;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.annotation.SessionScope;

import com.s2jo.khx.common.FileManager;
import com.s2jo.khx.model.psc.khxpscMemberVO;
import com.s2jo.khx.model.yyj.AdminMemberVO;
import com.s2jo.khx.model.yyj.MemberVO;
import com.s2jo.khx.model.yyj.PaysummaryVO;
import com.s2jo.khx.model.yyj.lossAdminVO;
import com.s2jo.khx.model.yyj.lossVO;
import com.s2jo.khx.model.yyj.trainVO;
import com.s2jo.khx.service.kyj.KhxService;
import com.s2jo.khx.service.yyj.KhxServiceyyj;

import oracle.net.aso.b;

// ==== #31. 컨트롤러 선언 ====

@Controller
@Component
// XML에서 bean을 만드는 대신에
// 클래스명 앞에 @Component 어노테이션을 쓰면
// 해당 클래스는 bean으로 자동 등록된다.
// 그리고 bean의 id는 해당 클래스명이 된다. (첫 글자는 소문자)

public class KhxControlleryyj {

	// ==== #33. 의존객체 주입하기 (DI : Dependency Injection) ====

	private static final String sessionScope = null;

	@Autowired
	private KhxServiceyyj service;

	// ==== #130. 파일 업로드 & 다운로드를 위한 FileManager 클래스 의존 객체 주입하기
	@Autowired
	private FileManager filemanager;

	// 관리자 메인페이지 요청 //

	@RequestMapping(value = "/khxyyj.action", method = { RequestMethod.GET })

	public String index(HttpServletRequest req,MemberVO mbo) {

    /*String userid = req.getParameter(mbo.getUserid());
    System.out.println("userid@@@@@@@@@@@@@@@@@@@확인용 " +userid);
    String joindate = req.getParameter("joindate");
	String day =req.getParameter("day");
	String hour = req.getParameter("hour");
	String minute = req.getParameter("minute");
	String second = req.getParameter("second");
*/
		
		
		
/*		HashMap<String, String> map = new HashMap<String,String>();
		map.put("userid", mbo.getUserid());
		map.put("joindate", mbo.getJoindate());
		map.put("day",day);
		map.put("hour",hour);
		map.put("minute",minute);
		map.put("second", second);
		
*/		
	//	List<MemberVO> timelinelist = service.gettimelinelist(map);
		List<HashMap<String, String>> timelinelist = service.gettimelinelist();
		
		req.setAttribute("timelinelist", timelinelist);
	   
		System.out.println(timelinelist);
		/*System.out.println("키값확인 : "+timelinelist.get(index));*/
		return "usermanage/khxyyj.tiles3";
		
		
		// └> /Board/src/main/webapp/WEB-INF/views/main/khx.jsp 파일을 생성한다.

	} // end of public String index(HttpServletRequest req) ----

	// 스크린락 //
	@RequestMapping(value = "/screenlock.action", method = { RequestMethod.GET })

	public String screenlock(HttpServletRequest req, HttpSession session) {

	khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null || !("admin").equals(loginuser.getUserid()) ){
		  String msg = "관리자만들어와";
		  String loc = "javascript:history.();";	
				  
		  req.setAttribute("msg", msg);
		  req.setAttribute("loc", loc);
		
		return "msg.notiles";
		
		}
		
		else{
		
		
       List<HashMap<String, String>> screenLock = service.getscreenLock();
		
		req.setAttribute("screenLock", screenLock);
		
		System.out.println("screenLock@@@@@@@@@@@@@@@@?" +screenLock );
		return "screenlock.notiles";
		
		

	}
	}
	
	// 분실물 리스트(유저등록) //
	@RequestMapping(value = "/lossuseryyj.action", method = { RequestMethod.GET })

	public String lossuser(HttpServletRequest req,HttpSession session) {

	    
		khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null || !("admin").equals(loginuser.getUserid()) ){
		  String msg = "관리자만들어와";
		  String loc = "javascript:history.();";	
				  
		  req.setAttribute("msg", msg);
		  req.setAttribute("loc", loc);
		
		return "msg.notiles";
		
		}
		
		else{
			String pageNo = req.getParameter("pageNo");

			int totalCount1 = 0; // 총게시물 건수
			int sizePerPage = 5; // 한 페이지당 보여줄 게시물 갯수 (예: 3, 5, 10)
			int currentShowPageNo = 1; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
			int totalPage = 0; // 총페이지수(웹브라우저상에 보여줄 총 페이지 갯수)

			int start1 = 0; // 시작 행 번호
			int end1 = 0; // 끝 행 번호
			int startPageNo = 0; // 페이지바에서 시작될 페이지 번호
			/*
			 * "페이지바" 란?
			 * 
			 * 이전5페이지 [1][2][3][4][5] 다음5페이지 이전5페이지 [6][7][8][9][10] 다음5페이지 와 같이
			 * 이전5페이지 [1][2][3][4][5] 다음5페이지 또는 이전5페이지 [6][7][8][9][10] 다음5페이지 를
			 * "페이지바" 라고 부른다. startPageNo 는 1 또는 6 을 말한다.
			 */

			int loop = 0; // startPageNo 값이 증가할때 마다 1씩 증가하는 용도.
			int blocksize = 5; // "페이지바" 에 보여줄 페이지의 갯수

			if (pageNo == null) {
				// 게시판 초기화면에 보여지는 것은
				// req.getParameter("pageNo"); 값이 없으므로
				// pageNo 는 null 이 된다.

				currentShowPageNo = 1;
				// 즉, 초기화면은 /list.action?pageNo=1 로 하겠다는 말이다.

			} else {
				currentShowPageNo = Integer.parseInt(pageNo);
				// GET 방식으로 파라미터 pageNo 에 넘어온 값을
				// 현재 보여주고자 하는 페이지로 설정한다.
			}


			start1 = ((currentShowPageNo - 1) * sizePerPage) + 1;
			end1 = start1 + sizePerPage - 1;

			// List<lossVO> lossList = service.lossList();

			String colname1 = req.getParameter("colname1");
			String search1 = req.getParameter("search1");

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("colname1", colname1);
			map.put("search1", search1);

			System.out.println("search1 불러오니 ? 불러옴 ^^ @@@@@@@@@@@@@@@@2" + search1);
			// ===== #109. 페이징 처리를 위해 start, end 를 map 에 추가하여 DB에서 select 되어지도록 한다.
			// =====

			map.put("start1", String.valueOf(start1)); // 키값 start, 밸류값은 해쉬맵이 String
														// 타입인데 start 는 int 타입이어서
														// String 타입으로 변경함.
			map.put("end1", String.valueOf(end1)); // 키값 end, 밸류값은 해쉬맵이 String 타입인데
													// end 는 int 타입이어서 String 타입으로
													// 변경함.

			List<lossVO> lossList = service.lossList(map);

			totalCount1 = service.gettotalcount1(map);

			totalPage = (int) Math.ceil((double) totalCount1 / sizePerPage);

			String pagebar1 = "";
			pagebar1 += "<ul>";
	
			loop = 1;

			// **** !!! 페이지바의 시작 페이지번호(startPageNo)값 만들기 --- 공식임 !!!!
			startPageNo = ((currentShowPageNo - 1) / blocksize) * blocksize + 1;
				

			// **** 이전5페이지 만들기 ****

			if (startPageNo == 1) {
				// 첫 페이지바에 도달한 경우
				pagebar1 += String.format("&nbsp;&nbsp;[이전%d페이지]", blocksize);
			} else {
				// 첫 페이지바가 아닌 두번째 이상 페이지바에 온 경우

				if (colname1 == null || search1 == null) {
					// 검색어가 없는 경우
					pagebar1 += String.format(
							"&nbsp;&nbsp;<a href='/khx/lossuseryyj.action?pageNo=%d'>[이전%d페이지]</a>&nbsp;&nbsp;",
							startPageNo - 1, blocksize); // 처음 %d 에는 startPageNo값 ,
															// 두번째 %d 에는 페이지바에 나타낼
															// startPageNo값 이다.
				} else {
					// 검색어가 있는 경우
					pagebar1 += String.format(
							"&nbsp;&nbsp;<a href='/khx/lossuseryyj.action?pageNo=%d&colname1=%s&search1=%s'>[이전%d페이지]</a>&nbsp;&nbsp;",
							startPageNo - 1, colname1, search1, blocksize); // 검색어
																			// 있는 경우
				}
			}

			// **** 이전5페이지 와 다음5페이지 사이에 들어가는 것을 만드는 것
			while (!(loop > blocksize || startPageNo > totalPage)) {

				if (startPageNo == currentShowPageNo) {
					pagebar1 += String.format(
							"&nbsp;&nbsp;<span style='color:red; font-weight:bold; text-decoration:underline;'>%d</span>&nbsp;&nbsp;",
							startPageNo);
				} else {
					if (colname1 == null || search1 == null) {
						// 검색어가 없는 경우
						pagebar1 += String.format(
								"&nbsp;&nbsp;<a href='/khx/lossuseryyj.action?pageNo=%d'>%d</a>&nbsp;&nbsp;", startPageNo,
								startPageNo); // 처음 %d 에는 startPageNo값 , 두번째 %d 에는
												// 페이지바에 나타낼 startPageNo값 이다.
					} else {
						// 검색어가 있는 경우
						pagebar1 += String.format(
								"&nbsp;&nbsp;<a href='/khx/lossuseryyj.action?pageNo=%d&colname1=%s&search1=%s'>%d</a>&nbsp;&nbsp;",
								startPageNo, colname1, search1, startPageNo); // 검색어
																				// 있는
																				// 경우
					}
				}

				loop++;
				startPageNo++;

			} // end of while--------------------

			// **** 다음5페이지 만들기 ****
			if (startPageNo > totalPage) {
				// 마지막 페이지바에 도달한 경우
				pagebar1 += String.format("&nbsp;&nbsp;[다음%d페이지]", blocksize);
			} else {
				// 마지막 페이지바가 아닌 경우

				if (colname1 == null || search1 == null) {
					// 검색어가 없는 경우
					pagebar1 += String.format(
							"&nbsp;&nbsp;<a href='/khx/lossuseryyj.action?pageNo=%d'>[다음%d페이지]</a>&nbsp;&nbsp;",
							startPageNo, blocksize); // 처음 %d 에는 startPageNo값 , 두번째
														// %d 에는 페이지바에 나타낼
														// startPageNo값 이다.
				} else {
					// 검색어가 있는 경우
					pagebar1 += String.format(
							"&nbsp;&nbsp;<a href='/khx/lossuseryyj.action?pageNo=%d&colname1=%s&search1=%s'>[다음%d페이지]</a>&nbsp;&nbsp;",
							startPageNo, colname1, search1, blocksize); // 검색어 있는 경우
				}
			}

			pagebar1 += "</ul>";

			req.setAttribute("pagebar1", pagebar1);
			req.setAttribute("start1", start1);
			req.setAttribute("end1", end1);
			req.setAttribute("colname1", colname1);
			req.setAttribute("search1", search1);

			req.setAttribute("lossList", lossList);

			return "lossyyj/lossuseryyj.tiles3";
			// └> /s2jo/src/main/webapp/WEB-INF/views/khx/booking.jsp 파일을 생성한다.

		} // end of public String index(HttpServletRequest req) ----
	
			
		}
		
		
		
	
	
	

	// 유실물등록 폼페이지 요청 //

	@RequestMapping(value = "/registerusilyyj.action", method = { RequestMethod.GET })

	public String registerusilyyj(HttpServletRequest req, HttpServletResponse res , HttpSession session) {
 /*    khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null || !("admin").equals(loginuser.getUserid()) ){
		  String msg = "관리자만들어와";
		  String loc = "javascript:history.();";	
				  
		  req.setAttribute("msg", msg);
		  req.setAttribute("loc", loc);
		
		return "msg.notiles";
		
		}
		
		else{
		*/return "lossyyj/registerusilyyj.tiles";
		}
		
		
	/*}*/ // end of public String index(HttpServletRequest req) ----

	// 유실물 등록(유저) //

	@RequestMapping(value = "/regiseterEnd.action", method = { RequestMethod.POST })

	public String regiseterEnd(HttpServletRequest req, HttpServletResponse res, lossVO lossvo , HttpSession session) {
/*
khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null || !("admin").equals(loginuser.getUserid()) ){
		  String msg = "관리자만들어와";
		  String loc = "javascript:history.();";	
				  
		  req.setAttribute("msg", msg);
		  req.setAttribute("loc", loc);
		
		return "msg.notiles";
		
		}
		
		else {*/
		// **** 첨부파일이 있는지 없는지 ? ****
		if (!lossvo.getFileimg().isEmpty()) { // 첨부 파일이 있는 경우 이라면(attach가 비어있지
												// 않다라면)
												// DB에 정보를 insert 를 하기 전 파일을 업로드
												// 하겠다.

			/*
			 * 1. 사용자가 보낸 파일을 was(톰캣서버)의 특정 폴더에 저장해주어야 한다. >>>> 파일이 업로드 되어질 특정
			 * 경로(폴더)지정해주기. 그래서 우리는 was의 webapp/resoutces/files 라는 폴더로 정해주겠다.
			 * 
			 */
			// WAS 의 webapp 의 절대경로를 알아 와야한다.
			String rootpath = req.getSession().getServletContext().getRealPath("/");
			String path = rootpath + "resources" + File.separator + "userregistfiles";
			// path 가 첨부파일들이 저장될 was() 의

			System.out.println(">>>> 확인용 path ==> " + path);

			// C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\serregistfiles
			// userregistfiles 는 유저가 첨부파일을 등록한 곳이다.
			// 관리자에서 받아올꺼면 file폴더로 가면된다.

			// 2. 파일첨부를 위한 변수의 설정 및 값을 초기화한 후 파일올리기

			String newFileName = "";
			// WAS(톰캣) 디스크에 저장한 파일명 이다.

			byte[] bytes = null;
			// 첨부파일을 WAS(톰캣) 디스크에 저장할때 사용되는 용도!

			long filesize = 0; ////////////////////////
			// 파일크기를 읽어오기 위한 용도.

			try {
				// 첨부된 파일을 byte[] 배열의 타입으로 얻어오기
				bytes = lossvo.getFileimg().getBytes();
				/// getBytes()는 첨부된 파일을 바이트단위로 파일을 다 읽어오는 것이다.

				// === 파일을 업로드 해주기 ===

				newFileName = filemanager.doFileUpload(bytes, lossvo.getFileimg().getOriginalFilename(), path);
				// getOriginalFilename() 은 첨부된 파일의 실제 파일명 (문자열) 을 얻어오는 것이다.

				System.out.println(">>>> 확인용 : " + newFileName);
				// >>>> 확인용 : 20170608171400114103959695557.png

				// DB의 spring_tblBoard 테이블에
				// filename 컬럼과, orgFileName 컬럼과, fileSize컬럼에 값을 입력해 주도록
				// boardvo 값 수정하기
				lossvo.setOrgfile(newFileName);
				// WAS(톰캣)에 저장될 파일명(20170608171400114103959695557.png)

				lossvo.setRealfile(lossvo.getFileimg().getOriginalFilename());
				// boardvo.getAttach().getOriginalFilename() = 진짜 파일 네임
				// EX:(강아지.png)
				// 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명

				filesize = lossvo.getFileimg().getSize();

				lossvo.setFilebyte(String.valueOf(filesize));

				System.out.println("파일사이즈?" + filesize);

			} catch (Exception e) {

			}

		} // end of if ~~~~~~~~
			// 첨부파일이 있는지 없는지? 의 끝

		// 파일타입(Attach)

		/* int n = service.add(boardvo); */

		/*
		 * #136. 파일첨부가 없는 경우 또는 파일첨부가 있는 경우 Service 단으로 호출하기 먼저 위의 int n =
		 * service.add(boardvo); 부분을 주석문 처리 하고서 아래처럼 한다.
		 */
		int n = 0;

		if (lossvo.getFileimg().isEmpty()) {
			// 파일첨부된 게 없다라면
			n = service.registerusilyyj(lossvo);
		} else {
			// 파일첨부가 있다라면

			System.out.println("============== 파일 첨부된 경우: " + n);
			n = service.registerusilyyj_withFile(lossvo);
			System.out.println("============== 파일 첨부된 경우: n 은 " + n);

		}

		////////////////////////////

		req.setAttribute("n", n);

		return "lossyyj/regiseterEnd.tiles";

	} // end of publi
	/*}*/
	///// 관리자 유실물 등록 폼 생성 //////
	@RequestMapping(value = "/registerusiladminyyj.action", method = { RequestMethod.GET })

	public String registerusiladminyyj(HttpServletRequest req, HttpServletResponse res , HttpSession session) {

khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null || !("admin").equals(loginuser.getUserid()) ){
		  String msg = "관리자만들어와";
		  String loc = "javascript:history.();";	
				  
		  req.setAttribute("msg", msg);
		  req.setAttribute("loc", loc);
		
		return "msg.notiles";
		
		}
		else{
		return "lossyyj/registerusiladminyyj.tiles3";

		}
	} // end of public String index(HttpServletRequest req) ----

	///// 관리자 유실물 등록 /////

	@RequestMapping(value = "/regiseteradminEnd.action", method = { RequestMethod.POST })

	public String regiseteradminEnd(HttpServletRequest req, HttpSession session, lossAdminVO lavo) {
khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null || !("admin").equals(loginuser.getUserid()) ){
		  String msg = "관리자만들어와";
		  String loc = "javascript:history.();";	
				  
		  req.setAttribute("msg", msg);
		  req.setAttribute("loc", loc);
		
		return "msg.notiles";
		
		}
		
        // **** 첨부파일이 있는지 없는지 ? ****
		else{if (!lavo.getLostimg().isEmpty()) { // 첨부 파일이 있는 경우 이라면(attach가 비어있지
											// 않다라면)
											// DB에 정보를 insert 를 하기 전 파일을 업로드
											// 하겠다.

			/*
			 * 1. 사용자가 보낸 파일을 was(톰캣서버)의 특정 폴더에 저장해주어야 한다. >>>> 파일이 업로드 되어질 특정
			 * 경로(폴더)지정해주기. 그래서 우리는 was의 webapp/resoutces/files 라는 폴더로 정해주겠다.
			 * 
			 */
			// WAS 의 webapp 의 절대경로를 알아 와야한다.
			String rootpath = req.getSession().getServletContext().getRealPath("/");
			String path = rootpath + "resources" + File.separator + "files";
			// path 가 첨부파일들이 저장될 was() 의

			System.out.println(">>>> 확인용 path ==> " + path);

			// C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files

			// 2. 파일첨부를 위한 변수의 설정 및 값을 초기화한 후 파일올리기

			String newFileName = "";
			// WAS(톰캣) 디스크에 저장한 파일명 이다.

			byte[] bytes = null;
			// 첨부파일을 WAS(톰캣) 디스크에 저장할때 사용되는 용도!

			long filesize = 0; ////////////////////////
			// 파일크기를 읽어오기 위한 용도.
			/*
			 * String thumbnailFileName = "";
			 */

			try {
				// 첨부된 파일을 byte[] 배열의 타입으로 얻어오기
				bytes = lavo.getLostimg().getBytes();
				/// getBytes()는 첨부된 파일을 바이트단위로 파일을 다 읽어오는 것이다.

				// === 파일을 업로드 해주기 ===
				newFileName = filemanager.doFileUpload(bytes, lavo.getLostimg().getOriginalFilename(), path);

				// getOriginalFilename() 은 첨부된 파일의 실제 파일명 (문자열) 을 얻어오는 것이다.

				System.out.println(">>>> 확인용 : " + newFileName);
				// >>>> 확인용 : 20170608171400114103959695557.png

				// DB의 spring_tblBoard 테이블에
				// filename 컬럼과, orgFileName 컬럼과, fileSize컬럼에 값을 입력해 주도록
				// boardvo 값 수정하기
				lavo.setOrgfilename(newFileName);
				// WAS(톰캣)에 저장될 파일명(20170608171400114103959695557.png)

				lavo.setItemimg(lavo.getLostimg().getOriginalFilename());
				// boardvo.getAttach().getOriginalFilename() = 진짜 파일 네임
				// EX:(강아지.png)
				// 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명

				filesize = lavo.getLostimg().getSize();

				/*
				 * System.out.println("섬네일대려가냐?@@@@@@@@@@@@@"
				 * +thumbnailFileName);
				 */
				lavo.setMiddleFilename(String.valueOf(filesize));

				System.out.println("미들파일사이즈찍힘?" + filesize);

			} catch (Exception e) {

			}

		} // end of if ~~~~~~~~
			// 첨부파일이 있는지 없는지? 의 끝

		// 파일타입(Attach)

		/* int n = service.add(boardvo); */

		/*
		 * #136. 파일첨부가 없는 경우 또는 파일첨부가 있는 경우 Service 단으로 호출하기 먼저 위의 int n =
		 * service.add(boardvo); 부분을 주석문 처리 하고서 아래처럼 한다.
		 */
		int n = 0;

		if (lavo.getLostimg().isEmpty()) {
			// 파일첨부된 게 없다라면
			n = service.registerusiladminyyj(lavo);
		} else {
			// 파일첨부가 있다라면

			System.out.println("============== 파일 첨부된 경우: " + n);
			n = service.registerusiladminyyj_withFile(lavo);
			System.out.println("============== 파일 첨부된 경우: n 은 " + n);

		}

		////////////////////////////

		req.setAttribute("n", n);
	
		return "lossyyj/regiseteradminEnd.tiles3";

	} // end of publi
	}
	
	// 유저가 등록한 유실물 //
	@RequestMapping(value = "/alluserloss.action", method = { RequestMethod.GET })

	public String alluserLoss(HttpServletRequest req, lossAdminVO advo , HttpSession session) {

	
		HashMap<String, String> map = new HashMap<String, String>();

		String lostno = req.getParameter("lostno");
		String article = req.getParameter("article");
		String lostname = req.getParameter("lostname");
		String storageplace = req.getParameter("storageplace");
		String lostdate1 = req.getParameter("lostdate1");
		String lostdate2 = req.getParameter("lostdate2");
		String lostdate3 = req.getParameter("lostdate3");

		map.put("lostno", lostno);
		map.put("article", article);
		map.put("lostname", lostname);
		map.put("storageplace", storageplace);
		map.put("lostdate1", lostdate1);
		map.put("lostdate2", lostdate2);
		map.put("lostdate3", lostdate3);

		// 1218 끝

		/*
		 * System.out.println("@@@@@@@@@@@@@@@@@@@@@@@확인@@@@@@@@@@@@@@@@@@@@");
		 * 
		 * System.out.println("@@@@@@@list첫번쨰@@@@@@@ : " +
		 * allLossList.get(0).toString() );
		 */

		String pageNo = req.getParameter("pageNo");

		int totalCount2 = 0; // 총게시물 건수
		int sizePerPage = 5; // 한 페이지당 보여줄 게시물 갯수 (예: 3, 5, 10)
		int currentShowPageNo = 1; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0; // 총페이지수(웹브라우저상에 보여줄 총 페이지 갯수)

		int start2 = 0; // 시작 행 번호
		int end2 = 0; // 끝 행 번호
		int startPageNo = 0; // 페이지바에서 시작될 페이지 번호
		/*
		 * "페이지바" 란?
		 * 
		 * 이전5페이지 [1][2][3][4][5] 다음5페이지 이전5페이지 [6][7][8][9][10] 다음5페이지 와 같이
		 * 이전5페이지 [1][2][3][4][5] 다음5페이지 또는 이전5페이지 [6][7][8][9][10] 다음5페이지 를
		 * "페이지바" 라고 부른다. startPageNo 는 1 또는 6 을 말한다.
		 */

		int loop = 0; // startPageNo 값이 증가할때 마다 1씩 증가하는 용도.
		int blocksize = 5; // "페이지바" 에 보여줄 페이지의 갯수

		if (pageNo == null) {
			// 게시판 초기화면에 보여지는 것은
			// req.getParameter("pageNo"); 값이 없으므로
			// pageNo 는 null 이 된다.

			currentShowPageNo = 1;
			// 즉, 초기화면은 /list.action?pageNo=1 로 하겠다는 말이다.

		} else {
			currentShowPageNo = Integer.parseInt(pageNo);
			// GET 방식으로 파라미터 pageNo 에 넘어온 값을
			// 현재 보여주고자 하는 페이지로 설정한다.
		}

		// **** 가져올 게시글의 범위를 구한다.(공식임!!!) ****
		/*
		 * currentShowPageNo start end -------------------------------------- 1
		 * page ==> 1 5 2 page ==> 6 10 3 page ==> 11 15 4 page ==> 16 20 5 page
		 * ==> 21 25 6 page ==> 26 30 7 page ==> 31 35
		 */

		start2 = ((currentShowPageNo - 1) * sizePerPage) + 1;
		end2 = start2 + sizePerPage - 1;

		// List<lossVO> lossList = service.lossList();

		String colname2 = req.getParameter("colname2");
		String search2 = req.getParameter("search2");

		map.put("colname2", colname2);
		map.put("search2", search2);

		// ===== #109. 페이징 처리를 위해 start, end 를 map 에 추가하여 DB에서 select 되어지도록 한다.
		// =====

		map.put("start2", String.valueOf(start2)); // 키값 start, 밸류값은 해쉬맵이 String
													// 타입인데 start 는 int 타입이어서
													// String 타입으로 변경함.
		map.put("end2", String.valueOf(end2)); // 키값 end, 밸류값은 해쉬맵이 String 타입인데
												// end 는 int 타입이어서 String 타입으로
												// 변경함.

		List<lossAdminVO> allLossList = service.getallLosslist(map);

		totalCount2 = service.gettotalcount2(map);

		totalPage = (int) Math.ceil((double) totalCount2 / sizePerPage);

		String pagebar2 = "";
		pagebar2 += "<ul>";
		/*
		 * 우리는 위에서 blocksize 를 5로 설정했으므로 아래와 같은 페이지바가 생성되도록 해야 한다.
		 * 
		 * 이전5페이지 [1][2][3][4][5] 다음5페이지 이전5페이지 [6][7][8][9][10] 다음5페이지 이전5페이지
		 * [11][12][13] 다음5페이지
		 * 
		 * 페이지번호는 1씩 증가하므로 페이지번호를 증가시켜주는 반복변수가 필요하다. 이것은 위에서 선언한 loop 를 사용한다. 이때
		 * loop 는 blocksize 의 크기보다 크면 안된다.!!
		 */

		loop = 1;

		// **** !!! 페이지바의 시작 페이지번호(startPageNo)값 만들기 --- 공식임 !!!!
		startPageNo = ((currentShowPageNo - 1) / blocksize) * blocksize + 1;
		/*
		 * 현재 우리는 blocksize 를 위에서 5로 설정했다.
		 * 
		 * 만약에 조회하고자 하는 currentShowPageNo 가 3페이지 이라면 startPageNo = ( (3 -
		 * 1)/5)*5 + 1; ==> 1
		 * 
		 * 만약에 조회하고자 하는 currentShowPageNo 가 5페이지 이라면 startPageNo = ( (5 -
		 * 1)/5)*5 + 1; ==> 1
		 * 
		 * 만약에 조회하고자 하는 currentShowPageNo 가 7페이지 이라면 startPageNo = ( (7 -
		 * 1)/5)*5 + 1; ==> 6
		 * 
		 * 만약에 조회하고자 하는 currentShowPageNo 가 10페이지 이라면 startPageNo = ( (10 -
		 * 1)/5)*5 + 1; ==> 6
		 * 
		 * 만약에 조회하고자 하는 currentShowPageNo 가 12페이지 이라면 startPageNo = ( (12 -
		 * 1)/5)*5 + 1; ==> 11
		 */

		// **** 이전5페이지 만들기 ****

		if (startPageNo == 1) {
			// 첫 페이지바에 도달한 경우
			pagebar2 += String.format("&nbsp;&nbsp;[이전%d페이지]", blocksize);
		} else {
			// 첫 페이지바가 아닌 두번째 이상 페이지바에 온 경우

			if (colname2 == null || search2 == null) {
				// 검색어가 없는 경우
				pagebar2 += String.format(
						"&nbsp;&nbsp;<a href='/khx/alluserloss.action?pageNo=%d'>[이전%d페이지]</a>&nbsp;&nbsp;",
						startPageNo - 1, blocksize); // 처음 %d 에는 startPageNo값 ,
														// 두번째 %d 에는 페이지바에 나타낼
														// startPageNo값 이다.
			} else {
				// 검색어가 있는 경우
				pagebar2 += String.format(
						"&nbsp;&nbsp;<a href='/khx/alluserloss.action?pageNo=%d&colname2=%s&search2=%s'>[이전%d페이지]</a>&nbsp;&nbsp;",
						startPageNo - 1, colname2, search2, blocksize); // 검색어
																		// 있는 경우
			}
		}

		// **** 이전5페이지 와 다음5페이지 사이에 들어가는 것을 만드는 것
		while (!(loop > blocksize || startPageNo > totalPage)) {

			if (startPageNo == currentShowPageNo) {
				pagebar2 += String.format(
						"&nbsp;&nbsp;<span style='color:red; font-weight:bold; text-decoration:underline;'>%d</span>&nbsp;&nbsp;",
						startPageNo);
			} else {
				if (colname2 == null || search2 == null) {
					// 검색어가 없는 경우
					pagebar2 += String.format(
							"&nbsp;&nbsp;<a href='/khx/alluserloss.action?pageNo=%d'>%d</a>&nbsp;&nbsp;", startPageNo,
							startPageNo); // 처음 %d 에는 startPageNo값 , 두번째 %d 에는
											// 페이지바에 나타낼 startPageNo값 이다.
				} else {
					// 검색어가 있는 경우
					pagebar2 += String.format(
							"&nbsp;&nbsp;<a href='/khx/alluserloss.action?pageNo=%d&colname2=%s&search2=%s'>%d</a>&nbsp;&nbsp;",
							startPageNo, colname2, search2, startPageNo); // 검색어
																			// 있는
																			// 경우
				}
			}

			loop++;
			startPageNo++;

		} // end of while--------------------

		// **** 다음5페이지 만들기 ****
		if (startPageNo > totalPage) {
			// 마지막 페이지바에 도달한 경우
			pagebar2 += String.format("&nbsp;&nbsp;[다음%d페이지]", blocksize);
		} else {
			// 마지막 페이지바가 아닌 경우

			if (colname2 == null || search2 == null) {
				// 검색어가 없는 경우
				pagebar2 += String.format(
						"&nbsp;&nbsp;<a href='/khx/alluserloss.action?pageNo=%d'>[다음%d페이지]</a>&nbsp;&nbsp;",
						startPageNo, blocksize); // 처음 %d 에는 startPageNo값 , 두번째
													// %d 에는 페이지바에 나타낼
													// startPageNo값 이다.
			} else {
				// 검색어가 있는 경우
				pagebar2 += String.format(
						"&nbsp;&nbsp;<a href='/khx/alluserloss.action?pageNo=%d&colname2=%s&search2=%s'>[다음%d페이지]</a>&nbsp;&nbsp;",
						startPageNo, colname2, search2, blocksize); // 검색어 있는 경우
			}
		}

		pagebar2 += "</ul>";

		req.setAttribute("pagebar2", pagebar2);
		req.setAttribute("start2", start2);
		req.setAttribute("end2", end2);
		req.setAttribute("colname2", colname2);
		req.setAttribute("search2", search2);
		req.setAttribute("allLossList", allLossList);

		req.setAttribute("allLossList", allLossList);

		return "lossyyj/alluserloss.tiles";
		
	} // end of publi
	
	// 유실물 디테일 라인 //
	@RequestMapping(value = "/lossDetail.action", method = { RequestMethod.GET })

	public String lossDetail(HttpServletRequest req , HttpSession session) {
/*khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null || !("admin").equals(loginuser.getUserid()) ){
		  String msg = "관리자만들어와";
		  String loc = "javascript:history.();";	
				  
		  req.setAttribute("msg", msg);
		  req.setAttribute("loc", loc);
		
		return "msg.notiles";
		
		}
		else{*/
		HashMap<String, String> map = new HashMap<String, String>();

		String lostno = req.getParameter("lostno");

		map.put("lostno", lostno);

		HashMap<String, String> lossDetailMap = service.getlossDetail(lostno);
		req.setAttribute("lossDetailMap", lossDetailMap);

		System.out.println("lossDetailMap" + lossDetailMap);

		return "lossyyj/lossDetail.tiles";

	} // end of public String index(HttpServletRequest req) ----
	/*}*/
	// 회원이 등록한 유실물 디테일 페이지 //

	@RequestMapping(value = "/lossuserDetail.action", method = { RequestMethod.GET })

	public String lossuserDetail(HttpServletRequest req) {
		HashMap<String, String> map = new HashMap<String, String>();

		String userid = req.getParameter("userid");
		String seq = req.getParameter("seq");

		map.put("userid", userid);
		map.put("seq", seq);

		HashMap<String, String> lossuserDetailMap = service.getlossuserDetail(userid);

		req.setAttribute("lossuserDetailMap", lossuserDetailMap);

		/* System.out.println("lossDetailMap" + lossDetailMap); */

		return "lossyyj/lossuserDetail.tiles3";

	} // end of public String index(HttpServletRequest req) ----

	// 유실물 디테일 사진등록 //

	@RequestMapping(value = "/lossDetailimage.action", method = { RequestMethod.GET })
	@ResponseBody
	public HashMap<String, String> lossDetailimage(HttpServletRequest req) {
		String lostno = req.getParameter("lostno");
		/*
		 * String thumbnailFileName = req.getParameter("thumbnailFileName");
		 */

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("lostno", lostno);

		String orgfilename = service.getlossDetailimage(map);

		HashMap<String, String> returnmap = new HashMap<String, String>();

		returnmap.put("orgfilename", orgfilename);

		return returnmap;

	} // end of public String index(HttpServletRequest req) ----

	////////////////////////// 유저유실물 End////////////////////////////////////////

	/////////////////////////// 회원관리 /////////////////////////

	@RequestMapping(value = "/adminuser.action", method = { RequestMethod.GET })
	public String userList(HttpServletRequest req, AdminMemberVO admvo) {

		String pageNo = req.getParameter("pageNo");

		int totalCount3 = 0; // 총게시물 건수
		int sizePerPage = 5; // 한 페이지당 보여줄 게시물 갯수 (예: 3, 5, 10)
		int currentShowPageNo = 1; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0; // 총페이지수(웹브라우저상에 보여줄 총 페이지 갯수)

		int start3 = 0; // 시작 행 번호
		int end3 = 0; // 끝 행 번호
		int startPageNo = 0; // 페이지바에서 시작될 페이지 번호
		/*
		 * "페이지바" 란?
		 * 
		 * 이전5페이지 [1][2][3][4][5] 다음5페이지 이전5페이지 [6][7][8][9][10] 다음5페이지 와 같이
		 * 이전5페이지 [1][2][3][4][5] 다음5페이지 또는 이전5페이지 [6][7][8][9][10] 다음5페이지 를
		 * "페이지바" 라고 부른다. startPageNo 는 1 또는 6 을 말한다.
		 */

		int loop = 0; // startPageNo 값이 증가할때 마다 1씩 증가하는 용도.
		int blocksize = 5; // "페이지바" 에 보여줄 페이지의 갯수

		if (pageNo == null) {
			// 게시판 초기화면에 보여지는 것은
			// req.getParameter("pageNo"); 값이 없으므로
			// pageNo 는 null 이 된다.

			currentShowPageNo = 1;
			// 즉, 초기화면은 /list.action?pageNo=1 로 하겠다는 말이다.

		} else {
			currentShowPageNo = Integer.parseInt(pageNo);
			// GET 방식으로 파라미터 pageNo 에 넘어온 값을
			// 현재 보여주고자 하는 페이지로 설정한다.
		}

		// **** 가져올 게시글의 범위를 구한다.(공식임!!!) ****
		/*
		 * currentShowPageNo start end -------------------------------------- 1
		 * page ==> 1 5 2 page ==> 6 10 3 page ==> 11 15 4 page ==> 16 20 5 page
		 * ==> 21 25 6 page ==> 26 30 7 page ==> 31 35
		 */

		start3 = ((currentShowPageNo - 1) * sizePerPage) + 1;
		end3 = start3 + sizePerPage - 1;

		// List<lossVO> lossList = service.lossList();

		String colname3 = req.getParameter("colname3");
		String search3 = req.getParameter("search3");

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("colname3", colname3);
		map.put("search3", search3);

		// ===== #109. 페이징 처리를 위해 start, end 를 map 에 추가하여 DB에서 select 되어지도록 한다.
		// =====

		map.put("start3", String.valueOf(start3)); // 키값 start, 밸류값은 해쉬맵이 String
													// 타입인데 start 는 int 타입이어서
													// String 타입으로 변경함.
		map.put("end3", String.valueOf(end3)); // 키값 end, 밸류값은 해쉬맵이 String 타입인데
												// end 는 int 타입이어서 String 타입으로
												// 변경함.

		List<AdminMemberVO> userList = service.getuserList(map);

		totalCount3 = service.gettotalcount3(map);

		totalPage = (int) Math.ceil((double) totalCount3 / sizePerPage);

		String pagebar3 = "";
		pagebar3 += "<ul>";
		/*
		 * 우리는 위에서 blocksize 를 5로 설정했으므로 아래와 같은 페이지바가 생성되도록 해야 한다.
		 * 
		 * 이전5페이지 [1][2][3][4][5] 다음5페이지 이전5페이지 [6][7][8][9][10] 다음5페이지 이전5페이지
		 * [11][12][13] 다음5페이지
		 * 
		 * 페이지번호는 1씩 증가하므로 페이지번호를 증가시켜주는 반복변수가 필요하다. 이것은 위에서 선언한 loop 를 사용한다. 이때
		 * loop 는 blocksize 의 크기보다 크면 안된다.!!
		 */

		loop = 1;

		// **** !!! 페이지바의 시작 페이지번호(startPageNo)값 만들기 --- 공식임 !!!!
		startPageNo = ((currentShowPageNo - 1) / blocksize) * blocksize + 1;
		/*
		 * 현재 우리는 blocksize 를 위에서 5로 설정했다.
		 * 
		 * 만약에 조회하고자 하는 currentShowPageNo 가 3페이지 이라면 startPageNo = ( (3 -
		 * 1)/5)*5 + 1; ==> 1
		 * 
		 * 만약에 조회하고자 하는 currentShowPageNo 가 5페이지 이라면 startPageNo = ( (5 -
		 * 1)/5)*5 + 1; ==> 1
		 * 
		 * 만약에 조회하고자 하는 currentShowPageNo 가 7페이지 이라면 startPageNo = ( (7 -
		 * 1)/5)*5 + 1; ==> 6
		 * 
		 * 만약에 조회하고자 하는 currentShowPageNo 가 10페이지 이라면 startPageNo = ( (10 -
		 * 1)/5)*5 + 1; ==> 6
		 * 
		 * 만약에 조회하고자 하는 currentShowPageNo 가 12페이지 이라면 startPageNo = ( (12 -
		 * 1)/5)*5 + 1; ==> 11
		 */

		// **** 이전5페이지 만들기 ****

		if (startPageNo == 1) {
			// 첫 페이지바에 도달한 경우
			pagebar3 += String.format("&nbsp;&nbsp;[이전%d페이지]", blocksize);
		} else {
			// 첫 페이지바가 아닌 두번째 이상 페이지바에 온 경우

			if (colname3 == null || search3 == null) {
				// 검색어가 없는 경우
				pagebar3 += String.format(
						"&nbsp;&nbsp;<a href='/khx/adminuser.action?pageNo=%d'>[이전%d페이지]</a>&nbsp;&nbsp;",
						startPageNo - 1, blocksize); // 처음 %d 에는 startPageNo값 ,
														// 두번째 %d 에는 페이지바에 나타낼
														// startPageNo값 이다.
			} else {
				// 검색어가 있는 경우
				pagebar3 += String.format(
						"&nbsp;&nbsp;<a href='/khx/adminuser.action?pageNo=%d&colname3=%s&search3=%s'>[이전%d페이지]</a>&nbsp;&nbsp;",
						startPageNo - 1, colname3, search3, blocksize); // 검색어
																		// 있는 경우
			}
		}

		// **** 이전5페이지 와 다음5페이지 사이에 들어가는 것을 만드는 것
		while (!(loop > blocksize || startPageNo > totalPage)) {

			if (startPageNo == currentShowPageNo) {
				pagebar3 += String.format(
						"&nbsp;&nbsp;<span style='color:red; font-weight:bold; text-decoration:underline;'>%d</span>&nbsp;&nbsp;",
						startPageNo);
			} else {
				if (colname3 == null || search3 == null) {
					// 검색어가 없는 경우
					pagebar3 += String.format(
							"&nbsp;&nbsp;<a href='/khx/adminuser.action?pageNo=%d'>%d</a>&nbsp;&nbsp;", startPageNo,
							startPageNo); // 처음 %d 에는 startPageNo값 , 두번째 %d 에는
											// 페이지바에 나타낼 startPageNo값 이다.
				} else {
					// 검색어가 있는 경우
					pagebar3 += String.format(
							"&nbsp;&nbsp;<a href='/khx/adminuser.action?pageNo=%d&colname3=%s&search3=%s'>%d</a>&nbsp;&nbsp;",
							startPageNo, colname3, search3, startPageNo); // 검색어
																			// 있는
																			// 경우
				}
			}

			loop++;
			startPageNo++;

		} // end of while--------------------

		// **** 다음5페이지 만들기 ****
		if (startPageNo > totalPage) {
			// 마지막 페이지바에 도달한 경우
			pagebar3 += String.format("&nbsp;&nbsp;[다음%d페이지]", blocksize);
		} else {
			// 마지막 페이지바가 아닌 경우

			if (colname3 == null || search3 == null) {
				// 검색어가 없는 경우
				pagebar3 += String.format(
						"&nbsp;&nbsp;<a href='/khx/adminuser.action?pageNo=%d'>[다음%d페이지]</a>&nbsp;&nbsp;", startPageNo,
						blocksize); // 처음 %d 에는 startPageNo값 , 두번째 %d 에는 페이지바에
									// 나타낼 startPageNo값 이다.
			} else {
				// 검색어가 있는 경우
				pagebar3 += String.format(
						"&nbsp;&nbsp;<a href='/khx/adminuser.action?pageNo=%d&colname3=%s&search3=%s'>[다음%d페이지]</a>&nbsp;&nbsp;",
						startPageNo, colname3, search3, blocksize); // 검색어 있는 경우
			}
		}

		pagebar3 += "</ul>";

		req.setAttribute("start3", start3);
		req.setAttribute("end3", end3);
		req.setAttribute("pagebar3", pagebar3);
		req.setAttribute("colname", colname3);
		req.setAttribute("search", search3);
		req.setAttribute("userList", userList);

		return "usermanage/adminuser.tiles3";

	} // end of publi

	// 회원삭제 복구 //

	@RequestMapping(value = "/UserRestore.action", method = { RequestMethod.GET })

	public String UserRestore(HttpServletRequest req, MemberVO mbrvo, HttpSession session) {
khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null || !("admin").equals(loginuser.getUserid()) ){
		  String msg = "관리자만들어와";
		  String loc = "javascript:history.();";	
				  
		  req.setAttribute("msg", msg);
		  req.setAttribute("loc", loc);
		
		return "msg.notiles";
		
		}
		else{
		
		HashMap<String, String> map = new HashMap<String, String>();

		String restoreuser = req.getParameter("restoreuser");

		// System.out.println("@@@@@@@@@@@@@@@@@deleteid" + deleteid);

		map.put("restoreuser", restoreuser);

		int n = service.getUserRestore(map);

		/*
		 * System.out.println("status?@@@@@@@@@@@@@" +status);
		 */

		req.setAttribute("n", n);

		return "usermanage/UserRestore.tiles3";

	}
	}
	// 유저디테일 //

	@RequestMapping(value = "/userdetailList.action", method = { RequestMethod.GET })

	public String userdetailList(HttpServletRequest req , HttpSession session) {

khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null || !("admin").equals(loginuser.getUserid()) ){
		  String msg = "관리자만들어와";
		  String loc = "javascript:history.();";	
				  
		  req.setAttribute("msg", msg);
		  req.setAttribute("loc", loc);
		
		return "msg.notiles";
		
		}
		else{
		
		HashMap<String, String> map = new HashMap<String, String>();

		String userid = req.getParameter("userid");

		map.put("userid", userid);

		HashMap<String, String> userListMap = service.getuserDetail(userid);

		req.setAttribute("userListMap", userListMap);

		// System.out.println("유저리스트불러옴? " +userListMap);

		return "usermanage/userdetailList.tiles3";

	} // end of public String index(HttpServletRequest req) ----
	}
	// 회원삭제 //

	@RequestMapping(value = "/UserDelete.action", method = { RequestMethod.GET })

	public String UserDelete(HttpServletRequest req, MemberVO mbrvo, HttpSession session) {
		
khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null || !("admin").equals(loginuser.getUserid()) ){
		  String msg = "관리자만들어와";
		  String loc = "javascript:history.();";	
				  
		  req.setAttribute("msg", msg);
		  req.setAttribute("loc", loc);
		
		return "msg.notiles";
		
		}
		else{
		HashMap<String, String> map = new HashMap<String, String>();

		String deleteid = req.getParameter("deleteid");

		// System.out.println("@@@@@@@@@@@@@@@@@deleteid" + deleteid);

		map.put("deleteid", deleteid);

		int n = service.getDeleteUser(map);

		/*
		 * System.out.println("status?@@@@@@@@@@@@@" +status);
		 */

		req.setAttribute("n", n);

		return "usermanage/UserDelete.tiles3";
		}
	} // end of public String index(HttpServletRequest req) ----

	///////////////

	@RequestMapping(value = "/getLargeImgFilename.action", method = { RequestMethod.GET })
	@ResponseBody
	public HashMap<String, String> getLargeImgFilename(HttpServletRequest req,HttpSession session) {

		
		
		String lostno = req.getParameter("lostno"); // 관리번호
		/*
		 * String thumbnailFileName = req.getParameter("thumbnailFileName"); //
		 * 썸네일파일명
		 */
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("lostno", lostno);

		String imgFilename = service.getLargeImgFilename(map);
		// spring_productimage 테이블에서
		// 제품번호(fk_prodseq), 썸네일파일명(thumbnailFileName)에 해당하는 imagefilename 컬럼의
		// 값(201706110056542344396781698764.jpg) 가져오기

		HashMap<String, String> returnmap = new HashMap<String, String>();

		returnmap.put("IMGFILENAME", imgFilename);

		return returnmap;

	}// end of getLargeImgFilename(HttpServletRequest req)------------------

	////////////////////////////////////////////////////////////////////


	/////////////////////////////// 열차 시간 수정 ///////////////////////////////////

	@RequestMapping(value = "/allocation.action", method = { RequestMethod.GET })

	public String allocation(HttpServletRequest req, HttpSession session, trainVO trvo) {

khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null || !("admin").equals(loginuser.getUserid()) ){
		  String msg = "관리자만들어와";
		  String loc = "javascript:history.();";	
				  
		  req.setAttribute("msg", msg);
		  req.setAttribute("loc", loc);
		
		return "msg.notiles";
		
		}
		else{
		String pageNo = req.getParameter("pageNo");

		int totalCount4 = 0; // 총게시물 건수
		int sizePerPage = 5; // 한 페이지당 보여줄 게시물 갯수 (예: 3, 5, 10)
		int currentShowPageNo = 1; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0; // 총페이지수(웹브라우저상에 보여줄 총 페이지 갯수)

		int start = 0; // 시작 행 번호
		int end = 0; // 끝 행 번호
		int startPageNo = 0; // 페이지바에서 시작될 페이지 번호
		/*
		 * "페이지바" 란?
		 * 
		 * 이전5페이지 [1][2][3][4][5] 다음5페이지 이전5페이지 [6][7][8][9][10] 다음5페이지 와 같이
		 * 이전5페이지 [1][2][3][4][5] 다음5페이지 또는 이전5페이지 [6][7][8][9][10] 다음5페이지 를
		 * "페이지바" 라고 부른다. startPageNo 는 1 또는 6 을 말한다.
		 */

		int loop = 0; // startPageNo 값이 증가할때 마다 1씩 증가하는 용도.
		int blocksize = 5; // "페이지바" 에 보여줄 페이지의 갯수

		if (pageNo == null) {
			// 게시판 초기화면에 보여지는 것은
			// req.getParameter("pageNo"); 값이 없으므로
			// pageNo 는 null 이 된다.

			currentShowPageNo = 1;
			// 즉, 초기화면은 /list.action?pageNo=1 로 하겠다는 말이다.

		} else {
			currentShowPageNo = Integer.parseInt(pageNo);
			// GET 방식으로 파라미터 pageNo 에 넘어온 값을
			// 현재 보여주고자 하는 페이지로 설정한다.
		}

		// **** 가져올 게시글의 범위를 구한다.(공식임!!!) ****
		/*
		 * currentShowPageNo start end -------------------------------------- 1
		 * page ==> 1 5 2 page ==> 6 10 3 page ==> 11 15 4 page ==> 16 20 5 page
		 * ==> 21 25 6 page ==> 26 30 7 page ==> 31 35
		 */

		start = ((currentShowPageNo - 1) * sizePerPage) + 1;
		end = start + sizePerPage - 1;

		// List<lossVO> lossList = service.lossList();

		String colname = req.getParameter("colname");
		String search = req.getParameter("search");

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("colname", colname);
		map.put("search", search);

		// ===== #109. 페이징 처리를 위해 start, end 를 map 에 추가하여 DB에서 select 되어지도록 한다.
		// =====

		map.put("start", String.valueOf(start)); // 키값 start, 밸류값은 해쉬맵이 String
													// 타입인데 start 는 int 타입이어서
													// String 타입으로 변경함.
		map.put("end", String.valueOf(end)); // 키값 end, 밸류값은 해쉬맵이 String 타입인데
												// end 는 int 타입이어서 String 타입으로
												// 변경함.

		List<trainVO> trainList = service.gettrainList(map);

		totalCount4 = service.gettotalcount4(map);

		totalPage = (int) Math.ceil((double) totalCount4 / sizePerPage);

		String pagebar = "";
		pagebar += "<ul>";
		/*
		 * 우리는 위에서 blocksize 를 5로 설정했으므로 아래와 같은 페이지바가 생성되도록 해야 한다.
		 * 
		 * 이전5페이지 [1][2][3][4][5] 다음5페이지 이전5페이지 [6][7][8][9][10] 다음5페이지 이전5페이지
		 * [11][12][13] 다음5페이지
		 * 
		 * 페이지번호는 1씩 증가하므로 페이지번호를 증가시켜주는 반복변수가 필요하다. 이것은 위에서 선언한 loop 를 사용한다. 이때
		 * loop 는 blocksize 의 크기보다 크면 안된다.!!
		 */

		loop = 1;

		// **** !!! 페이지바의 시작 페이지번호(startPageNo)값 만들기 --- 공식임 !!!!
		startPageNo = ((currentShowPageNo - 1) / blocksize) * blocksize + 1;
		/*
		 * 현재 우리는 blocksize 를 위에서 5로 설정했다.
		 * 
		 * 만약에 조회하고자 하는 currentShowPageNo 가 3페이지 이라면 startPageNo = ( (3 -
		 * 1)/5)*5 + 1; ==> 1
		 * 
		 * 만약에 조회하고자 하는 currentShowPageNo 가 5페이지 이라면 startPageNo = ( (5 -
		 * 1)/5)*5 + 1; ==> 1
		 * 
		 * 만약에 조회하고자 하는 currentShowPageNo 가 7페이지 이라면 startPageNo = ( (7 -
		 * 1)/5)*5 + 1; ==> 6
		 * 
		 * 만약에 조회하고자 하는 currentShowPageNo 가 10페이지 이라면 startPageNo = ( (10 -
		 * 1)/5)*5 + 1; ==> 6
		 * 
		 * 만약에 조회하고자 하는 currentShowPageNo 가 12페이지 이라면 startPageNo = ( (12 -
		 * 1)/5)*5 + 1; ==> 11
		 */

		// **** 이전5페이지 만들기 ****

		if (startPageNo == 1) {
			// 첫 페이지바에 도달한 경우
			pagebar += String.format("&nbsp;&nbsp;[이전%d페이지]", blocksize);
		} else {
			// 첫 페이지바가 아닌 두번째 이상 페이지바에 온 경우

			if (colname == null || search == null) {
				// 검색어가 없는 경우
				pagebar += String.format(
						"&nbsp;&nbsp;<a href='/khx/allocation.action?pageNo=%d'>[이전%d페이지]</a>&nbsp;&nbsp;",
						startPageNo - 1, blocksize); // 처음 %d 에는 startPageNo값 ,
														// 두번째 %d 에는 페이지바에 나타낼
														// startPageNo값 이다.
			} else {
				// 검색어가 있는 경우
				pagebar += String.format(
						"&nbsp;&nbsp;<a href='/khx/allocation.action?pageNo=%d&colname=%s&search=%s'>[이전%d페이지]</a>&nbsp;&nbsp;",
						startPageNo - 1, colname, search, blocksize); // 검색어 있는
																		// 경우
			}
		}

		// **** 이전5페이지 와 다음5페이지 사이에 들어가는 것을 만드는 것
		while (!(loop > blocksize || startPageNo > totalPage)) {

			if (startPageNo == currentShowPageNo) {
				pagebar += String.format(
						"&nbsp;&nbsp;<span style='color:red; font-weight:bold; text-decoration:underline;'>%d</span>&nbsp;&nbsp;",
						startPageNo);
			} else {
				if (colname == null || search == null) {
					// 검색어가 없는 경우
					pagebar += String.format(
							"&nbsp;&nbsp;<a href='/khx/allocation.action?pageNo=%d'>%d</a>&nbsp;&nbsp;", startPageNo,
							startPageNo); // 처음 %d 에는 startPageNo값 , 두번째 %d 에는
											// 페이지바에 나타낼 startPageNo값 이다.
				} else {
					// 검색어가 있는 경우
					pagebar += String.format(
							"&nbsp;&nbsp;<a href='/khx/allocation.action?pageNo=%d&colname=%s&search=%s'>%d</a>&nbsp;&nbsp;",
							startPageNo, colname, search, startPageNo); // 검색어
																		// 있는 경우
				}
			}

			loop++;
			startPageNo++;

		} // end of while--------------------

		// **** 다음5페이지 만들기 ****
		if (startPageNo > totalPage) {
			// 마지막 페이지바에 도달한 경우
			pagebar += String.format("&nbsp;&nbsp;[다음%d페이지]", blocksize);
		} else {
			// 마지막 페이지바가 아닌 경우

			if (colname == null || search == null) {
				// 검색어가 없는 경우
				pagebar += String.format(
						"&nbsp;&nbsp;<a href='/khx/allocation.action?pageNo=%d'>[다음%d페이지]</a>&nbsp;&nbsp;", startPageNo,
						blocksize); // 처음 %d 에는 startPageNo값 , 두번째 %d 에는 페이지바에
									// 나타낼 startPageNo값 이다.
			} else {
				// 검색어가 있는 경우
				pagebar += String.format(
						"&nbsp;&nbsp;<a href='/khx/allocation.action?pageNo=%d&colname=%s&search=%s'>[다음%d페이지]</a>&nbsp;&nbsp;",
						startPageNo, colname, search, blocksize); // 검색어 있는 경우
			}
		}

		pagebar += "</ul>";

		req.setAttribute("start", start);
		req.setAttribute("end", end);
		req.setAttribute("pagebar", pagebar);
		req.setAttribute("colname", colname);
		req.setAttribute("search", search);
		req.setAttribute("trainList", trainList);

		
		System.out.println("trainList@@@@@@@@@@@@@@@" +trainList);
		
		
		return "timeedit/allocation.tiles3";

	}

	}
	
	// 배차수정 //

	@RequestMapping(value = "/editTrain.action", method = { RequestMethod.GET })

	public String editTrain(HttpServletRequest req,HttpSession session) {
		
khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null || !("admin").equals(loginuser.getUserid()) ){
		  String msg = "관리자만들어와";
		  String loc = "javascript:history.();";	
				  
		  req.setAttribute("msg", msg);
		  req.setAttribute("loc", loc);
		
		return "msg.notiles";
		
		}
		else{
		HashMap<String, String> map = new HashMap<String, String>();
		
		
		String runinfoseq = req.getParameter("runinfoseq");
		String trainno = req.getParameter("trainno");
		String departure = req.getParameter("departure");
		String departuretime = req.getParameter("departuretime");
		String arrival = req.getParameter("arrival");
		String arrivaltime = req.getParameter("arrivaltime");
		
		// System.out.println("@@@@@@@@@@@@@@@@@deleteid" + deleteid);

		map.put("runinfoseq", runinfoseq);
		map.put("trainno", trainno);
		map.put("departure", departure);
		map.put("departuretime", departuretime);
		map.put("arrival", arrival);
		map.put("arrivaltime", arrivaltime);
		

	

		List<trainVO> viewtrain = service.getviewtrain(map);

			
		
		req.setAttribute("viewtrain", viewtrain);
		req.setAttribute("runinfoseq", runinfoseq);
		req.setAttribute("trainno", trainno);

		/*
		 * System.out.println("status?@@@@@@@@@@@@@" +status);
		 */

		System.out.println("viewtrain@@@@@@@@@@@@@@@" +viewtrain);
		 
		
		
		return "/timeedit/editTrain.tiles3";

	} // end of public String index(HttpServletRequest req) ----
	}
	// 배차수정 성공 실패 띄우기 //

	@RequestMapping(value = "/editTrainEnd.action", method = { RequestMethod.GET })
	/* @ResponseBody */
	public String editTrainEnd(HttpServletRequest req , HttpSession session) throws Throwable {
khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null || !("admin").equals(loginuser.getUserid()) ){
		  String msg = "관리자만들어와";
		  String loc = "javascript:history.();";	
				  
		  req.setAttribute("msg", msg);
		  req.setAttribute("loc", loc);
		
		return "msg.notiles";
		
		}
		
		else{
		
		String runinfoseq = req.getParameter("runinfoseq");
		String trainno = req.getParameter("trainno");
		String departure = req.getParameter("departure");
		String departuretime = req.getParameter("departuretime");
		String arrival = req.getParameter("arrival");
		String arrivaltime = req.getParameter("arrivaltime");

		/*
		 * String edittime1 = req.getParameter("edittime1"); String edittime2 =
		 * req.getParameter("edittime2"); String edittime3 =
		 * req.getParameter("edittime3"); String edittime4 =
		 * req.getParameter("edittime4");
		 */

		System.out.println("runinfoseq@@@@@@@@@@@@@@@@@@@@@@@@:" + runinfoseq);

		HashMap<String, String> map = new HashMap<String, String>();


		/*
		 * map.put("edittime1", edittime1); map.put("edittime2", edittime2);
		 * map.put("edittime3", edittime3); map.put("edittime4", edittime4);
		 */
		map.put("runinfoseq",runinfoseq);
		map.put("departuretime",departuretime);
		map.put("arrivaltime",arrivaltime);
		
		System.out.println("runinfoseq 뽑아오냐?@@@@@@@@@@@@@@@@@@" +runinfoseq);

        System.out.println("departuretime@@@@@@@@@@@@@@@" +departuretime);
        
		int editEnd = service.editTrainEnd(map);

		req.setAttribute("editEnd", editEnd);
	    req.setAttribute("runinfoseq", runinfoseq);
		req.setAttribute("trainno", trainno);
        req.setAttribute("departuretime", departuretime);
      
        
        return "/timeedit/editTrainEnd.tiles3";

		
		
	}// end of getLargeImgFilename(HttpServletRequest req)------------------

	
		
	}
	// 협력사별 좋아요 퍼센트에이지 차트 폼 요청 //
		
		
	@RequestMapping(value = "/likechart.action", method = { RequestMethod.GET })
	public String likechart(HttpServletRequest req, HttpServletResponse res , HttpSession session) {
    khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null || !("admin").equals(loginuser.getUserid()) ){
		  String msg = "관리자만들어와";
		  String loc = "javascript:history.();";	
				  
		  req.setAttribute("msg", msg);
		  req.setAttribute("loc", loc);
		
		return "msg.notiles";
		
		}
		else{
		return "chart/likechart.tiles3";
	}
	}
	
	
	
	//  지역별 많이간도시 퍼센트에이지 차트 폼 요청 //
	
	
		@RequestMapping(value = "/gochart.action", method = { RequestMethod.GET })
		public String gochart(HttpServletRequest req, HttpServletResponse res , HttpSession session) {
	    khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
			
			if(loginuser == null || !("admin").equals(loginuser.getUserid()) ){
			  String msg = "관리자만들어와";
			  String loc = "javascript:history.();";	
					  
			  req.setAttribute("msg", msg);
			  req.setAttribute("loc", loc);
			
			return "msg.notiles";
			
			}
			else{
			return "chart/gochart.tiles3";
		}
		}
	
	
		
	// 협력사별 좋아요 퍼센트에이지 차트  //

	
	
	
	
	@RequestMapping(value = "/likeStatistics.action", method = { RequestMethod.GET })
	@ResponseBody
	public List<HashMap<String, Object>> likeStatistics(HttpServletRequest req, HttpServletResponse res,
			HttpSession session) {

		List<HashMap<String, Object>> likeListMap = new ArrayList<HashMap<String, Object>>();

		

		
		
		List<HashMap<String, String>> Likelist = service.getlikeChartList();

		if (Likelist != null) {
			for (HashMap<String, String> datamap : Likelist) {
				HashMap<String, Object> submap = new HashMap<String, Object>();
				submap.put("name", datamap.get("name"));
				submap.put("cnt", datamap.get("cnt"));

				likeListMap.add(submap);
			}
		}
		
		
		
		System.out.println("라이크차트 컨트롤러 끝까지 오나???");
		System.out.println("likeList : " + likeListMap);
		/*
		req.setAttribute("submap", submap);
		*/
		return likeListMap;

	}


	

	// 각 날짜별 수익금 꺽새그래프로 차트내기 폼요청 //
	
	@RequestMapping(value = "/myorderchart.action", method = { RequestMethod.GET })
	public String requireLogin_myorderchart(HttpServletRequest req, HttpServletResponse res , HttpSession session) {
khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null || !("admin").equals(loginuser.getUserid()) ){
		  String msg = "관리자만들어와";
		  String loc = "javascript:history.();";	
				  
		  req.setAttribute("msg", msg);
		  req.setAttribute("loc", loc);
		
		return "msg.notiles";
		
		}
		else{
		return "chart/myorderchart.tiles3";
	}
	}
	// 각 날짜별 수익금 꺽새그래프로 차트한번 내보자 원제야 화이팅 ㅠㅠ.. //

	@RequestMapping(value = "/trainStatistics.action", method = { RequestMethod.GET })
	@ResponseBody
	public List<HashMap<String, Object>> trainStatistics(HttpServletRequest req, HttpServletResponse res,
			PaysummaryVO psvo , HttpSession session) {

		List<HashMap<String, Object>> returnmapList = new ArrayList<HashMap<String, Object>>();

		

		
		
		List<HashMap<String, String>> list = service.gettrainchartList(psvo);

		if (list != null) {
			for (HashMap<String, String> datamap : list) {
				HashMap<String, Object> submap = new HashMap<String, Object>();
				submap.put("TOTALPRICE", datamap.get("TOTALPRICE"));
				submap.put("PAYDATE", datamap.get("PAYDATE"));

				returnmapList.add(submap);
			}
		}
		System.out.println("기차통계 컨트롤러 끝까지 오나???");
		System.out.println("returnmapList : " + returnmapList);
		/*
		req.setAttribute("submap", submap);
		*/
		return returnmapList;

	}

	
	
	
	
	
	
	
	
	
	
	// 배차 정지 //

	@RequestMapping(value = "/stoptrain.action", method = { RequestMethod.GET })

	public String stoptrain(HttpServletRequest req, MemberVO mbrvo, HttpSession session) {

khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null || !("admin").equals(loginuser.getUserid()) ){
		  String msg = "관리자만들어와";
		  String loc = "javascript:history.();";	
				  
		  req.setAttribute("msg", msg);
		  req.setAttribute("loc", loc);
		
		return "msg.notiles";
		
		}
		
		else{
		HashMap<String, String> map = new HashMap<String, String>();

		String stoptrain = req.getParameter("stoptrain");
		String trainno = req.getParameter("trainno");
        String runinfoseq = req.getParameter("runinfoseq");
		// System.out.println("@@@@@@@@@@@@@@@@@deleteid" + deleteid);

		map.put("stoptrain", stoptrain);
		map.put("trainno", trainno);
        map.put("runinfoseq", runinfoseq);

        int n = service.getstoptrain(map);

		System.out.println("trainno옴@@@@@@@@@@@@@@@@@?" + trainno);
        System.out.println("n값옵니까?@@@@@@@ㅉ@@@@@@@@@@@@" +n);
		System.out.println("runinfoseq@@@@@@@@@@@@@@@  : " +runinfoseq);
		
		req.setAttribute("n", n);
		req.setAttribute("trainno", trainno);
		req.setAttribute("stoptrain", stoptrain);
        req.setAttribute("runinfoseq", runinfoseq);
		
		
		return "timeedit/stoptrain.tiles3";

	}

	
	}
	 // 배차 복구 //
	
	
	@RequestMapping(value = "/restoretrain.action", method = { RequestMethod.GET })

	public String restoretrain(HttpServletRequest req, trainVO tvo, HttpSession session) {
khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null || !("admin").equals(loginuser.getUserid()) ){
		  String msg = "관리자만들어와";
		  String loc = "javascript:history.();";	
				  
		  req.setAttribute("msg", msg);
		  req.setAttribute("loc", loc);
		
		return "msg.notiles";
		
		}
		else{
		
		HashMap<String, String> map = new HashMap<String, String>();

		String restoretrain = req.getParameter("restoretrain");
		 String runinfoseq = req.getParameter("runinfoseq");  
		 String status = req.getParameter("status");
		// System.out.println("@@@@@@@@@@@@@@@@@deleteid" + deleteid);

		map.put("restoretrain", restoretrain);
        map.put("runinfoseq",runinfoseq);
		map.put("status",status);
		
		int n = service.gettrainRestore(map);

		/*
		 * System.out.println("status?@@@@@@@@@@@@@" +status);
		 */
		
         System.out.println("restoretrain@@@@@@@@@@@@@@@@@@@@@@@" +restoretrain);
		 System.out.println("runinfoseq@@@@@@@@@@@@@@@@@@@@@@@@" +runinfoseq); 
         System.out.println("status@@@@@@@@@@@@@@@@@@@" +status);
         
		req.setAttribute("n", n);
        req.setAttribute("runinfoseq",runinfoseq);
        req.setAttribute("status",status);
		return "timeedit/restoretrain.tiles3";

	}
	
	// 배차 추가 폼페이지 요청 //
	}
	
	@RequestMapping(value = "/plustrain.action", method = { RequestMethod.GET })
	
  	public String plustrain(HttpServletRequest req, HttpServletResponse res, trainVO tvo , HttpSession session) {
khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null || !("admin").equals(loginuser.getUserid()) ){
		  String msg = "관리자만들어와";
		  String loc = "javascript:history.();";	
				  
		  req.setAttribute("msg", msg);
		  req.setAttribute("loc", loc);
		
		return "msg.notiles";
		
		}
		else{
		
	/*	 List<trainVO> plustrainlist = service.plustrainlist(tvo);*/
		
		   // System.out.println("plustrainlist@@@@@@@@@@@ 뽑아오닝? ㅋ" +plustrainlist);
		   
		return "train/plustrain.tiles3";
}	
	
	}
	
	
	
	
	// 배차 추가 //
	
	
	
	
		@RequestMapping(value = "/plustrainEnd.action", method = { RequestMethod.POST })

		public String plustrain(HttpServletRequest req, trainVO tvo, HttpSession session) {
		
			
			khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
			
			if(loginuser == null || !("admin").equals(loginuser.getUserid()) ){
			  String msg = "관리자만들어와";
			  String loc = "javascript:history.();";	
					  
			  req.setAttribute("msg", msg);
			  req.setAttribute("loc", loc);
			
			return "msg.notiles";
			
			}
			
			else {
			
			HashMap<String, String> map = new HashMap<String, String>();

			// String runinfoseq = req.getParameter("runinfoseq");
			 String trainno = req.getParameter("trainno");
			 String departure = req.getParameter("departure");
			 String departuretime = req.getParameter("departuretime");
			 String arrival = req.getParameter("arrival");
			 String arrivaltime = req.getParameter("arrivaltime");
			 String status = req.getParameter("status");
			 
		
				
				
			// System.out.println("@@@@@@@@@@@@@@@@@deleteid" + deleteid);
		   
		//	map.put("runinfoseq",runinfoseq);
			map.put("trainno", trainno);
	        map.put("departure", departure);
	        map.put("departuretime", departuretime);
	        map.put("arrival",arrival);
	        map.put("arrivaltime",arrivaltime);
			map.put("status",status);
			
			int n = service.getplustrain(map);

			
	        
			
	        // req.setAttribute("runinfoseq",runinfoseq);
	        req.setAttribute("trainno", trainno);
	        req.setAttribute("departure", departure);
	        req.setAttribute("departuretime", departuretime);
	        req.setAttribute("arrival",arrival);
	        req.setAttribute("arrivaltime", arrivaltime);
            req.setAttribute("status", status);
	       
            
            System.out.println("n값은????????????" +n);
            req.setAttribute("n", n);
	        
			
		
			return "train/plustrainEnd.tiles3";

		}
		

	
	
		
		
	
	
		
		
		
		
		}
		// 배차 삭제 //

		@RequestMapping(value = "/deletetrain.action", method = { RequestMethod.GET })

		public String lossuseryyj(HttpServletRequest req , HttpSession session) {

			khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
			
			if(loginuser == null || !("admin").equals(loginuser.getUserid()) ){
			  String msg = "관리자만들어와";
			  String loc = "javascript:history.();";	
					  
			  req.setAttribute("msg", msg);
			  req.setAttribute("loc", loc);
			
			return "msg.notiles";
			
			}
			else {
			String pageNo = req.getParameter("pageNo");

			int totalCount5 = 0; // 총게시물 건수
			int sizePerPage = 5; // 한 페이지당 보여줄 게시물 갯수 (예: 3, 5, 10)
			int currentShowPageNo = 1; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
			int totalPage = 0; // 총페이지수(웹브라우저상에 보여줄 총 페이지 갯수)

			int start5 = 0; // 시작 행 번호
			int end5 = 0; // 끝 행 번호
			int startPageNo = 0; // 페이지바에서 시작될 페이지 번호
			
			
			
			/*
			 * "페이지바" 란?
			 * 
			 * 이전5페이지 [1][2][3][4][5] 다음5페이지 이전5페이지 [6][7][8][9][10] 다음5페이지 와 같이
			 * 이전5페이지 [1][2][3][4][5] 다음5페이지 또는 이전5페이지 [6][7][8][9][10] 다음5페이지 를
			 * "페이지바" 라고 부른다. startPageNo 는 1 또는 6 을 말한다.
			 */

			int loop = 0; // startPageNo 값이 증가할때 마다 1씩 증가하는 용도.
			int blocksize = 5; // "페이지바" 에 보여줄 페이지의 갯수

			if (pageNo == null) {
				// 게시판 초기화면에 보여지는 것은
				// req.getParameter("pageNo"); 값이 없으므로
				// pageNo 는 null 이 된다.

				currentShowPageNo = 1;
				// 즉, 초기화면은 /list.action?pageNo=1 로 하겠다는 말이다.

			} else {
				currentShowPageNo = Integer.parseInt(pageNo);
				// GET 방식으로 파라미터 pageNo 에 넘어온 값을
				// 현재 보여주고자 하는 페이지로 설정한다.
			}

			// **** 가져올 게시글의 범위를 구한다.(공식임!!!) ****
			/*
			 * currentShowPageNo start end -------------------------------------- 1
			 * page ==> 1 5 2 page ==> 6 10 3 page ==> 11 15 4 page ==> 16 20 5 page
			 * ==> 21 25 6 page ==> 26 30 7 page ==> 31 35
			 */

			start5 = ((currentShowPageNo - 1) * sizePerPage) + 1;
			end5 = start5 + sizePerPage - 1;

			// List<lossVO> lossList = service.lossList();
			
			String colname5 = req.getParameter("colname5");
			String search5 = req.getParameter("search5");
            String traintype = req.getParameter("traintype");
			String departure = req.getParameter("departure");
			String departuretime = req.getParameter("departuretime");
			String arrival = req.getParameter("arrival");
			String arrivaltime = req.getParameter("arrivaltime");
			String trainno = req.getParameter("trainno");		
            
            
            
            
            HashMap<String, String> map = new HashMap<String, String>();
			map.put("colname5", colname5);
			map.put("search5", search5);
			map.put("traintype", traintype);
			map.put("departure", departure);
			map.put("departuretime", departuretime);
			map.put("arrival", arrival);
			map.put("arrivaltime", arrivaltime);
			map.put("trainno", trainno);
			

			
			// ===== #109. 페이징 처리를 위해 start, end 를 map 에 추가하여 DB에서 select 되어지도록 한다.
			// =====

			map.put("start5", String.valueOf(start5)); // 키값 start, 밸류값은 해쉬맵이 String
														// 타입인데 start 는 int 타입이어서
														// String 타입으로 변경함.
			map.put("end5", String.valueOf(end5)); // 키값 end, 밸류값은 해쉬맵이 String 타입인데
													// end 는 int 타입이어서 String 타입으로
													// 변경함.

        
/*		     List<HashMap<String, String>> traindeleteList = service.gettraindeleteList(map);
*/			
			
			
			System.out.println("traintype 받아옴?@@@@@@@@@@" +traintype);
			totalCount5 = service.gettotalcount5(map);

			totalPage = (int) Math.ceil((double) totalCount5 / sizePerPage);

			String pagebar5 = "";
			pagebar5 += "<ul>";
			/*
			 * 우리는 위에서 blocksize 를 5로 설정했으므로 아래와 같은 페이지바가 생성되도록 해야 한다.
			 * 
			 * 이전5페이지 [1][2][3][4][5] 다음5페이지 이전5페이지 [6][7][8][9][10] 다음5페이지 이전5페이지
			 * [11][12][13] 다음5페이지
			 * 
			 * 페이지번호는 1씩 증가하므로 페이지번호를 증가시켜주는 반복변수가 필요하다. 이것은 위에서 선언한 loop 를 사용한다. 이때
			 * loop 는 blocksize 의 크기보다 크면 안된다.!!
			 */

			loop = 1;

			// **** !!! 페이지바의 시작 페이지번호(startPageNo)값 만들기 --- 공식임 !!!!
			startPageNo = ((currentShowPageNo - 1) / blocksize) * blocksize + 1;
			/*
			 * 현재 우리는 blocksize 를 위에서 5로 설정했다.
			 * 
			 * 만약에 조회하고자 하는 currentShowPageNo 가 3페이지 이라면 startPageNo = ( (3 -
			 * 1)/5)*5 + 1; ==> 1
			 * 
			 * 만약에 조회하고자 하는 currentShowPageNo 가 5페이지 이라면 startPageNo = ( (5 -
			 * 1)/5)*5 + 1; ==> 1
			 * 
			 * 만약에 조회하고자 하는 currentShowPageNo 가 7페이지 이라면 startPageNo = ( (7 -
			 * 1)/5)*5 + 1; ==> 6
			 * 
			 * 만약에 조회하고자 하는 currentShowPageNo 가 10페이지 이라면 startPageNo = ( (10 -
			 * 1)/5)*5 + 1; ==> 6
			 * 
			 * 만약에 조회하고자 하는 currentShowPageNo 가 12페이지 이라면 startPageNo = ( (12 -
			 * 1)/5)*5 + 1; ==> 11
			 */

			// **** 이전5페이지 만들기 ****

			if (startPageNo == 1) {
				// 첫 페이지바에 도달한 경우
				pagebar5 += String.format("&nbsp;&nbsp;[이전%d페이지]", blocksize);
			} else {
				// 첫 페이지바가 아닌 두번째 이상 페이지바에 온 경우

				if (traintype == null || search5 == null) {
					// 검색어가 없는 경우
					pagebar5 += String.format(
							"&nbsp;&nbsp;<a href='/khx/deletetrain.action?pageNo=%d'>[이전%d페이지]</a>&nbsp;&nbsp;",
							startPageNo - 1, blocksize); // 처음 %d 에는 startPageNo값 ,
															// 두번째 %d 에는 페이지바에 나타낼
															// startPageNo값 이다.
				} else {
					// 검색어가 있는 경우
					pagebar5 += String.format(
							"&nbsp;&nbsp;<a href='/khx/deletetrain.action?pageNo=%d&traintype=%s&search5=%s'>[이전%d페이지]</a>&nbsp;&nbsp;",
							startPageNo - 1, traintype, search5, blocksize); // 검색어
																			// 있는 경우
				}
			}

			// **** 이전5페이지 와 다음5페이지 사이에 들어가는 것을 만드는 것
			while (!(loop > blocksize || startPageNo > totalPage)) {

				if (startPageNo == currentShowPageNo) {
					pagebar5 += String.format(
							"&nbsp;&nbsp;<span style='color:red; font-weight:bold; text-decoration:underline;'>%d</span>&nbsp;&nbsp;",
							startPageNo);
				} else {
					if (traintype == null || search5 == null) {
						// 검색어가 없는 경우
						pagebar5 += String.format(
								"&nbsp;&nbsp;<a href='/khx/deletetrain.action?pageNo=%d'>%d</a>&nbsp;&nbsp;", startPageNo,
								startPageNo); // 처음 %d 에는 startPageNo값 , 두번째 %d 에는
												// 페이지바에 나타낼 startPageNo값 이다.
					} else {
						// 검색어가 있는 경우
						pagebar5 += String.format(
								"&nbsp;&nbsp;<a href='/khx/deletetrain.action?pageNo=%d&traintype=%s&search5=%s'>%d</a>&nbsp;&nbsp;",
								startPageNo, traintype, search5, startPageNo); // 검색어
																				// 있는
																				// 경우
					}
				}

				loop++;
				startPageNo++;

			} // end of while--------------------

			// **** 다음5페이지 만들기 ****
			if (startPageNo > totalPage) {
				// 마지막 페이지바에 도달한 경우
				pagebar5 += String.format("&nbsp;&nbsp;[다음%d페이지]", blocksize);
			} else {
				// 마지막 페이지바가 아닌 경우

				if (traintype == null || search5 == null) {
					// 검색어가 없는 경우
					pagebar5 += String.format(
							"&nbsp;&nbsp;<a href='/khx/deletetrain.action?pageNo=%d'>[다음%d페이지]</a>&nbsp;&nbsp;",
							startPageNo, blocksize); // 처음 %d 에는 startPageNo값 , 두번째
														// %d 에는 페이지바에 나타낼
														// startPageNo값 이다.
				} else {
					// 검색어가 있는 경우
					pagebar5 += String.format(
							"&nbsp;&nbsp;<a href='/khx/deletetrain.action?pageNo=%d&traintype=%s&search5=%s'>[다음%d페이지]</a>&nbsp;&nbsp;",
							startPageNo, traintype, search5, blocksize); // 검색어 있는 경우
				}
			}

			pagebar5 += "</ul>";

			
			
			req.setAttribute("pagebar5", pagebar5);
			req.setAttribute("start5", start5);
			req.setAttribute("end5", end5);
			req.setAttribute("traintype", traintype);
			req.setAttribute("search5", search5);
/*            req.setAttribute("traindeleteList", traindeleteList);
*/
			
			
			return "train/deletetrain.tiles3";
			// └> /s2jo/src/main/webapp/WEB-INF/views/khx/booking.jsp 파일을 생성한다.

		} // end of public String index(HttpServletRequest req) ----

		
		
		}
	
		 /*많이간 지역 퍼센트에이지*/
		
		@RequestMapping(value = "/GoStatistics.action", method = { RequestMethod.GET })
		@ResponseBody
		public List<HashMap<String, Object>> GoStatistics(HttpServletRequest req, HttpServletResponse res,
				HttpSession session) {

			List<HashMap<String, Object>> goListMap = new ArrayList<HashMap<String, Object>>();

			

			
			
			List<HashMap<String, String>> goList = service.getGoList();

			if (goList != null) {
				for (HashMap<String, String> datamap : goList) {
					HashMap<String, Object> submap = new HashMap<String, Object>();
					submap.put("arrival", datamap.get("arrival"));
					submap.put("count", datamap.get("count"));
					goListMap.add(submap);
				}
			}
			
			
			
			System.out.println("고고차트 컨트롤러 끝까지 오나???");
			System.out.println("goListMap : " + goListMap);
			/*
			req.setAttribute("submap", submap);
			*/
			return goListMap;

		}


}