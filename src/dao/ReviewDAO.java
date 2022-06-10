package dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.ReviewVo;

@Repository
public class ReviewDAO {
	
	@Autowired
	SqlSessionTemplate SqlSessionTemplate;
	
	public void writeReview(ReviewVo rvo) { // 로그인후 이용 가능합니다. or 이미 작성하셨습니다.
		SqlSessionTemplate.insert("dao.ReviewDAO.writeReview",rvo);
	}
	
	public int updateReview(ReviewVo rvo) {
		int result=0;
		result = SqlSessionTemplate.update("dao.ReviewDAO.updateReview",rvo);
		return result;
	}
	
	public int deleteReview(int code,String userid) {
		int result=0;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code);
		map.put("userid", userid);
		
		result = SqlSessionTemplate.delete("dao.ReviewDAO.deleteReview",map);
		return result;
	}
	
	public ReviewVo oneReview(int code,String userid) {
		// 리뷰 수정시 수정할 리뷰 원본 내용 리턴  
		ReviewVo rvo = null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code);
		map.put("userid", userid);
		rvo = SqlSessionTemplate.selectOne("dao.ReviewDAO.oneReview",map);
		return rvo;
	}
	
	public ArrayList<ReviewVo> allReview(int code,int start,int end,int sort){
		List<ReviewVo> list = new ArrayList<ReviewVo>();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code);
		map.put("start", start);
		map.put("end", end);
		map.put("sort", sort);
		
		list=SqlSessionTemplate.selectList("dao.ReviewDAO.allReview",map);
		return (ArrayList<ReviewVo>) list;
	}
	
	public ArrayList<ReviewVo> myAllReview(String userid,int start, int end){
		List<ReviewVo> list = new ArrayList<ReviewVo>();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userid", userid);
		map.put("start", start);
		map.put("end", end);

		list = SqlSessionTemplate.selectList("dao.ReviewDAO.myAllReview", map);
		return (ArrayList<ReviewVo>) list;
	}
	
	public int myReviewCount(String userid) {
		int count=0;
		
		count = SqlSessionTemplate.selectOne("dao.ReviewDAO.myReviewCount",userid);
		
		return count;
	}
	
	public int countReview(int code) {
		int count=0;
		
		count = SqlSessionTemplate.selectOne("dao.ReviewDAO.countReview",code);
		
		return count;
	}
	
	public int confirmReview(String userid, int code) {
		int count=0;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userid", userid);
		map.put("code", code);
	
		count =SqlSessionTemplate.selectOne("dao.ReviewDAO.confirmReview",map);
		
		return count;
	}
	//추천 수 기능 like
	public void reviewLike(String userid,int code, int like) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userid", userid);
		map.put("code", code);
		map.put("like", like);
		SqlSessionTemplate.update("dao.ReviewDAO.reviewLike",map);
	}
	
	// 신고하기 기능  본인이 작성한 글이 아니면 신고 버튼 보여야 함. + 로그인시 이용 가능 리뷰마다 한번만 가능.
	// 신고 내역 담는 vo 및 table 생성 (admin) 신고시 해당 테이블에 내용 저장 
	
}
