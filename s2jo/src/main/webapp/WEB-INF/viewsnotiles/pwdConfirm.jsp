<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script> 

<style type="text/css">

.nonmydiv {display: inline-block; 
           position: relative; 
           top: 30px; 
           line-height: 100%; 
           border: solid 3px green;
          }
   
.nonmydisplay {
			  display: block;
			  background-color: yellow;
              }
             
.nonmyfont {font-size: 14pt;}
   
@media (min-width: 768px) {
    .omb_row-sm-offset-3 div:first-child[class*="col-"] {
        margin-left: 25%;
    }
}

.omb_login .omb_authTitle {
    text-align: center;
   line-height: 300%;
}
   
.omb_login .omb_socialButtons a {
   color: white; // In yourUse @body-bg 
   opacity:0.9;
}
.omb_login .omb_socialButtons a:hover {
    color: white;
   opacity:1;       
}
.omb_login .omb_socialButtons .omb_btn-facebook {background: #3b5998;}
.omb_login .omb_socialButtons .omb_btn-twitter {background: #00aced;}
.omb_login .omb_socialButtons .omb_btn-google {background: #c32f10;}


.omb_login .omb_loginOr {
   position: relative;
   font-size: 1.5em;
   color: #aaa;
   margin-top: 1em;
   margin-bottom: 1em;
   padding-top: 0.5em;
   padding-bottom: 0.5em;
}
.omb_login .omb_loginOr .omb_hrOr {
   background-color: #cdcdcd;
   height: 1px;
   margin-top: 0px !important;
   margin-bottom: 0px !important;
}
.omb_login .omb_loginOr .omb_spanOr {
   display: block;
   position: absolute;
   left: 50%;
   top: -0.6em;
   margin-left: -1.5em;
   background-color: white;
   width: 3em;
   text-align: center;
}         

.omb_login .omb_loginForm .input-group.i {
   width: 2em;
}
.omb_login .omb_loginForm   {
    color: red;
}

   
@media (min-width: 100px) {
    .omb_login .omb_forgotPwd {
        text-align: left;
      margin-top:10px;
      margin-left: 200px;
    }      
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
    			sweetAlert("","암호는 8글자 이상 15글자 이하에서 영문자, 숫자, 특수기호가 혼합되어야 합니다.!","warning");
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
    			var pwdConfirmFrm = document.pwdConfirmFrm;
    			pwdConfirmFrm.action = "/khx/pwdConfirm.action";
    			pwdConfirmFrm.method = "GET";
    			pwdConfirmFrm.submit();
    			sweetAlert("","비밀번호 변경이 완료되었습니다!","warning");
    			
    		}
			
		});
		
	});

</script>

<form name="pwdConfirmFrm"  style="margin-top: 50px;">
   <div align="center">


	<div id="div_pwd">
		<span class="input-group-addon" style="color: white; font-size: 12pt; background-color: #639EB0;">새암호</span>
		<input type="password" class="form-control" id="pwd" name="pwd" placeholder="PASSWORD" required /> 
	</div>
	
	<div id="div_pwd2" style="margin-top: 20px;">
		<span class="input-group-addon" style="color: white; font-size: 12pt; background-color: #639EB0;">새암호확인</span>
		<input type="password" class="form-control" id="pwd2" name="pwd2" placeholder="PASSWORD" required /> 
	</div><br/><br/><br/>
	
	<input type="hidden" name="userid" value="${userid}" />
	
	<c:if test="${method.equals('POST') && n==1}">
		<div id="div_confirmResult">
			 ID : ${userid} 님의 암호가 새로이 변경되었습니다.<br/>
		</div>
	</c:if>
	
	<c:if test="${method.equals('GET')}">
		<div id="div_btnUpdate">
			<button style="background-color: #639EB0;" type="button" class="btn btn-success" id="btnUpdate">암호변경하기</button> 
		</div>
	</c:if>
	
	
	
	</div>
	</form>
	







