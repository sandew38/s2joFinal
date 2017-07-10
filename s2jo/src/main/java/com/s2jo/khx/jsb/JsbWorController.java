package com.s2jo.khx.jsb;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.s2jo.khx.common.FileManager;
import com.s2jo.khx.model.jsb.AlarmVO;
import com.s2jo.khx.model.jsb.BoardVO;
import com.s2jo.khx.model.jsb.CommentVO;
import com.s2jo.khx.model.jsb.resultAlarmVO;
import com.s2jo.khx.model.psc.khxpscMemberVO;
import com.s2jo.khx.service.jsb.JsbService;



@Controller
@Component
// XML에서 bean을 만드는 대신에
// 클래스명 앞에 @Component 어노테이션을 쓰면
// 해당 클래스는 bean으로 자동 등록된다.
// 그리고 bean의 id는 해당 클래스명이 된다. (첫 글자는 소문자)
public class JsbWorController {

	
	//의존객체 주입하기 (DI : Dependency Injection) ====
			
	@Autowired
	private JsbService service; 
	
//  파일업로드 및 파일다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection) =====
    @Autowired
    private FileManager fileManager;
	
	//글목록
	@RequestMapping(value="/jsb/worryingList.action", method={RequestMethod.GET})
	public String worryingList(HttpServletRequest req, HttpSession session)
	{

		 // ===== 페이징 처리하기 =====
		   // 페이징처리는 URL 주소창에 예를들어 /list.action?pageNo=3 와 같이 해주어야 한다.
		    	
		      String pageNo = req.getParameter("pageNo");
		      
		      int totalCount = 0;        // 총게시물 건수
		      int sizePerPage = 10;      // 한 페이지당 보여줄 게시물 갯수 (예: 3, 5, 10) 
		      int currentShowPageNo = 1; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
		      int totalPage = 0;         // 총페이지수(웹브라우저상에 보여줄 총 페이지 갯수)
		      
		      int start = 0;             // 시작 행 번호
		      int end = 0;               // 끝 행 번호
		      int startPageNo = 0;       // 페이지바에서 시작될 페이지 번호 
		      /*
		           "페이지바" 란?
		           
		            이전5페이지 [1][2][3][4][5] 다음5페이지 
		            이전5페이지 [6][7][8][9][10] 다음5페이지
		            와 같이 이전5페이지 [1][2][3][4][5] 다음5페이지  
		            또는    이전5페이지 [6][7][8][9][10] 다음5페이지 를 
		           "페이지바" 라고 부른다.
		           startPageNo 는 1 또는 6 을 말한다.  
		       */
		      
		      int loop = 0;       // startPageNo 값이 증가할때 마다 1씩 증가하는 용도.
		      int blocksize = 10;  // "페이지바" 에 보여줄 페이지의 갯수 
		      
		      if(pageNo == null) {
		    	  // 게시판 초기화면에 보여지는 것은
		    	  // req.getParameter("pageNo"); 값이 없으므로
		    	  // pageNo 는 null 이 된다.
		    	  
		    	  currentShowPageNo = 1;
		    	  // 즉, 초기화면은 /list.action?pageNo=1 로 하겠다는 말이다.
		    	  
		      }
		      else {
		    	  currentShowPageNo = Integer.parseInt(pageNo);
		    	  // GET 방식으로 파라미터 pageNo 에 넘어온 값을
		    	  // 현재 보여주고자 하는 페이지로 설정한다.
		      }
		      
		      // **** 가져올 게시글의 범위를 구한다.(공식임!!!) ****
		      /*
		           currentShowPageNo      start    end
		           --------------------------------------
		               1 page      ==>      1       5 
		               2 page      ==>      6       10
		               3 page      ==>      11      15
		               4 page      ==>      16      20
		               5 page      ==>      21      25
		               6 page      ==>      26      30
		               7 page      ==>      31      35
		       */
		      
		      start = ((currentShowPageNo - 1) * sizePerPage) + 1;  
		      end = start + sizePerPage - 1;		  

	
		  //  검색어가 포함되었으므로 
		    String colname = req.getParameter("colname");
		    String search = req.getParameter("search");
		    
		    HashMap<String, String> map = new HashMap<String, String>();
		    map.put("colname", colname);
		    map.put("search", search);	
		    	
		 //  페이징 처리를 위해 start, end 를 map 에 추가하여 DB에서 select 되어지도록 한다. ===== 
	    	map.put("start", String.valueOf(start) ); // 키값 start, 밸류값은 해쉬맵이 String 타입인데 start 는 int 타입이어서 String 타입으로 변경함. 
	    	map.put("end", String.valueOf(end) );     // 키값 end,   밸류값은 해쉬맵이 String 타입인데 end 는 int 타입이어서 String 타입으로 변경함. 
	    	
	    	
	    	List<BoardVO> worryingBoardList = service.worryingBoardList(map);
	
	    	 for(BoardVO boardvo: worryingBoardList){
	        	  //좋아요 싫어요    	
	              String wLikeCnt = service.getwLikeCnt(boardvo.getSeq());
	              String wDisLikeCnt = service.getwDislikeCnt(boardvo.getSeq());

	              boardvo.setwLikeCnt(wLikeCnt);
	              boardvo.setwDisLikeCnt(wDisLikeCnt);
	          }
//	    	=====  페이징 작업의 계속(페이지바에 나타낼 총 페이지 갯수 구하기) =====
	    	/*
	    	    검색조건이 없을때의 총페이지수와
	    	    검색조건이 있을때의 총페이지수를 구해야 한다.
	    	    
	    	    검색조건이 없을때란 --> colname , search 값이 null 인 경우임.
	    	    검색조건이 있을때란 --> colname , search 값이 null 인 아닌경우임.
	    	 */
	    	
	    	// 총페이지수를 구하기 위해서는 먼저 총 게시물 건수를 구한다.
	    	// 총 게시물 건수는 검색조건이 있을 때와 없을때로 나뉘어진다.
	    	totalCount = service.getWorTotalCount(map);
	    	
	 //   	System.out.println(">>>> 확인용 totalCount : " + totalCount);
	    	
	    	// ==== 이제부터 페이지바 작성을 위한 작업에 들어간다. ====
	    //	43.0/10 ==> 4.3 --> 5 페이지가 필요함.
	    //	43.0/5  ==> 8.6 --> 9 페이지가 필요함.
	    	totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
	    	
	    	String pagebar = "";
	    	pagebar += "<ul>";
	    	/*
	    	    우리는 위에서 blocksize 를 5로 설정했으므로
	    	    아래와 같은 페이지바가 생성되도록 해야 한다.
	    	    
	    	    이전5페이지 [1][2][3][4][5] 다음5페이지 
	             이전5페이지 [6][7][8][9][10] 다음5페이지
	    	    이전5페이지 [11][12][13] 다음5페이지
	    	    
	    	    페이지번호는 1씩 증가하므로 페이지번호를 증가시켜주는 반복변수가 필요하다.
	    	    이것은 위에서 선언한 loop 를 사용한다.
	    	    이때 loop 는 blocksize 의 크기보다 크면 안된다.!! 
	    	 */
	    	
	        loop = 1;
	        
	        // **** !!! 페이지바의 시작 페이지번호(startPageNo)값 만들기 --- 공식임 !!!!
	        startPageNo = ((currentShowPageNo - 1)/blocksize)*blocksize + 1;
	        /*
		        현재 우리는 blocksize 를 위에서 5로 설정했다.
		        
		        만약에 조회하고자 하는 currentShowPageNo 가 3페이지 이라면
		       startPageNo = ( (3 - 1)/5)*5 + 1;  ==> 1
		  
		        만약에  조회하고자 하는  currentShowPageNo 가 5페이지 이라면
		       startPageNo = ( (5 - 1)/5)*5 + 1;  ==> 1
		    
		        만약에  조회하고자 하는  currentShowPageNo 가 7페이지 이라면
		       startPageNo = ( (7 - 1)/5)*5 + 1;  ==> 6   
		    
		        만약에  조회하고자 하는  currentShowPageNo 가 10페이지 이라면
		       startPageNo = ( (10 - 1)/5)*5 + 1;  ==> 6 
		    
		        만약에  조회하고자 하는  currentShowPageNo 가 12페이지 이라면
		       startPageNo = ( (12 - 1)/5)*5 + 1;  ==> 11                     
		   */
	        
	        
	        // **** 이전5페이지 만들기 ****
	        if(startPageNo == 1) {
	        	// 첫 페이지바에 도달한 경우
	        	pagebar += String.format("&nbsp;&nbsp;[이전%d페이지]", blocksize);
	        }
	        else {
	        	// 첫 페이지바가 아닌 두번째 이상 페이지바에 온 경우
	        	
	        	if(colname == null || search == null) {
	        		// 검색어가 없는 경우
	        		pagebar += String.format("&nbsp;&nbsp;<a href='/khx/jsb/worryingList.action?pageNo=%d'>[이전%d페이지]</a>&nbsp;&nbsp;", startPageNo-1, blocksize); // 처음 %d 에는 startPageNo값 , 두번째 %d 에는 페이지바에 나타낼 startPageNo값 이다.		
	        	}
	        	else{
	        		// 검색어가 있는 경우
	        	    pagebar += String.format("&nbsp;&nbsp;<a href='/khx/jsb/worryingList?pageNo=%d&colname=%s&search=%s'>[이전%d페이지]</a>&nbsp;&nbsp;", startPageNo-1, colname, search, blocksize); // 검색어 있는 경우        		
	        	}	
	        }        
	            	
	        // **** 이전5페이지 와 다음5페이지 사이에 들어가는 것을 만드는 것
	        while( !(loop > blocksize ||
	        		 startPageNo > totalPage) ) {
	        	
	        	if(startPageNo == currentShowPageNo) {
	        		pagebar += String.format("&nbsp;&nbsp;<span style='color:red; font-weight:bold; text-decoration:underline;'>%d</span>&nbsp;&nbsp;", startPageNo);	
	        	}
	        	else {
		        	if(colname == null || search == null) {
		        		// 검색어가 없는 경우
		        		pagebar += String.format("&nbsp;&nbsp;<a href='/khx/jsb/worryingList.action?pageNo=%d'>%d</a>&nbsp;&nbsp;", startPageNo, startPageNo); // 처음 %d 에는 startPageNo값 , 두번째 %d 에는 페이지바에 나타낼 startPageNo값 이다.		
		        	}
		        	else{
		        		// 검색어가 있는 경우
		        	    pagebar += String.format("&nbsp;&nbsp;<a href='/khx/jsb/worryingList.action?pageNo=%d&colname=%s&search=%s'>%d</a>&nbsp;&nbsp;", startPageNo, colname, search, startPageNo); // 검색어 있는 경우        		
		        	}
	        	}
	        	
	        	loop++;
	        	startPageNo++;
	        	
	        }// end of while--------------------
	                
	        // **** 다음5페이지 만들기 ****
	        if(startPageNo > totalPage) {
	        	// 마지막 페이지바에 도달한 경우
	        	pagebar += String.format("&nbsp;&nbsp;[다음%d페이지]", blocksize);
	        }
	        else {
	        	// 마지막 페이지바가 아닌 경우
	        	
	        	if(colname == null || search == null) {
	        		// 검색어가 없는 경우
	        		pagebar += String.format("&nbsp;&nbsp;<a href='/khx/jsb/worryingList.action?pageNo=%d'>[다음%d페이지]</a>&nbsp;&nbsp;", startPageNo, blocksize); // 처음 %d 에는 startPageNo값 , 두번째 %d 에는 페이지바에 나타낼 startPageNo값 이다.		
	        	}
	        	else{
	        		// 검색어가 있는 경우
	        	    pagebar += String.format("&nbsp;&nbsp;<a href='/khx/jsb/worryingList.action?pageNo=%d&colname=%s&search=%s'>[다음%d페이지]</a>&nbsp;&nbsp;", startPageNo, colname, search, blocksize); // 검색어 있는 경우        		
	        	}	
	        }
	        
	        
	        pagebar += "</ul>";
	        
	        req.setAttribute("pagebar", pagebar);
		    
			
		    req.setAttribute("colname", colname);
	        req.setAttribute("search", search);
			req.setAttribute("boardList", worryingBoardList);
			session.setAttribute("readCountPermission", "yes");
			
			
			
		return "jsb/board/worrying/worryingList.tiles";
//		└> /Board/src/main/webapp/WEB-INF/views/worryingList/worryingList.jsp 파일을 생성한다.
		
	} // end of public String worryingdList(HttpServletRequest req) ----
	
