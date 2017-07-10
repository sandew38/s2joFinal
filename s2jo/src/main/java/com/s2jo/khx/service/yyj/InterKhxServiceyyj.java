package com.s2jo.khx.service.yyj;

import java.util.HashMap;
import java.util.List;

import org.springframework.aop.ThrowsAdvice;

import com.s2jo.khx.model.kyj.RuninfoVO;

import com.s2jo.khx.model.yyj.trainVO;
import com.s2jo.khx.model.yyj.AdminMemberVO;
import com.s2jo.khx.model.yyj.MemberVO;
import com.s2jo.khx.model.yyj.PaysummaryVO;
import com.s2jo.khx.model.yyj.lossAdminVO;
import com.s2jo.khx.model.yyj.lossVO;

// Service 단 인터페이스 선언

public interface InterKhxServiceyyj {
	
	
	List<lossVO> lossList(HashMap<String, String> map); // 유저가 등록한 유실물 리스트
	
	int registerusiladminyyj(lossAdminVO lavo);
	
    
	int registerusilyyj(lossVO lossvo); // 유실물등록
	
	int gettotalcount1(HashMap<String, String> map); // 분실물리스트 (유저등록)
	
	int gettotalcount2(HashMap<String, String> map);  //유저가등록한분실물
	
	int gettotalcount3(HashMap<String, String> map); // 회원관리
	
	
	String getLargeImgFilename(HashMap<String,String> map);  // 썸네일 
	
    int loginEnd(HashMap<String, String> map); // 로그인 여부 알아오기
 	
 	MemberVO getLoginMember(String userid); // 로그인한 사용자 정보 가져오기
 	
 	int registerusilyyj_withFile(lossVO lossvo); 	// 첨부파일이 있는 유저 유실물등록 
 	
 	int registerusiladminyyj_withFile(lossAdminVO lavo); 	// 첨부파일이 있는 관리자 유실물등록 
	
 	
 	 List<lossAdminVO> getallLosslist(HashMap<String,String> map); // 일반 유저가 볼수있는 유실물 전체뽑기
 	
  	HashMap<String,String> getlossDetail(String lostno); // 유실물 디테일 페이지
 	 
  	HashMap<String,String> getlossuserDetail(String userid); // 유저유실물등록 디테일 페이지
  	
  	String getlossDetailimage(HashMap<String,String> map); // 유실물 이미지등록
  	
  	 List<AdminMemberVO> getuserList(HashMap<String,String> map); // 회원관리

  	 
  	HashMap<String,String> getuserDetail(String userid); // 유저디테일
  	
  	
   int getDeleteUser(HashMap<String,String> map); // 회원삭제
  	
  	int getUserRestore(HashMap<String,String> map); // 회원삭제 복구
    
    
  	
  	 List<trainVO>  gettrainList(HashMap<String,String> map);// 트레인리스트 가져오기
    
	  int gettotalcount4(HashMap<String,String> map);  // 열차수  카운트
    

	    List<trainVO> getviewtrain(HashMap<String,String> map); // 배차수정페이지 요청
	
		int editTrainEnd(HashMap<String,String> map);  // 배차수정 성공실패
	    
		 List<HashMap<String,String>> gettrainchartList(PaysummaryVO psvo); // 각날짜별 꺽새그래프 수익그리기
	    
		   int getstoptrain(HashMap<String,String> map); // 배차정지
		 
		   int gettrainRestore(HashMap<String,String> map); // 배차 복구
		   
		   
		   int getplustrain(HashMap<String,String> map); // 배차 추가
		   
	
		   int gettotalcount5(HashMap<String,String> map); // 배차삭제 카운트
		   
		   
		   List<MemberVO> gettimelinelist(HashMap<String,String> map);
		   
		   List<HashMap<String, String>> getscreenLock(); // 스크린락
		   
		   List<HashMap<String, String>> getlikeChartList(); // 라이크차트 뽑기 //
		   
		   List<HashMap<String, String>> getGoList(); // 많이간 지역별 퍼센트에이지 차트
		   
		   
}
