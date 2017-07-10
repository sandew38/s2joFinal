package com.s2jo.khx.jsb;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.s2jo.khx.model.jsb.AlarmVO;
import com.s2jo.khx.model.jsb.BoardVO;
import com.s2jo.khx.model.psc.khxpscMemberVO;
import com.s2jo.khx.service.jsb.JsbService;


@Controller
@Component
// XML에서 bean을 만드는 대신에
// 클래스명 앞에 @Component 어노테이션을 쓰면
// 해당 클래스는 bean으로 자동 등록된다.
// 그리고 bean의 id는 해당 클래스명이 된다. (첫 글자는 소문자)
public class JsbAlarmController {

	//의존객체 주입하기 (DI : Dependency Injection) ====
	
		@Autowired
		private JsbService service; 
		
		//알람 리스트 ㄱㄱ~
		@RequestMapping(value="/jsb/alarmList.action", method={RequestMethod.GET})
		public String alarmList(HttpServletRequest req, HttpSession session){
			
			
			List<AlarmVO> rAlarmList = service.rAlarmList();
			List<AlarmVO> tAlarmList = service.tAlarmList();
			List<AlarmVO> wAlarmList = service.wAlarmList();
		 	
			
			
		 	req.setAttribute("rAlarmList", rAlarmList);
		 	req.setAttribute("tAlarmList", tAlarmList);
		 	req.setAttribute("wAlarmList", wAlarmList);
			return "jsb/alarm/alarmList.tiles";
		}
		
		//resultAlarm 에 모든 alarm count 합하기
		@RequestMapping(value="/jsb/resultAlarm.action", method={RequestMethod.GET})
		public String alarmResult(HttpServletRequest req, HttpSession session){
			
			String seq = req.getParameter("seq");
			
			
			req.setAttribute("seq", seq);
			return "jsb/board/recommend/recAddCommentEnd.tiles";
		}
		
		
}
