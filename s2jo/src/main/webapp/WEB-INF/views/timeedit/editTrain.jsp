<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 
   
<link rel="stylesheet" href="resources/BootStrapStudy/css/bootstrap.css">
<!-- <script src="https://ajax.googleapis.com/s2jo/libs/jquery/3.2.1/jquery.min.js"></script> -->
<%-- <script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>  --%>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>






<style type="text/css">

table tr td
{
	border: 0px gold solid;
	text-align: center;
	padding : 3px;
}
	

</style>



<script>

$(document).ready(function(){

    $("#spinnerIbgoqty").spinner({
         spin: function( event, ui ) {
           if( ui.value > 100 ) {
             $( this ).spinner( "value", 0 ); 
             return false;
           } 
           else if ( ui.value < 0 ) {
             $( this ).spinner( "value", 10 );
             return false;
           }
         }
    
     });
    
    
 }); // end of $(document).ready()-
 
 
 
 
 $(document).ready(function(){

     $("#spinnerIbgoqty1").spinner({
          spin: function( event, ui ) {
            if( ui.value > 100 ) {
              $( this ).spinner( "value", 0 ); 
              return false;
            } 
            else if ( ui.value < 0 ) {
              $( this ).spinner( "value", 10 );
              return false;
            }
          }
        });
     
  }); // end of $(document).ready()-




  
  
  $(document).ready(function(){

      $("#spinnerIbgoqty2").spinner({
           spin: function( event, ui ) {
             if( ui.value > 100 ) {
               $( this ).spinner( "value", 0 ); 
               return false;
             } 
             else if ( ui.value < 0 ) {
               $( this ).spinner( "value", 10 );
               return false;
             }
           }
         });
      
   }); // end of $(document).ready()-

   
   
   
   
   $(document).ready(function(){

	      $("#spinnerIbgoqty3").spinner({
	           spin: function( event, ui ) {
	             if( ui.value > 100 ) {
	               $( this ).spinner( "value", 0 ); 
	               return false;
	             } 
	             else if ( ui.value < 0 ) {
	               $( this ).spinner( "value", 10 );
	               return false;
	             }
	           }
	         });
	      
	   }); // end of $(document).ready()-
   



	   
	   
	   
	   
	   $(document).ready(function(){

		      $("#spinnerIbgoqty4").spinner({
		           spin: function( event, ui ) {
		             if( ui.value > 100 ) {
		               $( this ).spinner( "value", 0 ); 
		               return false;
		             } 
		             else if ( ui.value < 0 ) {
		               $( this ).spinner( "value", 10 );
		               return false;
		             }
		           }
		         });
		      
		   }); // end of $(document).ready()-

		   
function goedit(){

    var departuretime = $("#spinnerIbgoqty").val();
    
    if(departuretime.trim()==""||departuretime.trim()=="0"){
   	  alert("변경시간을 입력하세요!");
   	  
   	  $("#spinnerIbgoqty").val("0");
   	  event.preventDefault();
   	  return;
   	}
    else{
	 document.traineditFrm.submit();
    }
	  }
		   
		   
</script>




<div class="table container" style="padding-left: 250px;">
   <form name="traineditFrm" action="<%= request.getContextPath()  %>/editTrainEnd.action" method="GET">
  <h2 style="color: blue; font-weight: bold; text-align: center; padding-bottom: 50px; margin-top: 100px;">열차수정페이지</h2>
<body>
       
<input type="hidden" name="runinfoseq" value="${runinfoseq}"/>
                
<table class="table table-hover">
<thead>

				        
						<th style="text-align: center;">시퀀스</th>
				     	<th style="text-align: center;">열차번호</th>  <!-- ** 로 가려주기 -->
				     	<th style="text-align: center;">출발역</th>
				     	<th style="text-align: center;">변경시간</th>
						<th style="text-align: center;">출발시간</th>
				    	<th style="text-align: center;">도착역</th>  <!-- ** 로 가려주기 -->
				    	<th style="text-align: center;">도착시간</th>
					
					
</thead>
<tbody>

	 <c:if test="${not empty viewtrain}">
                  <c:forEach items="${viewtrain}" var="ulist">
                    
                    
                     <tr>
                   <!--   edtrainno,eddeparture1,eddeparturetime1,eddeparture2,eddeparturetime2,eddeparture3,eddeparturetime3,eddeparture4,eddeparturetime4,eddeparture5,eddeparturetime5 -->
                      
                      
     
                      
                      
                       <td>
                        ${ulist.runinfoseq}
                        </td>
                       
                        <td>
                        ${ulist.trainno}
                        </td>
                      
                      <td>
                           ${ulist.departure}
                        </td>
                      
             
               <td>
                    <input id="spinnerIbgoqty" name="departuretime" value="0" style="width: 30px; height: 20px;">
                </td>
                      <td>
                        ${ulist.departuretime}
                      </td>
                      
                      
                    <td>
                        ${ulist.arrival}
                        </td>
                      
                      
                         
                      
                              
                        <td>
                        ${ulist.arrivaltime}
                        </td>
                  </c:forEach>   
                   
                       </tr>         
                  
               </c:if>

</div>      
</tbody>

</table>
</form>

</body>
<div style="text-align: right;">
                  <button type="button" class="btn btn-success" onClick="goedit();">수정하기</button>     
                  </div>

   
 