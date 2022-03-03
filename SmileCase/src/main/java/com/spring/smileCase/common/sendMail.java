package com.spring.smileCase.common;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class sendMail {

	public void sendEmail(String menu, String to, String content) throws Exception {
		// menu: 아이디 찾기/비밀번호 찾기          to : 받는 사람          content : 아이디의 일부/임시 비밀번호/이름
		
		// Properties 클래스 : 시스템의 속성을 객체로 생성하는 클래스
		Properties prop = new Properties();

		// 프로토콜 설정
		prop.put("mail.transport.protocol", "smtp");
		// gmail SMTP 서비스 주소(호스트)
		prop.put("mail.smtp.user", "sjlee.bsns.gmail.com");
		// 이메일 발송을 처리해줄 SMTP 서버
		prop.put("mail.smtp.host", "smtp.gmail.com");
		// gmail SMTP 서비스 포트 설정
		// TLS의 포트번호는 587, SSL의 포트번호는 465
		// 587로 설정하니까 에러남
		prop.put("mail.smtp.port", "465");
		// 로그인할 때 TLS를 사용할 것인지 설정 ==> gmail에서는 TLS가 필수가 아님
		prop.put("mail.smtp.starttls.enable", "true");
		// gmail 인증용 SSL 설정 ==> gmail에서 인증할 때 사용하므로 필수
		prop.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		// SMTP 인증을 사용한다는 설정
		prop.put("mail.smtp.auth", "true");

		prop.put("mail.smtp.debug", "true");
		prop.put("mail.smtp.socketFactory.fallback", "false");

		// Authenticator : 네트워크 접속에 필요한 인증을 취득하기 위한 객체
		// 암호 인증을 사용하기 위해 호출
		Authenticator auth = new SMTPAuthenticator();
		// MailAuth.java에서 Authenticator를 상속받아 생성한 MailAuth 클래스를 받아 세션을 생성
		// getDefaultInstance의 첫 번째 파라미터는 앞서 설정한 메일 처리 환경
		Session mailSession = Session.getDefaultInstance(prop, auth);
		// 메일을 전송할 때의 상황 출력
		mailSession.setDebug(true);

		// MimeMessage는 Message (추상)클래스를 상속받은 인터넷 메일을 위한 클래스
		// 위에서 생성한 세션을 담아 msg 객체를 생성함
		Message msg = new MimeMessage(mailSession);

		// 보내는 사람 설정
		// Message 클래스의 setFrom() 메소드를 사용하여 발송자를 지정함 (발송자의 메일, 발송자명)
		// InternetAddress 클래스는 이메일 주소를 나타낼 때 사용하는 클래스
		msg.setFrom(new InternetAddress("sjlee.bsns@gmail.com", "Smile Case"));
		// 받는 사람 설정
		// Message 클래스의 setRecipient() 메소드를 사용하여 수신자 설정
		// setRecipient() 메소드로 수신자, 참조, 숨은 참조 설정이 가능함
		// Message.RecipientType.TO : 받는 사람    .CC : 참조    .BCC : 숨은 참조
		// InternetAddress.parse(to, false) : 수신자의 메일
		msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));

		// 제목 설정
		msg.setSubject("안녕하세요. Smile Case 입니다.");
		
		String text ="";
		if(menu == "id") {
			// 아이디 찾기
			text = "<div style=\"border: 3px solid rgba(155, 89, 182, 0.5); width: 850px; text-align: center; padding-top: 15px;\">\r\n" + 
					"		<div style=\"padding: 15px; line-height:600%;\">\r\n" + 
					"			<b style=\"font-size: 21px;\"><< 아이디 안내 메일 >></b>\r\n" + 
					"			<div style=\"font-size: 19px; font-weight: 800;\">\r\n" + 
					"				<span>회원님의 아이디는 </span>\r\n" + 
					"				<span style=\"color: rgb(155, 89, 182);\">" + content + "***</span>\r\n" + 
					"				<span>입니다.</span>\r\n" + 
					"			</div>\r\n" + 
					"			<hr style=\"border:1.5px solid lightgray; width:60%;\">\r\n" + 
					"			<div style=\"font-weight: 550; line-height:200%;\">\r\n" + 
					"				저희 Smile Case를 이용해주셔서 감사합니다.<br>\r\n" + 
					"				더욱 편리한 서비스를 제공하기 위해 항상 최선을 다하겠습니다.\r\n" + 
					"			</div>\r\n" + 
					"		</div>\r\n" + 
					"		<br><br>\r\n" + 
					"		<div style=\"background: #eee; padding: 20px; line-height:250%;\">\r\n" + 
					"			Smile Case&nbsp;&nbsp;|&nbsp;&nbsp;서울시 네모구 세모동 어쩌구 123 (우) 12345&nbsp;&nbsp;|&nbsp;&nbsp;대표 : 김대표\r\n" + 
					"			<br>\r\n" + 
					"			TEL : 02-123-4567&nbsp;&nbsp;|&nbsp;&nbsp;FAX : 02-345-6789&nbsp;&nbsp;|&nbsp;&nbsp;사업자등록번호 : 123-45-67890\r\n" + 
					"		</div>\r\n" + 
					"	</div>\n";
		} else if(menu == "pwd") {
			// 비밀번호 찾기
			text = "<div style=\"border: 3px solid rgba(155, 89, 182, 0.5); width: 850px; text-align: center; padding-top: 15px;\">\r\n" + 
					"		<div style=\"padding: 15px; line-height:600%;\">\r\n" + 
					"			<b style=\"font-size: 21px;\"><< 비밀번호 안내 메일 >></b>\r\n" + 
					"			<div style=\"font-size: 19px; font-weight: 800;\">\r\n" + 
					"				<span>임시 비밀번호는 </span>\r\n" + 
					"				<span style=\"color: rgb(155, 89, 182);\">" + content + "</span>\r\n" + 
					"				<span>입니다.</span>\r\n" + 
					"			</div>\r\n" + 
					"			<hr style=\"border:1.5px solid lightgray; width:60%;\">\r\n" + 
					"			<div style=\"font-weight: 550; line-height:200%;\">\r\n" + 
					"				저희 Smile Case를 이용해주셔서 감사합니다.<br>\r\n" + 
					"				더욱 편리한 서비스를 제공하기 위해 항상 최선을 다하겠습니다.\r\n" + 
					"			</div>\r\n" + 
					"		</div>\r\n" + 
					"		<br><br>\r\n" + 
					"		<div style=\"background: #eee; padding: 20px; line-height:250%;\">\r\n" + 
					"			Smile Case&nbsp;&nbsp;|&nbsp;&nbsp;서울시 네모구 세모동 어쩌구 123 (우) 12345&nbsp;&nbsp;|&nbsp;&nbsp;대표 : 김대표\r\n" + 
					"			<br>\r\n" + 
					"			TEL : 02-123-4567&nbsp;&nbsp;|&nbsp;&nbsp;FAX : 02-345-6789&nbsp;&nbsp;|&nbsp;&nbsp;사업자등록번호 : 123-45-67890\r\n" + 
					"		</div>\r\n" + 
					"	</div>\n";
		}
		// 내용 설정
		msg.setContent(text, "text/html; charset=UTF-8;");
		// 보내는 날짜 설정
		msg.setSentDate(new Date());

		// Transport는 메일을 최종적으로 보내는 클래스로, 메일을 보내는 부분
		Transport.send(msg);
	}
}