	//글쓰기
	 @RequestMapping(value="/jsb/worryingAdd.action", method={RequestMethod.GET})
	 public String worryingAdd(HttpServletRequest req, HttpServletResponse res, HttpSession session) { 
		 khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
		 if(loginuser == null ) { 
	    		String msg = "회원 로그인을 해야 이용가능합니다..";
	    		String loc = "javascript:history.back()";
	    		
	    		req.setAttribute("msg", msg);
	    		req.setAttribute("loc", loc);
	    		
	    		return "msg.notiles";
	    		// /Board/src/main/webapp/WEB-INF/viewsnotiles/msg.jsp 파일을 생성한다.	
	    	}else{
		    		String userid = loginuser.getUserid();
					String name = loginuser.getName();
		    		req.setAttribute("userid", userid);
		    		req.setAttribute("name", name);
	    	
		 
	    	
	    	return "jsb/board/worrying/worryingAdd.tiles";
	    	// /Board/src/main/webapp/WEB-INF/views/board/worryingList/worryingAdd.jsp 파일을 생성한다.
	    	}
	    }// end of String add(HttpServletRequest req, HttpServletResponse res)..
	    
	 
	 //글쓰기저장(addEnd) 
	 @RequestMapping(value="/jsb/worryingAddEnd.action", method={RequestMethod.POST})
	 public String worryingAddEnd(BoardVO boardvo, MultipartHttpServletRequest req, HttpSession session) {
		   
		 	resultAlarmVO getResultAlarm = (resultAlarmVO)session.getAttribute("getResultAlarm");
			khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
			String userid = loginuser.getUserid();
			
		// **** 첨부파일이 있는지 없는지? ****
	    	if(!boardvo.getAttach().isEmpty()) {
	    		// 첨부파일이 있는 경우이라면(attach가 비어있지 않다라면)
	    		// DB에 정보를 insert 하기전 파일을 업로드 하겠다.
	    		
	    	/*
	    	    1. 사용자가 보낸 파일을 WAS(톰캣서버)의 특정 폴더에 저장해주어야 한다.
	    	    >>>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
	    	    우리는 WAS의 webapp/resources/files 라는 폴더로 정해주겠다. 	
	    	 */
	    	// WAS 의 webapp 의 절대경로를 알아와야 한다.
	    		String rootpath = session.getServletContext().getRealPath("/");
	    		String path = rootpath + "resources" + File.separator + "files"; 
	    		// path 가 첨부파일들이 저장될 WAS(톰캣서버)의 폴더가 된다. 
	    		
	    	//	System.out.println(">>>>> 확인용 path ==> " + path); 
	    		// >>>>> 확인용 path ==> C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files 
	    		
	    		// 2. 파일첨부를 위한 변수의 설정 및 값을 초기화한 후 파일올리기
	    		String newFileName = "";
	    		// WAS(톰캣) 디스크에 저장한 파일명이다.
	    		
	    		byte[] bytes = null;
	    		// 첨부파일을 WAS(톰캣) 디스크에 저장할때 사용되는 용도.
	    		
	    		long filesize = 0;
	    		// 파일크기를 읽어오기 위한 용도.
	    		
	    		try {
	    			// === 첨부된 파일을 byte[] 타입으로 얻어오기 ===
	    			bytes = boardvo.getAttach().getBytes();
	    			// getBytes()는 첨부된 파일을 바이트단위로 파일을 다 읽어오는 것이다.
	    			
	    			
	    			// === 파일을 업로드 해주기 ===
	    			newFileName = fileManager.doFileUpload(bytes, boardvo.getAttach().getOriginalFilename(), path); 
	    			
	    			// boardvo.getAttach().getOriginalFilename() 은 첨부된 파일의 실제 파일명(문자열)을 얻어오는 것이다.
	    			
	    	//		System.out.println(">>>>> 확인용 newFileName ==> " + newFileName);
	    			// >>>>> 확인용 newFileName ==> 2017060817143629229058438259.jpg
	    			
	    			// === DB의 spring_tblBoard 테이블에 
	    			//     fileName 컬럼과 orgFilename 컬럼과 fileSize 컬럼에 값을 입력해주도록
	    			//     boardvo 값 수정하기
	    		
	    			boardvo.setFileName(newFileName);
	    			// WAS(톰캣)에 저장될 파일명(20161121324325454354353333432.png) 
	    			
	    			boardvo.setOrgFilename(boardvo.getAttach().getOriginalFilename());
	    			// 진짜 파일명(강아지.png)
	    			// 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명.
	    			
	    			filesize = boardvo.getAttach().getSize();
	    			// 첨부한 파일의 파일크기를 얻어오는 것.
	    			
	    			boardvo.setFileSize(String.valueOf(filesize));
	    			// 첨부한 파일의 크기를 String 타입으로 변경해서 저장함.
	    			
				} catch (Exception e) {
					
				}
	    		
	    		
	    	}// end of if-----------------
	    	// **** 첨부파일이 있는지 없는지? 의 끝 ****
	    	
	    	
	    //	int n = service.add(boardvo);
	    	
	    /*	===== #136. 파일첨부가 없는 경우 또는 파일첨부가 있는 경우
	    	            Service 단으로 호출하기
	    	             먼저, 위의 int n = service.add(boardvo); 부분을
	    	             주석처리하고서 아래처럼 한다. =====
	    */	             
	    	int n = 0;
	    	if(boardvo.getAttach().isEmpty()) {
	    		// 파일첨부가 없다면
	    		n = service.worryingAdd(boardvo);
	    		
	    		HashMap<String, String> map = new HashMap<String, String>();
		    	map.put("userid", boardvo.getUserid());
		    	map.put("boardSeq", boardvo.getSeq());
		    	map.put("boardSubject", boardvo.getSubject());
		    	
		    	
	    		service.wAlarmCommentAdd(map); // rAlarm DB에 추가
	    		int m = service.w_resultAlarm(map); //resultAlarm DB에 추가
	    		
	    		if(m != 0){
	    			getResultAlarm = service.getResultAlarm(userid); //resultalarm 테이블 불러오기
	 	    		
	 	    		session.setAttribute("getResultAlarm", getResultAlarm);
	    		}
	    		
	    	}
	    	else {
	    		// 파일첨부가 있다면
	    		n = service.add_worWithFile(boardvo);
	    		
	    		HashMap<String, String> map = new HashMap<String, String>();
		    	map.put("userid", boardvo.getUserid());
		    	map.put("boardSeq", boardvo.getSeq());
		    	map.put("boardSubject", boardvo.getSubject());
		    	
		    	
	    		service.wAlarmCommentAdd(map); // rAlarm DB에 추가
	    		int m = service.w_resultAlarm(map); //resultAlarm DB에 추가
	    		
	    		if(m != 0){
	    			getResultAlarm = service.getResultAlarm(userid); //resultalarm 테이블 불러오기
	 	    		
	 	    		session.setAttribute("getResultAlarm", getResultAlarm);
	    		}
	    	}
		    	
		    	req.setAttribute("n", n);
		    	
		    	return "jsb/board/worrying/worryingAddEnd.tiles";
		    	// /Board/src/main/webapp/WEB-INF/views2/board/addEnd.jsp 파일을 생성한다.
	 }
	 
	 
	 //  글 1개를 보여주는 페이지 요청하기 =====
	 @RequestMapping(value="jsb/worryingView.action", method={RequestMethod.GET})
	 public String worryingView(HttpServletRequest req, HttpSession session,AlarmVO alarmvo) { 
	    	
		 	resultAlarmVO getResultAlarm = (resultAlarmVO)session.getAttribute("getResultAlarm");
	    	String seq = req.getParameter("seq");
	    	BoardVO boardvo = null;
	    	khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
	    	
	    	/* ===== #67. 글조회수(readCount)증가(DML문 update)는 
	    	                반드시 해당 글제목을 클릭했을 경우에만 증가되고 
	    	                웹브라우저에서 새로고침(F5)을 했을 경우에는
	    	                증가가 안되도록 한다. =====
	    	*/  
	    	if(session.getAttribute("readCountPermission") != null && 
	    	   "yes".equals(session.getAttribute("readCountPermission")) ) {
	    		
	    		boardvo = service.getworryingView(seq);
	    		// 조회수(readCount) 1증가 후 글 1개를 가져오는 것
	    		String likeCnt = service.gettLikeCnt(seq);
		        String dislikeCnt = service.gettDislikeCnt(seq);
	    		
		        req.setAttribute("likeCnt", likeCnt);
		        req.setAttribute("dislikeCnt", dislikeCnt);
	    		
	    		if(loginuser != null){
			 		String userid = loginuser.getUserid();
		    		HashMap<String, String> map = new HashMap<String, String>();
			    	map.put("userid", userid);
			    	map.put("boardSeq", seq);
			    	
			    	List<HashMap<String, String>> list = service.wZeroAlarmCount(map);
		    		
			    	if(list != null){
			    		String writer = req.getParameter("writer");
		    			int n = service.w_resultAlarmCntUpdate(writer);
		    			
		    			if(n != 0){
			    			getResultAlarm = service.getResultAlarm(userid); //resultalarm 테이블 불러오기
			 	    		
			 	    		session.setAttribute("getResultAlarm", getResultAlarm);
			    		}
				    }else{
				    	req.setAttribute("msg", "댓글알람2 실패!!");
				    }
	    		}
	    		session.setAttribute("readCountPermission", "no");
	    		// session "readCountPermission" 값을 "yes"에서 "no"로 변경함.
	    	}
	    	else {
	    		String likeCnt = service.gettLikeCnt(seq);
		        String dislikeCnt = service.gettDislikeCnt(seq);
	    		
		        req.setAttribute("likeCnt", likeCnt);
		        req.setAttribute("dislikeCnt", dislikeCnt);
	    		// 새로고침(F5)을 했을 경우
	    		
	    		if(loginuser != null){
			 		String userid = loginuser.getUserid();
		    		HashMap<String, String> map = new HashMap<String, String>();
			    	map.put("userid", userid);
			    	map.put("boardSeq", seq);
			    	
			    	List<HashMap<String, String>> list = service.tZeroAlarmCount(map);
			    	if(list != null){
			    		String writer = req.getParameter("writer");
		    			int n = service.t_resultAlarmCntUpdate(writer);
		    			
		    			if(n != 0){
			    			getResultAlarm = service.getResultAlarm(userid); //resultalarm 테이블 불러오기
			 	    		
			 	    		session.setAttribute("getResultAlarm", getResultAlarm);
			    		}
			    	}else{
			    		req.setAttribute("msg", "댓글알람3 실패!!");
			    	}
	    		}
	    		boardvo = service.getWorViewWithNoAddCount(seq);
	    		// 조회수(readCount) 1증가 없이 그냥 글 1개를 가져오는 것
	    	}
	    	
	    	
	    	/*
	    	  글내용에 엔터("\r\n")가 들어가 있으면  
	    	  엔터("\r\n")를 <br>로 대체시켜서
	    	  request 영역으로 넘긴다.
	    	 */
	    	String content = boardvo.getContent();
	    	content = content.replaceAll("\r\n", "<br>");
	    	boardvo.setContent(content);
	    	
	    	req.setAttribute("boardvo", boardvo);
	    	
	    	/*  댓글 내용 가져오기 ======*/
	    	List<CommentVO> commentList = service.worListComment(seq);
	    	req.setAttribute("commentList", commentList); 
	    	
	    	return "jsb/board/worrying/worryingView.tiles";
	    	// /Board/src/main/webapp/WEB-INF/views2/board/view.jsp 파일을 생성한다.
	    }    
	 
	 	
	// =====  글수정 페이지 요청 =====
	    @RequestMapping(value="jsb/worryingEdit.action", method={RequestMethod.GET})
	    public String requireLogin_edit(HttpServletRequest req, HttpServletResponse res, HttpSession session) { 
	    	
	    	khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
	    	// 글 수정해야할 글번호 가져오기
	    	String seq = req.getParameter("seq");
	    	BoardVO boardvo = service.getWorViewWithNoAddCount(seq);
	    	if(loginuser == null ) { 
	    		String msg = "회원 로그인을 해야 이용가능합니다..";
	    		String loc = "javascript:history.back()";
	    		
	    		req.setAttribute("msg", msg);
	    		req.setAttribute("loc", loc);
	    		
	    		return "msg.notiles";
	    		// /Board/src/main/webapp/WEB-INF/viewsnotiles/msg.jsp 파일을 생성한다.	
			}else if(loginuser != null && !loginuser.getUserid().equals(boardvo.getUserid())) {
	    	      		String msg = "다른 사용자의 글은 수정이 불가합니다.";
	    	      		String loc = "javascript:history.back()";
	    	      		
	    	      		req.setAttribute("msg", msg);
	    	      		req.setAttribute("loc", loc);
	    	      		
	    	      		return "msg.notiles";
	    	      		// /Board/src/main/webapp/WEB-INF/viewsnotiles/msg.jsp 파일을 생성한다.
	    	}
			else{
	    
	    		req.setAttribute("boardvo", boardvo);
	    		
	    		return "jsb/board/worrying/worryingEdit.tiles";
	    		// /Board/src/main/webapp/WEB-INF/views2/board/edit.jsp 파일을 생성한다.
	    	}
	    	
	    } 
	    
