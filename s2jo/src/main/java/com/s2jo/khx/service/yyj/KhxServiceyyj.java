package com.s2jo.khx.service.yyj;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.s2jo.khx.model.kyj.KhxDAO;
import com.s2jo.khx.model.kyj.RuninfoVO;
import com.s2jo.khx.model.yyj.trainVO;
import com.s2jo.khx.model.yyj.AdminMemberVO;
import com.s2jo.khx.model.yyj.KhxDAOyyj;
import com.s2jo.khx.model.yyj.MemberVO;
import com.s2jo.khx.model.yyj.PaysummaryVO;
import com.s2jo.khx.model.yyj.lossAdminVO;
import com.s2jo.khx.model.yyj.lossVO;

//	==== #30. Service 선언 ====

@Service
public class KhxServiceyyj implements InterKhxServiceyyj {

//	==== #31. 의존객체 주입하기 (DI : Dependency Injection) ====
	
	@Autowired
	private KhxDAOyyj kdao;

	
	
	@Override
	public List<lossVO> lossList(HashMap<String, String> map) {
		
	    List<lossVO> lossList = kdao.lossList(map);
    
	    return lossList;
	}


	
	  // 유실물등록 
	@Override 
	public int registerusilyyj(lossVO lossvo) {
		int n = kdao.registerusilyyj(lossvo);
		return n;
	}
	
	
	
	 // 관리자 유실물 등록
	@Override
	public int registerusiladminyyj(lossAdminVO lavo) {
		int n = kdao.registerusilAdminyyj(lavo);
		return n;
	}

	
	
	// 첨부파일이 있는 관리자 유실물 등록

	@Override
	public int registerusiladminyyj_withFile(lossAdminVO lavo) {
		
	   int n = kdao.registerusiladminyyj_withFile(lavo);
	   return n;
	
	}
	
	//첨부파일이 있는 일반유저 유실물 등록

	

	@Override
	public int registerusilyyj_withFile(lossVO lossvo) {
		
	   int n = kdao.registerusilyyj_withFile(lossvo);
	   return n;
	
	}

	
	
	
	
  // 일반 유저가 볼수있는 유실물페이지
	

	
	
	
   // 회원관리 //
	
  ////////////////////////////////////////////////////////////	
	
	

	@Override
	public int loginEnd(HashMap<String, String> map) {
		int n = kdao.loginEnd(map);
		return n;
	}



	@Override
	public MemberVO getLoginMember(String userid) {
		MemberVO loginuser = kdao.getLoginMember(userid);
		return loginuser;
	}


		@Override
		public List<lossAdminVO> getallLosslist(HashMap<String, String> map) {
		List<lossAdminVO> allLossList = kdao.getallLosslist(map);
		return allLossList;
	}


       // 일반유실물 디테일페이지 //
		@Override
		public HashMap<String, String> getlossDetail(String lostno) {
			HashMap<String,String> lossDetailMap =kdao.getlossDetail(lostno);
			return lossDetailMap;
		}

     
   // 유실물 이미지 등록 //
		@Override
		public String getlossDetailimage(HashMap<String, String> map) {
			String orgfilename = kdao.getlossDetailimage(map);
			
			return orgfilename;
		}


       // 총 게시글수 구하기 //
		@Override
		public int gettotalcount1(HashMap<String, String> map) {
		int count1 = kdao.gettotalcount1(map);
		return count1;
			
		}


      
		@Override
		public List<AdminMemberVO> getuserList(HashMap<String,String> map) {
			List<AdminMemberVO> userList  = kdao.userList(map);
			
			return userList;
		}


  // 회원 디테일 페이지 //
		@Override
		public HashMap<String, String> getuserDetail(String userid) {
	
			HashMap<String,String> userListMap =kdao.getuserDetail(userid);
			return userListMap;
			
			
			
		
		}


         // 회원삭제 //
		
		
		 // 회원삭제 //
		@Override
		public int getDeleteUser(HashMap<String, String> map) {
			int n = kdao.getDeleteUser(map);
			return n;
		}



	  // 회원삭제 복구 //
	
		@Override
		public int getUserRestore(HashMap<String, String> map) {
              int n = kdao.getUserRestore(map);
           	return n;
		}



       // 유저가 등록한 유실물 페이지 //
		@Override
		public HashMap<String, String> getlossuserDetail(String userid) {
			HashMap<String,String> lossuserDetailMap =kdao.getlossuserDetail(userid);
			return lossuserDetailMap;
		}

		//유저가등록한분실물

		@Override
		public int gettotalcount2(HashMap<String, String> map) {
			int count2 = kdao.gettotalcount2(map);
			return count2;
		}


   //회원관리
		@Override
		public int gettotalcount3(HashMap<String, String> map) {
			int count3 = kdao.gettotalcount3(map);
			return count3;
		}





@Override
	public String getLargeImgFilename(HashMap<String, String> map) {
		String imgFilename = kdao.getLargeImgFilename(map);
		return imgFilename;
	}


 // 열차 수를 불러오기 //
@Override
public List<trainVO> gettrainList(HashMap<String, String> map) {
	
	List<trainVO> trainList  = kdao.gettrainList(map);
	
	return trainList;
	
	
}


 // 열차수 카운트 //
@Override
public int gettotalcount4(HashMap<String, String> map) {
	
		int count = kdao.gettotalcount4(map);
		return count;
			
}

@Override
public List<trainVO> getviewtrain(HashMap<String, String> map) {

	  List<trainVO> viewtrain  = kdao.getviewtrain(map);
	
	return viewtrain;
}



// 배차수정 성공 실패 // 

@Override
public int editTrainEnd(HashMap<String, String> map) {
	int editEnd = kdao.editTrainEnd(map);
	return editEnd;
}




// 날짜별 수익금 꺾새그래프 그리기 //
@Override
public List<HashMap<String, String>> gettrainchartList(PaysummaryVO psvo) {
	     List<HashMap<String, String>> list = kdao.gettrainchartList(psvo);
	   return list;
}

// 배차정지 // 

@Override
public int getstoptrain(HashMap<String, String> map) {
	int n = kdao.getstoptrain(map);
	return n;
}


// 열차 복구 //
@Override
public int gettrainRestore(HashMap<String, String> map) {
	int n = kdao.gettrainRestore(map);
   	return n;
}



// 배차 추가 //

@Override
public int getplustrain(HashMap<String,String> map){
	
	int n = kdao.getplustrain(map);
   	return n;
	
}





// 배차삭제 카운트 //

@Override
public int gettotalcount5(HashMap<String, String> map) {
	int count5 = kdao.gettotalcount5(map);
	return count5;
}



@Override
public List<MemberVO> gettimelinelist(HashMap<String,String> map) {
	List<MemberVO> timelinelist  = kdao.gettimelinelist(map);
	
	return timelinelist;
}



public List<HashMap<String, String>> gettimelinelist() {
	List<HashMap<String, String>> timelinelist  = kdao.gettimelinelist();
	
	return timelinelist;
}



@Override
public List<HashMap<String, String>> getscreenLock() {
List<HashMap<String, String>> screenLock  = kdao.getscreenLock();
	
	return screenLock;
}


// 라이크 차트 뽑기 //
@Override
public List<HashMap<String, String>> getlikeChartList() {
	 List<HashMap<String, String>> Likelist = kdao.getlikeChartList();
	   return Likelist;
}


//많이간 지역별 퍼센트에이지 차트

@Override
public List<HashMap<String, String>> getGoList() {
	List<HashMap<String, String>> goList = kdao.getgoList();
	   return goList;
}



		






} // end of public class BoardService implements InterBoardService ----
