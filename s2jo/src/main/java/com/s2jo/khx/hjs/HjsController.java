package com.s2jo.khx.hjs;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.s2jo.khx.common.FileManager;
import com.s2jo.khx.common.ThumbnailManager;
import com.s2jo.khx.model.hjs.reviewBoardVO;
import com.s2jo.khx.model.hjs.reviewCommentVO;
import com.s2jo.khx.model.psc.khxpscMemberVO;
import com.s2jo.khx.service.hjs.HjsService;

//==== 컨트롤러 선언 ====

@Controller
@Component
//XML에서 bean을 만드는 대신에
//클래스명 앞에 @Component 어노테이션을 쓰면
//해당 클래스는 bean으로 자동 등록된다.
//그리고 bean의 id는 해당 클래스명이 된다. (첫 글자는 소문자)

public class HjsController {

   // ==== 의존객체 주입하기 (DI : Dependency Injection) ====   
   @Autowired
   private HjsService service;
   
   
   // ===== 관광지 Api 다루는 클래스 의존객체 주입하기(DI: Dependency Injection) =====
   @Autowired
   private ApiExplorer apiExplorer;
   
   
   //  ===== 파일업로드 및 파일다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection) =====
    @Autowired
    private FileManager fileManager;
    
   // ===== 썸네일을 다루어주는 클래스 의존객체 주입하기(DI: Dependency Injection) =====
   @Autowired
   private ThumbnailManager thumbnailManager;
    
    
   
   // ==== #js1. 기차역정보 메인 페이지 요청 ====
   @RequestMapping(value="/hjs/stationInfo.action", method={RequestMethod.GET})
   
   public String header_main(HttpServletRequest req, HttpServletResponse res){
	   
      List<String> stationList = service.getStationList();
       
       req.setAttribute("stationList", stationList);
      
      return "hjs/stationInfo.tiles";
      // /s2jo/src/main/webapp/WEB-INF/views/hjs/stationInfo.jsp 파일을 생성한다
      
   }// end of public String main(HttpServletRequest req) ----------------
   
   
   
   // >>> Ajax
   // ==== #js2. 기차역(시/도)별 관광정보 리스트 요청 ====
   @RequestMapping(value="/hjs/tourList.action", method={RequestMethod.POST})
   @ResponseBody
   
   public ArrayList<HashMap<String, String>> tourList(HttpServletRequest req) throws Exception{
      
      String SIDO = req.getParameter("SIDO");   // form_data 
      String GUGUN = req.getParameter("GUGUN"); 
    
      ArrayList<HashMap<String, String>> list = apiExplorer.tourList(SIDO, GUGUN); // 시/도, 군/구 별 관광지 목록 정보 담은 list
      
      return list;      
   }// end of public String main(HttpServletRequest req) ----------------

   
   
   // >>> Ajax
   // ==== #js3. 관광지별 상세 관광정보 요청 ====
   @RequestMapping(value="/hjs/tourDetail.action", method={RequestMethod.POST})
   @ResponseBody
   
   public HashMap<String, String> tourDetail(HttpServletRequest req) throws Exception{
      
      String SIDO = req.getParameter("SIDO");   // form_data 
      String GUGUN = req.getParameter("GUGUN"); 
      String RES_NM = req.getParameter("RES_NM"); 

      HashMap<String, String> map = apiExplorer.tourDetail(SIDO, GUGUN, RES_NM); // 관광지상세 정보 담은 list
      
      return map;      
   }// end of public String main(HttpServletRequest req) ----------------
   
   
   
   // ==== #js4 기차역후기 게시판 메인 페이지(글목록) 요청 ====
   @RequestMapping(value="/hjs/stationReview.action", method={RequestMethod.GET})
   
