package com.s2jo.khx.service.psc;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.s2jo.khx.model.psc.khxpscMemberVO;
import com.s2jo.khx.model.psc.khxpscNonMemberDAO;
import com.s2jo.khx.model.psc.khxpscNonMemberVO;

//	==== #30. Service 선언 ====

@Service
public class khxNonMemberService implements InterkhxNonMemberService {

//	==== #31. 의존객체 주입하기 (DI : Dependency Injection) ====
	
	@Autowired
	private khxpscNonMemberDAO knmdao;

	@Override//비회원 로그인여부 확인
	public int nonloginEnd(HashMap<String, String> map) {
		int n= knmdao.nonloginEnd(map);
		return n;
	}//end of public int nonloginEnd(HashMap<String, String> map) {

	@Override//비회원 로그인완료 요청
	public khxpscNonMemberVO getNonLoginEnd(String nhp) {
		khxpscNonMemberVO nonloginuser = knmdao.getNonLoginEnd(nhp);
		return nonloginuser;
	}
	
	@Override//정회원 로그인여부 확인
	public int loginEnd(HashMap<String, String> map) {
		int n= knmdao.loginEnd(map);
		return n;
	}

	@Override //정회원 로그인 여부(아이디, 비밀번호) 확인 및 아이디 저장
	public khxpscMemberVO getLoginEnd(HashMap<String, String> map) {
		khxpscMemberVO loginuser = knmdao.getLoginEnd(map);
		return loginuser;
	}
	
	
	@Override//회원가입 완료요청
	public Object memberRegisterEnd(HashMap<String, Object> membermap) {
		Object n= knmdao.memberRegisterEnd(membermap);
		return n;
	}

	@Override //아이디 중복검사!
	public int idDuplicateCheck(String useridforcheck) {
		int n = knmdao.idDuplicateCheck(useridforcheck);
		System.out.println("service단" + n);
		return n;
	}
	@Override //비밀번호 찾기!
	public int pwdFind(HashMap<String, String> map) {
		int n = knmdao.pwdFind(map);
		return n;
	}

	@Override //비밀번호 변경!
	public int updatePwdUser(HashMap<String, String> map) {
		int n = knmdao.updatePwdUser(map);
		return n;
	}
	@Override //마이페이지에서 비밀번호 찾기를 위한 인증번호 발송!
	public int MypagePwdFind(HashMap<String, String> map) {
		int n = knmdao.MypagePwdFind(map);
		return n;
	}
	@Override //마이페이지에서 비밀번호 변경!
	public int updateMypagePwdUser(HashMap<String, String> map) {
		int n = knmdao.updateMypagePwdUser(map);
		return n;
	}	
	@Override //회원탈퇴!!
	public int getDeleteUserID(HashMap<String, String> map) {
		int n = knmdao.getDeleteUserID(map);
		return n;
	}


} // end of public class BoardService implements InterBoardService ----
