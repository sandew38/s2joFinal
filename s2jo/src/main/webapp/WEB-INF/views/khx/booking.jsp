<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">

.yjcontent
{
	font-family: 나눔고딕;
}

table
{
	table-layout: fixed;
}


table tr td
{
	border: 0px gold solid;
	text-align: center;
}

tr td
{
	padding : 3px;
}

thead
{
	background-color: #639EB0;
	color: white;
	table-layout: fixed;
	position: absolute;
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

<script type="text/javascript">

$(document).ready(function(){

	 $('#headerFixTable').fixheadertable({height: '200',minWidth:800,caption:'my header is fixed', zebra : true});
	
});

function goingback()
{
	location.href="/khx";	
}

function selectseat(trainno, departuretime1, departuretime2, arrivaltime1, arrivaltime2)
{
	
	var selectinfo = document.selectinfo;
	
	$("#departuretime").val(departuretime1+":"+departuretime2);
	$("#arrivaltime").val(arrivaltime1+":"+arrivaltime2);
	
	selectinfo.trainno.value = trainno;
	selectinfo.method = "post";
	selectinfo.action = "selectseat.action";
	
	selectinfo.submit();
}
	
</script>
    
    
<form name = "selectinfo">
	<!-- 소요시간	:  -->
	<input type="hidden" value = "${turnaroundrateint}" name = "turnaroundrateint" id = "turnaroundrateint">
	<input type="hidden" value = "${turnaroundrate}" name = "turnaroundrate" id ="turnaroundrate">
	<!-- 가는날 :  -->
	<input type = "hidden" value = "${sessionScope.departuredate}" name = "departuredate" id = "departuredate">
	<!-- 오는날 :  -->
	<input type = "hidden" value = "${arrivaldate}" name = "arrivaldate" id = "arrivaldate">
	<!-- 출발지 :  -->
	<input type="hidden" value="${departure}" name = "departure" id="departure">
	<!-- 출발시각 :  -->
	<input type ="hidden" value = "-1" name = "departuretime" id = "departuretime">
	<!-- 도착지 :  -->
	<input type="hidden" value="${arrival}" name = "arrival" id="arrival">
	<!-- 도착시각 :  -->
	<input type ="hidden" value = "-1" name = "arrivaltime" id = "arrivaltime">
	<!-- 등급 :  -->
	<input type="hidden" value = "${trainclass}" name = "trainclass" id = "trainclass">
	<!-- 요금 :  -->
	<input type="hidden" value = "${rate}" name = "rate" id = "rate">
	<input type = "hidden" name = "trainno" id = "trainno">
</form>
    
<div class="yjcontent" style="width: 100%; height: 96%; margin-bottom: 10%; background-color: white;" align="center">
	<div id = "outer" style="width: 80%; height: 90%; border: 0px #639EB0 solid; " align="center">
	
	<br/><br/>
	
		<h3 style="font-weight: bold;">
		
		가는 편 배차조회
		
		</h3>
		<br/>
		
		
	<!--  progress bar  -->
		<div class="stepwizard" style="width:70%; margin-right:5%;">
		    <div class="stepwizard-row">
		        <div class="stepwizard-step">
		            <button type="button" class="btn btn-primary btn-circle" style="background-color: #639EB0;">1</button>
		            <p>예약 정보 선택</p>
		        </div>
		        <div class="stepwizard-step">
		            <button type="button" class="btn btn-default btn-circle" disabled="disabled">2</button>
		            <p>결제 정보 입력</p>
		        </div>
		        <div class="stepwizard-step">
		            <button type="button" class="btn btn-default btn-circle" disabled="disabled">3</button>
		            <p>예매 완료</p>
		        </div> 
		    </div>
		</div>
		
		
		<br/>

<!-- 		<div class="progress" style="width: 73%; text-align: center;" align="left">
			<div class="progress-bar progress-bar-info" style="width: 20%"></div>
		</div> -->
		
		<div id = "infobox" style="float: left; background-color:#639EB0; margin-left:10%; padding-top:3%; margin-right: 1%; width: 18%; height: 81.5%;" >
		
			<div style="height: 5%; vertical-align: middle; border: 0px green solid;">
				${sessionScope.departuredate}
			</div>
			
			<div style="height : 40%; border: 0px dashed pink; font-size: large;">
				<img src ="<%=request.getContextPath() %>/resources/images/circle.png" style="position: relative; padding-left:10%; width: 40%; z-index: 1;" align="left"> 
				<div style="position : relative; z-index: 2; left: -46%; top: 8%;">출발</div><span style="font-size: larger; padding-right: 15%;">${departure}</span><br/>
				
				<br/>
				<img src ="<%=request.getContextPath() %>/resources/images/circle.png" style="position: relative; padding-left:10%; width: 40%; z-index: 1;" align="left"> 
				<div style="position : relative; z-index: 2; left: -46%; top: 8%;">도착</div><span style="font-size: larger; padding-right: 15%;">${arrival}</span><br/>
				
				<br/>
				
				<c:if test="${turnaroundrate != null && not empty turnaroundrate} ">
					<div style="font-size: smaller; text-align: right; padding-right : 10%;">소요시간 : ${turnaroundrate} 
							
				
					<br/>
					기준 요금 : <fmt:formatNumber pattern="###,###" value="${rate}"></fmt:formatNumber>원 <br/>
					</div> 
				</c:if>				
				
				<div style="clear: both; margin-top: 10%; padding-right: 10%; cursor: pointer;" align="right">
					<span style="color: white; vertical-align: bottom;" onclick="goingback();">이전 페이지로</span>
					<img src="<%=request.getContextPath()%>/resources/images/edit.png" style="width: 20%; vertical-align: top;">
				</div>
			</div>
			
			<div style="height : 50%;">
			
			</div>
		</div>
		
		<div id = "detailbox" style="float: left; border: 1px #639EB0 solid; width: 55%; height: 81.5%;">
			<div style="height: 15%; width: 100%; float : left; border-bottom : 1px #639EB0 solid;">
				<div align="left" style="float: left; width: 10%; padding-top : 2.5%; padding-left : 3%;">
					<a href="#"><img src="<%=request.getContextPath()%>/resources/images/btn_refresh.png"
						 style="width: 100%; padding: 2%; padding-top : 5%;  cursor: pointer;"></a> 
						 
				</div>
				
				<div style="float: left; width : 50%; padding-left: 25%; text-align: center; padding-top : 3%; " align="center">
					<h2>${sessionScope.departuredate}</h2>
				</div>
			</div>
			<div style="max-height: 508px; clear: both; padding-top:0%; overflow-y: auto; " align="left">
				<table style="width: 100%; text-align: center; " >
					<thead style="width: 35.7%; height: 5%; padding-top: 0.6%;">
						<tr style="border-bottom: 1px #639EB0 solid; padding-bottom : 5%; vertical-align:top; position:absolute; width: 100%;">
							<!-- <th style="text-align: center; padding-bottom:2%;">분류</th>
							<th style="text-align: center; padding-bottom:2%;">열차번호</th>
							<th style="text-align: center; padding-bottom:2%;">출발지</th>
							<th style="text-align: center; padding-bottom:2%;">출발시각</th>
							<th style="text-align: center; padding-bottom:2%;">도착지</th>
							<th style="text-align: center; padding-bottom:2%;">도착시각</th>
							<th style="text-align: center; padding-bottom:2%;"></th> -->
							<th style="text-align: center; padding-left:2%; padding-bottom:2%; position:absolute; width: 15%; left: -2.5%;">분류</th>
							<th style="text-align: center; padding-left:2%; padding-bottom:2%; position:absolute; width: 17%; left:9%;">열차번호</th>
							<th style="text-align: center; padding-left:2%; padding-bottom:2%; position:absolute; width: 17%; left:21.5%;">출발지</th>
							<th style="text-align: center; padding-left:2%; padding-bottom:2%; position:absolute; width: 17%; left:34%;">출발시각</th>
							<th style="text-align: center; padding-left:2%; padding-bottom:2%; position:absolute; width: 17%; left:46%;">도착지</th>
							<th style="text-align: center; padding-left:2%; padding-bottom:2%; position:absolute; width: 17%; left:59%;">도착시각</th>
							
							
						</tr>
					</thead>
					
					<tbody>		
					<tr style="min-height: 10%;"><td>&nbsp;<br/></td></tr>	
						<c:if test="${not empty trainList}">
							<c:forEach items="${trainList}" var="train">
								<tr><td colspan="7">&nbsp;<td></tr>
								<tr>
									<td>
										${train.traintype} 
									</td>
									
									<td>
										${train.trainno}
									</td>
									<td>
										${train.departure}
									</td>
									<td>
										${train.departuretime.substring(0,2)} : ${train.departuretime.substring(2,4)}
									</td>
									<td>
										${train.arrival}
									</td>
									<td>
										${train.arrivaltime.substring(0,2)} : ${train.arrivaltime.substring(2,4)}
									</td>
									<td>	
										<span onClick="selectseat(${train.trainno}, ${train.departuretime.substring(0,2)}, ${train.departuretime.substring(2,4)}, ${train.arrivaltime.substring(0,2)}, ${train.arrivaltime.substring(2,4)});" 
												style="cursor: pointer; color: #639EB0; font-weight: bold;">선택 > </span> 
									</td>					
							</c:forEach>
						</c:if>
						
						<c:if test="${empty trainList || trainList == null}">
							<tr>
								<td colspan="7" style="font-size: large; color : #0D696C; font-weight: bold;">
									<br/>
									검색 조건에 해당하는 열차가 없습니다.
								</td>
							</tr>
						</c:if>
					</tbody>
				</table>		
			</div>
		</div>
	</div>    
</div>