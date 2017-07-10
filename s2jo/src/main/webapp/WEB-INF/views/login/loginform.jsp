<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.s2jo.khx.model.psc.khxpscMemberVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  </head>


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

.form-group input[type="checkbox"] {
    display: none;
}

.form-group input[type="checkbox"] + .btn-group > label span {
    width: 20px;
}

.form-group input[type="checkbox"] + .btn-group > label span:first-child {
    display: none;
}
.form-group input[type="checkbox"] + .btn-group > label span:last-child {
    display: inline-block;   
}

.form-group input[type="checkbox"]:checked + .btn-group > label span:first-child {
    display: inline-block;
    height: 20px;
}
.form-group input[type="checkbox"]:checked + .btn-group > label span:last-child {
    display: none;   
    
}

</style>


<script type="text/javascript">


$(document).ready(function(){
    
    $("#btnLOGIN").click(function(event){
	  
       var userid = $("#userid").val(); 
       var pwd = $("#pwd").val(); 
     
       if(userid.trim()=="") {
		alert("정회원 아이디를 입력하세요!!");
          $("#userid").val(""); 
          $("#userid").focus();
          event.preventDefault();
          return;
       }
       
      
       if(pwd.trim()=="") {
		alert("정회원 비밀번호를 입력하세요!!");    	   
          $("#pwd").val(""); 
          $("#pwd").focus();
          event.preventDefault();
          return;
       }
       document.loginFrm.action = "/khx/loginEnd.action";
       document.loginFrm.method = "post";
       document.loginFrm.submit();

   }); // end of $("#btnLOGIN").click();-----------------------

	
   $("#pwd").keydown(function(event){
      
      if(event.keyCode == 13) { // 엔터를 했을 경우
         
      var userid = $("#userid").val(); 
      var pwd = $("#pwd").val(); 
          
     
       if(userid.trim()!=""&& pwd.trim()!=""){
    	   document.loginFrm.action = "/khx/loginEnd.action";
    	      document.loginFrm.method = "post";
    	      document.loginFrm.submit();
       }
       
       
       if(userid.trim()=="") {
          // sweetAlert("","정회원 아이디를 입력하세요!!","warning");
		alert("정회원 아이디를 입력하세요!!");
         $("#userid").val(""); 
        $("#userid").focus();
         event.preventDefault();

        return;
      }
      
      if(pwd.trim()=="") {
          //sweetAlert("","정회원 비밀번호를 입력하세요!!","info");
		alert("정회원 비밀번호를 입력하세요!!");
         $("#pwd").val(""); 
        $("#pwd").focus();
         event.preventDefault();//버튼이 비활성화 되게 하는것
         return;
      }
      }
      
   
   }); // end of $("#pwd").keydown();-----------------------

   
}); //end of $(document).ready(function(){

//암호 정규식 (오류 찾기)
$(function(){
    
    $("#pwd").on('keydown', function(e){
        $(".help-block-userid").hide();
        var pwd = $(this).val();
      //15자 이상 못치도록 설정      
   if(pwd.length >15) 
   {
         e.preventDefault();
   }
   
    }).on('blur', function(){ // 포커스를 잃었을때 실행합니다.
        if($(this).val() == '') return;
        var pwd = $(this).val();
        
        // 입력값이 있을때만 실행합니다.
        if(pwd != null && pwd != '')
        {
            // 암호는 8자 이상 15자 이하 일때만 가능.
            if(pwd.length >= 8 && pwd.length <= 15) 
            {   
                // 유효성 체크
                var regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
                if(regExp.test(pwd))
                {               
                    $(this).val(pwd);
                    $(".help-block-pwd").hide();
                }
                else
                {
                   $(".help-block-pwd").show();
                    $(this).val("");
                    $(this).focus();
                }
            }
            else 
            {
               $(".help-block-pwd").show();
                $(this).val("");
                $(this).focus();
            }
      }
  });  
});//end of 암호 정규식 (오류 찾기)
</script>

<%


