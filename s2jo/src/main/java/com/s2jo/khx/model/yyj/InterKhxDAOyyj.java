package com.s2jo.khx.model.yyj;

import java.util.HashMap;
import java.util.List;

import com.s2jo.khx.model.yyj.trainVO;


// model 단 (DAO)의 인터페이스 생성

public interface InterKhxDAOyyj {

	 List<lossVO> lossList(HashMap<String, String> map); // 유저가 등록한 유실물 보기
	 
	 int registerusilAdminyyj(lossAdminVO lavo); // 관리자가 등록한 유실물
	
	 int registerusilyyj(lossVO lossvo); // 유실물등록 작성하기 
	 
	 int loginEnd(HashMap<String, String> map); // 로그인 여부 알아오기
	 	
	 	MemberVO getLoginMember(String userid); // 로그인한 사용자 정보 가져오기
	 	
	 	String getLargeImgFilename(HashMap<String,String> map); // 썸네일 
	 	
	 	
	 	int registerusilyyj_withFile(lossVO lossvo); // 일반유저가 등록한 첨부파일있는 유실물등록
	 	
	 	int registerusiladminyyj_withFile(lossAdminVO lavo); // 관리자가 등록한 첨부파일있는 유실물등록
	 	
	 	List<lossAdminVO> getallLosslist(HashMap<String,String> map); // 일반유저가 볼수있는 리스트
	 	
	 	HashMap<String,String> getlossDetail(String lostno); // 유실물 디테일 페이지
	 	
	 	String getlossDetailimage(HashMap<String,String> map); // 유실물 이미지 등록
	 	
	 	int gettotalcount1(HashMap<String, String> map); //분실물리스트(유저등록)
	 	
	 	int gettotalcount2(HashMap<String, String> map);//유저가등록한분실물
	 	
	 	int gettotalcount3(HashMap<String, String> map); //회원관리
	 	
	 	
	 	
	 	
	 	

	 	List<AdminMemberVO> userList(HashMap<String, String> map); // 회원관리
	 	
	 	
	 	HashMap<String,String> getuserDetail(String userid); // 유저디테일
	
	 	int getDeleteUser(HashMap<String,String> map);  // 회원삭제
	 	
	 	 int getUserRestore(HashMap<String,String> map); // 회원삭제 복구
	 	
	 	HashMap<String,String> getlossuserDetail(String userid); // 유저가 등혹한 유실물 페이지 //
	 	
	 	
	 	 List<trainVO>  gettrainList(HashMap<String,String> map); // 트레인리스트 가져오기
	    
		  int gettotalcount4(HashMap<String,String> map);  // 열차수  카운트
	    
	  	
	/*	  int updatetimeMapMap(HashMap<String,String> map); //배차수정
*/	 	
		  List<trainVO> getviewtrain(HashMap<String,String> map); // 배차수정페이지요청 
		  
	 	
		  
		  int editTrainEnd(HashMap<String,String> map); // 배차수정 성공실패
		  
		  
		  List<HashMap<String, String>> gettrainchartList(PaysummaryVO psvo); // 각 날자별 수익금 꺾새그래프 그리기
		  

		  
		  int getstoptrain(HashMap<String,String> map); // 배차정지
		  
			int gettrainRestore(HashMap<String,String> map); // 열차 복구
		  
			int getplustrain(HashMap<String,String> map); // 배차추가
			
			
			   /*List<HashMap<String, String>> gettraindeleteList(HashMap<String,String> map); // 배차 삭제 리스트
*/
			 int gettotalcount5(HashMap<String,String> map); // 배차삭제 카운
			 
			
			 List<MemberVO> gettimelinelist(HashMap<String,String> map);
			 
			 List<HashMap<String, String>> getscreenLock(); // 스크린락
			 
			 
			 List<HashMap<String, String>> getlikeChartList(); // 라이크 차트 뽑기
			 
			 
			 
			 List<HashMap<String, String>> getgoList();// 많이간 지역별 퍼센트에이지 차트
} // end of public interface InterBoardDAO ----


