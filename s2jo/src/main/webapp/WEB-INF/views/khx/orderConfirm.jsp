<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style type="text/css">

.yjcontent
{
	font-family: 나눔고딕;
}

table, td 
{
	padding-left: 2%;
	padding-rigt: 2%;
	padding-bottom: 2%; 
	border : 0px solid #639EB0;
}

.bold
{
	font-weight: bold;
	color : #639EB0;
	text-align: center;
}

.tdcontainer
{
	padding-left: 3%;
}

/* progress bar 관련 css */
body{margin:40px;}

.stepwizard-step p {
    margin-top: 10px;    
}

.stepwizard-row {
    display: table-row;
}

.stepwizard {
    display: table;     
    width: 100%;
    position: relative;
}

.stepwizard-step button[disabled] {
    opacity: 1 !important;
    filter: alpha(opacity=100) !important;
}

.stepwizard-row:before {
    top: 14px;
    bottom: 0;
    position: absolute;
    content: " ";
    width: 100%;
    height: 1px;
    background-color: #ccc;
    z-order: 0;
    
}

.stepwizard-step {    
    display: table-cell;
    text-align: center;
    position: relative;
}

.btn-circle {
  width: 30px;
  height: 30px;
  text-align: center;
  padding: 6px 0;
  font-size: 12px;
  line-height: 1.428571429;
  border-radius: 15px;
}
/* progress bar 관련 css */


</style>

<!-- SWAL -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.css"
   	  rel="stylesheet">
<script src=" https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.common.min.js"></script>


<script type="text/javascript">

$(document).ready(function(){
	
	$("#account").hide();
	$("#virtualacc").hide();
	$("#phone").hide();	
	
	
}); // end of ready ----

// 신용카드
function gocredit()
{
	$("#account").hide();
	$("#virtualacc").hide();
	$("#phone").hide();	
	$("#credit").show();	
}

//계좌이체
function goaccount()
{
	$("#credit").hide();
	$("#virtualacc").hide();
	$("#phone").hide();	
	$("#account").show();	
}

//가상계좌
function govirtual()
{
	$("#account").hide();
	$("#credit").hide();
	$("#phone").hide();	
	$("#virtualacc").show();	
}

//휴대폰결제
function gophone()
{
	$("#account").hide();
	$("#virtualacc").hide();
	$("#credit").hide();	
	$("#phone").show();	
}

