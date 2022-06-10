package model;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MyAuthentication extends Authenticator {

	PasswordAuthentication pa;

	public MyAuthentication() {

		String id = "ezenac11@gmail.com"; // 
		String pw = "jdvnzcdvjlxdzxhi"; // 

		// ID와 비밀번호를 입력한다.
		pa = new PasswordAuthentication(id, pw);
	}

	// 시스템에서 사용하는 인증정보
	public PasswordAuthentication getPasswordAuthentication() {
		return pa;
	}
}