khxpscMemberVO kmvo = (khxpscMemberVO)session.getAttribute("loginuser");

   
   System.out.println("확인============>" + kmvo);

   if(kmvo == null){
      Cookie[] cookieArr = request.getCookies();
      
      String cookie_key = "";
      String cookie_value = "";
      boolean isuseridsaved = false;
      
      if(cookieArr != null){
         
         for(Cookie cobj : cookieArr){
            
            cookie_key = cobj.getName(); //쿠키의 이름(키 값)을 꺼내오는 메소드.
            
            if(cookie_key.equalsIgnoreCase("saveuserid")){
               
               cookie_value = cobj.getValue();//쿠키의 value 값을 꺼내오는 메소드.
               System.out.println("cookie_key 확인============>" + cookie_key);
               System.out.println("cookie_value 확인============>" + cookie_value);
               isuseridsaved = true;
               break; //for 문 탈출
               
            }//end of if(Cookienhp_key.equals("savenhp")){
            
         }//end of for(Cookie NCobj : CookieArr){
         
      }//end of if(CookieArr != null){
%>

<div style="background-color:white; width:100%; height:100%; margin: auto; border: solid 0px red; padding-top: 100px;">
   <div class="omb_login">
       <h3 class="omb_authTitle">정회원로그인 or <a href="<%=request.getContextPath()%>/memberRegister.action" >회원가입</a></h3>
      <div class="row omb_row-sm-offset-3 omb_socialButtons">
           <div class="col-xs-4 col-sm-2">
              <a href="<%=request.getContextPath() %>/nonloginform.action" class="btn btn-lg btn-block omb_btn-facebook">
                 <i class="fa fa-facebook visible-xs"></i>
                 <span class="hidden-xs btn btn-lg">비회원 로그인</span>
             </a>
           </div>
           <div class="col-xs-4 col-sm-2">
              <a href="<%=request.getContextPath() %>/loginform.action" class="btn btn-lg btn-block omb_btn-twitter">
                 <i class="fa fa-twitter visible-xs"></i>
                 <span class="hidden-xs btn btn-lg">정회원 로그인</span>
              </a>
           </div>   
           <div class="col-xs-4 col-sm-2">
<%--               <a href="<%=request.getContextPath() %>/loginform.action" class="btn btn-lg btn-block omb_btn-google">
 --%>
              <a class="btn btn-lg btn-block"  style="background-color: #1FBC02"
              href="javascript:void(window.open('https://nid.naver.com/nidlogin.login'))">
                 <i class="fa fa-google-plus visible-xs"></i>
                 <span class="hidden-xs btn btn-lg">
                 <span style="font-weight: bold; color: white">N</span> &nbsp;
                	네이버아이디로그인</span>
              </a>
           </div>   
      </div>


      <div class="row omb_row-sm-offset-3 omb_loginOr">
         <div class="col-xs-12 col-sm-6">
            <hr class="omb_hrOr">
            <span class="omb_spanOr">or</span>
         </div>
      </div>
         <p align="center" style="font-size:14px;"><span style="color: #639EB0">통합 예매 홈페이지</span>는 네이버 회원 아이디와 비밀번호로 이용이 가능합니다.</p>
      <br/>
      
      <form name="loginFrm" id="loginFrm" class="loginFrm">
         <div class="row omb_row-sm-offset-3">
            <div class="col-xs-12 col-sm-6">   
                <form class="omb_loginForm" action="" autocomplete="off" method="POST">
                  <%-- 아이디 저장(userid) 구문 --%>
                  <div class="input-group">
                     <span class="input-group-addon"><i class="fa fa-user"></i></span>
                     <input type="text" class="form-control" name="userid" id="userid" placeholder="회원아이디"
                     <%
                        if(isuseridsaved){
                     %>
                        value="<%= cookie_value %>"
                     <%      
                        }else{ %>
                      value= ""      
                     <%   }
                     %>/>
                  </div>
                  <span class="help-block"></span>
                                 
                  <div class="input-group">
                     <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                     <input  type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호" style="color : black;">
                  </div>
      <br/><br/>
                  <button class="btn btn-lg btn-primary btn-block" type="button" id="btnLOGIN">Login</button>
               </form>
            </div>
          </div>
      </form>
      <form id="form1" runat="server" >
      <fieldset>
      <div>
      <%-- 아이디 저장(userid)구문 --%>
<div class="[ col-xs-13 col-sm-6 ]" >
    <div class="[ form-group ]" style="padding-right: 210px;" align="right">
        <input  type="checkbox" name="saveuserid fancy-checkbox-info" id="saveuserid fancy-checkbox-info" checked="checked" autocomplete="off" />
        <div class="[ btn-group ]">
            <label for="saveuserid fancy-checkbox-info" class="[ btn btn-info ]">
                <span class="[ glyphicon glyphicon-ok ]"></span>
                <span> </span>
            </label>
         <%if(isuseridsaved)
         { %>
            <label style="background-color: white;" for="saveuserid fancy-checkbox-info" class="[ btn btn-default active ]" >
            Remember ID
            </label>
         <%}else{%>
            <label style="background-color: white;" for="saveuserid fancy-checkbox-info" class="[ btn btn-default active ]" >
            Remember ID
            </label>
         <%}   %>
        </div>
    </div>
</div>
 
    

     
    <%         
   }//end of if(knmvo == null){