function goPay()
{	// 결제하러가기!
	
	// 회원로그인 한 경우
	if( ${sessionScope.loginuser != null} )
	{
		swal({
			  title: '결제하시겠습니까?',
			  type: 'warning',
			  showCloseButton: true,
			  showCancelButton: true,
			  confirmButtonText: '결제하기',
			  cancelButtonText: '취소'
			}).then(function () {

				var payForm = document.payForm;
				
				payForm.method = "POST";
				payForm.action = "pay.action";
				
				payForm.submit();
				  
			})
	}
	else
	{
		var nhp = $("#nhp").val();
		var npwd = $("#npwd").val();
		var npwdcheck = $("#npwdcheck").val();
		
		
		// ajax로 비회원 가입 가능한지 알아오기 
		
		var form_data = {nhp : nhp};
		
		$.ajax({
				url: "/khx/noncheck.action",
				type: "POST",
				data: form_data,
				dataType: "JSON",
				success: function(data){
												
				//	alert("ajax 뜬다!");
	
					if(data == 1)
					{
						sweetAlert("이미 예매 내역이 있습니다!", "번호당 1건의 예약만 가능합니다.", "error");
					}
					else if (data == 0)
					{
						if( !nhp.trim() )
						{
//							alert("휴대폰 번호를 입력해주세요!");

							sweetAlert("", "휴대폰 번호를 입력해주세요!", "error");
							
							$("#nhp").val("");
							$("#nhp").focus();
							return;
						}
						else if( nhp.trim().length < 11 )
						{
//							alert("휴대폰 번호를 입력해주세요!");

							sweetAlert("", "휴대폰 번호를 정확하게 입력해주세요!", "error");
							
//							$("#nhp").val("");
							$("#nhp").focus();
							return;
						}
						
						else if ( !npwd.trim() )
						{
//							alert("비밀번호를 입력해주세요!");

							sweetAlert("", "비밀번호를 입력해주세요!", "error");
							
							$("#npwd").val("");
							$("#npwd").focus();
							return;
						}
						
						else if ( !npwdcheck.trim() )
						{
//							alert("비밀번호 확인을 입력해주세요!");

							sweetAlert("", "비밀번호 확인을 입력해주세요!", "error");

							$("#npwdcheck").val("");
							$("#npwdcheck").focus();
							return;
						}
						
						else if ( npwd.trim() != npwdcheck.trim() )
						{
//							alert("비밀번호와 비밀번호 확인이 일치하지 않습니다!")				

							sweetAlert("", "비밀번호와 비밀번호 확인이 일치하지 않습니다!", "error");

							$("#npwd").val("");
							$("#npwdcheck").val("");
							$("#npwd").focus();
							return;
						}
						
						swal({
							  title: '결제하시겠습니까?',
							  type: 'warning',
							  showCloseButton: true,
							  showCancelButton: true,
							  confirmButtonText: '결제하기',
							  cancelButtonText: '취소'
							}).then(function () {

								var nonmemberRegForm = document.nonmemberRegForm;
								
								nonmemberRegForm.method = "POST";
								nonmemberRegForm.action = "pay.action";
								
								nonmemberRegForm.submit();
								  
							})
					}
					
					return;
					
	//				swal("사용 가능한 휴대폰 번호입니다.!", "", "success")
					
	/* 				var orderConfirmForm = document.orderConfirmForm;
					orderConfirmForm.method = "post";
					orderConfirmForm.action = "orderConfirm.action";
					
					orderConfirmForm.submit();		
	 */				
				}, // end of success ----
				error: function(){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error); 
			}//end of error
			
		}); // end of ajax ----
		
		
		/* if( !nhp.trim() )
		{
//			alert("휴대폰 번호를 입력해주세요!");

			sweetAlert("", "휴대폰 번호를 입력해주세요!", "error");
			
			$("#nhp").val("");
			$("#nhp").focus();
			return;
		}
		else if( nhp.trim().length < 11 )
		{
//			alert("휴대폰 번호를 입력해주세요!");

			sweetAlert("", "휴대폰 번호를 정확하게 입력해주세요!", "error");
			
//			$("#nhp").val("");
			$("#nhp").focus();
			return;
		}
		
		else if ( !npwd.trim() )
		{
//			alert("비밀번호를 입력해주세요!");

			sweetAlert("", "비밀번호를 입력해주세요!", "error");
			
			$("#npwd").val("");
			$("#npwd").focus();
			return;
		}
		
		else if ( !npwdcheck.trim() )
		{
//			alert("비밀번호 확인을 입력해주세요!");

			sweetAlert("", "비밀번호 확인을 입력해주세요!", "error");

			$("#npwdcheck").val("");
			$("#npwdcheck").focus();
			return;
		}
		
		else if ( npwd.trim() != npwdcheck.trim() )
		{
//			alert("비밀번호와 비밀번호 확인이 일치하지 않습니다!")				

			sweetAlert("", "비밀번호와 비밀번호 확인이 일치하지 않습니다!", "error");

			$("#npwd").val("");
			$("#npwdcheck").val("");
			$("#npwd").focus();
			return;
		}
		
		swal({
			  title: '결제하시겠습니까?',
			  type: 'warning',
			  showCloseButton: true,
			  showCancelButton: true,
			  confirmButtonText: '결제하기',
			  cancelButtonText: '취소'
			}).then(function () {

				var nonmemberRegForm = document.nonmemberRegForm;
				
				nonmemberRegForm.method = "POST";
				nonmemberRegForm.action = "pay.action";
				
				nonmemberRegForm.submit();
				  
			}) */
		
	} // end of inner if else ----

}

</script>

<c:if test="${sessionScope.loginuser.userid != null}">
	<form name = "payForm">
		<!-- 아이디 :  -->
		<input type="hidden" value ="${sessionScope.loginuser.userid}" name = "userid" id = "userid">
	</form>
</c:if>

<c:if test="${sessionScope.nonloginuser.nhp != null}">
	<!-- 전화번호 :  --><input type="hidden" value ="${sessionScope.nonloginuser.nhp}">
	<!-- 비회원번호 :  --><input type="hidden" value ="${sessionScope.nonloginuser.nonno}">
</c:if>

