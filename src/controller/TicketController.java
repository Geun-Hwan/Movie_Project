package controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.TicketDAO;
import model.Ticket;

@Controller
public class TicketController {

	@Autowired
	@Lazy
	TicketDAO tdao;
	
	@PostMapping("/kakaopay.do")
	public String kakaopay(HttpServletRequest request,HttpSession session) {
		String userid = (String)session.getAttribute("userid");
		String title = request.getParameter("title"); //제목
		String cinema = request.getParameter("selectedTheater"); //영화관 ,상영관
		String movieDate = request.getParameter("movieDate"); //영화 시작날짜
		String movieTime = request.getParameter("runningTime"); //영화 시작시간
		String movieAge = request.getParameter("movieAge");
		int person =Integer.parseInt(request.getParameter("ticketNumber")); // 티켓수
		String seat = request.getParameter("selectedSeat"); //선택 좌석 번호
		int price = Integer.parseInt(request.getParameter("payMoney")); // 표 가격
		System.out.println(userid);
		System.out.println(title);
		System.out.println(cinema); 
		System.out.println(movieDate);
		System.out.println(movieTime);
		System.out.println(movieAge);
		System.out.println(person); 
		System.out.println(seat); 
		System.out.println(price); 
		Ticket ticket = new Ticket();
		ticket.setCinema(cinema);
		ticket.setMovieDate(movieDate);
		ticket.setMovieTime(movieTime);
		ticket.setPerson(person);
		ticket.setPrice(price);
		ticket.setSeat(seat);
		ticket.setMovieAge(movieAge);
		ticket.setTitle(title);
		ticket.setUserid(userid);
		
		session.setAttribute("ticket", ticket);
		
		return "kakao";
	}
	
	@PostMapping("/ticketOk.do")
	public void ticketOk(HttpSession session) {
		Ticket ticket =(Ticket)session.getAttribute("ticket");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd aa hh:mm:ss");
		String ticketDate=format.format(new Date());
		ticket.setTicketDate(ticketDate);
		
		tdao.ticketting(ticket);
		session.removeAttribute("ticket");
	}
	
	@PostMapping("/seatCheck.do")
	@ResponseBody
	public ArrayList<String> seatCheck(String title,String movieDate, String movieTime,String cinema) {
		
		ArrayList<String> seats = tdao.seatCheck(title, movieDate, movieTime, cinema);
		ArrayList<String> seat = new ArrayList<String>();
		
		System.out.println(title);
		System.out.println(movieDate);
		System.out.println(movieTime);
		System.out.println(cinema);
	
		if (seats.size() != 0) {
			for (String s : seats) {
				String[] array = s.split(",");
				for (int i = 0; i < array.length; i++) {
					System.out.println(array[i]);
					seat.add(array[i]);
				}
			}
		}
		return seat;
	}
	
	@PostMapping("/seatRemainCheck")
	@ResponseBody
	public void seatRemainCheck(String title,String movieDate,String cinema,HttpSession session) {
		session.removeAttribute("remainSeat");
		
		ArrayList<String> seats = tdao.seatCheck(title, movieDate, "10:00", cinema);
		ArrayList<String> seat = new ArrayList<String>();
		ArrayList<Integer> remainSeat = new ArrayList<Integer>();
		System.out.println(title);
		System.out.println(movieDate);
		System.out.println(cinema);
		if (seats.size() != 0) {
			for (String s : seats) {
				String[] array = s.split(",");
				for (int i = 0; i < array.length; i++) {
					
					seat.add(array[i]);
				}
			}
		}
		remainSeat.add(seat.size());
		seats = tdao.seatCheck(title, movieDate, "13:00", cinema);
		seat = new ArrayList<String>();
		if (seats.size() != 0) {
			for (String s : seats) {
				String[] array = s.split(",");
				for (int i = 0; i < array.length; i++) {
					
					seat.add(array[i]);
				}
			}
		}
		remainSeat.add(seat.size());
		seats = tdao.seatCheck(title, movieDate, "16:00", cinema);
		seat = new ArrayList<String>();
		
		if (seats.size() != 0) {
			for (String s : seats) {
				String[] array = s.split(",");
				for (int i = 0; i < array.length; i++) {
					
					seat.add(array[i]);
				}
			}
		}
		remainSeat.add(seat.size());
		seats = tdao.seatCheck(title, movieDate, "19:00", cinema);
		seat = new ArrayList<String>();		
		if (seats.size() != 0) {
			for (String s : seats) {
				String[] array = s.split(",");
				for (int i = 0; i < array.length; i++) {
					
					seat.add(array[i]);
				}
			}
		}
		remainSeat.add(seat.size());
		session.setAttribute("remainSeat", remainSeat);
	}
	
	@GetMapping("/timetable")
	public String timetable() {
		return "timetable";
	}
	@PostMapping("/ticketDelete")
	@ResponseBody
	public int ticketDelete(@ModelAttribute Ticket ticket, HttpSession session) {
		int result =0;
		if(session.getAttribute("userid").equals("admin")) {
			result=1;
		}
		tdao.deleteTicket(ticket);
		return result;
	}
}
