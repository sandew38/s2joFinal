package com.s2jo.khx.psc;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MySMTPAuthenticator extends Authenticator {

	@Override
	public PasswordAuthentication getPasswordAuthentication() {
		
		// gmail 인 경우 @gmail.com 을 제외한 아이디만 입력해야 한다.
		return new PasswordAuthentication("s2joadm","qwer1234$");  
		
	}
	
}
