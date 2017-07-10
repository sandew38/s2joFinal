package com.s2jo.khx.jsb;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MailController {
	
	@Autowired
	  private JavaMailSender mailSender;
	 
	 
	
	 
	  // mailSending 코드
	  @RequestMapping(value = "/jsb/mailSending.action")
	  public String mailSending(HttpServletRequest request) {
	   
	    String setfrom = "s2joadm@gmail.com";         
	    String tomail  = request.getParameter("tomail");     // 받는 사람 이메일
	    String title   = request.getParameter("title");      // 제목
	    String content = request.getParameter("content");    // 내용
	    String enter = System.getProperty("line.separator");
	    try {
	      MimeMessage message = mailSender.createMimeMessage();
	      MimeMessageHelper messageHelper 
	                        = new MimeMessageHelper(message, true, "UTF-8");
	 
	      messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
	      messageHelper.setTo(setfrom);     // 받는사람 이메일
	      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
	      messageHelper.setText(content+enter+enter+"해당 문의자 이메일 : "+ tomail +"입니다.");  // 메일 내용
	     
	      mailSender.send(message);
	    } catch(Exception e){
	      System.out.println(e);
	    }
	   
	    return "jsb/board/help/helpBoard.tiles";
	  }

}
