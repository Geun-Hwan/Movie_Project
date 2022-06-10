package controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import dao.MovieDAO;
import model.MovieVo;

@Controller
public class SearchController {

	@Autowired
	@Lazy
	MovieDAO mdao;
	
	@GetMapping("/search.do")
	public String search(HttpServletRequest request) {
		String search=request.getParameter("search");
		
		ArrayList<MovieVo> searchMovie = mdao.getSearch(search);
		
		request.setAttribute("searchMovie", searchMovie);
		request.setAttribute("searchCount", searchMovie.size());
		
		return "movieSearch";
	}
}
