package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.AnswerDAO;
import dao.MemberDAO;
import dao.MovieDAO;
import dao.QnaDAO;
import dao.ReportDAO;
import dao.ReviewDAO;
import dao.TicketDAO;
import model.MemberVo;
import model.MovieVo;
import model.ReportVo;
import model.ReviewVo;
import model.Ticket;

@Controller
public class MemberController {
	
	@Autowired
	@Lazy
	MemberDAO mdao;
	
	@Autowired
	@Lazy
	ReviewDAO rdao;
	
	@Autowired
	@Lazy
	MovieDAO mvdao;
	
	@Autowired
	@Lazy
	ReportDAO rpdao;
	
	@Autowired
	@Lazy
	TicketDAO tdao;
	
	@Autowired
	@Lazy
	QnaDAO qdao;
	
	@Autowired
	@Lazy
	AnswerDAO adao;
	
	@GetMapping("/myPage")
	public String myPage(HttpServletRequest request) {
		String userid=request.getParameter("userid");
		MemberVo mvo=mdao.infoMember(userid);
		ArrayList<Ticket> tlist =tdao.myNewTicket(userid); 
		request.setAttribute("member", mvo);
		request.setAttribute("tlist", tlist);
		return "myPage";
	}
	
	@GetMapping("/memberUpdate")
	public String memberUpdate1() {
	
		return "memberUpdate";
	}
	
	@GetMapping("/myPageCheck")
	public String myPageCheck() {
		return "myPageCheck";
	}
	
	//회원 정보 수정 memberUpdate
	@PostMapping("/memberUpdate")
	public void memberUpdate(String userid,HttpSession session) throws ParseException {
		MemberVo mvo=mdao.infoMember(userid);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyymmdd");
		Date forbirth = dateFormat.parse(mvo.getBirth());
		String birth = new SimpleDateFormat("yyyy-mm-dd").format(forbirth);
		mvo.setBirth(birth);
		session.setAttribute("member", mvo);
	}
	
