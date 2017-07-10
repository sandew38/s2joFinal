<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script> 
 <!-- SWAL -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.css"
        rel="stylesheet">
<script src=" https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.common.min.js"></script>
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
	


</style>   

<script type="text/javascript">
	
	$(document).ready(function(){
		
		
		var method = "${method}";
		var userid = "${userid}";
		var email = "${email}";
		var n = "${n}";
		var certificationCode = "${certificationCode}";
		if(method == "POST" && userid != "" && email != "" ) {
			$("#userid").val("${userid}");
			$("#email").val("${email}");
		}

		
		$("#btnFind").click(function(){
			var pwdFindFrm = document.pwdFindFrm;
			pwdFindFrm.action = "/khx/MypagePwdFind.action";
			pwdFindFrm.method = "POST";
			pwdFindFrm.submit();

		});
		
		if(method=="POST" && n==1) {
			$("#btnFind").hide();

		}
		else if(method=="POST" && (n==-1 || n==0) ) {
			$("#btnFind").show();
		}
 		
		
		$("#btnConfirmCode").click(function(){
			if( "${certificationCode}" == $("#input_confirmCode").val() ) {
				sweetAlert("","인증성공 되었습니다!","warning");
				var pwdFindFrm = document.pwdFindFrm;
				pwdFindFrm.action = "/khx/MypagePwdConfirm.action";
				pwdFindFrm.method = "GET";   // 단순하게 폼만 띄워주는 것이므로
				pwdFindFrm.submit();
			}
			else {
				sweetAlert("","인증코드값을 다시 입력하세요!","warning");
				
				$("#input_confirmCode").val("");
			}
			
			
		}); 
		
		
	});

</script>
<div  align="center" style = " background-color:white; width:100%; height:100%; margin: auto; padding-top: 100px; ">

<form name="pwdFindFrm">
	<div align="center" style="padding: 10%; height: 90%;">
	<div id="div_userid" style="width: 40%;">
		<span class="input-group-addon" style="height:50px; color: white; font-size: 12pt;  background-color: #639EB0;">아이디</span>
		<input type="text" class="form-control" id="userid" name="userid" placeholder="아이디" required /> 
	</div>
	
	<div id="div_email" style="margin-top: 50px;width: 40%;">
		<span class="input-group-addon" style="height:50px; color : white; font-size : 12pt; background-color: #639EB0;">이메일</span>
		<input type="text" class="form-control" id="email" name="email" placeholder="khx@gmail.com" required /> 
	</div><br/><br/><br/>

	<div id="div_btnFind">
		<button style="background-color: #639EB0;" type="button" class="btn btn-primary" id="btnFind">찾기</button>
	</div>
	
	<div id="div_findResult">
		<c:if test="${n == 1}">
			<div id="pwdConfirmCodeDiv" style="width: 40%;">
				<span class="input-group-addon" style="height:50px; color : white; font-size : 12pt; background-color: #639EB0;">인증코드 입력란</span>
				<input type="text" class="form-control" id="input_confirmCode" name="input_confirmCode" required /><br/><br/>	
				<span style="font:12pt; color:white; background-color:red;">이메일로 인증코드 번호를 발송하였습니다.</span><br/><br/>
				<button style="background-color: #639EB0;" type="button" class="btn btn-success" id="btnConfirmCode">인증하기</button>
			</div><br/>
		</c:if>
		
		<c:if test="${n == 0}">
			<span style="font:12pt; color:white; background-color:red;">사용자 정보가 없습니다.</span>
		</c:if>
		
		<c:if test="${n == -1}">
			<span style="font:12pt; color:white; background-color:red;">인증코드번호가 일치하지 않습니다. 다시 입력해주세요.</span>
		</c:if>
	</div>
	
	</div>
</form>
</div>