<!-- 객실등급 :  --><input type="hidden" value ="${sessionScope.trainclass}">
<!-- 열차번호 :  --><input type="hidden" value ="${sessionScope.trainno}">
<!-- 출발지 :  --><input type="hidden" value ="${sessionScope.departure}">
<!-- 출발일 :  --><input type="hidden" value ="${sessionScope.departuredate}">
<!-- 출발시각 :  --><input type="hidden" value ="${sessionScope.departuretime}">
<!-- 도착지 :  --><input type="hidden" value ="${sessionScope.arrival}"> 
<!-- 도착일 :  --><input type="hidden" value ="${sessionScope.arrivaldate}"> 
<!-- 도착시간 :  --><input type="hidden" value ="${sessionScope.arrivaldate}"> 
<!-- 티켓 구매 장 수 :  --><input type="hidden" value ="${sessionScope.tqty}">  
<!-- 일반 탑승인 수 :   --><input type="hidden" value ="${sessionScope.normal}"> 
<!-- 중고생 탑승인 수 :  --><input type="hidden" value ="${sessionScope.students}"> 
<!-- 65세 이상 탑승인 수 :   --><input type="hidden" value ="${sessionScope.older}"> 
<!-- 기준 요금 :  --><input type="hidden" value ="${sessionScope.rate}"> 
<!-- 총 가격 :  --><input type="hidden" value ="${sessionScope.totalPrice}"> 
<!-- 선택한 좌석번호 :  --><input type="hidden" value = "${sessionScope.selectedSeatList}">


