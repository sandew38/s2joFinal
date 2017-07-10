package com.s2jo.khx.model.yyj;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.s2jo.khx.model.yyj.trainVO;

// ==== #28. DAO 선언 ====

@Repository
public class KhxDAOyyj implements InterKhxDAOyyj {

// ==== #29. 의존객체 주입하기 (DI : Dependency Injection) ====
	
	@Autowired
	private SqlSessionTemplate sqlsession;

	@Override
	public List<lossVO> lossList(HashMap<String, String> map) {
		
	List<lossVO> lossList = sqlsession.selectList("yyj.lossList",map);
		
		return lossList;
	}
		
		
	// 일반유저 유실물등록 // 
		@Override
		public int registerusilyyj(lossVO lossvo) {
		   int n = sqlsession.insert("yyj.registerusilyyj", lossvo);
			return n;
		}
	
	
		// 관리자가 등록한 유실물 보기 //
		@Override
		public int registerusilAdminyyj(lossAdminVO lavo) {
			  int n = sqlsession.insert("yyj.registerusilAdminyyj", lavo);
				return n;
		}
		
	
		
		
// 관리자가 등록한 유실물 등록 (파일첨부) //
		@Override
		public int registerusiladminyyj_withFile(lossAdminVO lavo) {
			
			int n = sqlsession.insert("yyj.registerusiladminyyj_withFile", lavo);
			return n;
			
		}
		
// 일반유저가 등록한 유실물 등록 (파일첨부)//	
		
		
		@Override
		public int registerusilyyj_withFile(lossVO lossvo) {
			
			int n = sqlsession.insert("yyj.registerusilyyj_withFile", lossvo);
			return n;
			
		}
		
		

			

			
			// 유저관리 //

		
		
		
		///////////////////////////////
		
		
		
	
	// ===== #47. 로그인 여부 알아오기 =====
	@Override
	public int loginEnd(HashMap<String, String> map) {
		int n = sqlsession.selectOne("yyj.loginEnd", map);
		return n; 
	}


	// ===== #50. 로그인 성공한 사용자 정보 가져오기 =====
	@Override
	public MemberVO getLoginMember(String userid) {
		MemberVO loginuser = sqlsession.selectOne("yyj.getLoginMember", userid);
		
		return loginuser;
		
	}


	// 유저 분실물 조회 //
	
	@Override
	public List<lossAdminVO> getallLosslist(HashMap<String, String> map) {
	List<lossAdminVO> allLossList = sqlsession.selectList("yyj.getallLosslist", map);
		return allLossList;
	}
	
	
 // 유실물 디테일단 //

	@Override
	public HashMap<String, String> getlossDetail(String lostno) {
	
		HashMap<String,String> lossDetailMap = sqlsession.selectOne("yyj.getlossDetail", lostno);
		
		return lossDetailMap;
	}

	
	
  // 유실물 이미지 뽑아오기 //
	 
	
	@Override
	public String getlossDetailimage(HashMap<String, String> map) {
	  String orgfilenam = sqlsession.selectOne("yyj.getlossDetailimage", map);
	  return orgfilenam;
		
		
	}


	@Override
	public int gettotalcount1(HashMap<String, String> map) {
		int count1 = sqlsession.selectOne("yyj.gettotalcount1", map);
		return count1;
	}

 ///// 회원관리 ////////////
	@Override
	public List<AdminMemberVO> userList(HashMap<String, String> map) {
		List<AdminMemberVO> userList = sqlsession.selectList("yyj.userList",map);
		return userList;
	}

 // 회원 디테일 페이지 //
	@Override
	public HashMap<String, String> getuserDetail(String userid) {
      
		HashMap<String,String> userListMap = sqlsession.selectOne("yyj.getuserDetail", userid);
		
		return userListMap;

	}
	
	
   
	
	// 회원삭제 //

	@Override
	public int getDeleteUser(HashMap<String, String> map) {
		int n = sqlsession.update("yyj.getDeleteUser", map);
		return n;
	}

 // 회원삭제 복구 //
	@Override
	public int getUserRestore(HashMap<String, String> map) {
		int n = sqlsession.update("yyj.getUserRestore", map);
		return n;
	}


  // 유저가 등록한 유실물 페이지 //	
	@Override
	public HashMap<String, String> getlossuserDetail(String userid) {
		
      HashMap<String,String> lossuserDetailMap = sqlsession.selectOne("yyj.getlossuserDetail", userid);
		
		return lossuserDetailMap;
	}

