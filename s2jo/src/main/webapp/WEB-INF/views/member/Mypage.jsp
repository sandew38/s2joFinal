<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="com.s2jo.khx.model.psc.khxpscMemberVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>

  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<!-- SWAL -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.css"
        rel="stylesheet">
<script src=" https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.common.min.js"></script>

</head>

<style type="text/css">
.containall {
width: 100%; 
text-align: center;
border: 0px gold solid;
font-size: large;
}
</style>


<script type="text/javascript">

$(document).ready(function(){

	$(".myInfo").addClass("active");
	
}); // end of ready ----
function goDeleteUser() {
	swal({
		  title: '정말 회원탈퇴 하시겠습니까?',
		  text: '회원탈퇴 요청 후 30일동안 서버에 저장된 후에 영구삭제 처리됩니다!',
		  type: 'warning',
		  
		  showCancelButton: true,
		  confirmButtonColor: '#639eb0',
		  cancelButtonColor: '#d33',
		  confirmButtonText: '회원탈퇴!'
		}).then(function () {

		  swal({title : '회원탈퇴 완료!!',
			    text : '회원탈퇴가 완료되었습니다. 다음에 또 만나요~!!',
			    type : 'success',
			    timer: 100000
		  })
			var userdelFrm = document.userdelFrm;
			userdelFrm.action = "/khx/UserIDDelete.action";
			userdelFrm.method = "get";
			userdelFrm.submit();
		})
}	
	

</script>



<div  align="center"style = " background-color:white; width:100%; height:100%; margin: auto; padding-top: 100px; ">
	<div align="center" style = " float: center; border : #4183D7 2px solid; border-radius: 50px;  width : 80%; height: 80%;">
		<div class="contentwrap" align="center" >
		
		   <article class="container"  style="width: 100%; text-align: center;" >

		      
				<div class = "containall" align="center">
					<div align="center" style="vertical-align:center; margin-top: 5%; display: inline-block; margin-right: 3%; margin-bottom: 5%; padding-top:5%; width: 90%;">
						<div class="well" style="text-align:left; width: 80%; height: 20%;"><span style="font-weight: bold; font-size: 12pt;"><span style="font-size: 14pt;">계정정보</span> <br/><br/> ${sessionScope.loginuser.userid} </span> 
							<div style="float: right;">	
								<label>
									<a href="<%=request.getContextPath()%>/MypagePwdFind.action"  style="text-align: right; font-size: 12pt;">비밀번호 변경 <span style="color: #639EB0;" class="glyphicon glyphicon-chevron-right"></span></a> &nbsp; 
								</label>
								<label>
									<a id="goDeleteUser" onclick="goDeleteUser();" style="text-align: right; font-size: 12pt;">회원탈퇴 <span style="color: #639EB0;" class="glyphicon glyphicon-chevron-right"></span></a>
									
								</label>
							</div>	
					    <br/><br/><br/>
						</div>
						<div class="well" style="text-align:left; width: 80%; height: 20%;">
							<span style="font-weight: bold; font-size: 12pt;">
								<span style="font-size: 14pt;">이메일주소</span> 
								<br/><br/> 
								${sessionScope.loginuser.email} 
							</span>
							<div style="float: right;">	
								<label>
									<a href="<%=request.getContextPath()%>/lsk/bookingcheck.action"  style="text-align: right; font-size: 12pt;">예매확인/변경/취소 
									<span style="color: #639EB0;" class="glyphicon glyphicon-chevron-right"></span>
									</a>
								</label>	
							</div> 
						</div>
					</div>
				<button style="background-color: #639EB0; margin-bottom: 5%;" type="button" class= "btn btn-primary" > 내정보 변경하러 가기 </button>
								
				<br/><br/><br/>
				</div> 
		    </article>
		</div>
	 </div>
</div>
    
     <form name="userdelFrm">
      <input type = "hidden" id="deleteuserid" name="deleteuserid" value = "${sessionScope.loginuser.userid}">
      </form>