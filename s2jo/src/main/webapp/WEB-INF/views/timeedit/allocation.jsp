<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 
   
   
   
   
   
<!-- <link rel="stylesheet" href="resources/BootStrapStudy/css/bootstrap.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

 -->





 <!DOCTYPE html>
 <head>
 

<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/js/jquery-ui.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


  

    <!-- Bootstrap core CSS -->
    <link href="<%= request.getContextPath() %>/resources/assets/css/bootstrap.css" rel="stylesheet">
    <!--external css-->
<!--     <link href="resources/assets/font-awesome/css/font-awesome.css" rel="stylesheet" /> -->
   
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/assets/css/zabuto_calendar.css">
    
    
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/assets/js/gritter/css/jquery.gritter.css" />
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/assets/lineicons/style.css">    
    
    <!-- Custom styles for this template -->
    <link href="<%= request.getContextPath() %>/resources/assets/css/style.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/resources/assets/css/style-responsive.css" rel="stylesheet">
    
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
<script>
function goSearch(){
    
    var trainFrm = document.trainFrm;
    
    var search = $("#search").val();
    
    if(search.trim() == "") {
       alert("검색어를 입력하세요!!");
    }
    else {
       searchFrm.action = "/khx/allocation.action";
       searchFrm.method = "GET";
       searchFrm.submit();
    }
    
 }
 
function goedit(runinfoseq) {

	var editFrm = document.editFrm;
	
	editFrm.runinfoseq.value = runinfoseq;
	/* editFrm.departure.value = departure;
	editFrm.arrival.value = arrival; */
	editFrm.action = "editTrain.action";
	editFrm.method = "GET";
	
	var bool =  window.confirm( "선택하신 열차를 정말로 수정하시곘습니까?" ); 
	         
	if(bool) {
		editFrm.submit();
	}

}


function goStop(runinfoseq , status) {
 

var editFrm = document.editFrm;

var bool =  window.confirm( "선택하신 열차를 정말로 정지하시곘습니까?" ); 

if(bool && status == 1){
	editFrm.runinfoseq.value = runinfoseq;
	/* editFrm.departure.value = departure;
	editFrm.arrival.value = arrival; */
	editFrm.action = "stoptrain.action";
	editFrm.method = "GET";
	editFrm.submit();
	
	}

else if (!bool)
{
  alert("배차정지를 취소하셨습니다.");
}

else if (status==0)
{
  alert("이미 배차정지를 하셨습니다.");	
}





}
	

function gorestore(runinfoseq , status) {

	
 /*    var restoreFrm = document.restoreFrm;
 
     restoreFrm.runinfoseq.value = runinfoseq;  
    restoreFrm.action = "restoretrain.action";
    restoreFrm.method = "get";
    restoreFrm.submit();
	 */
	 
	 

	var restoreFrm = document.restoreFrm;

	var bool =  window.confirm( "선택하신 열차를 정말로 복구하시곘습니까?" ); 

	if(bool && status == 0){
	 	restoreFrm.runinfoseq.value = runinfoseq; 
		/* editFrm.departure.value = departure;
		editFrm.arrival.value = arrival; */
		restoreFrm.action = "restoretrain.action";
		restoreFrm.method = "GET";
		restoreFrm.submit();
		
		}

	else if (!bool)
	{
	  alert("배차복구를 취소하셨습니다.");	
	}

	else if (status==1)
	{
	  alert("이미 배차복구를 하셨습니다.");	
	}


	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
}




</script>
 <!--main content start-->
      <section id="main-content">
          <section class="wrapper">
          	<i class="fa fa-angle-right"></i>
				<div class="row">
				
	               


	                  <div class="col-md-12 mt">
	                  	<div class="content-panel" style= "margin-top: 5%;">
	                          <table class="table table-hover">
	                  	  	  <span style="text-align:  center;"><h4><i class="fa fa-angle-right"></i> 배차 리스트</h4></span>
	                  	  	
	                              <thead>
	                              <tr>
	                    <th style="text-align: center;">시퀀스</th>
				     	<th style="text-align: center;">열차번호</th>  <!-- ** 로 가려주기 -->
				     	<th style="text-align: center;">출발역</th>
						<th style="text-align: center;">출발시간</th>
				    	<th style="text-align: center;">도착역</th>  <!-- ** 로 가려주기 -->
				    	<th style="text-align: center;">도착시간</th>
	                                  
	                              </tr>
	                              </thead>
	                            
	                              <tbody style="text-align: center;">
	                              
	                             
	                              <c:if test="${not empty trainList}">
	                              <c:forEach items="${trainList}" var="vlist">
	                 	
	                       <tr>
                       <td>
                       ${vlist.runinfoseq}
                        </td>
                       
                        <td>
                        ${vlist.trainno}
                        </td>
                      
                      <td>
                           
                           ${vlist.departure}
                        </td>
                      
             
                      <td>
                        ${vlist.departuretime}
                      </td>
                      
                      
                    <td>
                        ${vlist.arrival}
                        </td>
                      
                        
                        <td>
                        ${vlist.arrivaltime}
                        </td>
                     
                       
                        
               
                    <td class="td"><a href="javascript:goedit('${vlist.runinfoseq}')">열차수정</a>/&nbsp;<a href="javascript:goStop('${vlist.runinfoseq}','${vlist.status}')">열차정지</a>/<a href="javascript:gorestore('${vlist.runinfoseq}','${vlist.status}')">열차복구</a></td>
                       
                      
                       </tr>         
                        </c:forEach> 
                        </c:if>     
	                              </tbody>
	                          </table>
	                  	  </div>
	                  </div><!-- /col-md-12 -->
   			</div><!-- row -->



<div align="right" style="width: 400px; margin-left: 410px; margin-right: auto; padding-top: 50px;">
      ${pagebar}
   </div>
   <br/>
    


 <div style="margin-left: 500px;">
   <form name="trainFrm">
      <select name="colname" id="colname">
         <option value="trainno">열차번호</option>
         <option value="departure">출발지</option>
         <option value="arrival">도착지</option>
      </select>
  
      <input type="text" name="search" id="search" size="40px"/>
      <button type="button" onClick="goSearch();">검색</button>
   
   </form>
</div>


<form name="editFrm">
	<input type="hidden" name="runinfoseq" />
	
</form>

<form name="restoreFrm">
<input type="hidden" name="runinfoseq" value = "${vlist.status}" />

</form>



              
		</section>
      </section><!-- /MAIN CONTENT -->