	//유저가등록한분실물
	@Override
	public int gettotalcount2(HashMap<String, String> map) {
		int count2 = sqlsession.selectOne("yyj.gettotalcount2", map);
		return count2;
	}

   //회원관리
	@Override
	public int gettotalcount3(HashMap<String, String> map) {
		int count3 = sqlsession.selectOne("yyj.gettotalcount3", map);
		return count3;
	}

   // 썸네일
	

@Override
public String getLargeImgFilename(HashMap<String, String> map) {
		String imgFilename = sqlsession.selectOne("product.getLargeImgFilename", map);
		return imgFilename;
	}



// 기차 리스트 불러오기 //
@Override
public List<trainVO> gettrainList(HashMap<String, String> map) {
	List<trainVO> trainList = sqlsession.selectList("yyj.gettrainList",map);
	return trainList;
}

 // 열차 개수 알아오기 //
@Override
public int gettotalcount4(HashMap<String, String> map) {
	int count = sqlsession.selectOne("yyj.gettotalcount4", map);
	return count;
}




// 배차수정 // 

/*@Override
public int updatetimeMapMap(HashMap<String,String> map) {
	int updatetimeMapMap = sqlsession.update("yyj.getupdatetime", map);
	
	return updatetimeMapMap;
}
*/


 // 배차수정페이지요청 //
@Override
public List<trainVO> getviewtrain(HashMap<String, String> map) {
	List<trainVO> viewtrain = sqlsession.selectList("yyj.getviewtrain",map);
	return viewtrain;
}

// 배차수정 성공실패 //
@Override
public int editTrainEnd(HashMap<String, String> map) {
	int editEnd = sqlsession.update("yyj.editTrainEnd", map);
	return editEnd; 
}

// 각날짜별 수익금 꺾새그래프 그리기 //
@Override
public List<HashMap<String, String>> gettrainchartList(PaysummaryVO psvo) {
	 List<HashMap<String, String>> list = sqlsession.selectList("yyj.gettrainchartList", psvo);
	   return list;
}


// 배차정지 //

@Override
public int getstoptrain(HashMap<String, String> map) {
	int n = sqlsession.update("yyj.getstoptrain", map);
	return n; 
}


// 배차 복구 /

@Override
public int gettrainRestore(HashMap<String, String> map) {
	int n = sqlsession.update("yyj.gettrainRestore", map);
	return n;
}

//배차추가 리스트//


/*@Override
public List<trainVO> getplustrainlist(trainVO tvo) {
	List<trainVO> plustrainlist = sqlsession.selectList("yyj.getplustrainlist",tvo);
	return plustrainlist;
}*/

// 배차추가 //
@Override
public int getplustrain(HashMap<String, String> map) {
	int n = sqlsession.insert("yyj.getplustrain", map);
	return n;
}

 // 배차삭제 리스트 //
/*@Override
public List<trainVO> gettraindeleteList(HashMap<String, String> map) {
	List<trainVO> traindeleteList = sqlsession.selectList("yyj.gettraindeleteList",map);
	return traindeleteList;
}*/

// 배차삭제 카운트 //

@Override
public int gettotalcount5(HashMap<String, String> map) {
	int count5 = sqlsession.selectOne("yyj.gettotalcount5", map);
	return count5;
}





@Override
public List<MemberVO> gettimelinelist(HashMap<String,String> map) {
	List<MemberVO> timelinelist = sqlsession.selectList("yyj.gettimelinelist",map);
	return timelinelist;
}


public List<HashMap<String, String>> gettimelinelist() {
	
	List<HashMap<String, String>> timelinelist = sqlsession.selectList("yyj.gettimelinelist");
	return timelinelist;
}


@Override
public List<HashMap<String, String>> getscreenLock() {
	List<HashMap<String, String>> screenLock = sqlsession.selectList("yyj.getscreenLock");
	return screenLock;
}

/* 라이크 차트 뽑기*/
@Override
public List<HashMap<String, String>> getlikeChartList() {
	List<HashMap<String, String>> Likelist = sqlsession.selectList("yyj.getlikechartList");
	   return Likelist;
}

//많이간 지역별 퍼센트에이지 차트


@Override
public List<HashMap<String, String>> getgoList() {
	List<HashMap<String, String>> goList = sqlsession.selectList("yyj.getgoList");
	   return goList;
}


} // end of public class BoardDAO implements InterBoardDAO ----
