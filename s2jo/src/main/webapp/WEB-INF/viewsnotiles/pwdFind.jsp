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
			pwdFindFrm.action = "/khx/pwdFind.action";
			pwdFindFrm.method = "POST";
			pwdFindFrm.submit();

		});
		
		if(method=="POST" && n==1) {
			$("#btnFind").hide();

		}
		else if(method=="POST" && (n == -1 || n == 0) ) {
			$("#btnFind").show();
		}
 		
		
		$("#btnConfirmCode").click(function(){
			if( "${certificationCode}" == $("#input_confirmCode").val() ) {

				var pwdFindFrm = document.pwdFindFrm;
				pwdFindFrm.action = "/khx/pwdConfirm.action";
				pwdFindFrm.method = "GET";   // 단순하게 폼만 띄워주는 것이므로
				pwdFindFrm.submit();
			}
			else {
				$("#input_confirmCode").val("");
			}
			
			
		}); 
		
		
	});

</script>

<form name="pwdFindFrm" style="margin-top: 50px;">
	<div align="center">
	<div id="div_userid">
		<span class="input-group-addon" style="color: white; font-size: 12pt;  background-color: #639EB0;">아이디</span>
		<input type="text" class="form-control" id="userid" name="userid" placeholder="아이디" required /> 
	</div>
	
	<div id="div_email" style="margin-top: 20px;">
		<span class="input-group-addon" style="color : white; font-size : 12pt; background-color: #639EB0;">이메일</span>
		<input type="text" class="form-control" id="email" name="email" placeholder="khx@gmail.com" required /> 
	</div><br/><br/><br/>

	<div id="div_btnFind" >
		<button style="background-color: #639EB0;" type="button" class="btn btn-primary" id="btnFind">찾기</button>
	</div>
	
	<div id="div_findResult">
		<c:if test="${n == 1}">
			<div id="pwdConfirmCodeDiv" style="background-color: #639EB0;">
				<input type="text" id="input_confirmCode" name="input_confirmCode" required /><br/><br/>	
				<span style="color: red;">이메일로 인증코드 번호를 발송하였습니다.</span><br/><br/>
				<button style="background-color: #639EB0;" type="button" class="btn btn-success" id="btnConfirmCode">인증하기</button>
			</div><br/>
		</c:if>
		
		<c:if test="${n == 0}">
			<span style="color: red;">사용자 정보가 없습니다.</span>
		</c:if>
		
		<c:if test="${n == -1}">
			<span style="color: red;">인증코드번호가 일치하지 않습니다. 다시 입력해주세요.</span>
		</c:if>
	</div>
	</div>
</form>