	@PostMapping("/memberUpdate.do")
	public String memberUpdateDo(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException {
		String name=request.getParameter("changeName");
		String changePass=request.getParameter("changePass");
		String userid = request.getParameter("uid");
		String pass=request.getParameter("userpass");
		String birth=request.getParameter("birth");
		String gender=request.getParameter("changeGender");	
		MemberVo mvo= new MemberVo();
		mvo.setName(name);
		mvo.setGender(gender);
		mvo.setUserId(userid);
		if(changePass.equals("")) {
			mvo.setUserPwd(pass);
		}else {
			mvo.setUserPwd(changePass);
		}
		try {
		// form 에서 받은 yyyy-mm-dd 문자열 형식 생년월일을 8자로 바꿔줘야 함.
		SimpleDateFormat strDate = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		Date birthFormat = strDate.parse(birth);
		String birth8 = dateFormat.format(birthFormat); // birth 8자
		mvo.setBirth(birth8);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mdao.updateMember(mvo);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print("<script>");
		out.print("alert('정보가 변경되어 로그아웃 되었습니다. 다시 로그인 해주세요.');");
		out.print("</script>");
		out.flush();
		
		session.removeAttribute("userid");
		session.removeAttribute("member");
		session.removeAttribute("admin");
		return "login";
	}
	
	@PostMapping("/myInfoUpdate.do")
	@ResponseBody	
	public String memberInfoUpdateDo(String userid) {
		
		String pass=mdao.getPass(userid);
		
		return pass;
	}
	
	@PostMapping("/changePw")
	@ResponseBody	
	public int memberChangePw(String email,String userid, String userpw) {
		int result =0;
		
		result=mdao.changePw(email, userid, userpw);

		return result;
	}
	
	@PostMapping("/myPagePaging")
	@ResponseBody
	public void myPagePaging(String pageNum,String userid,HttpSession session) {
		
		session.removeAttribute("myReviewList");
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
			
		int totalData =rdao.myReviewCount(userid);
		int pageCount =10;
		Double dataPerPage=10.0;
		int totalPage=(int)Math.ceil(totalData / dataPerPage);
		
		int start = 1+(Integer.parseInt(pageNum)-1)*10;
		int end =(int)(dataPerPage*currentPage);
		ArrayList<ReviewVo> myReviewList=rdao.myAllReview(userid,start,end);
		if(totalData%10 !=0 && currentPage ==totalPage) {
			end=totalData;
		}

		if(totalPage<pageCount) {
			pageCount=totalPage;
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
		 session.setAttribute("myReviewList", myReviewList);
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
	
	
	//회원 탈퇴 memberDelete 모든 정보 삭제.
	@PostMapping("/merberDelete")
	public void merberDelete(String userid,HttpSession session) {
		
		if(session.getAttribute("userid").equals("admin")) {
		mdao.deleteMember(userid);
		rdao.deleteReview(userid);
		rpdao.deleteReport(userid);
		tdao.deleteTicket(userid);
		qdao.deleteQna(userid);
		adao.deleteAnswer(userid);
		// 관리자로 탈퇴 시킬땐 세션 초기화 X, 매개변수 추가해서 관리자 아닐때만 세션 초기화
		}else {
			mdao.deleteMember(userid);
			rdao.deleteReview(userid);
			rpdao.deleteReport(userid);
			tdao.deleteTicket(userid);
			qdao.deleteQna(userid);
			adao.deleteAnswer(userid);
			session.invalidate();
		}
	}
	
	//예매하기 ticket
	
	@GetMapping("/movieTicket")
	public String movieTicket(HttpServletRequest request) {
		String code=request.getParameter("code");
		
		List<MovieVo> nlist = mvdao.allMovie();
		List<MovieVo> klist = mvdao.korSortMovie();
		
		request.setAttribute("nlist", nlist);
		request.setAttribute("klist", klist);
		request.setAttribute("code", code);
		return "movieTicket";	
	}
	
	@GetMapping("/myAllTicket")
	public String myAllTicket(String userid, HttpSession session) {
		
		myTicketPaging("1",userid,session);
		
		return "myAllTicket";
	}
	
	@GetMapping("/myTicketList")
	public String myTicketList() {
		return "myAllTicket";
	}
	
	@PostMapping("/myTicketPaging")
	@ResponseBody
	public void myTicketPaging(String pageNum,String userid,HttpSession session) {
		
		session.removeAttribute("tlist");
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
			
		int totalData =tdao.myTicketCount(userid); // 전체 티켓수 카운트
		int pageCount =10;
		Double dataPerPage=6.0;
		int totalPage=(int)Math.ceil(totalData / dataPerPage);
		
		int start = 1+(Integer.parseInt(pageNum)-1)*6;
		int end =(int)(dataPerPage*currentPage);
		ArrayList<Ticket> tlist=tdao.myAllTicket(userid,start,end);
		if(totalData%6 !=0 && currentPage ==totalPage) {
			end=totalData;
		}

		if(totalPage<pageCount) {
			pageCount=totalPage;
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
		 session.setAttribute("tlist", tlist);
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
	
	//신고하기 report
	@PostMapping("/report.do")
	public void reportDo(HttpServletRequest request,HttpServletResponse response) throws IOException {
		String writer = request.getParameter("writeUser"); //작성자 신고대상
		String write_date = request.getParameter("writeDay"); //해당 글 작성날
		String reporter = request.getParameter("reportUser"); // 신고한 사람
		String reson = request.getParameter("reson"); //기본 사유
		String write_reson = request.getParameter("write-reson"); // 상세내용 
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd aa hh:mm");
		String report_date = format.format(date); //신고한 날
		int report_code = Integer.parseInt(request.getParameter("report_code"));
		System.out.println(writer);
		System.out.println(write_date);
		System.out.println(reporter);
		System.out.println(reson);
		System.out.println(write_reson);
		System.out.println(report_date);
		System.out.println(report_code);
		
		ReportVo rptvo = new ReportVo();
		
		rptvo.setReport_date(report_date);
		rptvo.setReporter(reporter);
		rptvo.setReson(reson);
		rptvo.setWrite_date(write_date);
		rptvo.setWrite_reson(write_reson);
		rptvo.setWriter(writer);
		rptvo.setReport_code(report_code);
		
		rpdao.insertReport(rptvo);
		
		PrintWriter out =response.getWriter();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		out.print("<script>");
		out.print("alert('신고 완료.');");
		out.print("history.back(-1);");
		out.print("</script>");
	}
	
	@PostMapping("/reportCheck")
	@ResponseBody
	public int reportCheck(String writer, String reporter, int code) {
		int check=0;
		
		check=rpdao.checkReport(writer, reporter, code);
		
		return check;
	}
	//문의글 남기기 qna
}