<div class="yjcontent" style=" width : 100%; background-color: white;" align="center" >
	
	<div style="width: 50%; padding-top: 1%;">
		
		
		<!--  progress bar  -->
		<div class="stepwizard" style="width:90%; margin-right:5%;">
		    <div class="stepwizard-row">
		        <div class="stepwizard-step">
		            <button type="button" class="btn btn-default btn-circle">1</button>
		            <p>예약 정보 선택</p>
		        </div>
		        <div class="stepwizard-step">
		            <button type="button" class="btn btn-primary btn-circle" style="background-color: #639EB0;">2</button>
		            <p>결제 정보 입력</p>
		        </div>
		        <div class="stepwizard-step">
		            <button type="button" class="btn btn-default btn-circle" disabled="disabled">3</button>
		            <p>예매 완료</p>
		        </div> 
		    </div>
		</div>
		<br/>
		
		
		
		<c:if test="${sessionScope.loginuser.userid == null}">
			
			<div style="border : 0px solid #639EB0; padding: 0%; margin:0%; border-collapse:collapse; color:white; background-color:#639EB0; min-height:5%; text-align: left;" >
				<h4 style="padding-top: 1.5%;">&nbsp;예매 조회정보 입력</h4> 
			</div>			
			<div style="height: 15%; border: 1px solid #639EB0;">
				<div style="min-height: 34%; text-align: left; border: 0px solid blue;">
					<br/>
					<span style="padding-left: 3%; font-size: small; color: red;">※ 예매사항을 조회하기 위한 필수항목 입니다.</span>
				</div>
				
				<div style="clear:both; padding-left: 3%; height: 45%; border: 0px solid red; margin-top: 1%; text-align: center; font-size: large; width: 100%;">
					
						
						<div style="clear:both; font-size: smaller; width: 80%; height: 35%; text-align: center;" align="center">
							<div style="float: left;text-align: center;">휴대폰번호</div>
							<div style="float: left; margin-left: 25%;">비밀번호</div>
							<div style="float: left; margin-left: 28%;">비밀번호 확인</div>
						</div>
						
						
					
					<div style="clear:both; width: 90%; height: 90%;">
						<form name = "nonmemberRegForm">	
							<input type="text"  style="width: 30%; height: 70%; font-size: smaller;" 
									placeholder="휴대폰번호(-없이 입력)" maxlength="11pt" 
									id = "nhp" name = "nhp"> &nbsp;&nbsp;
							<input type="password" style="width: 30%; height: 70%; font-size: smaller;" 
									placeholder="ex) 휴대폰번호 뒤 4자리" maxlength="4pt"
									id = "npwd" name = "npwd"> &nbsp;&nbsp;
							<input type="password" style="width: 30%; height: 70%; font-size: smaller;" 
									placeholder="비밀번호 재입력" maxlength="4pt"
									id = "npwdcheck" name = "npwdcheck">
						</form>
					</div>					
				</div>
			</div>
		</c:if>
		
		
		<div style="min-height : 2%;">
			<c:if test="${sessionScope.loginuser.userid != null}">
				<h1><span style="color : #639EB0;">${sessionScope.loginuser.name}</span>님의 발권 안내</h1>
				<br/><br/>
			</c:if>
		</div>
		
		<div style="border : 0px solid #639EB0; border-collapse:collapse; color:white; background-color:#639EB0; height:5%; text-align: left; margin-bottom: 1.5%;" >
			<h4 style="padding-top: 1.5%;">&nbsp;가는편 승차권 정보</h4> 
		</div>
		
		<div>
			<div style="border: 1px solid #639EB0; text-align: left; min-height: 5%; padding-top: 1%;">
				&nbsp;&nbsp;
					<span style="font-weight: bold; font-size: large;">
						${sessionScope.departuredate} ${sessionScope.departuretime}
					</span>
			</div>
			
			<div style="float: left; border-left: 1px solid #639EB0; width: 50%; height: 28%; padding: 3%; text-align: left;">
				
				<div style="min-height : 50%; border: 0px dashed pink; font-size: large;">
					<div>
						<div style="clear: both;">					
							<img src ="<%=request.getContextPath() %>/resources/images/circle_colored.png" 
								style="position: relative; width: 25%; z-index: 1;" align="left"> 
							<div style="position : relative; z-index: 2; left: -19%; top: 29px; color:white;">출발</div>
							<span style="font-size: medium; padding-left: 3%; text-align: right;">${sessionScope.departuretime}</span>
							<span style="font-size: larger; padding-left: 7%; ">${sessionScope.departure}</span>
							<br/>
						</div>
						
						<div style="clear: both;">
							<img src ="<%=request.getContextPath() %>/resources/images/circle_colored.png" 
								style="position: relative; width: 25%; z-index: 1;" align="left"> 
							<div style="position : relative; z-index: 2; left: -19%; top: 29px; color:white;">도착</div>
							<span style="font-size: medium; padding-left: 3%; text-align: right;">${sessionScope.arrivaltime}</span>
							<span style="font-size: larger; padding-left: 7%;">${sessionScope.arrival}</span>
							<br/>
						</div>
						
						
						<div style="clear:both; font-size: normal; text-align: left; padding-bottom: 5%; 
									color : #639EB0; padding-left: 20%;">
							${sessionScope.turnaroundrate} 소요
						</div>
					</div>
				</div>
				
			</div>
			<div style="float: left; border-left: 1px solid #639EB0; border-right: 1px solid #639EB0; width: 50%; height: 28%; padding: 2%; text-align: left;">
			
				<table style="width : 100%; height: 90%; margin-top : 2%;">
					<tr>
						<td class="bold">열차종류</td>
						<td class="tdcontainer">${sessionScope.traintype}</td>
					</tr>
					
					<tr>
						<td class="bold">열차번호</td>
						<td class="tdcontainer">${sessionScope.trainno}</td>
					</tr>
					
					<tr>
						<td class="bold">객실등급</td>
						<td class="tdcontainer">
							${sessionScope.trainclass} 호차
							<c:if test="${sessionScope.trainclass < 4}">( 프리미엄 객실 )</c:if>
							<c:if test="${sessionScope.trainclass > 3}">( 일반 객실 )</c:if>
						</td>
					</tr>
					
					<tr>
						<td class="bold">매수</td>
						<td class="tdcontainer">총 ${sessionScope.tqty}매 <br/>
						( <c:if test="${sessionScope.normal > 0}">일반 ${sessionScope.normal}명 </c:if>
						<c:if test="${sessionScope.students > 0}">중고생 ${sessionScope.students}명 </c:if>
						<c:if test="${sessionScope.older > 0}">65세이상 ${sessionScope.older}명 </c:if> )</td>
					</tr>
					
					<tr>
						<td class="bold">좌석</td>
						<td class="tdcontainer">${sessionScope.selectedSeatList}</td>
					</tr>
					
				</table>
			
			
			
			<%-- 	열차 종류 : ${sessionScope.traintype} <br/>
				열차번호 : ${sessionScope.trainno} <br/>
				객실등급 : ${sessionScope.trainclass} <br/>
				매수 : 	총 ${sessionScope.tqty}매 <br/>
						( <c:if test="${sessionScope.normal > 0}">일반 ${sessionScope.normal}매 </c:if>
						<c:if test="${sessionScope.students > 0}">중고생 ${sessionScope.students}매 </c:if>
						<c:if test="${sessionScope.older > 0}">65세이상 ${sessionScope.older}매 </c:if> )
					 	<br/>
				좌석 : ${sessionScope.selectedSeatList}<br/> --%>
			 </div>
			 
			 <div style="clear:both; border-top : 1px solid #639EB0; min-height: 1%;">
			 	&nbsp;
			 </div>
			 
			
			<div style="border : 0px solid #639EB0; padding: 0%; margin:0%; border-collapse:collapse; color:white; background-color:#639EB0; min-height:5%; text-align: left;" >
				<h4 style="padding-top: 1.5%;">&nbsp;결제 정보</h4> 
			</div>		
			 
			 <div style="border : 1px solid #639EB0; height: 30%; margin-bottom: 3%;">
			 	<div style="float:left; width: 40%; min-height: 10%; padding-top: 1%;">
					<h4>총 결제금액</h4> 
				</div>
			 	<div style="float:left; width: 50%; min-height: 10%;  padding-top: 1%; text-align: center;">
			 		<h4><fmt:formatNumber pattern="###,###">${sessionScope.totalPrice}</fmt:formatNumber> 원</h4>
			 	</div>			 	
			 	
			 	<div style="clear : both; border-top: 1px solid #639EB0; border-bottom: 0px solid #639EB0; padding: 1%; height: 60%;" align="center">
			 		<div class="btn-group-vertical" style="float: left; width: 25%; height: 45%;">
					    <a href="#" class="btn btn-default" onClick="gocredit();">신용카드</a>
					    <a href="#" class="btn btn-default" onClick="goaccount();">계좌이체</a>
					    <a href="#" class="btn btn-default" onClick="govirtual();">가상계좌</a>
					    <a href="#" class="btn btn-default" onClick="gophone();">휴대폰 소액결제</a>
		   			</div>
		   			
		   			<!-- 신용카드 -->
		   			<div style="float: left; width: 75%; height: 95%; padding-top: 7%;" class = "panel panel-default" id = "credit">
		   				신용카드 결제를 진행합니다. 
		   				<input type="hidden" value = "credit">
		   			</div>
		   			
		   			<!-- 계좌이체 -->
		   			<div style="float: left; width: 75%; height: 95%; padding-top: 7%;" class = "panel panel-default" id = "account">
		   				계좌이체 결제를 진행합니다. 
		   				<input type="hidden" value = "account">
		   			</div>
		   			
		   			<!-- 가상계좌 -->
		   			<div style="float: left; width: 75%; height: 95%; padding-top: 7%;" class = "panel panel-default" id = "virtualacc">
		   				가상계좌 결제를 진행합니다. 
		   				<input type="hidden" value = "virtualacc">
		   			</div>
		   			
		   			<!-- 휴대폰 소액결제 -->
		   			<div style="float: left; width: 75%; height: 95%; padding-top: 7%;" class = "panel panel-default" id = "phone">
		   				휴대폰 소액결제를 진행합니다. 
		   				<input type="hidden" value = "phone">
		   			</div>

		   			
		   			
		   		<!-- 	<div style="clear:both; min-height: 1%;"></div> -->
			 	</div>
			 	
			 	
			 	
