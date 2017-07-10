<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<style type="text/css">

.bold
{
	font-weight: bold;
	color: #639EB0;
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



<script>

	$(document).ready(function(){
		
//		alert("결제가 완료되었습니다!");

		sweetAlert("결제가 완료되었습니다!", "", "success");
				
	}); // end of ready ----

	
	function goindex()
	{
		location.href="/khx";
	}
	
	function goHAJOTA()
	{	
//		location.href="http://192.168.10.8:9090/hajota";

		var hajotaForm = document.hajotaForm;
		hajotaForm.method="get";
		hajotaForm.action="http://192.168.10.8:9090/hajota/test.go";
		
		hajotaForm.submit();
	}
	
</script>


<div style="margin-bottom:10%; background-color: white;" align="center">
	
	<div style="width: 50%; padding-top: 3%; ">
		
		<!--  progress bar  -->
		<div class="stepwizard" style="width:90%; margin-right:5%;">
		    <div class="stepwizard-row">
		        <div class="stepwizard-step">
		            <button type="button" class="btn btn-default btn-circle">1</button>
		            <p>예약 정보 선택</p>
		        </div>
		        <div class="stepwizard-step">
		            <button type="button" class="btn btn-default btn-circle">2</button>
		            <p>결제 정보 입력</p>
		        </div>
		        <div class="stepwizard-step">
		            <button type="button" class="btn btn-primary btn-circle"style="background-color: #639EB0;">3</button>
		            <p>예매 완료</p>
		        </div> 
		    </div>
		</div>
		
		<div style="min-height : 7%;">
			<c:if test="${sessionScope.loginuser.userid != null}">
				<h1><span style="color : #639EB0;">${sessionScope.loginuser.name}</span>님의 예매 완료</h1>
			</c:if>
			
			<c:if test="${sessionScope.loginuser.userid == null}">
				<h1><span style="color : #639EB0;">${sessionScope.nhp}</span>님의 예매 완료</h1>
			</c:if>
			
		</div>
		
		<div style="border : 0px solid #639EB0; padding: 0%; margin:0%; border-collapse:collapse; color:white; background-color:#639EB0; min-height:5%; text-align: left;" >
			<h4 style="padding-top: 1.5%;">&nbsp;가는편 승차권 정보</h4> 
		</div>
		
		
		<div>
			<div style="border: 1px solid #639EB0; text-align: left; min-height: 6%; padding-top: 1.5%;">
				&nbsp;&nbsp;
					<span style="font-weight: bold; font-size: medium;">
						출발일 : ${departuredate}
					</span>
			</div>
			
			<div style="float: left; border-left: 1px solid #639EB0; width: 50%; height: 35%; padding: 5%; text-align: left;">
				
				<div style="min-height : 50%; border: 0px dashed pink; font-size: large;">
					<div>
						<div style="clear: both;">					
							<img src ="<%=request.getContextPath() %>/resources/images/circle_colored.png" 
								style="position: relative; width: 25%; z-index: 1;" align="left"> 
							<div style="position : relative; z-index: 2; left: -19%; top: 29px; color:white;">출발</div>
							<span style="font-size: medium; padding-left: 3%; text-align: right;">${sessionScope.departuretime}</span>
							<span style="font-size: larger; padding-left: 3%; ">${departure}</span><br/>
						</div>
						
						<div style="clear: both;">
							<img src ="<%=request.getContextPath() %>/resources/images/circle_colored.png" 
								style="position: relative; width: 25%; z-index: 1;" align="left"> 
							<div style="position : relative; z-index: 2; left: -19%; top: 29px; color:white;">도착</div>
							<span style="font-size: medium; padding-left: 3%; text-align: right;">${sessionScope.arrivaltime}</span>
							<span style="font-size: larger; padding-left: 3%;">${arrival}</span><br/>
						</div>
						
						
						<div style="clear:both; font-size: normal; text-align: left; padding-bottom: 5%; 
									color : #639EB0; padding-left: 20%;">
							${sessionScope.turnaroundrate} 소요
						</div>
					</div>
				</div>
				
			</div>
			
			<div style="float: left; border-left: 1px solid #639EB0; border-right: 1px solid #639EB0; width: 50%; height: 35%; padding: 5%; text-align: left;">
			
				<table style="width : 100%; height: 90%;">
					<tr>
						<td class="bold">열차종류</td>
						<td class="tdcontainer">${traintype}</td>
					</tr>
					
					<tr>
						<td class="bold">열차번호</td>
						<td class="tdcontainer">${sessionScope.trainno}</td>
					</tr>
					
					<tr>
						<td class="bold">객실등급</td>
						<td class="tdcontainer">
							${trainclass} 호차
							<c:if test="${trainclass < 4}">( 프리미엄 객실 )</c:if>
							<c:if test="${trainclass > 3}">( 일반 객실 )</c:if>
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
			</div>
		
			<div style="clear:both; border-top : 1px solid #639EB0; min-height: 5%;">
	 		&nbsp;
			</div>
			 	
		 	<div style="border : 0px solid #639EB0; padding: 0%; margin:0%; border-collapse:collapse; color:white; background-color:#639EB0; min-height:5%; text-align: left;" >
				<h4 style="padding-top: 1.5%;">&nbsp;결제 정보</h4> 
			</div>		
			 
			 <div style="border : 1px solid #639EB0; height: 10%; margin-bottom: 3%;">
		 	<div style="float:left; width: 40%; min-height: 10%; padding-top: 3%;">
				<h4>총 결제금액</h4> 
			</div>
		 	<div style="float:left; width: 50%; min-height: 10%;  padding-top: 3%; text-align: center;">
		 		<h4><fmt:formatNumber pattern="###,###">${sessionScope.totalPrice}</fmt:formatNumber> 원</h4>
		 	</div>	
		 	
	</div>
	
			<div style="clear: both; margin-top: 7%;">
				<h3>
					예매가 완료되었습니다!
				</h3>
			</div>
			
			
			<div style="clear: both; margin-top: 10%;">
							
				<button class="btn btn-primary" onclick="goindex();" style="font-size: x-large;" >홈으로</button>
				<!-- <button class="btn" onclick="goHAJOTA();">HAJOTA 홈페이지</button> -->
				
				<div style="margin : 10%;">
					<div>
						<img src="<%=request.getContextPath()%>/resources/images/hajotabanner.png" onclick="goHAJOTA();" style="cursor: pointer;">
						<br/><br/>
						<span style="font-size: x-large;"> <span style="color:#639EB0;">${arrival}</span> 에 있는 멋진 숙소를 HAJOTA에서 <br/> 
						<span style="color:red; font-weight: bolder;">10% 할인된 가격</span>으로 예약해보세요!</span> <br/>
						
						<span style="font-size: large;">${departuredate}부터, 인원 ${sessionScope.tqty}명<br/> 숙박 <a onclick="goHAJOTA();" style="cursor: pointer;">예약하기!</a></span>
					
					</div>
				</div>
				
			</div>
			
			
			<form name="hajotaForm">
				<!-- 지역 --><input type="hidden" name="location" value="${arrival}">
				<!-- 인원수 --><input type="hidden" name="checkin_person" value="${sessionScope.tqty}">
				<!-- 숙박시작날짜 --><input type="hidden" name="checkin_date" value="${departuredate}">
				<c:if test="${sessionScope.loginuser.userid != null}">
					<!-- 이메일 --><input type="hidden" name="email" value="${sessionScope.loginuser.email}">
				</c:if>
			</form>
		
	</div>
</div>
