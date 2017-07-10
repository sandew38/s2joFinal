<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<link rel="stylesheet" href="resources/BootStrapStudy/css/bootstrap.css">
<!-- <script src="https://ajax.googleapis.com/s2jo/libs/jquery/3.2.1/jquery.min.js"></script> -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- <div style="padding-left: 20%;"> -->

<script>
function goregist() {
	
	 var plustrainFrm = document.plustrainFrm;
	
	 var trainno = $("#trainno").val();
     var departure = $("#departure").val();
     var departuretime = $("#departuretime").val();
     var arrival = $("#arrival").val();
     var arrivaltime = $("#arrivaltime").val();
	
     
     if(trainno.trim() == ""){
   	  alert("열차번호를 입력하여주세요 ^-^");
         $("#trainno").val();
         $("#trainno").focus();
         event.preventDefault();
         return;
     }
     
     else if (departure.trim() == ""){
   	  alert("출발역을 입력하여주세여 ^-^");
   	  $("#departure").val();
         $("#departure").focus();
         event.preventDefault();
         return;
     } 
     else if (departuretime.trim() == "") {
   	  alert("출발시간을 입력하여주세여 ^-^");
   	  $("#departuretime").val();
         $("#departuretime").focus();
         event.preventDefault();
         return;
   	  
     } 
      
      
     else if (arrival.trim() == "") {
   	  alert("도착역을 입력하여주세여 ^-^");
   	  $("#arrival").val();
         $("#arrival").focus();
         event.preventDefault();
         return;
   	  
     } 
      
   
     else if (arrivaltime.trim() == "") {
   	  alert("도착시간을 입력하여주세여 ^-^");
   	  $("#arrivaltime").val();
         $("#arrivaltime").focus();
         event.preventDefault();
         return;
   	  
     } 
     
     else{
    	
    	 plustrainFrm.action = "/khx/plustrainEnd.action";
    	 plustrainFrm.method = "post";
    	 plustrainFrm.submit();
    	 
     }
     
	
	
}
	


</script>
<div style="margin-left: 300px; ">
	<form name="plustrainFrm" style="border: 0px solid blue; height: 80%; width: 60%;">
		<div
			style="border: 0PX SOLID RED; height: 100%; width: 60%; text-align: center; font-size: 23px; font-weight: bold; margin-right: 300px;">
			<div>
			<h3 style=" width:100%; margin-left: 600px; padding-top: 10%; font-weight: bold;">배차 추가</h3>
            </div>
			<table class="table table-hover" style="margin-right: -100px;">

				<thead>



					<tr>
						<!-- 	trainno departure departuretime arrival arrivaltime status -->
						<th style="text-align: left;">열차번호</th>
						<!-- ** 로 가려주기 -->
						<th style="text-align: left;">출발역</th>
						<th style="text-align: left;">출발시간</th>
						<th style="text-align: left;">도착역</th>
						<!-- ** 로 가려주기 -->
						<th style="text-align: left;">도착시간</th>
					</tr>

				</thead>
				<tbody>

					<div class="table container">

						<tr>

							<td><input type="text" id="trainno" name="trainno"
								class="long" /></td>
							<td><input type="text" id="departure" name="departure"
								class="long" /></td>
							<td><input type="text" id="departuretime"
								name="departuretime" class="long" /></td>
							<td><input type="text" id="arrival" name="arrival"
								class="long" /></td>
							<td><input type="text" id="arrivaltime" name="arrivaltime"
								class="long" /></td>



						</tr>

					</div>

				</tbody>


			</table>
		</div>
	</form>
</div>
<br />
<br />
<br />

<div style="text-align: right; font-size: 40pt;">
	<a class="btn btn-success" onClick="goregist();">배차추가</a>
</div>

