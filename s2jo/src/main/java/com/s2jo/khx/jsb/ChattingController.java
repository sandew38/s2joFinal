package com.s2jo.khx.jsb;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.s2jo.khx.model.psc.khxpscMemberVO;



//=== # 웹채팅관련6 === 

@Controller
public class ChattingController {
	
	@RequestMapping(value="/jsb/multichat.action", method={RequestMethod.GET})
	public String requireLogin_multichat(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		
		
		return "jsb/chatting/multichat.tiles";
	}
	
	@RequestMapping(value="/jsb/multichat2.action", method={RequestMethod.GET})
	public String multichat2(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		
		
		return "jsb/chatting/multichat2.tiles";
	}
	
}
