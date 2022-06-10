package controller;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dao.MemberDAO;

@Controller
public class IdCheckController {

	@Autowired
	@Lazy
	MemberDAO mdao;
	
	@RequestMapping(value="/idCheck.do",method=RequestMethod.GET)
	public String login(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String userid=request.getParameter("userid");
		
		int result=mdao.confrimID(userid);
		if(result==1) {
			request.setAttribute("userid",userid);
			request.setAttribute("result",result);
			
			return "idcheck";
		}
		
		if(userid.length()==0) {
			result=-1;
		}
		Pattern pattern = Pattern.compile("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{3,15}$");
		Matcher matcher = pattern.matcher(userid);
		if(!matcher.matches()) {
			result=5;
		}

		if(userid.length()<4) {
			result=4;
		}

		request.setAttribute("userid",userid);
		request.setAttribute("result",result);
		
		return "idcheck";
	}
}
