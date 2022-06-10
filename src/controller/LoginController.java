package controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dao.MemberDAO;
import model.MemberVo;

@Controller
public class LoginController {
	@Autowired
	@Lazy
	MemberDAO mdao;
	
	
	@RequestMapping(value="/login",method= {RequestMethod.GET,RequestMethod.POST})
	public String login() {
		
		return "login";
	}
	
	@RequestMapping(value="/logout.do",method=RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session= request.getSession();
		session.invalidate();
		
		return "main";
	}
	
	@PostMapping("/login.do")
	public void loginDo(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String userId = request.getParameter("userid");
		String userPwd = request.getParameter("userpwd");

		String pass=mdao.getPass(userId);
		HttpSession session = request.getSession();
		if(userPwd.equals(pass)) {
			System.out.println("로그인 성공");
			//세션에 아이디값 넣고 null이 아닐 시 header페이지 login을 logout 버튼 으로 변경
			//admin이 1일 경우 admin header로 변경
			MemberVo mvo = mdao.infoMember(userId); 
			if(mvo.getAdmin() == 0) {// 일반 사용자
				session.setAttribute("userid", userId);
				session.setAttribute("admin", 0);
				response.sendRedirect("main");
			}else if(mvo.getAdmin() == 1) {// 관리자
				session.setAttribute("userid", userId);
				session.setAttribute("admin", 1);
				response.sendRedirect("adminMain");
			}
			else {
				System.out.println("정지된 회원입니다.");
				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.print("<script>");
				out.print("alert('이용이 정지된 회원입니다.');");
				out.print("history.back(-1);");
				out.print("</script>");
				out.flush();
			}
		}else { //로그인 실패시 이전페이지로(로그인페이지) 경고창 띄우고
			System.out.println("아이디 또는 패스워드 오류입니다.");
			
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("<script>");
			out.print("alert('아이디 또는 패스워드가 일치하지 않습니다.');");
			out.print("history.back(-1);");
			out.print("</script>");
			out.flush();
		}
	}
}