	 //  글수정 페이지 완료하기 =====
	    @RequestMapping(value="jsb/worryingEditEnd.action", method={RequestMethod.POST})
	    public String worryingEditEnd(BoardVO boardvo,  MultipartHttpServletRequest req, HttpSession session) { 
	    	
	    	
	    	/*
	    	 글수정을 하려면 원본글의 암호와 수정시 입력해주는 암호가 일치할때만 수정이 가능하도록 한다.
	    	 서비스단에서 글수정을 처리한 결과를 int 타입으로 받아오겠다. 
	    	 */
	    	
	    	// 넘겨받은 값이 1이면 update 성공,
	    	// 넘겨받은 값이 0이면 update 실패(암호가 틀리므로).
	    	
	    	// **** 첨부파일이 있는지 없는지? ****
	    	if(!boardvo.getAttach().isEmpty()) {
	    		// 첨부파일이 있는 경우이라면(attach가 비어있지 않다라면)
	    		// DB에 정보를 insert 하기전 파일을 업로드 하겠다.
	    		
	    	/*
	    	    1. 사용자가 보낸 파일을 WAS(톰캣서버)의 특정 폴더에 저장해주어야 한다.
	    	    >>>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
	    	    우리는 WAS의 webapp/resources/files 라는 폴더로 정해주겠다. 	
	    	 */
	    	// WAS 의 webapp 의 절대경로를 알아와야 한다.
	    		String rootpath = session.getServletContext().getRealPath("/");
	    		String path = rootpath + "resources" + File.separator + "files"; 
	    		// path 가 첨부파일들이 저장될 WAS(톰캣서버)의 폴더가 된다. 
	    		
	    	//	System.out.println(">>>>> 확인용 path ==> " + path); 
	    		// >>>>> 확인용 path ==> C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files 
	    		
	    		// 2. 파일첨부를 위한 변수의 설정 및 값을 초기화한 후 파일올리기
	    		String newFileName = "";
	    		// WAS(톰캣) 디스크에 저장한 파일명이다.
	    		
	    		byte[] bytes = null;
	    		// 첨부파일을 WAS(톰캣) 디스크에 저장할때 사용되는 용도.
	    		
	    		long filesize = 0;
	    		// 파일크기를 읽어오기 위한 용도.
	    		
	    		try {
	    			// === 첨부된 파일을 byte[] 타입으로 얻어오기 ===
	    			bytes = boardvo.getAttach().getBytes();
	    			// getBytes()는 첨부된 파일을 바이트단위로 파일을 다 읽어오는 것이다.
	    			
	    			
	    			// === 파일을 업로드 해주기 ===
	    			newFileName = fileManager.doFileUpload(bytes, boardvo.getAttach().getOriginalFilename(), path); 
	    			
	    			// boardvo.getAttach().getOriginalFilename() 은 첨부된 파일의 실제 파일명(문자열)을 얻어오는 것이다.
	    			
	    	//		System.out.println(">>>>> 확인용 newFileName ==> " + newFileName);
	    			// >>>>> 확인용 newFileName ==> 2017060817143629229058438259.jpg
	    			
	    			// === DB의 spring_tblBoard 테이블에 
	    			//     fileName 컬럼과 orgFilename 컬럼과 fileSize 컬럼에 값을 입력해주도록
	    			//     boardvo 값 수정하기
	    		
	    			boardvo.setFileName(newFileName);
	    			// WAS(톰캣)에 저장될 파일명(20161121324325454354353333432.png) 
	    			
	    			boardvo.setOrgFilename(boardvo.getAttach().getOriginalFilename());
	    			// 진짜 파일명(강아지.png)
	    			// 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명.
	    			
	    			filesize = boardvo.getAttach().getSize();
	    			// 첨부한 파일의 파일크기를 얻어오는 것.
	    			
	    			boardvo.setFileSize(String.valueOf(filesize));
	    			// 첨부한 파일의 크기를 String 타입으로 변경해서 저장함.
	    			
				} catch (Exception e) {
					
				}
	    		
	    		
	    	}// end of if-----------------
	    	// **** 첨부파일이 있는지 없는지? 의 끝 ****
	    	HashMap<String, String> map = new HashMap<String, String>();
	    	map.put("seq", boardvo.getSeq());
	    	map.put("subject", boardvo.getSubject());
	    	map.put("content", boardvo.getContent());
	    	map.put("fileName", boardvo.getFileName());
	    	map.put("orgFilename", boardvo.getOrgFilename());
	    	map.put("fileSize", boardvo.getFileSize());
	    	             
	    	int n = 0;
	    	if(boardvo.getAttach().isEmpty()) {
	    		// 파일첨부가 없다면
	    		n = service.worryingEdit(map);
	    	}
	    	else {
	    		// 파일첨부가 있다면
	    		n = service.Edit_worWithFile(map);
	    	}
		    	
	    	
	    	// n(글수정 성공 또는 실패)값을 request 영역에 저장시켜서 view 단 페이지로 넘긴다.
	    	// 그리고 변경되어진 글을 보여주기 위해서 request 영역에 변경한 글번호도 저장시키도록 한다.
	    	req.setAttribute("n", n);
	    	req.setAttribute("seq", boardvo.getSeq()); // 수정된 자신의 글을 보여주기 위해서 넘긴다.
	    	
	    	return "jsb/board/worrying/worryingEditEnd.tiles";
	    	// /Board/src/main/webapp/WEB-INF/views2/board/editEnd.jsp 파일을 생성한다.
	    } 
	    
