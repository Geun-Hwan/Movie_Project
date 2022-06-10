package model;

public class Ticket {
	private String userid; // 예매자 id
	private String title; // 예매한 영화제목
	private String cinema; // 극장,상영관
	private String movieDate; //영화날짜
	private String movieTime; //상영시간
	private String ticketDate; //예매한날
	private String seat; //예매 좌석
	private String movieAge;
	private int person; //예매 인원
	private int price; //표 가격
	
	public String getMovieAge() {
		return movieAge;
	}
	public void setMovieAge(String movieAge) {
		this.movieAge = movieAge;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCinema() {
		return cinema;
	}
	public void setCinema(String cinema) {
		this.cinema = cinema;
	}
	public String getMovieDate() {
		return movieDate;
	}
	public void setMovieDate(String movieDate) {
		this.movieDate = movieDate;
	}
	public String getMovieTime() {
		return movieTime;
	}
	public void setMovieTime(String movieTime) {
		this.movieTime = movieTime;
	}
	public String getTicketDate() {
		return ticketDate;
	}
	public void setTicketDate(String ticketDate) {
		this.ticketDate = ticketDate;
	}
	public String getSeat() {
		return seat;
	}
	public void setSeat(String seat) {
		this.seat = seat;
	}
	public int getPerson() {
		return person;
	}
	public void setPerson(int person) {
		this.person = person;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
}
