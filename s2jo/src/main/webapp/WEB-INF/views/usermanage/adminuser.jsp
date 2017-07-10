<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 
   
<link rel="stylesheet" href="resources/BootStrapStudy/css/bootstrap.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


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

    <script src="/resources/assets/js/chart-master/Chart.js"></script>
    
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
<script>


function goSearch3(){
    
    var userFrm = document.userFrm;
    
    var search3 = $("#search3").val();
    
    if(search3.trim() == "") {
       alert("검색어를 입력하세요!!");
    }
    else {
       searchFrm.action = "/khx/adminuser.action";
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
    
				<div class="row">
			    



  <div class="col-md-12 mt">
	                  	<div class="content-panel" style= "margin-top: 5%;">
	                          <table class="table table-hover">
	                  	  	  <h4 style="text-align: center;"><i class="fa fa-angle-right"></i> 회원관리</h4>
	                  	  	  <hr>
	                              <thead>
	                              <tr>
                        <th style="text-align: center;">아이디</th>
						<th style="text-align: center;">이름</th>
				    <!--  	<th style="text-align: center;">비밀번호</th> -->  <!-- ** 로 가려주기 -->
						<th style="text-align: center;">이메일</th>
						<th style="text-align: center;">전화번호</th>
						<th style="text-align: center;">우편번호</th>
						<th style="text-align: center;">주소1</th>
						<th style="text-align: center;">주소2</th>
						<th style="text-align: center;">가입날짜</th>
						<th style="text-align: center;">회원유무</th>
						<th style="text-align: center;">생일</th>
						<th style="text-align: center;">성별</th>
	                                 
	                              </tr>
	                              </thead>
	                              
	                              <tbody>
	           <c:if test="${not empty userList}">
                  <c:forEach items="${userList}" var="ulist">
                     <tr>
                      <td>     
                          <a href="<%=request.getContextPath() %>/userdetailList.action?userid=${ulist.userid}">${ulist.userid}</a>
                        </td>
                     
                     
                        <td>
                           ${ulist.name}   
                        </td>
                      <%--   <td>
                        ${ulist.pwd}
                        </td> --%>
                      
                         <td>
                           ${ulist.email}
                        </td>
                        <td>
                           ${ulist.hp}   
                        </td>
                        <td>
                        ${ulist.post}
                        </td>
                   
                   
                         <td>
                           ${ulist.addr1}
                        </td>
                        <td>
                           ${ulist.addr2}   
                        </td>
                        <td>
                        ${ulist.joindate}
                        </td>
                      
                         <td>
                           ${ulist.status}
                        </td>
                        <td>
                           ${ulist.birthday}   
                        </td>
                        
                     
                     <td>
                     
                      <c:choose>
                     <c:when test="${ulist.gender == 1}">
         <span style="color: blue; font-weight: bold; font-size: 10pt;">남</span>
         </c:when>
          <c:when test="${ulist.gender == 2}">
         <span style="color: red; font-weight: bold; font-size: 10pt;">여</span><br/>
         </c:when>
         </c:choose>
         </td>
         
         
         
         
         
         
         
         
                   <%--    <td>
                           ${ulist.gender}   
                        </td>
                       --%>
                      
                      
                       </tr>         
                              
                  </c:forEach>
               </c:if>
	
	                              </tbody>
	                          </table>
	                  	  </div><! --/content-panel -->
	                  </div><!-- /col-md-12 -->
				</div><!-- row -->
		
<div align="right" style="width: 400px; margin-left: 560px; margin-right: auto; padding-top: 50px;">
      ${pagebar3}
   </div>
   <br/>






 
  <div align="center">
   <form name="userFrm">
      <select name="colname3" id="colname3">
         <option value="userid">아이디</option>
         <option value="name">이름</option>
         <option value="birthday">생일</option>
      </select>
  
      <input type="text" name="search3" id="search3" size="40px"/>
      <button type="button" onClick="goSearch3();">검색</button>
   
   </form>
   
   </div>
   