	    //  글삭제 페이지 완료하기 =====
	    @RequestMapping(value="/jsb/worryingDel.action", method={RequestMethod.POST})
	    public String delEnd(HttpServletRequest req, HttpSession session) 
	    	throws Throwable { 
	    	
	    	khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
	    	String seq = req.getParameter("seq");
	    	BoardVO boardvo = service.getWorViewWithNoAddCount(seq);
	    	if(loginuser == null ) { 
	    		String msg = "회원 로그인을 해야 이용가능합니다..";
	    		String loc = "javascript:history.back()";
	    		
	    		req.setAttribute("msg", msg);
	    		req.setAttribute("loc", loc);
	    		
	    		return "msg.notiles";
	    		// /Board/src/main/webapp/WEB-INF/viewsnotiles/msg.jsp 파일을 생성한다.	
			}else if(loginuser != null && !loginuser.getUserid().equals(boardvo.getUserid())) {
	    	      		String msg = "다른 사용자의 글은 수정이 불가합니다.";
	    	      		String loc = "javascript:history.back()";
	    	      		
	    	      		req.setAttribute("msg", msg);
	    	      		req.setAttribute("loc", loc);
	    	      		
	    	      		return "msg.notiles";
	    	      		// /Board/src/main/webapp/WEB-INF/viewsnotiles/msg.jsp 파일을 생성한다.
	    	}
			else{

	    	/*
	    	 글삭제를 하려면 원본글의 암호와 삭제시 입력해주는 암호가 일치할때만 
	    	 삭제가 가능하도록 한다.
	    	 서비스단에서 글삭제를 처리한 결과를 int 타입으로 받아오겠다. 
	    	 */
	    	HashMap<String, String> map = new HashMap<String, String>();
	    	map.put("seq", seq);

	    	
	    	
	    	int n = service.worryingDel(map);
	    	// 넘겨받은 값이 1이면 글삭제 성공,
	    	// 넘겨받은 값이 0이면 글삭제 실패(암호가 틀리므로).
	    	
	    	// n(글삭제 성공 또는 실패)값을 request 영역에 저장시켜서 view 단 페이지로 넘긴다.
	    	req.setAttribute("n", n);
	    	
	    	return "jsb/board/worrying/worryingDelEnd.tiles";
	    	// /Board/src/main/webapp/WEB-INF/views2/board/delEnd.jsp 파일을 생성한다.
			}
	    }    
	 
	    
	 // ===== 댓글쓰기  =====
	    @RequestMapping(value="/jsb/worAddComment.action", method={RequestMethod.GET})
	    public String waddComment(HttpSession session, HttpServletRequest req, HttpServletResponse res, CommentVO commentvo,
	    					AlarmVO alarmvo, resultAlarmVO resAlarmvo) 
	    	throws Throwable { 
	    	
	    	resultAlarmVO getResultAlarm = (resultAlarmVO)session.getAttribute("getResultAlarm");
	    	String seq = req.getParameter("seq");
	    	BoardVO boardvo = null;
	    	khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
	    	
	    	if(loginuser == null ) { 
	    		String msg = "회원 로그인을 해야 이용가능합니다..";
	    		String loc = "javascript:history.back()";
	    		
	    		req.setAttribute("msg", msg);
	    		req.setAttribute("loc", loc);
	    		
	    		return "msg.notiles";
	    		// /Board/src/main/webapp/WEB-INF/viewsnotiles/msg.jsp 파일을 생성한다.	
			}else{
	    	String content = req.getParameter("content");
	    	
	    	if(content.trim().isEmpty()){
	    		String msg = "글 내용을 적어주세요";
	      		String loc = "javascript:history.back()";
	      		
	      		req.setAttribute("msg", msg);
	      		req.setAttribute("loc", loc);
	      		
	      		return "msg.notiles";
	    	}
   	
	    	int result = service.worAddComment(commentvo);
	    	
	    	if(result != 0) {
		    	int n = service.wAlarmCommentUpdate(alarmvo); //Alarm boardSeq Update count +1
		    	System.out.println("adsfkljadfljk"+ n );
		    	
		    		if(n != 0){
		    			String writer = req.getParameter("writer");
		    			int m = service.w_resultAlarmCntUpdate(writer); //resultAlarm 에 모든 alarm count 증감
		    			String userid = loginuser.getUserid();
		    			if(m != 0){
			    			getResultAlarm = service.getResultAlarm(userid); //resultalarm 테이블 불러오기
			 	    		
			 	    		session.setAttribute("getResultAlarm", getResultAlarm);
			    		}
		    			
		    		}else
		    			req.setAttribute("msg", "댓글알람1 실패!!");
	    	}else {
	    		// 댓글쓰기를 실패 or 댓글의 갯수(1씩 증가) 증가가 실패했다라면
	    		req.setAttribute("msg", "댓글쓰기 실패!!");
	    	}
	    	
	    	seq = commentvo.getParentSeq(); // 댓글에 대한 원게시물 글번호
	    	req.setAttribute("seq", seq);
	    	
	    	return "jsb/board/worrying/worAddCommentEnd.tiles";
	    	// /Board/src/main/webapp/WEB-INF/views2/board/addCommentEnd.jsp 파일을 생성한다.
			}
	    }
	    
