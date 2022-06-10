package dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.AnswerBoard;

@Repository
public class AnswerDAO {

	@Autowired
	SqlSessionTemplate SqlSessionTemplate;
	
	public void insertAnswer(AnswerBoard ans) {
		
		SqlSessionTemplate.selectOne("dao.AnswerDAO.insertAnswer",ans);
	}
	
	public AnswerBoard oneAnswer(int num) {
		
		AnswerBoard ans =SqlSessionTemplate.selectOne("dao.AnswerDAO.oneAnswer",num);
		return ans;
	}
	
	public void deleteAnswer(int num) {
		
		SqlSessionTemplate.delete("dao.AnswerDAO.deleteAnswer",num);
	}
}
