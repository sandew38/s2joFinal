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





</script>




<%-- 



 <section id="main-content">
          <section class="wrapper">
          	<i class="fa fa-angle-right"></i>
			
				<div class="row">
				
  <div class="col-md-12 mt">
	                  	<div class="content-panel" style= "margin-top: 5%;">
	                          <table class="table table-hover">
	                  	  	  <h4 style="text-align: center;"><i class="fa fa-angle-right"></i> 유실물 리스트</h4>
	                  	  	  <hr>
	                              <thead style="text-align: right;" >
	                              <tr>
                                      <th style="text-align: center;">습득물명</th>
	                                  <th>분실자명</th>
	                                  <th>보관장소</th>
	                                  <th>습득일</th>
	                                  <th>분실일자</th>
	                                 
	                              </tr>
	                              </thead>
	                              
	                              <tbody>
	                              <c:if test="${not empty allLossList}">
                  <c:forEach items="${allLossList}" var="aloss">
                   
                     <tr style="text-align: right;">
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
	                  </div><!-- /col-md-12 -->
				</div><!-- row -->
		



<div align="center">
<div align="right" style="width: 400px; margin-left: 410px; margin-right: auto; padding-top: 50px;">
      ${pagebar2}
   </div>
</div>
   <br/>
   
   
   
   
   <div style="margin-left: 500px;">
   <form name="userlossFrm">
      <select name="colname2" id="colname2">
         <option value="lostno">관리번호</option>
         <option value="article">습득물명</option>
         <option value="lostname">분실자명</option>
      </select>
      
      <input type="text" name="search2" id="search2" size="40px"/>
      <button type="button" onClick="goSearch2();">검색</button>
   
   </form>
   
   </div> --%>

















<div  style="background-color:white; width:100%; height:100%; margin: auto; padding-top: 30px;  margin-bottom: 100px;">

<div class="hjs-background-panel" style="padding-top:3%;" >

<div align="left" style="width:90%; margin: 0 auto;  /* border: solid red 1px; */">
	<span class="well well-sm">${sessionScope.station}역 게시판</span>
</div>
	
<div  align="left" style="width:83%; margin-left:3%; padding-left: 10%; margin-top:3%; border: solid 0px red;">
	<span style="font-size:24px;">${sessionScope.station}역 이용후기 목록</span>
	
<div class="container" style="float:left; margin-top:1%;">	
	<div class="table-responsive">
	<table class="table" id="table">

		<tr>
			<th style="width: 40%;" >제목</th>
			<th style="width: 10%;" >성명</th>
			<th style="width: 10%;" >등록일</th>
			<th style="width: 7%;" >조회수</th>
			<th style="width: 7%;" >추천수</th>
			<th style="width: 6%;" >파일</th>
		</tr>
		
		
		<c:if test="${empty rboardList}">
		  <tr>
			<td colspan="7" align="center">작성된 이용후기가 없습니다.</td>
		  </tr>			
		</c:if>
		
		
		<c:if test="${not empty rboardList}">
		  <c:forEach var="rboardvo" items="${rboardList}" varStatus="status"> 	
			<tr>
				<td>
				 <!-- ===== 답변글인 경우 제목앞에 공백(여백)과 함께 Re 라는 글자를 붙이도록 한다. ===== -->
	             <!-- 답변글이 아닌 원글인 경우 -->
	             <c:if test="${rboardvo.depthno == 0}">          
				 	<c:if test="${rboardvo.commentCount > 0}">	
		     			<a href="<%= request.getContextPath() %>/hjs/reviewView.action?seq=${rboardvo.seq}">${rboardvo.subject}<span style="color: red; font-weight: bold; font-style: italic; font-size: smaller; vertical-align: super; ">[${rboardvo.commentCount}]</span></a> 
				 	</c:if>
				   
				 	<c:if test="${rboardvo.commentCount == 0}">
				 		<a href="<%= request.getContextPath() %>/hjs/reviewView.action?seq=${rboardvo.seq}">${rboardvo.subject}</a>
				 	</c:if>
				 </c:if>	 
				 
				 <!-- 답변글인 경우 --> 
	             <c:if test="${rboardvo.depthno > 0}">
	                 <c:if test="${rboardvo.commentCount > 0}">			
					 	<a href="<%= request.getContextPath() %>/hjs/reviewView.action?seq=${rboardvo.seq}"><span style="color: red; font-style: italic; padding-left: ${rboardvo.depthno * 20}px;">┗Re</span>${rboardvo.subject}<span style="color: red; font-weight: bold; font-style: italic; font-size: smaller; vertical-align: super; ">[${rboardvo.commentCount}]</span></a> 
					 </c:if>
					 
					 <c:if test="${rboardvo.commentCount == 0}">
					 	<a href="<%= request.getContextPath() %>/hjs/reviewView.action?seq=${rboardvo.seq}"><span style="color: red; font-style: italic; padding-left: ${rboardvo.depthno * 20}px;">┗Re</span>${rboardvo.subject}</a>
					 </c:if>
	             </c:if> 
				</td>
				<td align="center">${rboardvo.name}</td>
				<td align="center">${rboardvo.regDate}</td>
				<td align="center">${rboardvo.readCount}</td>
				<td align="center">${rboardvo.recCount}</td>
				<td align="center">
					<c:if test="${not empty rboardvo.fileName}">
						<img src="<%= request.getContextPath() %>/resources/images/disk.gif" />
					</c:if>
				</td>
			</tr>
		  </c:forEach>
		</c:if>	
		
	</table>
	</div>
	<br/>
	<div align="left">
		<button  class="btn" type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/hjs/stationReview.action?station=${sessionScope.station}'">글목록</button>
		<button style="margin-right:5px;" class="btn" type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/hjs/addReview.action?station=${sessionScope.station}'">글쓰기</button>
	</div>

	
	<!-- ===== 페이지바 보여주기 ===== -->
	<div align="center" style="margin-right: auto;">
		${pagebar}
	</div>
	<br/>
	
	<!-- ===== 글검색 폼 추가하기 : 제목, 내용, 글쓴이로 검색하도록 한다. ===== -->
  <div align="center">
	<form name="searchFrm">
		<div class="col-sm-2" style="margin-left:15%; margin-right:-2%;"> 
			<select class="form-control" name="colname" id="colname">
			  <option value="subject">제목</option>
			  <option value="content">내용</option>
			  <option value="name">성명</option>
			</select>
		</div>
		
		<div class="col-sm-6" style="margin-right:-2%;">
        	<input id="search" type="text" class="form-control" name="search" placeholder="검색어를 입력하세요">
     	</div>
     	
     	<div class="col-sm-1">
     		<button class="btn" type="button" onClick="goSearch();">검색</button>
     	</div>	
		
		<input type="hidden" name="station" id="station" value="${sessionScope.station}"/>
	</form>
  </div>

</div>

</div>

</div>
</div>