	    // =====  첨부파일 다운로드 받기  =====
	    @RequestMapping(value="/jsb/worDownload.action", method={RequestMethod.GET})
	    public void worDownload(HttpServletRequest req, HttpServletResponse res, HttpSession session) { 
	    	
	    	String seq = req.getParameter("seq");
	    	// 첨부파일이 있는 글번호
	    	
	    	// 파일을 다운받기 위해서는 
	    	// DB에서 첨부파일이 있는 글번호의 fileName(2017060818081932452483099304.jpg) 값을 
	    	// 알아와야 한다.
	    	BoardVO boardvo = service.getWorViewWithNoAddCount(seq);
	    	
	    	String fileName = boardvo.getFileName();
	    	// fileName 은 예를들어 "2017060818081932452483099304.jpg" 이다.
	    	
	    	String orgFilename = boardvo.getOrgFilename();
	    	// orgFilename 은 예를들어 "강아지.png" 이다.
	    	
	    	// WAS 의 webapp 의 절대경로를 알아와야 한다.
			String rootpath = session.getServletContext().getRealPath("/");
			String path = rootpath + "resources" + File.separator + "files"; 
			// path 가 첨부파일들이 저장될 WAS(톰캣서버)의 폴더가 된다. 
			
			System.out.println(path);
			
			// === 다운로드 하기 === //
			boolean bool = false;
			
			bool = fileManager.doFileDownload(fileName, orgFilename, path, res);
	    	// 파일다운로드가 성공이면 true 를 반납해주고,
			// 파일다운로드가 실패이면 false 를 반납해준다.
			
		//	System.out.println(">>>> 확인용 bool : " + bool);
			
			if(!bool) {
				// 다운로드가 실패할 경우에만 에러메시지를 띄우도록 한다.
				
				res.setContentType("text/html; charset=UTF-8"); 
				PrintWriter writer = null;
				
				try {
					writer = res.getWriter();
					// 웹브라우저상에서 메시지를 쓰기 위한 객체(볼펜)생성.
				} catch (IOException e) {
					
				}
				
				writer.println("<script type='text/javascript'>alert('파일다운로드가 불가능 합니다!!!')</script>");  
			}
			
	    }    
	    
	    
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
	    
