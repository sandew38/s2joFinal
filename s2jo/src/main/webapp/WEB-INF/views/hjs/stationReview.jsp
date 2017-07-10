<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style type="text/css">

#table th {text-align:center; }

a{text-decoration: none;} 


.hjs-background-panel{

	max-width: 96.5%;
	min-height: 70%;
    background-color: white;
    padding: 0.01em 16px;
    margin: 20px 0;
	margin-left: 3%;
    box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;

}


.well-sm{
    position: relative !important;
    color: #FFFFFF !important;
    font-weight: 600 !important;
    font-size: 24px !important;
    text-decoration: none !important;
    padding: 11px 20px !important;
    border-radius: 0px !important;
    border: 2px solid #11939A !important;
    text-transform: uppercase !important;
    outline: none !important;
    line-height: 55px !important;
    font-family: ff-clan-web-pro, "Helvetica Neue", Helvetica, sans-serif !important;
    display: inline-block !important;
    vertical-align: middle !important;
    text-align: center !important;
    margin: 0 !important;
    overflow: visible !important;
    background-color: #0D696C !important;
    border-color: #0D696C !important;
}

</style>

<script type="text/javascript">


	$(document).ready(function(){
	
		searchKeep();

	});// end of $(document).ready()----------------------


	function goSearch(){
		
		var searchFrm = document.searchFrm;
		
		var search = $("#search").val();
		
		if(search.trim() == "") {
			alert("검색어를 입력하세요!!");
		}
		else {
			searchFrm.action = "/hjs/stationReview.action";
			searchFrm.method = "GET";
			searchFrm.submit();
		}
		
	}
	
	
	function searchKeep(){
		<c:if test="${not empty colname && not empty search}">
			$("#colname").val("${colname}"); // 검색어 컬럼명을 유지시켜 주겠다.
			$("#search").val("${search}");   // 검색어를 유지시켜 주겠다.
		</c:if>
	}


</script>


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