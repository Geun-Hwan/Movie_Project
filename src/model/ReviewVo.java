package model;

public class ReviewVo {

	// 정렬 시 작성 날짜 순 (최신작성 리뷰 제일 먼저 노출)
	// 필요에 따라 추천 기능 부여 (추천많은순 정렬)
	
	private int code;
	private String content;
	private String write_date;
	private String userid;
	private String email;
	private int score;
	private String title;
	private int commentlike;
	private int changeCheck;
	
	public int getChangeCheck() {
		return changeCheck;
	}
	public void setChangeCheck(int changeCheck) {
		this.changeCheck = changeCheck;
	}
	
	public int getCommentlike() {
		return commentlike;
	}
	public void setCommentlike(int commentlike) {
		this.commentlike = commentlike;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score ;
	}
}
