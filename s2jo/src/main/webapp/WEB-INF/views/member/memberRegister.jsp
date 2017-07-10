<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="com.s2jo.khx.model.psc.khxpscMemberVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"   href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script   src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script   src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style>
.omb_btn-twitter {
   background: #00aced;
   color: white;
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

.help-block{
   font-weight: bold;
   color:red;
   
}
</style>


<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">


$(document).ready(function(){
  
   searchKeep();
   $(".help-block-pwdCheck").hide();   
   $(".help-block-pwd").hide();
   $(".help-block-email").hide();
   $(".help-block-birth").hide();
   $(".help-block-hp").hide();
   
   $("#userid").click(function(){
      
       $("#idcheckModal").click();
       
       if(event.keyCode == 13){
          
          
       }
       
       });
     
   
   $("#idcheck").click(function(){
      //아이디 중복검사
    
      var useridforcheck = $("#useridforcheck").val();

      if(!useridforcheck || useridforcheck.trim() =="")
         {
         sweetAlert("","아이디를 입력해주세요!","warning");
         useridforcheck.focus();
         }
      
      var form_data = { useridforcheck : useridforcheck }; //HashMap의 키값: 밸류값

      $.ajax({
         url: "/khx/idDuplicateCheck.action",
         type: "GET",
         data: form_data,
         dataType: "JSON",
         success: function(data){
            var resultHTML = "";   
            if(data==1){//중복인경우
                    resultHTML = "<span id='result' style='color:red; font-weight: bold; font-size:14pt;'>"+"중복된 id입니다."+"</span>"
                    
                    
                    }else if(data==0){//중복되지않는경우
                    resultHTML = "<span id='result' style='color:red; font-weight: bold; font-size:14pt;'>"+"사용하실 수 있는 id입니다."+"</span>"
                    
               }
               $("#idcheckresult").html(resultHTML);
               

         },//end of success
         error: function(){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error); 
      }//end of error
         
      });//end of $.ajax
    
    });// end of $("#idcheck").click() -----------
    
    
 
    
    $("#pwd").click(function(){
       $(".help-block-userid").hide();
    });
    $("#pwdCheck").click(function(){
       $(".help-block-userid").hide();
    });
    $("#email").click(function(){
       $(".help-block-userid").hide();
    });
    $("#birth").click(function(){
       $(".help-block-userid").hide();
    });
    $("#hp").click(function(){
       $(".help-block-userid").hide();
    });
    $("#post").click(function(){
       $(".help-block-userid").hide();
    });


   //우편주소 찾기  
   $("#zipcodeSearch").click(function(){
      
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 도로명 조합형 주소 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }
            // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
            if(fullRoadAddr !== ''){
                fullRoadAddr += extraRoadAddr;
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('post').value = data.zonecode; //5자리 새우편번호 사용
            
            var post = document.getElementById('post').value;
            
            // 입력값이 있을때만 실행합니다.
            if(post != null && post != '')
            {
               postbool = true;
            }
            document.getElementById('addr1').value = fullRoadAddr;       
        }
    }).open();
    


   });// end of $("#zipcodeSearch").click()-------------
   
   
   

   // 회원가입
   $("#btnRegister").click(function(){
      
      var flagBool = false;
      
      $(".requiredInfo").each(function(){
         var data = $(this).val().trim();
         if(data.length == 0) {
            flagBool = true;
            // for 문에서의 continue 와 동일한 기능을 하는 것이
            // each(); 내에서는 return true; 이고
            // for 문에서의 break 와 동일한 기능을 하는 것이
            // each(); 내에서는 return false; 이다.
            return false;  // 마치 for문에서의 break; 와 동일한 기능임.
         }
      });
      
      if(flagBool) {
         sweetAlert("","필수입력란은 모두 입력하셔야 합니다!","warning");
         event.preventDefault();   // click event 를 작동치 못 하도록 한다.
      }
      else if(!$("#agree").is(":checked")) {  // $(":checked") 은 All checked input elements 을 말한다. 참조 w3school jQuery Selectors 볼것!!
         
         sweetAlert("","이용약관에 동의하셔야 합니다!","warning");
      
         event.preventDefault(); // click event 를 작동치 못하도록 한다.
      }
      else {
          sweetAlert("","회원가입 완료! KHX Family가 된것을 진심으로 축하드립니다!","warning");

            var frm = document.registerFrm;
            frm.method="post";
            frm.action="/khx/memberRegisterEnd.action";
            frm.submit();
         
      }
      
   });// end of goRegister(event)---------------------

   
});// end of $(document).ready()----------------
 

