<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- SWAL -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.css" rel="stylesheet">
<script src=" https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.common.min.js"></script>


<html>
<head>
<meta charset="utf-8">


<title>Insert title here</title>
</head>
<style type="text/css">

.main_s2 {
		border: 1px solid #639EB0;
		width: 70%;
		height: 49%; 
		text-align:center; 
		margin:0 auto;
		vertical-align: middle;
		padding: 0.5%
}

.sub01_s2 {
		border: 1px solid white;
		display: inline-block;
		width: 50%; 
		height: 100%; 
		float: left;
		padding: 0.5%;

}

.sub02_s2 {
		border: 1px solid white;
		display: inline-block;
		width: 50%; 
		height: 100%;
		float: right;
		padding: 0.5%;
}

.sub01-1_s2 {
		border: 1px solid #f4f6f9;
		width: 100%; 
		height: 49%;	
		text-align: center;
		background-color: #f4f6f9;
}


.sub01-2_s2 {
		border: 1px solid #f4f6f9;
		width: 100%; 
		height: 49%;	
		text-align: center;
		background-color: #f4f6f9;
		margin-top: 5px;
}


.sub02-1_s2 {
		border: 1px solid #f4f6f9;
		width: 100%;
		height: 49%;
		text-align: left;
		background-color: #f4f6f9;
		margin-top: 5px;
		padding: 5%;
}

.sub02-2_s2 {
		border: 1px solid #f4f6f9;
		width: 100%;
		height: 49%;
		text-align: left;
		background-color: #f4f6f9;
		padding: 5%;
}

.traintype_pic {
		text-align: center; 
		width:100%; 
		height: 45%; 
		font-size: large;
		border: 1px solid #f4f6f9;
		background-color: #f4f6f9;
}

.time_pic {
		text-align: center; 
		width:100%; 
		height: 45%; 
		font-size: large;
		border: 1px solid #f4f6f9;
		background-color: #f4f6f9;
}

/*  css  */



</style>

<script type="text/javascript">

$(document).ready(function(){

	$("#traintype_pic").change(function(){
		
		var departure = "${departure}";
		var arrival = "${arrival}";
		var traintype_pic = $('#traintype_pic').val();
		var departuredate = $('#departuredate').val();

		// alert("일자" + departuredate);

		form_data = { departure : departure
					, arrival : arrival
					, traintype_pic : traintype_pic 
					, departuredate : departuredate }
		
		
		$.ajax({
			url: "/khx/lsk/bookingEdit_pic.action",
			type: "GET",
			data: form_data,
			dataType: "JSON",
			success: function(data) {
				var html = "";
				var pic = document.getElementById("time_pic");
				
				html += "<option selected id=''> 예약시간대를 선택해주세요. </option>";
				
				$.each(data, function(indexentry, entry){
					html += "<option value='" + entry.DEPARTURETIME + "'>" + entry.DEPARTURETIME + "</option>";
					
				});
				
				$("#time_pic").html(html);	
				
				
			},
			error: function(){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			} //end of error ---
			
		}); // end of ajax ---
		
	}); // end of $("#traintype_pic").click(function() ---
	
});

	
function goRepic() {
	
	var traintype = $("#traintype_pic").val();
	var time = $("#time_pic").val();
	var paymentcode = $("#paymentcode").val();
	
	$("#departuretime").val(time);
	$("#trainno").val(traintype);
	
	
	if(traintype != '1' && traintype != '2' && traintype != '3') {

		sweetAlert("","열차등급을 선택해주세요!","warning");
		
		return;
	}
	else if(time == "예약시간대를 선택해주세요.") {
		
		sweetAlert("","예약시간대를 선택해주세요!","warning");
		
		return;
	}
 	
	var repicForm = document.repicForm;
	repicForm.method = "POST";
	repicForm.action = "/khx/lsk/reselectseat.action";
	
	repicForm.submit();
	
}
	
	
</script>

<body>

<div class="#" style="border: 1px solid white;  width: 100%; height: 100%; background-color: white;">

<h2 style="text-align: center; margin-top: 7%; margin-bottom: 30px;">시간/등급 변경</h2>

<c:forEach items="${list}" var="map" >

<div class="main_s2">
	<div class="sub01_s2">
		<div class="sub01-1_s2" align="center">
		<br/>
		<h3> ${map.DEPARTUREDATE} ${map.DEPARTURETIME} </h3>
		<h3>열차등급 :
        <c:if test="${map.TRAINTYPE == 1 }" >
        KHX 
        </c:if>
        <c:if test="${map.TRAINTYPE == 2 }" >
                    무궁화 
        </c:if></h3>
		<h3> 예매장수 : ${map.TQTY} </h3>
		</div>
		
		<div class="sub01-2_s2" align="center">
		<h3> 출발지 : ${map.DEPARTURE} </h3>
		<h3> 도착지 : ${map.ARRIVAL} </h3>
		</div>
	</div>
	
	<div class="sub02_s2">

	<form name = "repicForm">
	<div class="sub02-2_s2" align="center">
		<select class="traintype_pic" name="traintype_pic" id="traintype_pic">
			<option selected> 기차 종류를 선택해주세요. </option>
			<option value = "1" > KHX </option>
			<option value = "2" > 무궁화호 </option>
		</select>		
		<span id = "" style="font-size: x-large; color : #639EB0; font-weight: bold;"></span>
	</div>
	
	<div class="sub02-1_s2" align="center">
		<select class="time_pic" name="time_pic" id="time_pic">
			<option selected id="time_onepic"> 예약시간대를 선택해주세요. </option>
		</select>		
		<span id = "" style="font-size: x-large; color : #639EB0; font-weight: bold;"></span>
	</div>
	<input type="hidden" id="paymentcode" 	name="paymentcode" 	 value="${map.PAYMENTCODE}" />
	<input type="hidden" id="departure" 	name="departure" 	 value="${map.DEPARTURE}" />
	<input type="hidden" id="arrival" 		name="arrival" 	 	 value="${map.ARRIVAL}" />
	<input type="hidden" id="departuredate" name="departuredate" value="${map.DEPARTUREDATE}" />
	<input type="hidden" id="trainclass" 	name="trainclass"	 value="4" />
	<input type="hidden" id="departuretime" name="departuretime" value="" />
	<input type="hidden" id="trainno" 		name="trainno" 		 value="" />
	
	</form>
	
	</div>
</div>
<div class="col-sm-3" style="text-align: center; margin-left: 600px; margin-top: 50px;">
<button class="btn btn-primary btn-block" type="button" onclick="goRepic();">조회하기</button>
</div>
</c:forEach>

</div>

</body>


</html>