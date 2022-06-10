package controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import dao.MovieDAO;

@Controller
public class HomeController {	
	
	@Autowired
	@Lazy
	MovieDAO mdao;
	
	@Autowired
	AdminController adminControl;
	
	@RequestMapping(value="/",method=RequestMethod.GET)
	public String home(HttpServletRequest request) throws IOException {
		
			
		return "main";
	}
	
	@RequestMapping(value="/main",method= {RequestMethod.GET,RequestMethod.POST})
	public String main() {
		
		return "main";
	}
	
	@GetMapping("/information")
	public String information(HttpSession session) {
		adminControl.noticePaging("1",session);
		return "information";
	}
	
	@GetMapping("/event")
	public String event() {
		
		return "event";
	}
	

	@GetMapping("/nowmovie")
	public String join1(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String activeTab = request.getParameter("activeTab");
		session.removeAttribute("nowlist");
		session.removeAttribute("expectlist");
		if(activeTab.equals("tab1(nowmovie)")) {		
		session.setAttribute("nowlist", mdao.nowMovie());
		}else if(activeTab.equals("tab2(uncoming)")) {
		session.setAttribute("expectlist", mdao.expectedMovie());
		}
		System.out.println(activeTab);
		return activeTab;
	}
}
