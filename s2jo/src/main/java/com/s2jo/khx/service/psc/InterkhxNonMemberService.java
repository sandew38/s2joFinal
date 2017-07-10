
package com.s2jo.khx.service.psc;

import java.util.HashMap;

import com.s2jo.khx.model.psc.khxpscMemberVO;
import com.s2jo.khx.model.psc.khxpscNonMemberVO;

// Service 단 인터페이스 선언
public interface InterkhxNonMemberService {

	int nonloginEnd(HashMap<String, String> map); // 비회원 로그인 여부 알아오기 

	khxpscNonMemberVO getNonLoginEnd(String nhp); //비회원 로그인완료 요청

	int loginEnd(HashMap<String, String> map); //정회원 로그인 여부 알아오기

	khxpscMemberVO getLoginEnd(HashMap<String, String> map); //정회원 로그인 여부(아이디, 비밀번호) 확인 및 아이디 저장
	
	Object memberRegisterEnd(HashMap<String, Object> membermap);// 회원가입 완료요청
	
	int idDuplicateCheck(String useridforcheck);//아이디 중복검사

	int pwdFind(HashMap<String, String> map); //비밀번호 찾기!

	int updatePwdUser(HashMap<String, String> map); //비밀번호 변경!!

	int MypagePwdFind(HashMap<String, String> map); //마이페이지에서 비밀번호 찾기!

	int updateMypagePwdUser(HashMap<String, String> map); //마이페이지에서 비밀번호 변경!

	int getDeleteUserID(HashMap<String, String> map);//회원탈퇴!!
	

}//end of public interface InterkhxNonMemberService {