// 모달창 닫을 때 중복확인한 값 넣어주기
function closeandinput()
{
   var result = document.getElementById("result").innerHTML;
   var n = result.search("사용");
   
   /* ★★ search 메소드 ★★
   
   일치하는 부분이 있으면, 
   search 메소드가 처음으로 일치하는 문자열의 시작 부분에서 오프셋을 나타내는 정수 값을 반환한다.
   
   일치하는 부분이 없으면 -1을 반환한다.
   
   */
   var userid = $("#userid").val();
   var useridforcheck = $("#useridforcheck").val();
   
   if(n!=-1)
   {   // result span태그에 "사용"이라는 단어가 들어가 있는 경우 -1이 아닌 값을 반환!
      
      $("#userid").val(useridforcheck);
//      $("#userid").attr('disabled', true);//disabled쓰니까 userid 배열값을 db에 가져가지 못한다.
      
      // alert("사용 가능합니다!");
   }
   else
   {   // result span태그에 "사용"이라는 단어가 들어있지 않은 경우 -1값을 반환!
      
//      $("#userid").attr('disabled', false);

   }
   
   
}

 
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

//암호 체크 == 암호 와 같은지 확인하기(오류 찾기)
$(function(){
    
    $("#pwdCheck").on('keydown', function(e){
    
        var pwdCheck = $(this).val();
       //15자 이상 못치도록 설정         
   if(pwdCheck.length >15) 
   {
         e.preventDefault();
   }
   
    }).on('blur', function(){ // 포커스를 잃었을때 실행합니다.
        if($(this).val() == '') return;
        var pwd = $("#pwd").val();
        var pwdCheck = $(this).val();
        
        // 입력값이 있을때만 실행합니다.
        if(pwdCheck == pwd)
        {           
               $(this).val(pwd);
               $(".help-block-pwdCheck").hide();              
      }else {
         $(".help-block-pwdCheck").show();
          $(this).val("");
          $(this).focus();
      }
  });  
});//end of 암호 체크 == 암호 와 같은지 확인하기(오류 찾기)


//이메일 정규식 (오류 찾기)
$(function(){
    
    $("#email").on('keydown', function(e){
      
        var email = $(this).val();
      //30자 이상 못치도록 설정      
   if(pwd.length > 30) 
   {
         e.preventDefault();
   }
   
    }).on('blur', function(){ // 포커스를 잃었을때 실행합니다.
        if($(this).val() == '') return;
        var email = $(this).val();
        
        // 입력값이 있을때만 실행합니다.
        if(email != null && email != '')
        {
            // 암호는 30자 이하 일때만 가능.
            if(email.length <= 30) 
            {   
                // 유효성 체크
                var regExp = /^[0-9a-zA-Z]([\-.\w]*[0-9a-zA-Z\-_+])*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}$/g;
                if(regExp.test(email))
                {               
                    $(this).val(email);
                    $(".help-block-email").hide();
                }
                else
                {
                   $(".help-block-email").show();
                    $(this).val("");
                    $(this).focus();
                }
            }
            else 
            {
               $(".help-block-email").show();
                $(this).val("");
                $(this).focus();
            }
      }
  });  
});//end of 이메일 정규식 (오류 찾기)

