<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<style type="text/css">
  .carousel-inner > .item > img,
  .carousel-inner > .item > a > img {
      width: 70%;
      margin: auto;
  }
  
  .myborder {
   border: navy solid 1px;
  }
  
  
  
  
  
  
</style>




<div style="padding-left: 30%; border: solid 0px red;">
<script>
function goDeleteUser(){
	

	var userdelFrm = document.userdelFrm;
	
	if(${userListMap.status == 0}){
		alert("이미 삭제된 회원입니다");
	}
	else{

		userdelFrm.action = "/khx/UserDelete.action";
		userdelFrm.method = "get";
		userdelFrm.submit();
		
	}
	
}




function gorestore(){
	
   
	if(${userListMap.status == 1}){
		alert("이미 복구한 회원입니다");
	}
	else {

		var restoreUserFrm = document.restoreUserFrm;
		restoreUserFrm.action = "/khx/UserRestore.action";
		restoreUserFrm.method = "get";
		restoreUserFrm.submit();
		
	}

}


</script>



<div class="container" style="margin-right: 60%; font-size: 25px; margin-top: 5%;">
	<div class="row">
        <div class="span12">
    		<table class="table table-condensed table-hover">
    			<thead>
    				<tr>
    				
    			</thead>
    			<tbody>
    		
    				<tr>
    					<td>아이디</td>
    					<td>${userListMap.userid}</td>
    				</tr>
    				<tr>
    					<td>이름</td>
    					<td>${userListMap.name}</td>
    				</tr>
    				<tr>
    					<td>패스워드</td>
    					<td>${userListMap.pwd}</td>
    				</tr>
    				<tr>
    					<td>이메일</td>
    					<td>${userListMap.email}</td>
    				</tr>
    				<tr>
    					<td>휴대폰번호</td>
    					<td>${userListMap.hp}</td>
    				</tr>
    			<!-- 	<tr>
    					<td> </td>
    					<td> </td>
    					<td> </td>
    					<td> </td>
    					<td> </td>
    				</tr> -->
    				<tr>
    					<td>우편번호</td>
    					<td>${userListMap.post}</td>
    				
    				</tr>
    				<tr>
    					<td>주소1</td>
    					<td>${userListMap.addr1}</td>
    					
    				</tr>
    				<tr>
    					<td>주소2</td>
    					<td>${userListMap.addr2}</td>
    				
    				</tr>
    				
    				
    				
    				<tr>
    					<td>가입날짜</td>
    					<td>${userListMap.joindate}</td>
    					
    				</tr>
    				<tr>
    					<td>회원상태</td>
    					<td> <c:choose>
      <c:when test="${userListMap.status == 1}">
         <span style="color: blue; font-weight: bold; font-size: 20pt;">가입회원</span>
         </c:when>
         <c:when test="${userListMap.status == 0}">
         <span style="color: red; font-weight: bold; font-size: 20pt;">탈퇴회원</span><br/>
         </c:when>
      </c:choose></td>
    				
    				</tr>
    				
    				
    				<tr>
    					<td>생일</td>
    					<td>${userListMap.birthday}</td>
    				
    				</tr>
    				<tr>
    					<td>성별</td>
    					<td> <c:choose>
      <c:when test="${userListMap.gender == 1}">
         <span style="color: blue; font-weight: bold; font-size: 12pt;">남자</span>
         </c:when>
         <c:when test="${userListMap.gender == 0}">
         <span style="color: red; font-weight: bold; font-size: 12pt;">여자</span><br/>
         </c:when>
      </c:choose></td>
    				
    				</tr>
    				
    				<tr>
    					<td>회원삭제</td>
    					<td><button style="font-size: 20px;" class="btn btn-danger" onClick="goDeleteUser()">회원삭제</button></td>
    				
    				</tr>
    				<tr>
    					<td>회원복구</td>
    					<td><button style="font-size: 20px;" class="btn btn-primary" onClick="gorestore()">회원복구</button></td>
    				
    				</tr>
    				
    				
    				
    				
    				
    				
    			</tbody>
    		</table>
    	</div>
	</div>
</div>



     
     <form name="userdelFrm">
      <input type = "hidden" id="deleteid" name="deleteid" value = "${userListMap.userid}">
      </form>
     
     
      <form name="restoreUserFrm">
      <input type="hidden" id="restoreuser" name="restoreuser" value = "${userListMap.userid}" />
      </form>
     
     
    </ol>
</div>

<!-- 폴더안에 저장되있는 파일을 뽑아오는 -->

   
   </div>