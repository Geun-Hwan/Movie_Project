package dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.Ticket;

@Repository
public class TicketDAO {

	@Autowired
	SqlSessionTemplate SqlSessionTemplate; 
	
	public void ticketting(Ticket ticket) { // 로그인후 이용 가능합니다. or 이미 작성하셨습니다.
		SqlSessionTemplate.insert("dao.TicketDAO.ticketting",ticket);
	}
	
	public ArrayList<Ticket> myAllTicket(String userid,int start,int end){
		List<Ticket> tlist = new ArrayList<Ticket>();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userid", userid);
		map.put("start", start);
		map.put("end", end);
		
		tlist = SqlSessionTemplate.selectList("dao.TicketDAO.myAllTicket",map);
		
		return (ArrayList<Ticket>) tlist;
	}
	
	public ArrayList<Ticket> myNewTicket(String userid){ // 최신 예매 3개
		List<Ticket> tlist = new ArrayList<Ticket>();
		
		tlist = SqlSessionTemplate.selectList("dao.TicketDAO.myNewTicket",userid);
		
		return (ArrayList<Ticket>) tlist;
	}
	
	public ArrayList<Ticket> allUserTicket(int start, int end) { // 전체 회원 예매내역 최신순
		List<Ticket> tlist = new ArrayList<Ticket>();

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("start", start);
		map.put("end", end);

		tlist = SqlSessionTemplate.selectList("dao.TicketDAO.allUserTicket", map);

		return (ArrayList<Ticket>) tlist;
	}
	
	public int myTicketCount(String userid) {
		int count=0;
		
		count = SqlSessionTemplate.selectOne("dao.TicketDAO.myTicketCount",userid);
		
		return count;
	}
	
	public int allTicketCount() {
		int count=0;
		
		count = SqlSessionTemplate.selectOne("dao.TicketDAO.allTicketCount");
		
		return count;
	}
	
	public ArrayList<String> seatCheck(String title,String movieDate,String movieTime,String cinema){
		List<String> seats = new ArrayList<String>();
		
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("title", title);
		map.put("movieDate", movieDate);
		map.put("movieTime", movieTime);
		map.put("cinema", cinema);
		seats=SqlSessionTemplate.selectList("dao.TicketDAO.seatCheck",map);
		
		return (ArrayList<String>) seats;
	}
}