   public String header_stationReview(HttpServletRequest req, HttpServletResponse res, HttpSession session){
      
      String station = req.getParameter("station"); 
      session.setAttribute("station", station);
      
     // 페이징처리는 URL 주소창에 예를들어 /list.action?pageNo=3 와 같이 해주어야 한다.
   
      String pageNo = req.getParameter("pageNo");
      
      int totalCount = 0;        // 총게시물 건수
      int sizePerPage = 10;      // 한 페이지당 보여줄 게시물 갯수 (예: 3, 5, 10) 
      int currentShowPageNo = 1; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
      int totalPage = 0;         // 총페이지수(웹브라우저상에 보여줄 총 페이지 갯수)
      
      int start = 0;             // 시작 행 번호
      int end = 0;               // 끝 행 번호
      int startPageNo = 0;       // 페이지바에서 시작될 페이지 번호 

      
      int loop = 0;       // startPageNo 값이 증가할때 마다 1씩 증가하는 용도.
      int blocksize = 5;  // "페이지바" 에 보여줄 페이지의 갯수 
      
      if(pageNo == null) {
         currentShowPageNo = 1;
      }
      else {
         currentShowPageNo = Integer.parseInt(pageNo);

      }

      start = ((currentShowPageNo - 1) * sizePerPage) + 1;  
      end = start + sizePerPage - 1;        
       
      // ===== 검색어 포함

          String colname = req.getParameter("colname");
          String search = req.getParameter("search");
          
          HashMap<String, String> map = new HashMap<String, String>();
          map.put("colname", colname);
          map.put("search", search);
          
          map.put("station", station);
          
          // ===== 페이징 처리를 위해 start, end 를 map 에 추가하여 DB에서 select 되어지도록 한다. ===== 
          map.put("start", String.valueOf(start) ); // 키값 start, 밸류값은 해쉬맵이 String 타입인데 start 는 int 타입이어서 String 타입으로 변경함. 
          map.put("end", String.valueOf(end) );     // 키값 end,   밸류값은 해쉬맵이 String 타입인데 end 는 int 타입이어서 String 타입으로 변경함. 
          
          
          List<reviewBoardVO> rboardList = service.getRboardList(map);
        
          for(reviewBoardVO rboardvo: rboardList){
        	  
        	  // 추천수 ( 추천수 - 비추천수) 가져오기
              String likeCnt = service.getLikeCnt(rboardvo.getSeq());
              String dislikeCnt = service.getDislikeCnt(rboardvo.getSeq());
              
              int recCount = Integer.parseInt(likeCnt) - Integer.parseInt(dislikeCnt);
              rboardvo.setRecCount(Integer.toString(recCount));              
          }

           totalCount = service.getTotalCount(map);
           
           totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
           
           String pagebar = "";
           pagebar += "<ul>";
           
            loop = 1;
            
            // **** !!! 페이지바의 시작 페이지번호(startPageNo)값 만들기 
            startPageNo = ((currentShowPageNo - 1)/blocksize)*blocksize + 1;

  
            // **** 이전5페이지 만들기 ****  
            if(startPageNo == 1) {
               // 첫 페이지바에 도달한 경우
               pagebar += String.format("&nbsp;&nbsp;[이전%d페이지]", blocksize);
            }
            else {
               // 첫 페이지바가 아닌 두번째 이상 페이지바에 온 경우
               
               if(colname == null || search == null) {
                  // 검색어가 없는 경우
                  pagebar += String.format("&nbsp;&nbsp;<a href='/hjs/stationReview.action?station=%s&pageNo=%d'>[이전%d페이지]</a>&nbsp;&nbsp;", station, startPageNo-1, blocksize); // 처음 %d 에는 startPageNo값 , 두번째 %d 에는 페이지바에 나타낼 startPageNo값 이다.      
               }
               else{
                  // 검색어가 있는 경우
                   pagebar += String.format("&nbsp;&nbsp;<a href='/hjs/stationReview.action?station=%s&pageNo=%d&colname=%s&search=%s'>[이전%d페이지]</a>&nbsp;&nbsp;", station, startPageNo-1, colname, search, blocksize); // 검색어 있는 경우              
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
                     pagebar += String.format("&nbsp;&nbsp;<a href='/hjs/stationReview.action?station=%s&pageNo=%d'>%d</a>&nbsp;&nbsp;", station, startPageNo, startPageNo); // 처음 %d 에는 startPageNo값 , 두번째 %d 에는 페이지바에 나타낼 startPageNo값 이다.      
                  }
                  else{
                     // 검색어가 있는 경우
                      pagebar += String.format("&nbsp;&nbsp;<a href='/hjs/stationReview.action?station=%s&pageNo=%d&colname=%s&search=%s'>%d</a>&nbsp;&nbsp;", station, startPageNo, colname, search, startPageNo); // 검색어 있는 경우              
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
                  pagebar += String.format("&nbsp;&nbsp;<a href='/hjs/stationReview.action?station=%s&pageNo=%d'>[다음%d페이지]</a>&nbsp;&nbsp;", station, startPageNo, blocksize); // 처음 %d 에는 startPageNo값 , 두번째 %d 에는 페이지바에 나타낼 startPageNo값 이다.      
               }
               else{
                  // 검색어가 있는 경우
                   pagebar += String.format("&nbsp;&nbsp;<a href='/hjs/stationReview.action?station=%s&pageNo=%d&colname=%s&search=%s'>[다음%d페이지]</a>&nbsp;&nbsp;", station, startPageNo, colname, search, blocksize); // 검색어 있는 경우              
               }   
            }
            
            pagebar += "</ul>";
           
            req.setAttribute("pagebar", pagebar);
            req.setAttribute("colname", colname);
            req.setAttribute("search", search);
           
            req.setAttribute("rboardList", rboardList);

         session.setAttribute("readCountPermission", "yes");

         
      return "hjs/stationReview.tiles";
      // /s2jo/src/main/webapp/WEB-INF/views/hjs/stationReview.jsp 파일을 생성한다
      
   }// end of public String stationReview(HttpServletRequest req) ----------------
   
   
   
