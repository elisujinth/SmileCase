package com.spring.smileCase.common;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticator extends Authenticator {
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		String userName = "sjlee.bsns";
		String userPwd = "dltnwls1!";
		return new PasswordAuthentication(userName, userPwd);
	}
}
