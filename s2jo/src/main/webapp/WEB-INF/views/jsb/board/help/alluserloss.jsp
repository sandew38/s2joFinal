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

<style type="text/css">

table tr td
{
	border: 0px gold solid;
	text-align: center;
	padding : 3px;
}


</style>

 
 
 
<script>



function goSearch2(){
    
    var userlossFrm = document.userlossFrm;
    
    var search2 = $("#search2").val();
    
    if(search2.trim() == "") {
       alert("검색어를 입력하세요!!");
    }
    else {
       searchFrm.action = "/khx/alluserloss.action";
       searchFrm.method = "GET";
       searchFrm.submit();
    }
    
 }



function goregisterusilyyj() 
{
    location.href="registerusilyyj.action";
}


</script>

<div  style="background-color:white; width:100%; height:100%; margin: auto; padding-top: 30px;  margin-bottom: 100px;">

<div class="hjs-background-panel" style="padding-top:3%;" >
<%-- 
<div align="left" style="width:90%; margin: 0 auto;  /* border: solid red 1px; */">
	<span class="well well-sm">${sessionScope.station}역 게시판</span>
</div>
	 --%>
<div  align="left" style="width:83%; margin-left:3%; padding-left: 10%; margin-top:3%; border: solid 0px red;">
	<span style="font-size:24px;">유실물 센터</span>
	
<div class="container" style="float:left; margin-top:1%;">	
	<div class="table-responsive">
	<table class="table" id="table">

		<tr>
			<th style="width: 40%; text-align: center;" >관리번호</th>
			<th style="width: 10%;" >습득물명</th>
			<th style="width: 10%;" >분싷자명</th>
			<th style="width: 7%;" >보관장소</th>
			<th style="width: 16%;" >주운일자</th>
			
		</tr>
		
		
		 <tbody>
	                              <c:if test="${not empty allLossList}">
                  <c:forEach items="${allLossList}" var="aloss">
                   
                     <tr style="margin-right: 60px;">
                     <td>     
                          <a href="<%=request.getContextPath() %>/lossDetail.action?lostno=${aloss.lostno}">${aloss.lostno}</a>
                        </td>
                     
                        <td style="text-align: left;">
                           ${aloss.article}
                        </td>
                        <td style="text-align: left;">
                           ${aloss.lostname}   
                        </td>
                        <td style="text-align: left;">
                        ${aloss.storageplace}
                        </td>
                        <td style="text-align: left;">
                           ${aloss.lostdate1}년-${aloss.lostdate2}월-${aloss.lostdate3}일
                        </td>
                     </tr>         
                              
                  </c:forEach>
               </c:if>


	                              </tbody>
</table>
</div>

	
	<!-- ===== 페이지바 보여주기 ===== -->
	<div align="center" style="margin-right: auto;">
		${pagebar2}
	</div>
	<br/>
	
	<!-- ===== 글검색 폼 추가하기 : 제목, 내용, 글쓴이로 검색하도록 한다. ===== -->
  <div align="center">
	<form name="userlossFrm">
		<div class="col-sm-2" style="margin-left:15%; margin-right:-2%;"> 
			<select class="form-control" name="colname2" id="colname2">
			  <option value="lostno">관리번호</option>
			  <option value="article">습득물명</option>
			  <option value="lostname">분실자명</option>
			</select>
		</div>    
		
		<div class="col-sm-6" style="margin-right:-2%;">
        	<input id="search2" type="text" class="form-control" name="search2" placeholder="검색어를 입력하세요">
     	</div>
     	
     	<div class="col-sm-1">
     		<button class="btn" type="button" onClick="goSearch()2;">검색</button>
     	</div>	
		
	</form>
<div id="background" class="">

	<br/><br/><br/><br/>
			<button type="button" 
				style="height: 50px; width: 150px;" 
		     	class="btn btn-success"
				onclick="goregisterusilyyj();"> 유실물등록(유저) </button>
				</div>
  </div>

</div>

</div>


</div>

</div>