//생일 정규식 (오류 찾기)
$(function(){
    
    $("#birthday").on('keydown', function(e){
       // 숫자만 입력받기
        var birthday = $(this).val();
      var k = e.keyCode;
            
   if(birthday.length >= 8 && ((k >= 48 && k <=126) || (k >= 12592 &&k<= 12687 || k==32 || k==229 || (k>=45032 && k<=55203)) )) 
   {
         e.preventDefault();
   }
   
    }).on('blur', function(){ // 포커스를 잃었을때 실행합니다.
        if($(this).val() == '') return;
        var birthday = $(this).val();
        
        // 입력값이 있을때만 실행합니다.
        if(birthday != null && birthday != '')
        {
            // 총 핸드폰 자리수는 11글자이거나, 10자여야 합니다.
            if(birthday.length==8) 
            {   
                // 유효성 체크
                var regExp = /[12][0-9]{3}[01][0-9][0-3][0-9]/;
                if(regExp.test(birthday))
                {               
                    $(this).val(birthday);
                    $(".help-block-birth").hide();
                }
                else
                {
                   $(".help-block-birth").show();
                    $(this).val("");
                    $(this).focus();
                }
            }
            else 
            {
               $(".help-block-birth").show();
                $(this).val("");
                $(this).focus();
            }
      }
  });  
});//end of 생일 정규식 (오류 찾기)




//핸드폰번호 정규식 (오류 찾기)
$(function(){
    
    $(".phone-number-check").on('keydown', function(e){
       // 숫자만 입력받기
        var trans_num = $(this).val().replace(/-/gi,'');
   var k = e.keyCode;
            
   if(trans_num.length >= 11 && ((k >= 48 && k <=126) || (k >= 12592 &&k<= 12687 || k==32 || k==229 || (k>=45032 && k<=55203)) ))
   {
         e.preventDefault();
   }
   
    }).on('blur', function(){ // 포커스를 잃었을때 실행합니다.
        if($(this).val() == '') return;
 
        // 기존 번호에서 - 를 삭제합니다.
        var trans_num = $(this).val().replace(/-/gi,'');
      
        // 입력값이 있을때만 실행합니다.
        if(trans_num != null && trans_num != '')
        {
            // 총 핸드폰 자리수는 11글자이거나, 10자여야 합니다.
            if(trans_num.length==11 || trans_num.length==10) 
            {   
                // 유효성 체크
                var regExp_ctn = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;
                if(regExp_ctn.test(trans_num))
                {                         
                    $(this).val(trans_num);
                    $(".help-block-hp").hide();
                }
                else
                {
                   $(".help-block-hp").show();
                    $(this).val("");
                    $(this).focus();
                }
            }
            else 
            {
               $(".help-block-hp").show();
                $(this).val("");
                $(this).focus();
            }
      }
  });  
});//end of //핸드폰번호 정규식 (오류 찾기)

 function searchKeep(){//zipcode에서 검색어를 유지시켜주는 역할을 해준다.
   <c:if test="${not empty colname && not empty search}">
      $("#colname").val("${colname}"); // 검색어 컬럼명을 유지시켜 주겠다.
      $("#search").val("${search}");   // 검색어를 유지시켜 주겠다.
   </c:if>
}


   $(".myclose").click(function(){
      
         
      //  현재 페이지를 새로고침을 함으로써 모달창에 입력한 성명과 휴대폰값이 텍스트박스에 남겨있지 않고 삭제하는 효과를 누린다.
          javascript:history.go(0);
      
       /* === 새로고침(다시읽기) 방법 3가지 차이점 ===
              
           1. window.location.reload();
            ==> 우선 컴퓨터의 캐쉬에서 파일을 찾아서 읽어오고 
                 캐쉬에 파일이 없으면 서버(웹서버)에서 받아온다. 
                 이것이 일반적인 방법이다.
      
          2. window.location.reload(true);
            ==> 무조건 서버(웹서버)에서 파일을 다시 받아온다. 
                  캐쉬는 완전히 무시한다.
          
          3. javascript:history.go(0);
            ==> 컴퓨터의 캐쉬에서 파일을 찾아서 읽어온다. 
      */
      });



