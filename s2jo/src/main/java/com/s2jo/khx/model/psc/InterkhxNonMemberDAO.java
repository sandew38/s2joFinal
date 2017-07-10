package com.s2jo.khx.model.psc;

import java.util.HashMap;

public interface InterkhxNonMemberDAO {

	int nonloginEnd(HashMap<String, String> map); //비회원 로그인 여부 알아오기
	
	khxpscNonMemberVO getNonLoginEnd(String nhp); // 로그인한 비회원 정보 가져오기	
	
	int loginEnd(HashMap<String, String> map);	  // 정회원 로그인 여부 알아오기
	
	khxpscMemberVO getLoginEnd(HashMap<String, String> map);	//정회원 로그인 여부(아이디, 비밀번호) 확인 및 아이디 저장
	
	Object memberRegisterEnd(HashMap<String, Object> membermap);  // 회원가입 완료	
	
	int idDuplicateCheck(String useridforcheck);//아이디 중복검사
	
	int pwdFind(HashMap<String, String> map); //비밀번호 찾기!

	int updatePwdUser(HashMap<String, String> map); //비밀번호 변경!!

	int MypagePwdFind(HashMap<String, String> map); //마이페이지에서 비밀번호 찾기!

	int getDeleteUser(HashMap<String, String> map); //회원탈퇴!!

}//end of public interface InterkhxNonMemberDAO {