	    @RequestMapping(value="jsb/worWordSearchShow.action", method={RequestMethod.GET})
	    @ResponseBody
	    public List<HashMap<String, Object>> wordSearchShow(HttpServletRequest req) { 
	    	
	    	List<HashMap<String, Object>> returnmapList = new ArrayList<HashMap<String, Object>>(); 
	    	
	    	String colname = req.getParameter("colname");
	    	String search = req.getParameter("search");
	    	
	    	HashMap<String, String> map = new HashMap<String, String>();
	    	map.put("colname", colname);
	    	map.put("search", search);
	    	
	    	List<HashMap<String, String>> searchWordCompleteList = service.worSearchWordCompleteList(map); 
	    	
	    	if(searchWordCompleteList != null) {
	    		for(HashMap<String, String> datamap : searchWordCompleteList) {
	    			
	    			HashMap<String, Object> submap = new HashMap<String, Object>();
	    			submap.put("RESULTDATA", datamap.get("SEARCHDATA")); 
	    			
	    			returnmapList.add(submap);
	    		}
	    	}
	    	
	    	return returnmapList;
	    }
	    
	 // ====  추천 요청 ====
	    @RequestMapping(value="/jsb/wlikeAdd.action", method={RequestMethod.POST})
	    @ResponseBody
	    
