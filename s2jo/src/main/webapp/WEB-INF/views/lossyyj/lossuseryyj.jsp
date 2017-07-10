<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 
 
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
 function goregisterusilyyj() 
 {
     location.href="registerusilyyj.action";
 }

 
 function goregisterusiladminyyj() {
	 
	 location.href="registerusiladminyyj.action"
	 
 }
 
 
 
 
 
 function goSearch(){
     
     var searchFrm = document.searchFrm;
     
     var search = $("#search1").val();
     
     if(search.trim() == "") {
        alert("검색어를 입력하세요!!");
     }
     else {
        searchFrm.action = "/khx/lossuseryyj.action";
        searchFrm.method = "GET";
        searchFrm.submit();
     }
     
  }
 
 
 
 
 </script>
    
<style type="text/css">

table tr td
{
	border: 0px gold solid;
	text-align: center;
	padding : 3px;
}


</style>
    
    <section id="main-content">
          <section class="wrapper">


	                  <div class="col-md-12 mt">
	                  	<div class="content-panel" style= "margin-top: 5%;">
	                          <table class="table table-hover">
	                  	  	  <h4 style="text-align: center;"><i class="fa fa-angle-right"></i> 유실물 등록 리스트</h4>
	                  	  	  <hr>
	                              <thead>
	                              <tr>
	                    <th>글번호</th>
						<th>유저아이디</th>
						<th>분실물종류</th>
						<th>습득일</th>
						<th>습득장소</th>
						<th>비고</th>
						<th>분실자명</th>
						<th>습득물명</th>
						<th>글암호</th>
						
						
	                              </tr>
	                              </thead>
	                              
	                              <tbody>
	                              
                  
                    <c:if test="${not empty lossList}">
						<c:forEach items="${lossList}" var="loss">
							<tr>
							<td style="text-align: left;">
									${loss.seq}
								</td>
							
							 <td style="text-align: left;">     
                          <a href="<%=request.getContextPath() %>/lossuserDetail.action?userid=${loss.seq}">${loss.userid}</a>
                        </td>	
                    	             
                                 <td style="text-align: left;">
									${loss.losskind}   
								</td>
								<td style="text-align: left;">
									${loss.finddate1}년-${loss.finddate2}월-${loss.finddate3}일
								</td>
								<td style="text-align: left;">
								${loss.findplace}
								</td>
								<td style="text-align: left;">
									${loss.note}
								</td>
								<td style="text-align: left;">
								${loss.lossname}
								</td>
								<td style="text-align: left;">	
								 	${loss.article}				
								</td>			
								
								<td style="text-align: left;">	
								 	${loss.writepw}				
								</td>			
								
										
						</c:forEach>
					</c:if>
	                              </tbody>
	                          </table>
	                  	  </div><! --/content-panel -->
	                  </div><!-- /col-md-12 -->
				</div><!-- row -->
		



					
		<!-- 			
			<div style="width:100%; margin: 0 auto; /* border: solid red 1px; */">
		<div id="background" class="">
			<button type="button" 
				style="height: 50px; width: 100px;" 
				class="btn btn-warning"
				onclick="goregisterusilyyj();"> 유실물등록(유저) </button>
			   
			    <button type="button" 
				style="height: 50px; width: 100px;" 
				class="btn btn-warning"
				onclick="goregisterusiladminyyj();"> 유실물등록(관리자) </button>
				
	  	</div>
	</div>	
	
	 -->
	
	
					
				</table>		
 
 <div align="center">
 
<div align="right" style="width: 400px; margin-left: 700px; margin-right: auto; padding-top: 50px; ">
      ${pagebar1}
   </div>
   </div>
   <br/>
    
   
   
    <div align="center">
   <form name="searchFrm">
      <select name="colname1" id="colname1">
         <option value="userid">아이디</option>
         <option value="losskind">분실물종류</option>
         <option value="lossname">분실자명</option>
      </select>
       	
      <input type="text" name="search1" id="search1" size="40px"/>
      <button type="button" onClick="goSearch();">검색</button>
   
   </form>
</div>

<div>
<div style="text-align:right; width:100%; margin: 0 auto; padding-left: 150px; /* border: solid red 1px; */">
		<!-- <div id="background" class="">
			<button type="button" 
				style="height: 50px; width: 150px;" 
		     	class="btn btn-success"
				onclick="goregisterusilyyj();"> 유실물등록(유저) </button>
			 -->
			<!-- <div style="text-align: right;"> -->
			    <button type="button" 
				style="height: 50px; width: 150px;" 
				class="btn btn-success"
				onclick="goregisterusiladminyyj();"> 유실물등록(관리자) </button>
			
			</div>
				
	  	</div>
	</div>	
</div>


   </section>
   </section>
   