<!-- 			 	<div style="clear: both; border-top: 1px solid #639EB0; padding-top: 1.2%; height: 100%;" align="center">
			 			<div class = "btn" style="width: 90%; height: 20%; background-color: #639EB0; font-size: x-large; color: white;" onclick="goPay();" >결제하기</div>
	 			</div> -->
	 			
			 	<div class = "btn" style="clear: both; width: 100%; background-color: #639EB0; 
			 		border-top: 1px solid #639EB0; font-size: x-large; color: white; height: 20%;" align="center" onclick="goPay();">
		 			결제하기
	 			</div>
			 </div>
			 
			 <div style="clear:both; text-align: left; font-size:small; max-height: 15%; margin-bottom: 10%;">
				* 열차 탑승 시 결제에 사용된 카드(창구, 무인기 발권 시), 모바일티켓, 홈티켓 중 하나를 가져오셔야 됩니다.<br/>
				* 예매가 완료된 후 예매확인/취소/변경 메뉴를 통해 예매내역을 확인 하시기 바랍니다.<br/>
				* 모든 결제정보는 암호화 처리 후 안전하게 전송됩니다.<br/>
				* 비밀번호 입력 오류가 3회 이상 발생할 경우 홈페이지에서 결제가 불가하니 카드사/은행을 방문하셔서 처리 후 다시 시도 바랍니다.<br/>		
				
			 </div>
		</div>
	</div>
</div>