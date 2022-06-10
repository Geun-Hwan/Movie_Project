package dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.ReportVo;

@Repository
public class ReportDAO {
	
	@Autowired
	SqlSessionTemplate SqlSessionTemplate;  
	
	public void insertReport(ReportVo rvo) {
		SqlSessionTemplate.insert("dao.ReportDAO.insertReport",rvo);
	}
	
	public ArrayList<ReportVo> allReport(int start, int end){
		List<ReportVo> list = new ArrayList<ReportVo>();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		
		list=SqlSessionTemplate.selectList("dao.ReportDAO.allReport",map);
	
		return (ArrayList<ReportVo>) list;
	}
	public int reportCount() {
		int count=0;
		
		count = SqlSessionTemplate.selectOne("dao.ReportDAO.reportCount");
		
		return count;
	}
	
	public int checkReport(String writer,String reporter, int code) {
		int check=0;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("writer", writer);
		map.put("reporter", reporter);
		map.put("code", code);
		
		check = SqlSessionTemplate.selectOne("dao.ReportDAO.checkReport",map);
		
		return check;
	}
	
	public void deleteReport(String writer,String reporter, int code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("writer", writer);
		map.put("reporter", reporter);
		map.put("code", code);
		
		SqlSessionTemplate.delete("dao.ReportDAO.deleteReport",map);
	}
}