	    public HashMap<String, String> wlikeAdd(HttpServletRequest req) {  
	    
	       String userid = req.getParameter("userid");
	       String seq = req.getParameter("seq");
	       
	           HashMap<String, String> map = new HashMap<String, String>();
	           map.put("userid", userid);
	           map.put("seq", seq);

	           HashMap<String, String> msg = new HashMap<String, String>();
	           
	       if(userid.equals("")) { // 조심!!!!  if(userid == null) 이면 안됨!!!
	          msg.put("msg", "추천을 클릭하시려면 먼저 로그인 하셔야 합니다."); 
	       }
	       else {
	            int n = service.wInsertLike(map);
	            
	            if(n > 0) {
	               msg.put("msg", "추천을 클릭하셨습니다."); 
	            }

	            else {
	               msg.put("msg", "이미 이전에 추천을 클릭하셨습니다.");  
	           }
	       }// end of if~else------------------
	       
	       return msg;      
	    }// end of public HashMap<String, String> likeAdd(HttpServletRequest req) throws Exception
	    
	    
	    // >>> Ajax
	    // ==== #js15. 관광지 리뷰 비추천 요청 ====
	    @RequestMapping(value="/jsb/wdislikeAdd.action", method={RequestMethod.POST})
	    @ResponseBody
	    
