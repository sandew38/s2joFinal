package com.s2jo.khx.model.psc;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.s2jo.khx.model.psc.khxpscMemberVO;
import com.s2jo.khx.model.psc.khxpscNonMemberVO;



@Repository//DAO 선언
public class khxpscNonMemberDAO {

	//의존객체 주입하기(DI : Dependency Injection) =====
	@Autowired
	private SqlSessionTemplate sqlsession;

	//비회원정보 가져오기
	public int nonloginEnd(HashMap<String, String> map) {
		int n = sqlsession.selectOne("pscmember.nonloginEnd", map);
									/*xml이름.xml에서 불러다 쓸 ID*/
		return n;
	}
	
	//로그인성공한 비회원 정보가져오기
	public khxpscNonMemberVO getNonLoginEnd(String nhp) {
		khxpscNonMemberVO nonloginuser = sqlsession.selectOne("pscmember.getNonLoginEnd", nhp);
		
		return nonloginuser;
	}

	//정회원 정보 가져오기!
	public int loginEnd(HashMap<String, String> map) {
		int n = sqlsession.selectOne("pscmember.loginEnd", map);
									//xml이름.xml에서 불러다 쓸 ID
		return n;
	}


	//정회원 로그인 여부(아이디, 비밀번호) 확인 및 아이디 저장
	public khxpscMemberVO getLoginEnd(HashMap<String, String> map) {
		khxpscMemberVO loginuser = sqlsession.selectOne("pscmember.getLoginEnd", map);
		return loginuser;
	}

	
	//회원가입 완료 요청!!
	public Object memberRegisterEnd(HashMap<String, Object> membermap) {
		int n = sqlsession.insert("pscmember.memberRegisterEnd", membermap);
									//xml이름.xml에서 불러다 쓸 ID
		System.out.println("dao단" + n);

		return n;
	}
	
	//아이디 중복검사!
	public int idDuplicateCheck(String useridforcheck) {
		int n = sqlsession.selectOne("pscmember.idDuplicateCheck",useridforcheck);
		return n;
	}

	//비밀번호 찾기
	public int pwdFind(HashMap<String, String> map) {
		int n = sqlsession.selectOne("pscmember.pwdFind",map);
		return n;
	}

	//비밀번호 변경!!
	public int updatePwdUser(HashMap<String, String> map) {
		int n = sqlsession.update("pscmember.updatePwdUser",map);
		return n;
	}
	//마이페이지에서 비밀번호 찾기!!
	public int MypagePwdFind(HashMap<String, String> map) {
		int n = sqlsession.selectOne("pscmember.MypagePwdFind",map);
		return n;
	}

	//회원탈퇴!!
	public int getDeleteUserID(HashMap<String, String> map) {
		int n = sqlsession.update("pscmember.getDeleteUserID", map);
		return n;
	}
	//마이페이지에서 비밀번호 변경하기!
	public int updateMypagePwdUser(HashMap<String, String> map) {
		int n = sqlsession.selectOne("pscmember.updateMypagePwdUser",map);
		return n;
	}




	
}//end of public class khxpscNonMemberDAO {














