package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.MemberDAO;
import dao.ReviewDAO;
import model.ReviewVo;

@Controller
public class ReviewController {

	@Autowired
	@Lazy
	ReviewDAO rdao;
	
	@Autowired
	@Lazy
	MemberDAO mdao;
	
	@Autowired
	MemberController memControl;
	
	@PostMapping("/reviewWrite.do")
	public String reviewWrite(HttpServletRequest request) {
		String userid =request.getParameter("userid");
		int code =Integer.parseInt(request.getParameter("code"));
		int score = Integer.parseInt(request.getParameter("score"));
		String content=request.getParameter("content");
		String email = mdao.getMail(userid);
		String title = request.getParameter("title");
		// 넘어오는 값 확인.
		System.out.println(userid);
		System.out.println(code);
		System.out.println(content);
		System.out.println(score);
		System.out.println(email);
		System.out.println(title);
		ReviewVo rvo = new ReviewVo();
		rvo.setCode(code);
		rvo.setUserid(userid);
		rvo.setContent(content);
		rvo.setScore(score);
		rvo.setEmail(email);
		rvo.setTitle(title);
		
		rdao.writeReview(rvo);
		
		return "redirect:/movieInfo?code="+code;
	}
	
	@PostMapping("/reviewCount.do")
	@ResponseBody
	public int reviewCountgo(int code) {
		
	int revcount =rdao.countReview(code);
	
	return revcount;
	}
	
	@PostMapping("/reviewConfirm")
	@ResponseBody
	public int reviewConfirm(String userid,int code) {
		
		int count =rdao.confirmReview(userid, code);
		
		return count;
	}
	
	@PostMapping("/reviewDelete")
	@ResponseBody
	public int reviewDelte(String userid,int code) {
		
		int count =rdao.deleteReview(code, userid);
		System.out.println(userid);
		System.out.println(code);
		return count;
	}

	
	@PostMapping("/reviewUpdate")
	public String reviewUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException {
		ReviewVo rvo = new ReviewVo();
		int code= Integer.parseInt(request.getParameter("code2"));
		rvo.setContent(request.getParameter("recontent"));
		rvo.setUserid(request.getParameter("reuserid"));
		rvo.setScore(Integer.parseInt(request.getParameter("rescore")));
		rvo.setCode(code);
		rvo.setTitle(request.getParameter("title2"));
		rvo.setChangeCheck(1);
		
		int result=rdao.updateReview(rvo);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(result !=0) {
			out.print("<script>");
			out.print("alert('수정완료');");
			out.print("history.pushState(null, null, 'movieInfo?code="+code+"')");
			out.print("</script>");
			out.flush();
		}
		return "forward:/movieInfo?code="+code;
	}
	
	@PostMapping("/reviewBoard")
	public String reviewboard() {
		
		return "reviewBoard";
	}
	
	@PostMapping("/reviewPaging")
	@ResponseBody
	public void reviewList(String pageNum,int code,int sort,HttpSession session) {
		
		session.removeAttribute("rlist");
		session.removeAttribute("rcount");
		session.removeAttribute("currentPage");
		session.removeAttribute("totalData");
		session.removeAttribute("pageCount");
		session.removeAttribute("totalPage");
		session.removeAttribute("pageGroup");
		session.removeAttribute("last");
		session.removeAttribute("first");
		session.removeAttribute("next");
		session.removeAttribute("prev");
		
		Double currentPage = Double.parseDouble(pageNum);
		
		int totalData = rdao.countReview(code);
		int pageCount =10;
		Double dataPerPage=6.0;
		int totalPage=(int)Math.ceil(totalData / dataPerPage);
		
		int start = 1+(Integer.parseInt(pageNum)-1)*6;
		int end =(int)(dataPerPage*currentPage);
		if(totalData%6 !=0 && currentPage ==totalPage) {
			end=totalData;
		}

		if(totalPage<pageCount) {
			pageCount=totalPage;
		}
		
		ArrayList<ReviewVo> rlist=rdao.allReview(code, start, end,sort);
		int rcount=rlist.size()/2;
		if(rlist.size()%2==0&&rlist.size()!=0) {
			rcount--;
		}
		
		int pageGroup =(int)Math.ceil(currentPage / pageCount); // 페이지 그룹
		int last = pageGroup * pageCount; //화면에 보여질 마지막 페이지 번호
		if(last>totalPage) {
			last=totalPage;
		}
		
		int first = (pageGroup-1)*pageCount+1;
		
		int next = last+1;
		int prev = first-1;
		 if(totalData ==0){
			  first=1;
			  prev=0;
		 }
		 
		 session.setAttribute("rlist", rlist);
		 session.setAttribute("rcount", rcount);
		 session.setAttribute("currentPage", currentPage);
		 session.setAttribute("totalData", totalData);
		 session.setAttribute("pageCount", pageCount);
		 session.setAttribute("totalPage", totalPage);
		 session.setAttribute("pageGroup", pageGroup);
		 session.setAttribute("last", last);
		 session.setAttribute("first", first);
		 session.setAttribute("next", next);
		 session.setAttribute("prev", prev);	
	}
	
	@PostMapping("/myReviewAll.do")
	@ResponseBody
	public String myReviewAll(String userid, HttpSession session) {
		
		memControl.myPagePaging("1", userid, session);
		
		
		return "myReviewList";
	}
	
	@GetMapping("/myReviewList")
	public String myReviewList() {
		return "myReviewList";
	}
	
	@PostMapping("/myOneReview")
	@ResponseBody
	public ReviewVo myOneReview(int mycode,String myid) {
		
		ReviewVo review=rdao.oneReview(mycode, myid);
		return review;
	}
	
	@PostMapping("/myReviewUpdate")
	@ResponseBody
	public int myReviewUpdate(int recode,String reuser, String rewrite_date,
			String remodal,int rescore,String retitle) {
		int result=0;
		ReviewVo rvo = new ReviewVo();
		
		rvo.setCode(recode);
		rvo.setContent(remodal);
		rvo.setScore(rescore);
		rvo.setTitle(retitle);
		rvo.setUserid(reuser);
		rvo.setWrite_date(rewrite_date);
		rvo.setChangeCheck(1);
		result=rdao.updateReview(rvo);
		return result;
	}
	
	@PostMapping("/reviewLike")
	@ResponseBody
	public void reviewLikeUpdate(int code, String userid, int like) {
		
		rdao.reviewLike(userid, code, like);
	}
}
