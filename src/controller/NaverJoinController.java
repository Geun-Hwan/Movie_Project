package controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class NaverJoinController {

	@RequestMapping(value = "/kakao.do", method = RequestMethod.POST)
	@ResponseBody
	public void join(String email, String gender, String birthday, HttpSession session) throws Exception {

		System.out.println(email);
		System.out.println(gender);
		System.out.println(birthday);
		// 단순히 세션값만 줘서 로그인 효과.
		 session.setAttribute("admin", 0);
		 session.setAttribute("userid", "kakao");

	}
}