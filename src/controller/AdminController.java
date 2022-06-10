package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.AnswerDAO;
import dao.MemberDAO;
import dao.MovieDAO;
import dao.NoticeDAO;
import dao.QnaDAO;
import dao.ReportDAO;
import dao.TicketDAO;
import model.AnswerBoard;
import model.MemberVo;
import model.MovieVo;
import model.NoticeBoard;
import model.QnaBoard;
import model.ReportVo;
import model.Ticket;

@Controller
public class AdminController {

	@Autowired
	SqlSessionTemplate SqlSessionTemplate;
	
	@Autowired
	@Lazy
	QnaDAO qdao;
	
	@Autowired
	@Lazy
	AnswerDAO adao;
	
	@Autowired
	@Lazy
	MemberDAO mdao;
	
	@Autowired
	@Lazy
	MovieDAO mvdao;
	
	@Autowired
	@Lazy
	NoticeDAO ndao;
	
	@Autowired
	@Lazy
	ReportDAO rdao;
	
	@Autowired
	@Lazy
	TicketDAO tdao;
	
	@RequestMapping(value="/adminMain",method=RequestMethod.GET)
	public String adminMain() {
		
		return "adminView/adminMain";
	}
	
	@RequestMapping(value="/adminMyPage",method=RequestMethod.GET)
	public String adminMyPage(HttpServletRequest request) {
		
		MemberVo admin=mdao.infoMember(request.getParameter("userid"));
		request.setAttribute("adminInfo", admin);
		return "adminView/adminMyPage";
	}
	
	@GetMapping("/adminMovieUpdate")
	public String adminMovieUpdate(HttpServletRequest request) {
		
		List<MovieVo> list = mvdao.allMovie();
		int count=mvdao.countMovie();
		request.setAttribute("list", list);
		request.setAttribute("count", count);
		
		return "adminView/adminMovieUpdate";
	}
	
	@GetMapping("/adminMovieDelete")
	public String adminMovieDelete(HttpServletRequest request) {
		
		List<MovieVo> list = mvdao.allMovie();
		
		request.setAttribute("list", list);
		
		return "adminView/adminMovieDelete";
	}
	
	@GetMapping("/movieWrite")
	public String movieWrite() {
		
		return "adminView/movieWrite";
	}
	
	@GetMapping("/movieUpdate")
	public String movieUpdate(HttpServletRequest request) { 
		// 선택한 영화 코드 값 처리
		int code = Integer.parseInt(request.getParameter("code"));
		 
		MovieVo MV = mvdao.infoMovie(code);
		request.setAttribute("movie", MV);
		
		return "adminView/movieUpdate";
	}
	
	@GetMapping("/memberList")
	public String memberList(HttpServletRequest request) {
		List<MemberVo>members=mdao.allMember();
		List<MemberVo> banmembers = mdao.banlist();

		request.setAttribute("members", members);
		request.setAttribute("banmembers", banmembers);
		
		return "memberList";
	}
	
	@GetMapping("/memberInfo")
	public String memberInfo(HttpServletRequest request) {
		
		MemberVo member=mdao.infoMember(request.getParameter("userid"));
		request.setAttribute("member", member);
		
		return "memberInfo";
	}
	
	@GetMapping("/addfunction")
	public String addfunction(HttpServletRequest request) {
		
		return "adminView/addfunction";
	}
	
	@GetMapping("/newWindow")
	public String newWindow(HttpSession session) {
		
		return "main";
	}
	
	@PostMapping("/reportAll.do")
	@ResponseBody
	public String reportAll(HttpSession session) {
		
		adminReportPaging("1", session);	
		
		return "adminView/reportAll";
	}
	
	@GetMapping("/reportList")
	public String reportList() {
		return "adminView/reportAll";
	}
	
