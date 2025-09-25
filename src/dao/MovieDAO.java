package dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.MovieVo;

@Repository
public class MovieDAO {

	@Autowired
	SqlSessionTemplate SqlSessionTemplate;

	public void insertMovie(MovieVo movie) {

		SqlSessionTemplate.insert("dao.MovieDAO.insertMovie", movie);
	}

	public void updateMovie(MovieVo movie) {
		SqlSessionTemplate.update("dao.MovieDAO.updateMovie", movie);
	}

	public MovieVo infoMovie(int code) {
		MovieVo movie = new MovieVo();

		// movie = SqlSessionTemplate.selectOne("dao.MovieDAO.infoMovie",code);
		return movie;
	}

	public void deleteMovie(int code) {
		SqlSessionTemplate.delete("dao.MovieDAO.deleteMovie", code);
	}

	public List<MovieVo> allMovie() { // 기본 조회 또는 무비차트 클릭시.
		List<MovieVo> list = new ArrayList<MovieVo>();
		// 기본 출력을 예매율 순서로 지정했다.
		// list=SqlSessionTemplate.selectList("dao.MovieDAO.allMovie");
		return list;
	}

	public Integer countMovie() {
		int count = 0;
		// count =SqlSessionTemplate.selectOne("dao.MovieDAO.countMovie");

		return count;
	}

	public Integer movieConfirm(int code) {
		int count = 0;

		// count =SqlSessionTemplate.selectOne("dao.MovieDAO.movieConfirm",code);
		return count;
	}

	public ArrayList<MovieVo> getSearch(String search) {
		List<MovieVo> list = new ArrayList<MovieVo>();
		String searchTrim = search.trim();
		// list = SqlSessionTemplate.selectList("dao.MovieDAO.getSearch",searchTrim);
		return (ArrayList<MovieVo>) list;
	}

	// 상영예정악 영화 조회쿼리 현재 날짜보다 개봉일이 늦은 영화만 출력. 상영예정작 클릭시
	// select *from movie where TO_CHAR(SYSDATE+9/24,'YYYY.MM.DD') < releasedate
	// order by percent desc
	public ArrayList<MovieVo> expectedMovie() {
		List<MovieVo> elist = new ArrayList<MovieVo>();

		// elist = SqlSessionTemplate.selectList("dao.MovieDAO.expectedMovie");
		return (ArrayList<MovieVo>) elist;
	}

	// 현재 상영작만 보기 체크박스 체크시
	// 개봉일이 현재일보다 작은것만 출력
	public ArrayList<MovieVo> nowMovie() {
		List<MovieVo> nlist = new ArrayList<MovieVo>();

		// nlist = SqlSessionTemplate.selectList("dao.MovieDAO.nowMovie");

		return (ArrayList<MovieVo>) nlist;
	}

	public ArrayList<MovieVo> korSortMovie() {
		List<MovieVo> klist = new ArrayList<MovieVo>();

		// klist = SqlSessionTemplate.selectList("dao.MovieDAO.korSortMovie");

		return (ArrayList<MovieVo>) klist;
	}

	public void deleteAllMovie() {
		SqlSessionTemplate.delete("dao.MovieDAO.deleteAllMovie");
	}
}
