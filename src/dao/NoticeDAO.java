package dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.NoticeBoard;

@Repository
public class NoticeDAO {
	@Autowired
	SqlSessionTemplate SqlSessionTemplate;

	public void insertNotice(NoticeBoard not) {
		SqlSessionTemplate.insert("dao.NoticeDAO.insertNotice", not);
	}

	public ArrayList<NoticeBoard> allNotice(int start, int end) {
		List<NoticeBoard> list = new ArrayList<NoticeBoard>();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		list =SqlSessionTemplate.selectList("dao.NoticeDAO.allNotice",map);
		return (ArrayList<NoticeBoard>) list;
	}

	public int noticeCount() {
		int count = 0;
		
		count =SqlSessionTemplate.selectOne("dao.NoticeDAO.noticeCount");
				
		return count;
	}

	public NoticeBoard readNotice(int num) { // 게시글 클릭시
		NoticeBoard notice = null;
		SqlSessionTemplate.update("dao.NoticeDAO.readCountUp",num);
		notice = SqlSessionTemplate.selectOne("dao.NoticeDAO.readNotice",num);
		
		return notice;
	}

	public void noticeUpdate(NoticeBoard not) {
		SqlSessionTemplate.update("dao.NoticeDAO.noticeUpdate",not);
	}

	public void noticeDelete(int num) {
		
	SqlSessionTemplate.delete("dao.NoticeDAO.noticeDelete",num);
	}
}