   // ==== #js5 기차역후기 게시판 글쓰기 요청 ====
   @RequestMapping(value="/hjs/addReview.action", method={RequestMethod.GET})
   
   public String addReview(HttpServletRequest req){
      
       // ===== 답변글쓰기 추가되었으므로 아래와 같이 한다. ===== 
       String fk_seq = req.getParameter("fk_seq");
       String groupno = req.getParameter("groupno"); 
       String depthno = req.getParameter("depthno");
       
       req.setAttribute("fk_seq", fk_seq);
       req.setAttribute("groupno", groupno);
       req.setAttribute("depthno", depthno);
      
      return "hjs/addReview.tiles";
      // /s2jo/src/main/webapp/WEB-INF/views/hjs/addReview.jsp 파일을 생성한다
      
   }// end of public String stationReview(HttpServletRequest req) ----------------
      
   
   
    // ===== #js6 기차역후기 게시판 글쓰기 완료 요청 =====
    @RequestMapping(value="/hjs/addReviewEnd.action", method={RequestMethod.POST})

    public String addReviewEnd(reviewBoardVO rboardvo, MultipartHttpServletRequest req, HttpSession session) {

       if(!rboardvo.getAttach().isEmpty()) {

       // WAS 의 webapp 의 절대경로를 알아와야 한다.
          String rootpath = session.getServletContext().getRealPath("/");
          String path = rootpath + "resources" + File.separator + "files";      
          
          // 2. 파일첨부를 위한 변수의 설정 및 값을 초기화한 후 파일올리기
          String newFileName = "";
          // WAS(톰캣) 디스크에 저장한 파일명이다.
          
          byte[] bytes = null;
          // 첨부파일을 WAS(톰캣) 디스크에 저장할때 사용되는 용도.
          
          long filesize = 0;
          // 파일크기를 읽어오기 위한 용도.
          
          try {
             // === 첨부된 파일을 byte[] 타입으로 얻어오기 ===
             bytes = rboardvo.getAttach().getBytes();
             // getBytes()는 첨부된 파일을 바이트단위로 파일을 다 읽어오는 것이다.
             
             
             // === 파일을 업로드 해주기 ===
             newFileName = fileManager.doFileUpload(bytes, rboardvo.getAttach().getOriginalFilename(), path); 

            // === >>>> thumbnail 파일 생성을 위한 작업 <<<<    =========  //
             String thumbnailFileName = thumbnailManager.doCreateThumbnail(newFileName, path); 
             rboardvo.setThumbnailFileName(thumbnailFileName);   
             // ===================================================  //

             rboardvo.setFileName(newFileName);
             // WAS(톰캣)에 저장될 파일명(20161121324325454354353333432.png) 
             
             rboardvo.setOrgFilename(rboardvo.getAttach().getOriginalFilename());
             // 진짜 파일명(강아지.png)
             // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명.
             
             filesize = rboardvo.getAttach().getSize();
             // 첨부한 파일의 파일크기를 얻어오는 것.
             
             rboardvo.setFileSize(String.valueOf(filesize));
             // 첨부한 파일의 크기를 String 타입으로 변경해서 저장함.
             
         } catch (Exception e) {
            
         }
          
       }// end of if-----------------
       // **** 첨부파일이 있는지 없는지? 의 끝 ****
       
       int n = 0;
       if(rboardvo.getAttach().isEmpty()) {
          // 파일첨부가 없다면
          n = service.addReview(rboardvo);
       }
       else {
          // 파일첨부가 있다면
          n = service.addReview_withFile(rboardvo);
       }
       
       req.setAttribute("n", n);
       return "hjs/addReviewEnd.tiles";
      // /s2jo/src/main/webapp/WEB-INF/views/hjs/addReviewEnd.jsp 파일을 생성한다
       
    }// end of public String stationReview(HttpServletRequest req) ----------------
      
   
   
