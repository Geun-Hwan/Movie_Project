package dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.QnaBoard;

@Repository
public class QnaDAO {
	
	@Autowired
	SqlSessionTemplate SqlSessionTemplate;

	public void insertQna(QnaBoard qna) {

		SqlSessionTemplate.insert("dao.QnaDAO.insertQna", qna);
	}
	
	public ArrayList<QnaBoard> myQnaList(String userid) {

		List<QnaBoard> list= SqlSessionTemplate.selectList("dao.QnaDAO.myQnaList",userid);
		return (ArrayList<QnaBoard>) list;
	}
	
	public ArrayList<QnaBoard> allQnaList() {

		List<QnaBoard> list= SqlSessionTemplate.selectList("dao.QnaDAO.allQnaList");
		return (ArrayList<QnaBoard>) list;
	}
	

	public void answerCheck(String answer,int num) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("answer", answer);
		map.put("num", num);
		SqlSessionTemplate.update("dao.QnaDAO.answerCheck",map);
	}
	
	public void deleteQna(int num) {

		SqlSessionTemplate.delete("dao.QnaDAO.deleteQna",num);
	}
	
	public void deleteQna(String userid) {

		SqlSessionTemplate.delete("dao.QnaDAO.deleteAllQna",userid);
	}
}