	    public HashMap<String, String> wdislikeAdd(HttpServletRequest req) { 
	    
	       String userid =   req.getParameter("userid");
	       String seq = req.getParameter("seq");
	       
	           HashMap<String, String> map = new HashMap<String, String>();
	           map.put("userid", userid);
	           map.put("seq", seq);
	       
	           HashMap<String, String> msg = new HashMap<String, String>();
	           
	       if(userid.equals("")) { // 조심!!!!  if(userid == null) 이면 안됨!!!
	          msg.put("msg", "비추천을 클릭하시려면 먼저 로그인 하셔야 합니다."); 
	       }
	       else {
	            int n = service.wInsertDislike(map); 
	            
	            if(n > 0) {
	               msg.put("msg", "비추천을 클릭하셨습니다."); 
	            }
	            else {
	               msg.put("msg", "이미 이전에 비추천을 클릭하셨습니다.");  
	           }
	       }// end of if~else------------------
	       
	       return msg;      
	    }// end of public HashMap<String, String> dislikeAdd(HttpServletRequest req) throws Exception
	
	    
	 // >>> Ajax
	    // ==== 리뷰 추천/비추천 수 알아오기 ====
	    @RequestMapping(value="/jsb/wlikeDislike.action", method={RequestMethod.POST})
	    @ResponseBody
	    
	    public HashMap<String, String> wlikeDislike(HttpServletRequest req) throws Exception{
	    
	       HashMap<String, String> map = new HashMap<String, String>();
	       
	       String seq = req.getParameter("seq");
	       
	           String likeCnt = service.getwLikeCnt(seq);
	           String dislikeCnt = service.getwDislikeCnt(seq);
	           
	         map.put("likeCnt", likeCnt); 
	         map.put("dislikeCnt", dislikeCnt); 
	         
	       return map;      
	    }// end of public HashMap<String, String> dislikeAdd(HttpServletRequest req) throws Exception
	 
	 
	
}
