


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<head>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/js/jquery-ui.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>



    <title>DASHGUM - Bootstrap Admin Template</title>

    <!-- Bootstrap core CSS -->
    <link href="<%= request.getContextPath() %>/resources/assets/css/bootstrap.css" rel="stylesheet">
    <!--external css-->
    <link href="<%= request.getContextPath() %>/resources/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        
    <!-- Custom styles for this template -->
    <link href="<%= request.getContextPath() %>/resources/assets/css/style.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/resources/assets/css/style-responsive.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

<style>

#sclock{
 background:url("<%=request.getContextPath()%>/resources/images/khxbackground.png") no-repeat;
	background-size: 100%;
	width : 100%;
	height: 100%;
}


</style>

 <script>

 var ref= "<?=$_SERVER['http://localhost:9090/khx/screenlock.action']?>";
 if(ref=='http://localhost:9090/khx/screenlock.action'){
	 history.pushState(null,null,location.href);
	 window.onpopstate = function(event) {history.go(1);}
	 
 }
 
 
 
 function move(){
 
	 location.replace("http://localhost:9090/khx/screenlock.action");
 }

 
 
 
 
/* 
 window.onbeforeunload = function(){
   alert("재로그인을 통하여 로그인 해주십시오.");
  
   doExit();

   }
 */ 
     $(document).ready(function(){
    	 
    	
     });
     
      function goAdminPwd(){
  
            var realpwd = $("#realpwd").val();
            if(realpwd.trim()==""){
      
            	alert("비밀번호를 입력하세요 !!");	
             $("#realpwd").val("");
             $("#realpwd").focus();
             event.preventDefault();
              return;
            }
            /* location.href="registerusilyyj.action"; */
          
            if(!(realpwd =='qwer1234$')){
            	alert("비밀번호가 틀렸습니다.");
            }
            else{
            	alert(" 재로그인을 환영합니다 !!");
            	 location.href="khxyyj.action";
            }
            
     }
     
    
     
     
     
     
  
        function getTime()
        {
            var today=new Date();
            var h=today.getHours();
            var m=today.getMinutes();
            var s=today.getSeconds();
            // add a zero in front of numbers<10
            m=checkTime(m);
            s=checkTime(s);
            document.getElementById('showtime').innerHTML=h+":"+m+":"+s;
            t=setTimeout(function(){getTime()},500);
        }

        function checkTime(i)
        {
            if (i<10)
            {
                i="0" + i;
            }
            return i;
        }

        <%--
         --%>
            
        </script>



<div id="sclock">
 
  <body onload="getTime()">


	  	<div class="container">
	  	
	  		<div id="showtime"></div>
	  			<div class="col-lg-4 col-lg-offset-4">
	  				<div class="lock-screen">
		  				<h2><a data-toggle="modal" href="#myModal"><i class="fa fa-lock"></i></a></h2>
		  				<p>UNLOCK</p>
		  				
				          <!-- Modal -->
				          <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
				              <div class="modal-dialog">
				                  <div class="modal-content">
				                      <div class="modal-header">
				                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				                          <h4 class="modal-title">Welcome Back</h4>
				                      </div>
				                      <div class="modal-body">
				                          <p class="centered"><img class="img-circle" width="80" src="resources/assets/img/ui-sam.jpg"></p>
				                          <input id="realpwd" name="pwd" type="password" name="password" placeholder="Password" autocomplete="off" class="form-control placeholder-no-fix">
				
				                      </div>
				                      <div class="modal-footer centered">
				                          <button data-dismiss="modal" class="btn btn-theme04" type="button">Cancel</button>
				                          <button class="btn btn-theme03" type="button" onClick="goAdminPwd();">Login</button>
				                      </div>
				                  </div>
				              </div>
				          </div>
				          <!-- modal -->
		  				
		  				
	  				</div><! --/lock-screen -->
	  			</div><!-- /col-lg-4 -->
	  	
	  	</div><!-- /container -->

    <!-- js placed at the end of the document so the pages load faster -->
     <script src="resources/assets/js/jquery.js"></script>
     <script src="resources/assets/js/bootstrap.min.js"></script>
x	
    <!--BACKSTRETCH-->
    <!-- You can use an image of whatever size. This script will stretch to fit in any screen size.-->
   <script type="text/javascript" src="resources/assets/js/jquery.backstretch.min.js"></script>
  <!--   <script>
        $.backstretch("/assets/img/login-bg.jpg", {speed: 500});
    </script> -->
   
  </body>
</html>




