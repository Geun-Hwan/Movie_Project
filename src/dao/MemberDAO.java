package dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.MemberVo;

@Repository
public class MemberDAO {

	@Autowired
	SqlSessionTemplate SqlSessionTemplate;
	
	public Integer insertMember(MemberVo member) {
		int result=0;

		result=SqlSessionTemplate.insert("dao.MemberDAO.insertMember",member);
		return result;
	}
	
	
	public void deleteMember(String userId) {

		SqlSessionTemplate.delete("dao.MemberDAO.deleteMember",userId);
	}
	
	public void updateMember(MemberVo member) {

		SqlSessionTemplate.update("dao.MemberDAO.updateMember",member);
	}
	
	public String getPass(String userId) { //정보 변경 시필요,로그인도?
		String pwd=null;

		pwd = SqlSessionTemplate.selectOne("dao.MemberDAO.getPass",userId);
		return pwd;
	}
	
	public MemberVo infoMember(String userId) {
		MemberVo member=new MemberVo();

		member = SqlSessionTemplate.selectOne("dao.MemberDAO.infoMember",userId);
		return member;
	}
	
	public Integer confrimID(String userid) {
		int result=-1;

		result = SqlSessionTemplate.selectOne("dao.MemberDAO.confrimID",userid);
		return result;
	}
	
	public List<MemberVo> allMember(){ // 관리자모드에서 회원관리 들어가면 출력할 전체 회원 정보
		List <MemberVo> list = new ArrayList<MemberVo>();

		list =SqlSessionTemplate.selectList("dao.MemberDAO.allMember");
		return list;
	}
	
	public Integer confirmEamil(String email) {
		int result=-1;

		result = SqlSessionTemplate.selectOne("dao.MemberDAO.confirmEamil",email);
		return result;
	}
	
	public String getMail(String userid) {
		String email="";

		email =SqlSessionTemplate.selectOne("dao.MemberDAO.getMail",userid);
		return email;
	}
	
	public String findId(String email, String name) {
		String userid=null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		map.put("name", name);

		userid=SqlSessionTemplate.selectOne("dao.MemberDAO.findId",map);
		return userid;
	}
	
	public boolean findPwd(String userid, String email) {
		boolean check =false;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userid", userid);
		map.put("email", email);

		int result =SqlSessionTemplate.selectOne("dao.MemberDAO.findPwd",map);
		if(result ==1) {
			check= true;
		}
		return check;
	}
	
	public Integer changePw(String email,String userid, String userpw) {
		int result =0;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		map.put("userid", userid);
		map.put("userpw", userpw);
		

		result =SqlSessionTemplate.update("dao.MemberDAO.changePw",map);
		return result;
	}
	
	// 회원 정지
		public void banMemberDo(MemberVo member) {

			SqlSessionTemplate.update("dao.MemberDAO.banMemberDo",member);
		}
		
		public List<MemberVo> banlist(){ // 관리자모드에서 정지회원 조회
			List <MemberVo> list = new ArrayList<MemberVo>();

			list =SqlSessionTemplate.selectList("dao.MemberDAO.banlist");
			return list;
		}
		
		public MemberVo banMember(String bandate) {
			MemberVo member=new MemberVo();
			
			member =SqlSessionTemplate.selectOne("dao.MemberDAO.banMember",bandate);
			return member;
		}
		
		public void permitMember(MemberVo member) {

			SqlSessionTemplate.update("dao.MemberDAO.permitMember",member);
		}
		
		public void deleteBandate(MemberVo member) {

			SqlSessionTemplate.update("dao.MemberDAO.deleteBandate",member);
		}
		
		public void changeBandate(String userid , String ban_date) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("userid", userid);
			map.put("ban_date", ban_date);

			SqlSessionTemplate.update("dao.MemberDAO.changeBandate",map);
		}
		
}

