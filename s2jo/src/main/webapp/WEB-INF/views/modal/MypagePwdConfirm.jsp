<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script> 

<style type="text/css">

  #div_userid {
  		width: 70%;
  		height: 15%;
  		margin-bottom: 5%;
  		margin-left: 10%;
  		position: relative;
  }
  
  #div_email {
  		width: 70%;
  		height: 15%;
  		margin-left: 10%;
  		position: relative;
  }
  
  #div_findResult {
  		width: 70%;
  		margin-left: 10%;
  		position: relative;
  		font-weight: bold;
  		font-size: 18pt;
  		padding: 3px;
  }
  
  #div_btnFind {
  		width: 70%;
  		margin-bottom: 30px;
  		margin-left: 10%;
  		position: relative;
  }
	
	#div_pwd{
	
	  		width: 70%;
  		height: 15%;
  		margin-bottom: 5%;
  		margin-left: 10%;
  		position: relative;
	}
	#div_pwd2
	{
	  		width: 70%;
  		height: 15%;
  		margin-bottom: 5%;
  		margin-left: 10%;
  		position: relative;
	}
</style>   

<script type="text/javascript">
	
	$(document).ready(function(){
		var userid ="${userid}";
		var mthd = "${method}";
		
		if(mthd == "POST") {
			$("#pwd").val("${pwd}");
			$("#pwd2").val("${pwd2}");
		}
		
		
		$("#btnUpdate").click(function(event){
			var pwd = $("#pwd").val();
			var pwd2 = $("#pwd2").val();
			
			var pattern = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
    		// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규식 
    		
			var bool = pattern.test(pwd);
    		
    		if(!bool) {
    			sweetAlert("","암호는 8글자 이상 15글자 이하에서 영문자, 숫자, 특수기호가 혼합되어야 합니다!","warning");

    			$("#pwd").val("");
    			$("#pwd2").val("");
    			$("#pwd").focus();
    			
    			event.preventDefault();
    			return;
    		}
    		else if(pwd != pwd2) {
    			sweetAlert("","암호가 일치하지 않습니다!","warning");

    			$("#pwd").val("");
    			$("#pwd2").val("");
    			$("#pwd").focus();
    			
    			event.preventDefault();
    			return;
    		}
    		else {
    			sweetAlert("","비밀번호 변경이 완료되었습니다!","warning");

    			var pwdConfirmFrm = document.pwdConfirmFrm;
    			pwdConfirmFrm.action = "/khx/Mypage.action";
    			pwdConfirmFrm.method = "GET";
    			pwdConfirmFrm.submit();
    		}
			
		});
		
	});

</script>
<div  align="center" style = "background-color:white; width:100%; height:100%; margin: auto; padding-top: 100px;">

<form name="pwdConfirmFrm" >
	<div align="center" style="padding: 10%; height: 90%;">

	<div id="div_pwd" style="width: 40%;">
		<span class="input-group-addon" style="height:50px; color: white; font-size: 12pt;  background-color: #639EB0;">새암호</span>
		<input type="password" class="form-control"id="pwd" name="pwd" size="15" placeholder="PASSWORD" required /> 
	</div>
	
	<div id="div_pwd2" align="center" style="width: 40%;">
		<span class="input-group-addon" style="height:50px; color: white; font-size: 12pt;  background-color: #639EB0;">새암호확인</span>
		<input type="password" class="form-control"id="pwd2" name="pwd2" size="15" placeholder="PASSWORD" required /> 
	</div>
	
	<input type="hidden" name="userid" value="${sessionScope.loginuser.userid}" />
	
	<c:if test="${method.equals('POST') && n==1}">
		<div id="div_confirmResult" align="center">
			 ID : ${sessionScope.loginuser.userid} 님의 암호가 새로이 변경되었습니다.<br/>
		</div>
	</c:if>
	
	<c:if test="${method.equals('GET')}">
		<div id="div_btnUpdate" align="center" style="margin-left: 130px; ">
			<button style="background-color: #639EB0;" type="button" class="btn btn-success" id="btnUpdate">암호변경하기</button> 
		</div>
	</c:if>
	</div>
</form>

</div>



