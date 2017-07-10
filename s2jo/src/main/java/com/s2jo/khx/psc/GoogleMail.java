package com.s2jo.khx.psc;


import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;


public class GoogleMail {

	public void sendmail(String recipient, String certificationCode) 
	       throws Exception {
		
		// 1. 정보를 담아주는 객체
		Properties prop = new Properties();
		
		// 2. SMTP(Simple Mail Transfer Protocol) 를 
		//    무엇으로 사용할 것인지 설정을 해주어야 한다.
		//    우리는 Google gmail 를 사용하도록 하겠다.
		//    그러므로 gmail 계정이 있어야 한다.
		prop.put("mail.smtp.user", "s2joadm@gamil.com");
		
		// 3. SMTP 서버 정보 설정
		//    Google gmail 를 사용하는 경우 "smtp.gmail.com" 
		prop.put("mail.smtp.host", "smtp.gmail.com");
		
		prop.put("mail.smtp.port", "465");
		prop.put("mail.smtp.starttls.enable", "true");
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.debug", "true");
		prop.put("mail.smtp.socketFactory.port", "465");
		prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); 
		prop.put("mail.smtp.socketFactory.fallback", "false");
		prop.put("mail.smtp.ssl.enable", "true");
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com"); 
		
		Authenticator smtpAuth = new MySMTPAuthenticator();
		Session ses = Session.getInstance(prop, smtpAuth);
		
		// 메일을 보내는 상황을 콘솔에 출력해본다.
		ses.setDebug(true);
		
		// 메일의 내용을 담기 위한 객체생성
		MimeMessage msg = new MimeMessage(ses);
		
		// 제목설정
		String subject = "[KHX Family]인증번호 안내메일입니다."; 
		msg.setSubject(subject);
		
		// 보내는 사람의 메일주소
		String sender = "s2joadm@gamil.com";
		Address fromAddr = new InternetAddress(sender);
		msg.setFrom(fromAddr);
		
		// 받는 사람의 메일주소
		Address toAddr = new InternetAddress(recipient);
		msg.addRecipient(Message.RecipientType.TO, toAddr);
		
		MimeBodyPart imgPart = new MimeBodyPart();
		DataSource fds = new FileDataSource("/khx/resources/images/");
					
		imgPart.setDataHandler(new DataHandler(fds));
		imgPart.setFileName(fds.getName());
		imgPart.addHeader("Content-ID", "khxlogo.png");
		imgPart.setDisposition("inline"); 


		MimeMultipart mp = new MimeMultipart("related");
		mp.addBodyPart(imgPart);  


		// 메시지 본문의 내용과 형식, 캐릭터셋 설정하기
		msg.setContent(
				"<div align='center' style='background-color:#F6F6F6; height:300px;'>"+
					"<h1>안녕하세요, KHX Family 고객센터입니다.</h1>"+
						"<hr>"+
					   "<h2>회원님께서 요청하신 인증번호입니다.</h2>"+ 
						    
							"<br/>"+
							"<span style='font-weight:bold; font-size:16pt; color:blue;'>"+
							"<br/>"+
							certificationCode+
							"</span>"+
							"항상 저희 KHX를 이용해주셔서 감사드립니다."+
						"<br/>"+
						"<label>"+
							"<a href='http://192.168.10.42:9090/khx/' style='color: black; font-size: large;'>"+
								"<h3>KHX EXPRESS사이트 바로가기</h3>"+
							"</a>"+
						"</label>"+		
				"</div>"+
						
				"<div align='center' style='background-color:#F6F6F6; height:100px;'>"+
					"<h1>"+
						"<span style='color:black;'>KHX EXPRESS와 소통하실 4가지 방법!</span>"+
					"</h1>"+
					"<h3>"+
						"<a href='https://www.facebook.com/profile.php?id=100019126300090'><span style='font-weight:bold;'>khx 페이스북</span></a>&nbsp;"+
						
						"<a href='https://www.instagram.com/trainkhx/'><span style='font-weight:bold;'>khx 인스타그램</span></a>&nbsp;"+
						
						"<a href='https://story.kakao.com/khxexpress'><span style='font-weight:bold;'>khx 카카오스토리</span></a>&nbsp;"+
					
						"<a href='https://twitter.com/s2joadm'><span style='font-weight:bold;'>khx 트위터</span></a></div>"+
					"</h3>"+
				"</div>"
	, "text/html;charset=UTF-8"); 
		
		// 메일발송
		Transport.send(msg);
		
		
	}// end of sendmail(String recipient, String certificationCode)-----------
	
}






