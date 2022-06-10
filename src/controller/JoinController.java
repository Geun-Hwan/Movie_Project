package controller;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dao.MemberDAO;
import model.MemberVo;

@Controller
public class JoinController {

	@Autowired
	@Lazy
	MemberDAO mdao;
	
	@RequestMapping(value="/join",method=RequestMethod.GET)
	public String join() {
		
		return "join";
	}
	
	@RequestMapping(value="/join.do",method=RequestMethod.POST)
	public void joinDo(HttpServletRequest request, HttpServletResponse response) throws Exception{
		MemberVo mem = new MemberVo();

		try {
			// form 에서 받은 yyyy-mm-dd 문자열 형식 생년월일을 8자로 바꿔줘야 함.
			SimpleDateFormat strDate = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
			Date birthFormat = strDate.parse(request.getParameter("birth"));
			String birth = dateFormat.format(birthFormat); // birth 8자
			mem.setBirth(birth);
			System.out.println(birth);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mem.setName(request.getParameter("name"));
		mem.setUserId(request.getParameter("userid"));
		mem.setUserPwd(request.getParameter("userpwd"));
		mem.setEmail(request.getParameter("email"));
		mem.setGender(request.getParameter("gender"));
		
		int result = mdao.insertMember(mem);

		PrintWriter out = response.getWriter();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		// join 성공시 login으로 -->가입 성공 창 띄우고
		if (result == 1) {
			out.print("<script>");
			out.print("alert('회원가입 성공');");
			out.print("location.href='login';");
			out.print("</script>");
			out.flush();
		}
		else {
			out.print("<script>");
			out.print("alert('회원가입에 실패했습니다..');");
			out.print("history.back(-1);");
			out.print("</script>");
			out.flush();
		}
	}
}
