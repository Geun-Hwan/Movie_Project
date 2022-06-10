package controller;

import java.io.IOException;
import java.util.ArrayList;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.MovieDAO;
import model.MovieVo;

@Controller
public class MovieAutoClass {

	@Autowired
	@Lazy
	MovieDAO mvdao;
	
	@PostMapping("/movieAutoWrite") // 영화 등록 및 수정 진행  1~19위
	@ResponseBody
	public void movieAuto() throws IOException {
		ArrayList<Integer> codes = movieCode();
		for(int i=0; i<codes.size(); i++) {
			int code=codes.get(i);
			Document doc = Jsoup.connect("http://www.cgv.co.kr/movies/detail-view/?midx="+code).get();
			
			Elements titles = doc.select("div.box-contents div.title strong");
			String percents = doc.select("div.box-contents div.score strong.percent span").text();
			Double percent= Double.parseDouble(percents.substring(0,percents.indexOf("%")));
			Elements directors = doc.select("div.box-contents div.spec dl dd a");
			String director = "";
			if(directors.hasText()) {
				director = directors.get(0).text();
			}
			String actors = doc.select("div.box-contents div.spec dl dd.on a").html();
			Elements categorys = doc.select("div.box-contents div.spec dl dt");
			String category = "";
			Elements ons = doc.body().getElementsByClass("on");
			Element on = ons.get(1); // 장르 , 기본
			String[] basic=on.text().split(",");
			String nation = "";
			if(basic.length>2) {
				nation=basic[2];
			}
			
			Element release = ons.get(2); 
			String synopsis = doc.select("div.cols-content div.col-detail div.sect-story-movie").html();
			String poster = doc.select("div.sect-base-movie div.box-image span.thumb-image img").attr("src");

			//System.out.println(synopsis);
			// 장르 추출
			int j=0;
			while(categorys.next() != null) {
				if(categorys.get(j).text().contains("장르")) {
					if(categorys.get(j).text().split(":").length>1)
						category=categorys.get(j).text().split(":")[1];
					
					break;
				}
				j++;
			}
			int running = Integer.parseInt(basic[1].replace("분", "").trim());
			
			// 영화 등록 부분
			MovieVo mvo = new MovieVo();
			mvo.setCode(code);
			mvo.setTitle(titles.text());
			mvo.setActor(actors);
			mvo.setCategory(category);
			mvo.setDirector(director);
			mvo.setGrade(basic[0]);
			mvo.setRunningTime(running);
			mvo.setPercent(percent);
			mvo.setPrice(15000); // 가격
			mvo.setReleaseDate(release.text());
			mvo.setSynopsis(synopsis);
			mvo.setPoster(poster);
			mvo.setNation(nation); //나라
			
			if(mvdao.movieConfirm(code)==0) {
				System.out.println("영화 신규 등록");
				mvdao.insertMovie(mvo);
			}else{
				System.out.println("영화 정보 수정");
				mvdao.updateMovie(mvo);
			}
		}
	}
	// cgv 무비차트에 있는 moviecode 가져오기
	public ArrayList<Integer> movieCode() throws IOException {
		Document doc = Jsoup.connect("http://www.cgv.co.kr/movies/?lt=1&ft=0").get();
		Elements codes = doc.select("div.box-contents a");
		ArrayList<Integer> code = new ArrayList<Integer>();
		
		for(int i=0; i<codes.size();i++) {
			String c = codes.get(i).absUrl("href");
			if(c.contains("midx=")) {
				String str=c.substring(c.lastIndexOf("midx=")+1);
				code.add(Integer.parseInt(str.substring(4)));
			}
		}
		
		return code;
	}
	
	@PostMapping("/movieAllDelete")
	public void movieAllDelete() {
		mvdao.deleteAllMovie();
	}
}