    // ===== #js7 기차역후기 글1개 보여주는 요청 =====
    @RequestMapping(value="/hjs/reviewView.action", method={RequestMethod.GET})

    public String reviewView(HttpServletRequest req, HttpSession session) {
       
       String seq = req.getParameter("seq");
       
       reviewBoardVO rboardvo = null;
       
       /* =====  글조회수(readCount)증가(DML문 update)는 
                       반드시 해당 글제목을 클릭했을 경우에만 증가되고 
                       웹브라우저에서 새로고침(F5)을 했을 경우에는
                       증가가 안되도록 한다. =====
       */  
       if(session.getAttribute("readCountPermission") != null && 
          "yes".equals(session.getAttribute("readCountPermission")) ) {
          
          rboardvo = service.getView(seq);
           // 조회수(readCount) 1증가 후 글 1개를 가져오는 것
          
          session.setAttribute("readCountPermission", "no");
          // session "readCountPermission" 값을 "yes"에서 "no"로 변경함.
       }
       else {
          // 새로고침(F5)을 했을 경우
          rboardvo = service.getViewWithoutCount(seq);   
          // 조회수(readCount) 1증가 없이 그냥 글 1개를 가져오는 것
       }
       /*
         글내용에 엔터("\r\n")가 들어가 있으면  
         엔터("\r\n")를 <br>로 대체시켜서
         request 영역으로 넘긴다.
        */
       String content = rboardvo.getContent();
       content = content.replaceAll("\r\n", "<br>");
       rboardvo.setContent(content);
       
       // 추천수 ( 추천수 - 비추천수) 가져오기
       String likeCnt = service.getLikeCnt(seq);
       String dislikeCnt = service.getDislikeCnt(seq);
       
       int recCount = Integer.parseInt(likeCnt) - Integer.parseInt(dislikeCnt);
       rboardvo.setRecCount(Integer.toString(recCount));
       
       req.setAttribute("rboardvo", rboardvo);

       // ===== 댓글 내용 가져오기 ======
       List<reviewCommentVO> rcommentList = service.listComment(seq);
       req.setAttribute("rcommentList", rcommentList); 
       
       // ===== 이전글/다음글 가져오기 =====
       String station = (String)session.getAttribute("station");
       
       HashMap<String, String> map = new HashMap<String, String>();
       map.put("station", station);
       map.put("seq", seq);
       
       List<HashMap<String, String>> prevNextList = service.getPrevNext(map);
       req.setAttribute("prevNextList", prevNextList);
       
       return "hjs/reviewView.tiles";
      // /s2jo/src/main/webapp/WEB-INF/views/hjs/reveiwView.jsp 파일을 생성한다
       
    }// end of public String reviewView(HttpServletRequest req, HttpSession session) ----------------
    
    

