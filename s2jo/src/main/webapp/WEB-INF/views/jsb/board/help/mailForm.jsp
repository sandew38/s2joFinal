<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link
	href="http://code.jquery.com/ui/1.12.0-rc.2/themes/smoothness/jquery-ui.css"
	rel="Stylesheet"></link>
<script src="http://code.jquery.com/ui/1.12.0-rc.2/jquery-ui.js"></script>

<script type="text/javascript">

$(function(){
    $(".btn").click(function(){
    	if($("#tomail").val() == '' || $("#title").val()=='' || $("#content").val()==''){
    		alert("모든 항목을 입력해 주셔야 합니다");
    	}else{
    		var emailFrm = emailFrm.document;
    		/* emailFrm.action = "/khx/jsb/mailSending.action";
    		emailFrm.method = "POST"; */
    		emailFrm.submit();
    		alert("발송완료");
    	}
    });
	
    $("#tomail").on('keydown', function(e){
      
        var email = $(this).val();
      //30자 이상 못치도록 설정      
   if(pwd.length > 30) 
   {
         e.preventDefault();
   }
   
    }).on('blur', function(){ // 포커스를 잃었을때 실행합니다.
        if($(this).val() == '')
        	return;
        
        var email = $(this).val();
        
        // 입력값이 있을때만 실행합니다.
        if(email != null && email != '')
        {
            // 암호는 30자 이하 일때만 가능.
            if(email.length <= 30) 
            {   
                // 유효성 체크
                var regExp = /^[0-9a-zA-Z]([\-.\w]*[0-9a-zA-Z\-_+])*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}$/g;
                $(this).focus();
                if(regExp.test(email))
                {               
                    $(this).val(email);       
                }
                else
                { 
                	 alert("이메일 형식에 맞게 써주세요.");
                    $(this).val("");  
                }
            }
            else 
            {
            	 alert("이메일 형식에 맞게 써주세요.");
                $(this).val("");
              
            }
      }
  });  
});//end of 이메일 정규식 (오류 찾기)
</script>

<title>메일 보내기</title>
</head>
<body>
<div class="container">
  <h4>메일 보내기</h4>
  <form id="emailFrm" action="/khx/jsb/mailSending.action" method="post">
    <div align="center"><!-- 받으실 이메일 -->
      <input type="text" name="tomail" id="tomail" size="120" style="width:100%" placeholder="답장받으실 고객님의 이메일" class="form-control" >
    </div>     
    <div align="center"><!-- 제목 -->
      <input type="text" name="title" id="title" size="120" style="width:100%" placeholder="제목을 입력해주세요" class="form-control" >
    </div>
    <p>
    <div align="center"><!-- 내용 --> 
      <textarea name="content" id="content" cols="120" rows="12" style="width:100%; resize:none" placeholder="내용#" class="form-control"></textarea>
    </div>
    <p>
    <div align="center">
      <input type="submit" value="메일 보내기" class="btn btn-warning">
    </div>
  </form>
</div>
</body>
</html> 