	@PostMapping("/adminReportPaging")
	@ResponseBody
	public void adminReportPaging(String pageNum,HttpSession session) {
		
		session.removeAttribute("reportList");
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
			
		int totalData =rdao.reportCount();
		int pageCount =10;
		Double dataPerPage=10.0;
		int totalPage=(int)Math.ceil(totalData / dataPerPage);
		
		int start = 1+(Integer.parseInt(pageNum)-1)*10;
		int end =(int)(dataPerPage*currentPage);
		ArrayList<ReportVo> reportList=rdao.allReport(start, end);
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
		 session.setAttribute("reportList", reportList);
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
	
	@PostMapping("/ticketAll.do")
	@ResponseBody
	public String ticketAll(HttpSession session) {
		
		adminTicketPaging("1", session);	
		
		return "adminView/ticketAll";
	}
	
	@GetMapping("/ticketList")
	public String ticketList() {
		return "adminView/ticketAll";
	}
	
	@PostMapping("/adminTicketPaging")
	@ResponseBody
	public void adminTicketPaging(String pageNum,HttpSession session) {
		
		session.removeAttribute("ticketList");
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
			
		int totalData =tdao.allTicketCount();
		int pageCount =10;
		Double dataPerPage=10.0;
		int totalPage=(int)Math.ceil(totalData / dataPerPage);
		
		int start = 1+(Integer.parseInt(pageNum)-1)*10;
		int end =(int)(dataPerPage*currentPage);
		ArrayList<Ticket> ticketList=tdao.allUserTicket(start, end);
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
		 session.setAttribute("ticketList", ticketList);
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
	
	
	@GetMapping("/memberDelete")
	public String memberDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String userId = request.getParameter("userId");

		mdao.deleteMember(userId);

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print("<script>");
		out.print("alert('회원이 삭제되었습니다.');");
		out.print("location.href='memberList';");
		out.print("history.pushState(null, null, 'memberList');");
		out.print("</script>");
		out.flush();
		
		// 삭제 완료 출력
		return "forward:/memberList";
	}

	@PostMapping("/reportDelete")
	public void reportDelete(String writer, String reporter, int code) {
		
		rdao.deleteReport(writer, reporter, code);
	}
	
	@GetMapping("/memberBan")
	public String memberBan(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String userId = request.getParameter("userId");

		
		MemberVo mvo = mdao.infoMember(userId);
		
		Calendar banday = Calendar.getInstance();
		banday.add(Calendar.MONTH, 1);
		String pattern = "yyyy-MM-dd";
		String bandate = getCalendarString(banday, pattern);
		
		
		mvo.setAdmin(3);
		mvo.setBan_date(bandate);

		mdao.banMemberDo(mvo);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print("<script>");
		out.print("alert('회원이 정지되었습니다.');");
		out.print("history.pushState(null, null, 'memberList');");
		out.print("</script>");
		out.flush();

		return "forward:/memberList";
	}
	
	@PostMapping("/banChange")
	@ResponseBody
	public void banChange(String userid, String ban_date) {
		System.out.println(userid);
		System.out.println(ban_date);
		
		mdao.changeBandate(userid, ban_date);
	}
	
	@PostMapping("/banUserAll")
	public void banUserAll(HttpSession session) {
		session.removeAttribute("banMember");
		

		List<MemberVo> banMember = mdao.banlist();
		session.setAttribute("banMember", banMember);
	}
	
	@GetMapping("/banList")
	public String banList() {
		return "adminView/banList";
	}
	
	@GetMapping("/memberPermit")
	public String memberPermit(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String userId = request.getParameter("userId");

		MemberVo mvo = mdao.infoMember(userId);

		mvo.setAdmin(0);
		mvo.setBan_date(null);

		mdao.banMemberDo(mvo);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print("<script>");
		out.print("alert('회원 정지가 해제되었습니다.');");
		out.print("history.pushState(null, null, 'memberList');");
		out.print("</script>");
		out.flush();

		return "forward:/memberList";
	}
	
	private static String getCalendarString(Calendar calendar, String pattern) {
	    SimpleDateFormat format = new SimpleDateFormat(pattern);
	    return format.format(calendar.getTime());
	}
	
	
	@GetMapping("/noticeWrite")
	public String noticeWrite() {
		return "adminView/noticeWrite";
	}
	
	@PostMapping("/noticeWrite.do")
	public String noticeWriteDo(@ModelAttribute NoticeBoard not) {
		System.out.println(not.getUserid());
		System.out.println(not.getTitle());
		System.out.println(not.getContent());
		
		
		ndao.insertNotice(not);
		
		return "redirect:/notice";
	}
	
	@PostMapping("/noticeUpdate.do")
	public String noticeUpdateDo(@ModelAttribute NoticeBoard not) {
		System.out.println(not.getNum());
		System.out.println(not.getTitle());
		System.out.println(not.getContent());
		
		
		ndao.noticeUpdate(not);
		
		return "redirect:/notice";
	}
	
	@PostMapping("/noticeDelete.do")
	public void noticeDeleteDo(int num) {
		
		ndao.noticeDelete(num);
	}
	
	@GetMapping("/noticeList")
	public String noticeList() {
		return "adminView/noticePaging";
	}
	
	@PostMapping("/noticePaging")
	@ResponseBody
	public void noticePaging(String pageNum,HttpSession session) {
		
		session.removeAttribute("noticeList");
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
		
			
		int totalData =ndao.noticeCount();
		int pageCount =10;
		Double dataPerPage=10.0;
		int totalPage=(int)Math.ceil(totalData / dataPerPage);
		
		int start = 1+(Integer.parseInt(pageNum)-1)*10;
		int end =(int)(dataPerPage*currentPage);
		ArrayList<NoticeBoard> noticeList=ndao.allNotice(start, end);
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
		 session.setAttribute("noticeList", noticeList);
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
	
	@PostMapping("/askAll.do")
	public void askAll(HttpSession session) {

		ArrayList<QnaBoard> qnalist=qdao.allQnaList();
		session.setAttribute("qnalist", qnalist);
	}
	
	@GetMapping("/askList")
	public String askList() {
		return "adminView/askList";
	}
	
	@PostMapping("/answerWrite.do")
	public String answerWrite(HttpServletRequest request) {
		String answer = "ok";
		int num = Integer.parseInt(request.getParameter("answerNum"));
		String title = request.getParameter("admin_title");
		String content = request.getParameter("admin_content");
		String userid = request.getParameter("admin_userid");
		String category = request.getParameter("admin_category");
		AnswerBoard ans = new AnswerBoard();
		ans.setNum(num);
		ans.setUserid(userid);
		ans.setTitle(title);
		ans.setCategory(category);
		ans.setContent(content);
		adao.insertAnswer(ans);
		System.out.println("답변 완료");
		qdao.answerCheck(answer,num);
		
		return "adminView/adminMyPage";
	}
	
	@PostMapping("/deleteQna.do")
	public void deleteQnaDo(int num) {
		qdao.deleteQna(num);
		adao.deleteAnswer(num);
	}
}
