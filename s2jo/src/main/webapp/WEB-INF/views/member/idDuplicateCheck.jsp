<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중복 ID 검사하기</title>

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/style.css">

<script type="text/javascript">


$(document).ready(function(){
   $(".myclose").keydown(function(event){
   //  현재 페이지를 새로고침을 함으로써 모달창에 입력한 성명과 휴대폰값이 텍스트박스에 남겨있지 않고 삭제하는 효과를 누린다.
       javascript:history.go(0);
   });
   $("#goCheck").keydown(function(event){
      if(event.keyCode == 13){//엔터를 눌렀을 경우

      var userid = document.getElementById("userid");
         if(!userid.value || userid.value.trim()=="") {
            // 자바스크립트에서 null 은 false 로 인식한다.   
                alert("아이디를 입력하세요!!");
               userid.value = "";
                userid.focus();
                $("#goCheck").attr('disabled', true);
      //          $(":input").attr('disabled', true).addClass('bgcol');    
            }
            else {
               var frmIdDuplicateCheck = document.frmIdDuplicateCheck; 
               frmIdDuplicateCheck.action="/idDuplicateCheck.action";
               frmIdDuplicateCheck.method="post"
               frmIdDuplicateCheck.submit();   
         

            }
         self.close();
         }
      });// end of goCheck()--------------
});



   
   function setUserID(userid) {
      var openerfrm = opener.document.registerFrm;
      // opener 는 팝업창을 열게한 부모창을 말한다.
      // 여기서 부모창은 memberRegisterForm.jsp 회원가입 페이지이다.
      openerfrm.userid.value = userid;
      openerfrm.pwd.focus();
      
      self.close();
      // 여기서 self 는 팝업창 자기자신을 말한다.
      // 지금의 self 는 idDuplicateCheck.jsp 페이지 이다.
   }

</script>

</head>
<body style="background-color: #fff0f5;">
<span style="font-size:10pt; font-weight: bold;">${method}</span>   

<c:if test="${method == 'GET'}">
<form name="frmIdDuplicateCheck">
   <table style="width: 95%; height: 90%;">
      <tr>
         <td style="text-align: center;">
               아이디를 입력하세요<br style="line-height: 200%;"/>
               <input type="text" id="userid" name="userid" size="20" class="box" /><br style="line-height: 300%;"/>
               <button type="button" class="box" id="goCheck" onClick="goCheck();">확인</button>
         </td>
      </tr>
   </table>
</form>
</c:if>

<c:if test="${method == 'POST'}">
   <c:if test="${isuserid == true}">
      <br style="line-height: 200%"/>
      <br style="line-height: 200%"/>   
      <div align="center">
         ID로 [<span style="color:red; font-weight: bold;">${userid}</span>]를 사용할 수 있습니다.
         <br/><br/><br/>
         <button type="button" class="myclose" onClick="setUserID('${userid}');">닫기</button>
      </div>
   </c:if>
   <c:if test="${isuserid == false}">
         <br style="line-height: 200%"/>   
         <div align="center">
            <span style="color:red; font-weight: bold;">[${userid}]는 이미 사용중입니다.</span>
         <br/>
            <form name="frmIdDuplicateCheck" action="/idDuplicateCheck.action" method="post">
                <table style="width: 95%; height: 90%;">
               <tr>
                 <td style="text-align: center;">
                  아이디를 입력하세요
                  <br style="line-height: 200%;"/>
                  <input type="text" id="userid" name="userid" size="20" class="box" />
                  <br style="line-height: 300%;"/>
                  <button type="button" class="box myclose" id="goCheck"onClick="goCheck();">확인</button>
                </td>
               </tr>
                </table>
               </form>
         </div>
   </c:if>

</c:if>

</body>
</html>