   // ===== #js8 기차역후기 글수정 페이지 요청 =====
    @RequestMapping(value="/hjs/reviewEdit.action", method={RequestMethod.GET})
    public String reviewEdit(HttpServletRequest req, HttpServletResponse res, HttpSession session) { 
       
       // 글 수정해야할 글번호 가져오기
       String seq = req.getParameter("seq");
       
       // 글 수정해야할 글전체 내용 가져오기
       reviewBoardVO rboardvo = service.getViewWithoutCount(seq);
       // 조회수(readCount) 1증가 없이 그냥 글 1개를 가져오는 것
    
       khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
       
       if(loginuser == null){
          String msg = "먼저 로그인해주세요.";
          String loc = "/khx/loginform.action";
          
          req.setAttribute("msg", msg);
          req.setAttribute("loc", loc);
          
          return "hjs/msg.tiles";
          
       }
       if(!loginuser.getUserid().equals(rboardvo.getUserid()) ) { 
          String msg = "다른 사용자의 글은 수정이 불가합니다.";
          String loc = "javascript:history.back()";
          
          req.setAttribute("msg", msg);
          req.setAttribute("loc", loc);
          
          return "hjs/msg.tiles";
          // /s2jo/src/main/webapp/WEB-INF/views/hjs/msg.jsp 파일을 생성한다
       }
       else {
          req.setAttribute("rboardvo", rboardvo);
          
          return "hjs/reviewEdit.tiles";
          // /s2jo/src/main/webapp/WEB-INF/views/hjs/reviewEdit.jsp 파일을 생성한다
       }
       
    } 
    
    

    // ===== #js9. 글수정 페이지 완료하기 =====
    @RequestMapping(value="/hjs/reviewEditEnd.action", method={RequestMethod.POST})
    public String reviewEditEnd(reviewBoardVO rboardvo, HttpServletRequest req) { 
       
       HashMap<String, String> map = new HashMap<String, String>();
       map.put("seq", rboardvo.getSeq());
       map.put("subject", rboardvo.getSubject());
       map.put("content", rboardvo.getContent());
       map.put("pw", rboardvo.getPw());
       
       /*
        글수정을 하려면 원본글의 암호와 수정시 입력해주는 암호가 일치할때만 수정이 가능하도록 한다.
        서비스단에서 글수정을 처리한 결과를 int 타입으로 받아오겠다. 
        */
       int n = service.editReview(map);
       // 넘겨받은 값이 1이면 update 성공,
       // 넘겨받은 값이 0이면 update 실패(암호가 틀리므로).
       
       // n(글수정 성공 또는 실패)값을 request 영역에 저장시켜서 view 단 페이지로 넘긴다.
       // 그리고 변경되어진 글을 보여주기 위해서 request 영역에 변경한 글번호도 저장시키도록 한다.
       req.setAttribute("n", n);
       req.setAttribute("seq", rboardvo.getSeq()); // 수정된 자신의 글을 보여주기 위해서 넘긴다.
       
      return "hjs/reviewEditEnd.tiles";
      // /s2jo/src/main/webapp/WEB-INF/views/hjs/reviewEditEnd.jsp 파일을 생성한다
    } 
    
    

    // ===== #js10. 글삭제 페이지 요청하기 =====
    @RequestMapping(value="/hjs/reviewDel.action", method={RequestMethod.GET})
    public String reviewDel(HttpServletRequest req, HttpServletResponse res, HttpSession session) { 
       
       // 삭제해야할 글번호 가져오기
       String seq = req.getParameter("seq");
       
       // 글 삭제해야할 글전체 내용 가져오기
       reviewBoardVO rboardvo = service.getViewWithoutCount(seq);
       // 조회수(readCount) 1증가 없이 그냥 글 1개를 가져오는 것

       khxpscMemberVO loginuser = (khxpscMemberVO)session.getAttribute("loginuser");
       
       if(loginuser == null){
          String msg = "먼저 로그인해주세요.";
          String loc = "/khx/loginform.action";
          
          req.setAttribute("msg", msg);
          req.setAttribute("loc", loc);
          
          return "hjs/msg.tiles";
          
       }
       if(!loginuser.getUserid().equals(rboardvo.getUserid()) ) { 
          String msg = "다른 사용자의 글은 삭제가 불가합니다.";
          String loc = "javascript:history.back()";
          
          req.setAttribute("msg", msg);
          req.setAttribute("loc", loc);
          
          return "hjs/msg.tiles";
       }
       else {
          req.setAttribute("seq", seq);
          
          return "hjs/reviewDel.tiles";
       }
    } 
    
    