%>          <%-- 비밀번호 찾기 Modal 출력하는 버튼위치 --%>
         <div class="col-xs-12 col-sm-3">
            <p class="omb_forgotPwd" >
                     <img src = "<%=request.getContextPath()%>/resources/images/forgotPW.png"style="height: 30px; width: 30px;">
             			<a data-toggle="modal" data-target="#passwdFind" data-dismiss="modal">forgot Password?</a>
            </p>
         </div>
         
			<%-- 비밀번호 찾기 Modal 첫번째 창, 인증코드 발송해서 인증코드 입력하는 칸 만들고, 인증코드발송한것과 이메일에 있는 인증코드 일치하면 인증완료되었습니다 !!띄워주고
				비밀번호변경 버튼을 만들어서 클릭하면 두번째 모달창에서 비밀번호 변경시켜주고 비밀번호 변경이 완료되었습니다! 출력해주기 --%>
			  <div class="modal fade" id="passwdFind" role="dialog">
			    <div class="modal-dialog">
			
				<!-- Modal content-->
			      <div class="modal-content">
			      
			        <div class="modal-header"  style="color:white; background-color: #639EB0;">
			          <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
			          <h3 class="modal-title" align="center">비밀번호 찾기</h3>
			        </div>
			        
			        <div class="modal-body" style="height: 400px; width: 100%;" align="center">
				        <div id="pwFind">
							<iframe style="border: none; width: 100%; height: 350px;" src="<%= request.getContextPath() %>/pwdFind.action"></iframe>				          
						</div>
			        </div>
			        <div class="modal-footer">
				          <button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>

			        </div>
			      </div>	
			    </div>
			  </div>
     
     
     
     				<%-- 비밀번호 찾기 Modal 두번째 창, 인증코드 발송해서 인증코드 입력하는 칸 만들고, 인증코드발송한것과 이메일에 있는 인증코드 일치하면 인증완료되었습니다 !!띄워주고
					비밀번호변경 버튼을 만들어서 클릭하면 두번째 모달창에서 비밀번호 변경시켜주고 비밀번호 변경이 완료되었습니다! 출력해주기 --%>
				  <div class="modal fade" id="passwdChange" role="dialog">
				    <div class="modal-dialog">
				    	<div class="modal-content">
				      
				        <div class="modal-header"  style="color:white; background-color: #639EB0;">
				          <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
				          <h3 class="modal-title" align="center" >비밀번호 찾기</h3>
				        </div>
				        
				        <div class="modal-body" style="height: 400px; width: 100%;" align="center">
		          <div id="pwdConfirm">
				<iframe style="border: none; width: 100%; height: 350px;" src="<%= request.getContextPath() %>/pwdConfirm.action"></iframe>				          
				</div>
				        </div>
				        <div class="modal-footer">
				          <button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>
				        </div>
				      </div>	
				
				    </div>
				  </div>
    		</div> 
      		</fieldset>
		</form>        
   </div>
</div>


  