package com.s2jo.khx.jsb;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.s2jo.khx.common.FileManager;
import com.s2jo.khx.model.psc.khxpscMemberVO;
import com.s2jo.khx.service.jsb.JsbService;

@Controller
@Component
// XML에서 bean을 만드는 대신에
// 클래스명 앞에 @Component 어노테이션을 쓰면
// 해당 클래스는 bean으로 자동 등록된다.
// 그리고 bean의 id는 해당 클래스명이 된다. (첫 글자는 소문자)
public class JsbHelpController {
	//의존객체 주입하기 (DI : Dependency Injection) ====
	
		@Autowired
		private JsbService service; 
		
	//  파일업로드 및 파일다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection) =====
	    @Autowired
	    private FileManager fileManager;
	    
	    
	    //고객센터 기본 뷰
	    @RequestMapping(value="/jsb/helpBoard.action", method={RequestMethod.GET})
		public String recommendList(HttpServletRequest req, HttpSession session){
	    	
	    	
	    	return "jsb/board/help/helpBoard.tiles";
	    }
	    
	    //자동검색
  /* @RequestMapping(value="/jsb/autocomplete.action", method={RequestMethod.GET})
		public JSONArray autocomplete(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException{

			request.setCharacterEncoding("UTF-8");
			
	        String value = request.getParameter("value");
	        JSONArray list = new JSONArray();
	        JSONObject object = null;
	    		
	         
	        if(value.indexOf("개발") > -1) {
	            object = new JSONObject();
	            object.put("data", "개발");
	            list.put(object);
	            object = new JSONObject();
	            object.put("data", "개발자");
	            list.put(object);
	            object = new JSONObject();
	            object.put("data", "개에발자");
	            list.put(object);
	            object = new JSONObject();
	            object.put("data", "kkkkkk");
	            list.put(object);
	        }else if(value.indexOf("블로") > -1) {
	            object = new JSONObject();
	            object.put("data", "블로그꾸미기");
	            list.put(object);      
	            object = new JSONObject();
	            object.put("data", "블로그누락");
	            list.put(object);
	            object = new JSONObject();
	            object.put("data", "개발로짜의블로그");
	            list.put(object);
	            object = new JSONObject();
	            object.put("data", "블로장생");
	            list.put(object);
	        }
	             
	        PrintWriter pw = response.getWriter();
	        pw.print(list);
	        pw.flush();
	        pw.close();
	    
	    	return list;
	    	
	    }*/
	    
	    
	    
}
