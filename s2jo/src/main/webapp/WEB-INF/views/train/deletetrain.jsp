<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 
   
<link rel="stylesheet" href="resources/BootStrapStudy/css/bootstrap.css">
<!-- <script src="https://ajax.googleapis.com/s2jo/libs/jquery/3.2.1/jquery.min.js"></script> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<div style="padding-left: 20%;">
<div style="text-align: center; padding-top: 5%;">
	
</div>

<script>

$(document).ready(function(){


$("#traintype").val("${traintype}"); 


$("#traintype").bind("change", function(){

	var traintypeFrm = document.traintypeFrm;
	traintypeFrm.action = "deletetrain.action";
	traintypeFrm.method = "get";
	traintypeFrm.submit();
});



});



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
<form name="plustrainFrm"> 
<table class="table table-hover">
<thead>

				       <tr> 
					<!-- 	trainno departure departuretime arrival arrivaltime status -->
				     	<th style="text-align: center;">열차번호</th>  <!-- ** 로 가려주기 -->
				     	<th style="text-align: center;">출발역</th>
						<th style="text-align: center;">출발시간</th>
				    	<th style="text-align: center;">도착역</th>  <!-- ** 로 가려주기 -->
				    	<th style="text-align: center;">도착시간</th>
					</tr>
					
</thead>

<tbody>
 
 <div class="table container">
  
       <c:if test="${not empty traindeleteList}">
	   <c:forEach var="map" items="${traindeleteList}" >
  
                 <tr>
              
                      <td>
                        ${map.trainno}
                        </td>
                      
                      <td>
                           
                           ${map.departure}
                        </td>
                      
             
                      <td>
                        ${map.departuretime}
                      </td>
                      
                      
                    <td>
                        ${map.arrival}
                        </td>
                      
                        
                        <td>
                        ${map.arrivaltime}
                        </td>
                     
                   <td>
                        ${map.arrivaltime}
                        </td>
                     
                    
                    
                    
                 
                       </tr>         
        </c:forEach>
        </c:if>



</div>


                 </tbody> 
 
<div align="center" style="width: 400px; margin-left: 100px; margin-right: auto;">
      ${pagebar5}
   </div>
   <br/>
   
<form name="traintypeFrm">
	
      <select name="traintype" id="traintype">
        <option value="1">KHX</option>
	    <option value="2">무궁화호</option>
      </select>
      
      
   <!--     <button type="button" onClick="goSearch();">검색</button> -->
	</form>

	
                
</table>
</form>
</div>

