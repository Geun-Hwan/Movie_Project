package controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import dao.AnswerDAO;
import dao.MemberDAO;
import dao.NoticeDAO;
import dao.QnaDAO;
import model.AnswerBoard;
import model.MemberVo;
import model.NoticeBoard;
import model.QnaBoard;

@Controller
public class QnaController {
	@Autowired
	SqlSessionTemplate SqlSessionTemplate;
	
	@Autowired
	@Lazy
	QnaDAO qdao;
	
	@Autowired
	@Lazy
	MemberDAO mdao;
	
	@Autowired
	@Lazy
	AnswerDAO adao;
	
	@Autowired
	@Lazy
	NoticeDAO ndao;
	
	@Autowired
	AdminController adminControl;
	
	@GetMapping("/qnawrite")
	public String qnawrite() {
		System.out.println("qnawrite");
		return "information";

	}
	
	@GetMapping("/Oneone")
	public String Oneone(HttpSession session,Model model) {
		System.out.println("Oneone");
		String userid = (String)session.getAttribute("userid");
		MemberVo member = mdao.infoMember(userid);
		model.addAttribute("member",member);
		return "information(One-on-one)";
	}
	
	@GetMapping("/notice")
	public String notice(HttpSession session) {
		System.out.println("notice");
		adminControl.noticePaging("1",session);
		return "information";
	}

	@PostMapping("/qnaWrite.do")
	public String qnaWirteDo(@ModelAttribute QnaBoard qna, @RequestParam MultipartFile file, HttpSession session) throws IllegalStateException, IOException{
		String uploadDir = session.getServletContext().getRealPath("/resources/upload/"+qna.getUserid()+"/");
		String fileName = file.getOriginalFilename();
		File dir = new File(uploadDir);
		if(fileName.equals("")) {
			qna.setFileName("");
		}else {
			if(!dir.exists()) {
				dir.mkdirs();
			}
			qna.setFileName(fileName);
			System.out.println(qna.getFileName());
			file.transferTo(new File(uploadDir,fileName));
		}
		System.out.println(uploadDir);
		System.out.println(fileName);
		qdao.insertQna(qna);
		
		return "redirect:/myPage?userid="+qna.getUserid();
	}
	
	@GetMapping("/noticeInfo")
	public String noticeInfo(@RequestParam int num ,Model model) {
		System.out.println(num);
		
		NoticeBoard notice = ndao.readNotice(num);
		model.addAttribute("notice",notice);
		return "noticeInfo";
	}
	
	@PostMapping("/myQnaAll.do")
	public void myQnaAll(String userid,HttpSession session) {
		
		ArrayList<QnaBoard> qlist =qdao.myQnaList(userid);
		
		session.setAttribute("qlist", qlist);
	}
	
	@GetMapping("/myQnaList")
	public String myQnaList() {
		return "myQnaList";
	}
	
	@GetMapping("/download")
	public void download(HttpSession session,HttpServletRequest request, HttpServletResponse response) throws IOException {
		String userid=request.getParameter("userid");
		String fileName=request.getParameter("fileName");
		System.out.println(userid);
		System.out.println(fileName);
		String path = session.getServletContext().getRealPath("/resources/upload/"+userid+"/"+fileName);
		byte[] fileByte = FileUtils.readFileToByteArray(new File(path));
		response.setContentType("application/octet-stream");
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName, "UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");

	    response.getOutputStream().write(fileByte);
	    response.getOutputStream().flush();
	    response.getOutputStream().close();
	}

	
	@PostMapping("/answerRead")
	@ResponseBody
	public AnswerBoard answerRead(int num) {
		AnswerBoard answer = adao.oneAnswer(num);

		return answer;
	}
}
