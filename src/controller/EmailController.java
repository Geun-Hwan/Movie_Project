package controller;

import java.util.Date;
import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.MemberDAO;
import model.MyAuthentication;

@Controller
public class EmailController {

	@Autowired
	@Lazy
	MemberDAO mdao;
	
	@RequestMapping(value="/email.do",method= {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public String email(String mail) {
		
		String key =null;
		Properties p = System.getProperties();
		
		p.put("mail.smtp.starttls.enable", "true"); // gmail은 true 고정
		p.put("mail.smtp.host", "smtp.gmail.com"); // smtp 서버 주소
		p.put("mail.smtp.auth", "true"); // gmail은 true 고정
		p.put("mail.smtp.port", "587"); //
		p.put("mail.smtp.ssl.protocols", "TLSv1.2");

		Authenticator auth = new MyAuthentication();
		// session 생성 및 MimeMessage생성
		Session session = Session.getDefaultInstance(p, auth);
		MimeMessage msg = new MimeMessage(session);
		
		Random random = new Random();
		int checkNum = random.nextInt(8888)+1111;
		try {
			// 편지보낸시간
			msg.setSentDate(new Date());
			InternetAddress from;
			from = new InternetAddress("ezenac11@gmail.com"); // 발신자 아이디 고정
			// 이메일 발신자
			msg.setFrom(from);
			// 이메일 수신자
			InternetAddress to = new InternetAddress(mail);
			msg.setRecipient(Message.RecipientType.TO, to);
			// 이메일 제목
			msg.setSubject("EZV 회원가입 인증메일 입니다.", "UTF-8");
			// 이메일 내용
			msg.setText("해당 인증번호를 인증번호 확인란에 정확히 입력해 주세요<br><br> "
					+ "정상적으로 인증번호를 입력하셔야 회원가입이 처리됩니다.<br><br>"
					+ "인증 번호:"+checkNum, "UTF-8"); // 인증번호 넣기
			// 이메일 헤더
			msg.setHeader("content-Type", "text/html");
			// 메일보내기
			Transport.send(msg, msg.getAllRecipients());
			System.out.println(mail);
			System.out.println("전송 완료");
		} catch (AddressException addr_e) {
			addr_e.printStackTrace();
		} catch (MessagingException msg_e) {
			msg_e.printStackTrace();
		} catch (Exception msg_e) {
			msg_e.printStackTrace();
		}
		key = Integer.toString(checkNum);
		return key;
	}
	
	@PostMapping("/emailCheck.do")
	@ResponseBody
	public int emailCheck(String mail) {
			
		return mdao.confirmEamil(mail);
	}
	
	
	@PostMapping("/findId")
	@ResponseBody
	public boolean findId(String email,String name) {
		// dao 작업 후 아이디가 있으면 id를 이메일로 전송
		// 해당하는 정보를 이메일로 전송하였습니다.
		boolean check = false;
		String userid=null;
		
		userid = mdao.findId(email, name);
		System.out.println(userid);
	if (!(userid==null)) {
		Properties p = System.getProperties();
		
		p.put("mail.smtp.starttls.enable", "true"); // gmail은 true 고정
		p.put("mail.smtp.host", "smtp.gmail.com"); // smtp 서버 주소
		p.put("mail.smtp.auth", "true"); // gmail은 true 고정
		p.put("mail.smtp.port", "587"); //
		p.put("mail.smtp.ssl.protocols", "TLSv1.2");


		Authenticator auth = new MyAuthentication();
		// session 생성 및 MimeMessage생성
		Session session = Session.getDefaultInstance(p, auth);
		MimeMessage msg = new MimeMessage(session);
		
		try {
			// 편지보낸시간
			msg.setSentDate(new Date());
			InternetAddress from;
			from = new InternetAddress("ezenac11@gmail.com"); // 발신자 아이디 고정
			// 이메일 발신자
			msg.setFrom(from);
			// 이메일 수신자
			InternetAddress to = new InternetAddress(email);
			msg.setRecipient(Message.RecipientType.TO, to);
			// 이메일 제목
			msg.setSubject("EZV 아이디 찾기 확인 메일 입니다.", "UTF-8");
			// 이메일 내용
			msg.setText("회원님의 아이디 찾기 결과입니다. <br><br> "
					+ "회원님의 아이디는 <b>"+userid+"</b>입니다.<br><br> "
							+ "개인정보 보호를 위해 비밀번호 변경을 권장합니다.", "UTF-8");
			// 이메일 헤더
			msg.setHeader("content-Type", "text/html");
			// 메일보내기
			Transport.send(msg, msg.getAllRecipients());
			System.out.println(email);
			System.out.println("전송 완료");
		} catch (AddressException addr_e) {
			addr_e.printStackTrace();
		} catch (MessagingException msg_e) {
			msg_e.printStackTrace();
		} catch (Exception msg_e) {
			msg_e.printStackTrace();
		}
		check =true;
		}
		else {
			System.out.println("일치하는 정보가 없습니다."); // 일치하는 정보가 없습니다.
		}
		return check;
	}
	
	@PostMapping("/findPw")
	@ResponseBody
	public int findPw(String email, String userid) {
		int checkcode = 0;
		
		
		Properties p = System.getProperties();
		//db 작업 email, userid 해당하는 정보 가져오기 있으면 
		if(mdao.findPwd(userid, email)) {
		p.put("mail.smtp.starttls.enable", "true"); // gmail은 true 고정
		p.put("mail.smtp.host", "smtp.gmail.com"); // smtp 서버 주소
		p.put("mail.smtp.auth", "true"); // gmail은 true 고정
		p.put("mail.smtp.port", "587"); //
		p.put("mail.smtp.ssl.protocols", "TLSv1.2");

		Authenticator auth = new MyAuthentication();
		// session 생성 및 MimeMessage생성
		Session session = Session.getDefaultInstance(p, auth);
		MimeMessage msg = new MimeMessage(session);

		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		try {
			// 편지보낸시간
			msg.setSentDate(new Date());
			InternetAddress from;
			from = new InternetAddress("ezenac11@gmail.com"); // 발신자 아이디 고정
			// 이메일 발신자
			msg.setFrom(from);
			// 이메일 수신자
			InternetAddress to = new InternetAddress(email);
			msg.setRecipient(Message.RecipientType.TO, to);
			// 이메일 제목
			msg.setSubject("EZV 비밀번호 찾기 인증메일 입니다.", "UTF-8");
			// 이메일 내용
			msg.setText("해당 인증번호를 인증번호 확인란에 정확히 입력해 주세요<br><br> " + 
			"인증번호 확인 후 홈페이지에서 비밀번호 변경을 진행해 주세요.<br><br> "
			+ "인증 번호: <b>"+checkNum+"</b>", "UTF-8"); // 인증번호 넣기
			// 이메일 헤더
			msg.setHeader("content-Type", "text/html");
			// 메일보내기
			Transport.send(msg, msg.getAllRecipients());
			System.out.println(email);
			System.out.println("전송 완료");
		} catch (AddressException addr_e) {
			addr_e.printStackTrace();
		} catch (MessagingException msg_e) {
			msg_e.printStackTrace();
		} catch (Exception msg_e) {
			msg_e.printStackTrace();
		}
		checkcode=checkNum;
		}//일치하는 정보 x
		else {
			System.out.println("일치하는 정보가 없습니다.");
		}
		
		return checkcode;
	}
}
