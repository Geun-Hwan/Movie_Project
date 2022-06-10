package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import dao.MovieDAO;
import model.MovieVo;

@Controller
public class MovieController {

	@Autowired
	@Lazy
	MovieDAO mdao;
	
	@Autowired
	ReviewController reviewControl;
	
	@GetMapping("/movieList")
	public String movieList(HttpServletRequest request,HttpSession session) {
		
		List<MovieVo> list = mdao.allMovie();
		int count=mdao.countMovie();
		
		request.setAttribute("list", list);
		request.setAttribute("count", count);
		
		return "movieList";
	}
	@RequestMapping(value = "/movieInfo", method = {RequestMethod.POST,RequestMethod.GET})
	public String movieInfo(HttpServletRequest request, HttpSession session) {
		
		int code = Integer.parseInt(request.getParameter("code"));
		
		int count = mdao.movieConfirm(code);
		MovieVo MV = mdao.infoMovie(code);

		String actor[] =null;
		if(MV.getActor() != null) {
			actor=MV.getActor().split("\n");
		}
		

		reviewControl.reviewList("1", code, 1, session); //처음 접속시 기본 날짜순으로 출력
		
		request.setAttribute("movie", MV);
		request.setAttribute("actor", actor);
		request.setAttribute("count", count);
		
		return "movieInfo";
	}

	@RequestMapping(value = "/movieWrite.do", method = {RequestMethod.POST,RequestMethod.GET})
	public String movieWirteDo(HttpServletRequest request,HttpServletResponse response,HttpSession session,@RequestParam MultipartFile poster) throws Exception {
		String saveDirectory = session.getServletContext().getRealPath("/resources/images/");
		String fileName = poster.getOriginalFilename();
		System.out.println(fileName);
		MovieVo mvo = new MovieVo();
		mvo.setCode(Integer.parseInt(request.getParameter("code")));
		mvo.setTitle(request.getParameter("title"));
		mvo.setDirector(request.getParameter("director"));
		mvo.setActor(request.getParameter("actor"));
		mvo.setCategory(request.getParameter("category"));
		mvo.setPoster("images/"+fileName); // 
		mvo.setSynopsis(request.getParameter("synopsis"));
		//상영시간 넣는부분 없음
		mvo.setPercent(0.0);
		mvo.setPrice(Integer.parseInt(request.getParameter("price"))); //
		mvo.setScore(Integer.parseInt(request.getParameter("rating")));
		mvo.setGrade("전체");
		if(fileName.equals("")) {
			mvo.setPoster("images/noimage.gif");
		}else {
			poster.transferTo(new File(saveDirectory,fileName));
		}
		
		mdao.insertMovie(mvo);
		
		//등록 완료 출력
		return "adminView/adminMain";
	}
	
	@PostMapping("/movieUpdate") 
	public void movieUpdateDo(HttpServletRequest request,HttpSession session,@RequestParam MultipartFile poster,HttpServletResponse response) throws Exception{
	String saveDirectory = session.getServletContext().getRealPath("resources/images/");
	String fileName=poster.getOriginalFilename();
	MovieVo mvo = new MovieVo();
		
		// 포스터 변경
		if(fileName.equals("")) {
			mvo.setPoster(request.getParameter("reid"));
		}
		else {
			poster.transferTo(new File(saveDirectory,fileName));
			mvo.setPoster("images/"+fileName);
		}
		 
		mvo.setCode(Integer.parseInt(request.getParameter("code")));
		mvo.setTitle(request.getParameter("title"));
		mvo.setDirector(request.getParameter("director"));
		mvo.setActor(request.getParameter("actor"));
		mvo.setGrade(request.getParameter("grade"));
		mvo.setSynopsis(request.getParameter("synopsis"));
		mvo.setPrice(Integer.parseInt(request.getParameter("price")));
		mvo.setPercent(Double.parseDouble(request.getParameter("percent")));
		mdao.updateMovie(mvo);
		
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print("<script>");
		out.print("alert('수정 완료');");
		out.print("location.href='adminMovieUpdate';");
		out.print("</script>");
		out.flush();

	}
	
	@GetMapping("/movieDelete.do")
	public void movieDeleteDo(HttpServletRequest request,HttpServletResponse response) throws IOException {
		int code = Integer.parseInt(request.getParameter("code"));
		
		
		mdao.deleteMovie(code);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print("<script>");
		out.print("alert('삭제 완료');");
		out.print("location.href='adminMovieDelete';");
		out.print("</script>");
		out.flush();
		
	}
	
	@GetMapping("/movieCheck.do")
	@ResponseBody
	public int movieCheck(String mcode) {
		int code= Integer.parseInt(mcode);
		int count=mdao.movieConfirm(code);
		
		return count;
	}

	@PostMapping("/nowMovie")
	public void nowMovie(HttpSession session) {
		ArrayList<MovieVo> nlist=mdao.nowMovie();
		
		session.setAttribute("nlist", nlist);
		session.setAttribute("ncount", nlist.size());
	}
	
	@PostMapping("/nowshow")
	public String nowshow() {
		return "nowshow";
	}
	
	@PostMapping("/koreanSort")
	public void koreanSort(HttpSession session) {
		ArrayList<MovieVo> klist=mdao.korSortMovie();
		
		session.setAttribute("klist", klist);
		session.setAttribute("kcount", klist.size());
	}
	
	@GetMapping("/movieExpected")
	public String movieExpected(HttpServletRequest request) {
		ArrayList<MovieVo> elist=mdao.expectedMovie();
		request.setAttribute("elist", elist);
		request.setAttribute("ecount", elist.size());
		
		return "movieExpected";
	}
	
}
