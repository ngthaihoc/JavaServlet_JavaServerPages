package hocng.utils;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class sendMail {

	public static void sendEmail(String to, String subject, String content) throws Exception {
		Properties pro = new Properties();
		pro.put("mail.smtp.host", "smtp.gmail.com");
		pro.put("mail.smtp.port", "587");
		pro.put("mail.smtp.auth", "true");
		pro.put("mail.smtp.starttls.enable", "true");
		pro.put("mail.debug", "true");

		Session session = Session.getInstance(pro, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("ngthaihoc.vn@gmail.com", "xrue lasq zttm oltr");
			}
		});

		Message mess = new MimeMessage(session);
		mess.setContent(content, "text/html; charset=UTF-8");
		mess.setFrom(new InternetAddress("ngthaihoc.vn@gmail.com"));
		mess.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
		mess.setSubject(subject);
		mess.setText(content);

		Transport.send(mess);
	}

}