    // ===== #js11. 글삭제 페이지 완료하기 =====
    @RequestMapping(value="/hjs/reviewDelEnd.action", method={RequestMethod.POST})
    public String delEnd(HttpServletRequest req) 
       throws Throwable { 
       
       String seq = req.getParameter("seq");
       String pw = req.getParameter("pw");

       HashMap<String, String> map = new HashMap<String, String>();
       map.put("seq", seq);
       map.put("pw", pw);   
       
       int n = service.delReview(map);
       // 넘겨받은 값이 1이면 글삭제 성공,
       // 넘겨받은 값이 0이면 글삭제 실패(암호가 틀리므로).
       
       // n(글삭제 성공 또는 실패)값을 request 영역에 저장시켜서 view 단 페이지로 넘긴다.
       req.setAttribute("n", n);
       
       return "hjs/reviewDelEnd.tiles";
    }    
    

    
    // ===== #js12. 첨부파일 다운로드 받기  =====
    @RequestMapping(value="/hjs/download.action", method={RequestMethod.GET})
    public void download(HttpServletRequest req, HttpServletResponse res, HttpSession session) { 
       
       String seq = req.getParameter("seq");
       // 첨부파일이 있는 글번호
       
       // 파일을 다운받기 위해서는 
       // DB에서 첨부파일이 있는 글번호의 fileName(2017060818081932452483099304.jpg) 값을 
       // 알아와야 한다.
       reviewBoardVO rboardvo = service.getViewWithoutCount(seq);
       
       String fileName = rboardvo.getFileName();
       // fileName 은 예를들어 "2017060818081932452483099304.jpg" 이다.
       
       String orgFilename = rboardvo.getOrgFilename();
       // orgFilename 은 예를들어 "강아지.png" 이다.
       
       // WAS 의 webapp 의 절대경로를 알아와야 한다.
      String rootpath = session.getServletContext().getRealPath("/");
      String path = rootpath + "resources" + File.separator + "files"; 
      // path 가 첨부파일들이 저장될 WAS(톰캣서버)의 폴더가 된다. 
      
      
      // === 다운로드 하기 === //
      boolean bool = false;
      
      bool = fileManager.doFileDownload(fileName, orgFilename, path, res);
       // 파일다운로드가 성공이면 true 를 반납해주고,
      // 파일다운로드가 실패이면 false 를 반납해준다.
      
   //   System.out.println(">>>> 확인용 bool : " + bool);
      
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
    
    
    
    // ===== #js13. 댓글쓰기  =====
    @RequestMapping(value="/hjs/addComment.action", method={RequestMethod.GET})
    public String addComment(HttpServletRequest req, HttpServletResponse res, reviewCommentVO rcommentvo) 
       throws Throwable { 
       
       //System.out.println(">>>>> 확인용 userid :" + rcommentvo.getUserid());
       
       int result = service.addReviewComment(rcommentvo); 
       
       if(result != 0) {
          // 댓글쓰기와 원게시물(final_stationBoard 테이블)에 댓글의 갯수(1씩 증가) 증가가 모두 성공했다라면
          req.setAttribute("msg", "댓글쓰기 완료!!");
       }
       else {
          // 댓글쓰기를 실패 or 댓글의 갯수(1씩 증가) 증가가 실패했다라면
          req.setAttribute("msg", "댓글쓰기 실패!!");
       }
       
       String seq = rcommentvo.getParentSeq(); // 댓글에 대한 원게시물 글번호
      
       req.setAttribute("seq", seq);
       
       return "hjs/addCommentEnd.tiles";
    }
    
    
   // >>> Ajax
   // ==== #js14. 관광지 리뷰 추천 요청 ====
   @RequestMapping(value="/hjs/likeAdd.action", method={RequestMethod.POST})
   @ResponseBody
   
   public HashMap<String, String> likeAdd(HttpServletRequest req) {  
   
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
           int n = service.insertLike(map);
           
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
   @RequestMapping(value="/hjs/dislikeAdd.action", method={RequestMethod.POST})
   @ResponseBody
   
   public HashMap<String, String> dislikeAdd(HttpServletRequest req) { 
   
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
           int n = service.insertLike(map); 
           
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
   // ==== #js16. 관광지 리뷰 추천/비추천 수 알아오기 ====
   @RequestMapping(value="/hjs/likeDislike.action", method={RequestMethod.POST})
   @ResponseBody
   
   public HashMap<String, String> likeDislike(HttpServletRequest req) throws Exception{
   
      HashMap<String, String> map = new HashMap<String, String>();
      
      String seq = req.getParameter("seq");
      
          String likeCnt = service.getLikeCnt(seq);
          String dislikeCnt = service.getDislikeCnt(seq);
          
        map.put("likeCnt", likeCnt); 
        map.put("dislikeCnt", dislikeCnt); 
        
      return map;      
   }// end of public HashMap<String, String> dislikeAdd(HttpServletRequest req) throws Exception

   
   
   
   // >>> Ajax
   // ===== #js17. 관광지 좋아요 요청  =====
   @RequestMapping(value="/hjs/tourLike.action", method={RequestMethod.POST})
   @ResponseBody
   
   public HashMap<String, String> tourLikeAdd(HttpServletRequest req, HttpServletResponse res) 
      throws Throwable { 
      
	      String sido = req.getParameter("sido");
	      String name = req.getParameter("name");
      
	      HashMap<String, String> map = new HashMap<String, String>();
	    
	      map.put("sido", sido); 
	      map.put("name", name); 
	      
	      int n = service.insertTourLike(map); 
         
	      HashMap<String, String> msg = new HashMap<String, String>();
	      
	      if(n > 0) {
	          msg.put("msg", "관광지를 추천하셨습니다!"); 
	      } 
	      else {
	    	  msg.put("msg", "다시 시도해주세요."); 
	      } 
	      
     return msg;
   }
     
   
   
   // >>> Ajax
   // ==== #js18. 관광지 좋아요 수 알아오기 ====
   @RequestMapping(value="/hjs/tourLikeShow.action", method={RequestMethod.POST})
   @ResponseBody
   
   public HashMap<String, String> tourLikeShow(HttpServletRequest req) throws Exception{
   
      HashMap<String, String> map = new HashMap<String, String>();
      
      String sido = req.getParameter("sido");
      String name = req.getParameter("name");
     
      map.put("sido", sido); 
      map.put("name", name); 
      
      String likeCnt = service.getTourLikeCnt(map);
      
      HashMap<String, String> map2 = new HashMap<String, String>();
      
      map2.put("likeCnt", likeCnt); 
        
      return map2;      
   }// end of public HashMap<String, String> dislikeAdd(HttpServletRequest req) throws Exception
   
   
   
   
   // ==== #js19. 차트 메인 페이지 요청 ====
   @RequestMapping(value="/hjs/hjsStatistics.action", method={RequestMethod.GET})
   
   public String chartMain(HttpServletRequest req, HttpServletResponse res){
	   
      
      return "hjs/chartMain.tiles";
      // /s2jo/src/main/webapp/WEB-INF/views/hjs/chartMain.jsp 파일을 생성한다
      
   }// end of public String main(HttpServletRequest req) ----------------
   
   
   
   
   
	 // >>> Ajax
	 // ==== #js20. 관광지 통계1 ====
	 @RequestMapping(value="/hjs/hjsStatistics1.action", method={RequestMethod.GET})
	 @ResponseBody
	 
	 public List<HashMap<String, Object>> hjsStatistics1(HttpServletRequest req, HttpServletResponse res) 
			 throws Exception{
	 
			List<HashMap<String, Object>> returnmapList = new ArrayList<HashMap<String, Object>>(); 
			
			List<HashMap<String,String>> list = service.getHjsStatistics1();
						
			if(list != null) {
				for(HashMap<String,String> datamap : list) {
					HashMap<String, Object> submap = new HashMap<String, Object>(); 
					submap.put("SIDO",  	 datamap.get("SIDO"));
					submap.put("SCNT",   	 datamap.get("SCNT"));
					submap.put("RK",   		 datamap.get("RK"));
					submap.put("PERCENTAGE", datamap.get("PERCENTAGE"));
					
					returnmapList.add(submap);
				}
			}
			return returnmapList;
			
	 }// end of public HashMap<String, String> dislikeAdd(HttpServletRequest req) throws Exception
	 
   
   
   
   
    
}