</script>







<div style="background-color: white; width: 100%; height: 100%; margin: auto; border: solid 0px red; padding-top: 100px; margin-bottom: 100px;">
<div align="center" style="color:white; background-color:#639EB0;  width: 60%; height: 30px; margin-left: 20%;padding-bottom: 5%; margin-bottom: 30px; display: inline-block;" >
            <h2>회원가입</h2> 
</div>
   <div style="padding-top:30px; background-color: white; float: left; position: relative; border: #639EB0 2px solid; width: 60%; margin-left: 20%; display: inline-block; min-height: 100%; margin-bottom: 100px;"align="center">
      <div class="contentwrap" align="left">
         <article class="container">
        
            <form name="registerFrm" class="form-horizontal" style="padding-top:30px;">
               <div class="form-group">
                  <label for="inputUserid" class="col-sm-2 control-label">아이디 *</label>
                  <div class="col-sm-2">
                     <input type="text" class="form-control requiredInfo" id="userid" name="userid" required placeholder="아이디">
                  </div>
                  <div class="col-sm-1">

                     <%-- trigger the modal with a button, 회원가입 창에서의 id 중복확인 --%>
                     <button name="idcheck" id="idcheckModal" type="button" style="background-color: #639EB0" class="btn omb_btn-twitter" data-toggle="modal" data-target="#myModal">ID중복확인</button>

                     <div class="modal fade" id="myModal" role="dialog">
                        <div class="modal-dialog">
                           <!-- Modal content-->
                           <div class="modal-content">
                              <div class="modal-header"  style="color:white; background-color: #639EB0;">
                                 <button type="button" class="close myclose"   data-dismiss="modal">&times;</button>
                                 <h3 class="modal-title" align="center" >ID중복확인</h3>
                              </div>

                              <div class="modal-body" style="height: 400px; width: 100%;" align="center">
                                 <p>
                                 <h4>아이디를 입력하세요</h4>
                                 <br /> <input type="text" class="form-control" name="useridforcheck" id="useridforcheck" placeholder="아이디" />
                                 <br />
                                 </p>

                                 <div id="idcheckresult"></div>
                                 <br />
                                 <button type="button" style="background-color: #639EB0;" class="btn omb_btn-twitter" id="idcheck" name="idcheck">확인</button>
                              </div>

                              <div class="modal-footer">
                                 <button type="button" class="btn omb_btn-twitter " style="background-color: #639EB0;" data-dismiss="modal" onclick="closeandinput();">Close</button>
                              </div>
                           </div>

                        </div>
                     </div>
                  </div>
               </div>


               <div class="form-group">
                  <label for="inputName" class="col-sm-2 control-label">이름 *</label>
                  <div class="col-sm-4">
                     <input type="text" class="form-control requiredInfo" id="name"
                        name="name" required placeholder="이름">
                  </div>
               </div>


               <div class="form-group">
                  <label for="inputPassword" class="col-sm-2 control-label">비밀번호 *</label>
                  <div class="col-sm-4">
                     <input type="password" class="form-control requiredInfo" id="pwd" name="pwd" required placeholder="비밀번호">
                     <p class="help-block-pwd">영문,숫자, 특수문자 포함 8자 이상</p>
                  </div>
               </div>
               <div class="form-group">
                  <label for="inputPasswordCheck" class="col-sm-2 control-label">비밀번호 확인 *</label>
                  <div class="col-sm-4">
                     <input type="password" class="form-control requiredInfo" id="pwdCheck" name="pwdCheck" required placeholder="비밀번호 확인">
                     <p class="help-block-pwdCheck">암호와 일치하지 않습니다..</p>
                  </div>
               </div>

               <div class="form-group">
                  <label for="inputEmail" class="col-sm-2 control-label">이메일 *</label>
                  <div class="col-sm-4">
                     <input type="email" class="form-control requiredInfo" id="email" name="email" required placeholder="khx@gmail.com">
                     <p class="help-block-email">이메일을 정확히 적어주세요</p>
                  </div>
               </div>
               <div class="form-group">
                  <label for="inputNumber" class="col-sm-2 control-label">휴대폰번호</label>
                  <div class="col-sm-4">
                     <input type="text" class="form-control phone-number-check"
                        id="hp" name="hp" placeholder="휴대폰번호(- 없이 적어주세요.)">
                     <p class="help-block-hp">유효하지 않은 번호 입니다.(- 없이 적어주세요.)</p>
                  </div>
               </div>

               <div class="form-group">
                  <input type="hidden" id="chkpost"> 
                     <label for="inputName" class="col-sm-2 control-label">우편번호 *</label>
                  <div class="col-sm-2">
                     <input type="text" readonly="readonly" class="form-control requiredInfo" id="post" name="post" placeholder="우편번호">
                  </div>
                  <div class="col-sm-1">
                     <button id="zipcodeSearch" type="button" style="background-color: #639EB0;" class="btn omb_btn-twitter">주소찾기</button>
                  </div>
               </div>
               <div class="form-group">
                  <label for="inputName" class="col-sm-2 control-label">주소 *</label>
                  <div class="col-sm-6">
                     <input type="text" readonly="readonly" class="form-control requiredInfo" id="addr1" name="addr1" placeholder="도로명주소(주소찾기로 찾아주세요)"> 
                     <input type="text" class="form-control" id="addr2" name="addr2" placeholder="상세주소" style="margin-top: 5px;">
                  </div>
               </div>



               <div class="form-group">
                  <label for="inputNumber" class="col-sm-2 control-label">생년월일 *</label>
                  <div class="col-sm-4">
                     <input type="text" class="form-control requiredInfo" id="birthday" name="birthday" required   placeholder="생년월일 (ex.19930308)">
                     <p class="help-block-birth" style="color: red; font-weight: bold;">생년월일을 정확히 적어주세요</p>
                  </div>
               </div>
               <div class="form-group">
                  <label for="inputNumber" class="col-sm-2 control-label">성별 *</label>
                  <div class="col-sm-1">
                     <select class="form-control" name="gender" id="gender">
                        <option value="1" selected>남</option>
                        <option value="2">여</option>
                     </select>
                  </div>
               </div>



               <div class="form-group">
                  <label for="inputAgree" class="col-sm-2 control-label">약관 동의</label>
                  <div class="col-sm-8" style="margin-bottom: 30px;">
                     <iframe src="<%=request.getContextPath()%>/agree/agree2.html" width="87%" height="150px" class="box" style="border: 1px solid #ccc; margin-top: 10px;">
                     </iframe>
                  </div>

                  
                    <div class="[ col-xs-12 col-sm-6 ]" style="margin-left: 190px;">
                           <input style="background-color: #639EB0;" type="checkbox" name="fancy-checkbox-info" id="fancy-checkbox-info" autocomplete="off" />
                           <div class="[ btn-group ]">
                               <label  style="background-color: #639EB0;"  for="fancy-checkbox-info" class="[ btn btn-info ]">
                                   <span class="[ glyphicon glyphicon-ok ]"></span>
                                   <span> </span>
                               </label>
                               <label style="background-color: white;" for="fancy-checkbox-info" class="[ btn btn-default active ]">
                                   <input id="agree" type="checkbox" checked> 이용약관에 동의합니다!
                               </label>
                               
                           </div>
                  </div>
               </div>
               <div class="form-group" >
                  <label for="inputName" class="col-sm-2 control-label"></label>
                  <div class="col-xs-30 col-sm-7" align="left" >
                     <button  style="background-color: #639EB0;" type="button" id="btnRegister" onclick="btnRegister" class="btn btn-block omb_btn-twitter">회원가입</button>
                  </div>
               </div>
            </form>
         </article>

      </div>
   </div>
</div>