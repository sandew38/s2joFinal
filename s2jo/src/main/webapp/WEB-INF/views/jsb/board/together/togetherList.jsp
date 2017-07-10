<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
 <style type="text/css">
	#table th {text-align:center; }

a{text-decoration: none;} 


.hjs-background-panel{

	min-width: 50%;
	min-height: 70%;
    background-color: white;
    padding: 0.01em 16px;
    margin: 20px 0;
	margin-left: 3%;
    box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;

}


.well-sm-r{
    position: relative !important;
    color:  #FFFFFF !important;
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

.well-sm-t{
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
    background-color: #00AF87 !important;
    border-color: #00AF87 !important;
}

.well-sm-w{
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
		
		$("#displayList").hide();
	
	    $("#search").keyup(function(){
	    	
	    	var form_data = { colname : $("#colname").val(),  // 키값 : 밸류값 
	    	       		      search  : $("#search").val()    // 키값 : 밸류값 
	    	       		    };
	    	
	    	$.ajax({
	    		url: "/khx/jsb/togWordSearchShow.action",
	    		type: "GET",
	    		data: form_data,  // url 요청페이지로 보내는 ajax 요청 데이터
	    		dataType: "JSON", 
	    		success: function(data){
	    			
	    		// ===== #152. Ajax 로 검색어 입력시 자동글 완성하기 7 ===== 
	    		   if(data.length > 0) {
	    			  // 검색된 데이터가 있는 경우.
	    			  // 조심할것은 if(data != null) 으로 하면 안된다.
	    			   var resultHTML = "";
	    			  
	    			   $.each(data, function(entryIndex, entry){
	    				   var wordstr = entry.RESULTDATA.trim();
						    
                            var index = wordstr.toLowerCase().indexOf( $("#search").val().toLowerCase() ); 
						    var len = $("#search").val().length;
						    var result = "";
						    
						    result = "<span class='first' style='color: blue;'>" +wordstr.substr(0, index)+ "</span>" + "<span class='second' style='color: red; font-weight: bold;'>" +wordstr.substr(index, len)+ "</span>" + "<span class='third' style='color: blue;'>" +wordstr.substr(index+len, wordstr.length - (index+len) )+ "</span>";        
                           
							resultHTML += "<span style='cursor: pointer;'>" + result + "</span><br/>"; 	   
	    			   });
	    			  
	    			   $("#displayList").html(resultHTML);
	    			   $("#displayList").show();
	    		   }
	    		   else {
	    			  // 검색된 데이터가 없는 경우.
	    			  // 조심할것은 if(data == null) 으로 하면 안된다.
	    			   $("#displayList").hide();
	    		   }
	    			
	    		},
	    		error: function(){
	   				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error); 
	   		    }
	    	});
	    	
	    }); // end of keyup(function(){})---------
	    
	    
	    // ===== #153. Ajax 로 검색어 입력시 자동글 완성하기 8 ===== 
	    $("#displayList").click(function(event){
			var word = "";
			
			var $target = $(event.target);
			
			if($target.is(".first")) {
				word = $target.text() + $target.next().text() + $target.next().next().text();
			//	alert(word);
			}
			else if($target.is(".second")) {
				word = $target.prev().text() + $target.text() + $target.next().text();
			//	alert(word);
			}
			else if($target.is(".third")) {
				word = $target.prev().prev().text() + $target.prev().text() + $target.text();
			//	alert(word);
			}
			
			$("#search").val(word); // 텍스트박스에 검색된 결과의 문자열을 입력해준다.
			
			$("#displayList").hide();
			
	    });// end of $("#displayList").click()---------	
	    
	
		
	});// end of $(document).ready()---------------------- 
	
	
	function goSearch(){
		
		var searchFrm = document.searchFrm;
		
		var search = $("#search").val();
		
		if(search.trim() == "") {
			alert("검색어를 입력하세요!!");
		}
		else {
			searchFrm.action = "/khx/jsb/togetherList.action";
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

<div style="background-color:white; width:100%; height:100%; margin: auto; padding-top: 30px;  margin-bottom: 100px;">
<div class="hjs-background-panel" style="padding-top:3%;">

<div align="left" style=" display: inline-block; margin: 0 auto; cursor: pointer; padding-left: 20%;" onClick="javascript:location.href='<%= request.getContextPath() %>/jsb/recommendList.action'">
	<span class="well well-sm-r">여기 추천해요</span>
</div>

<div align="center" style=" display: inline-block; margin: 0 auto;cursor: pointer; padding-left:10%;" onClick="javascript:location.href='<%= request.getContextPath() %>/jsb/togetherList.action'">
	<span class="well well-sm-t">함께 여행해요</span>
</div>

<div align="right" style=" display: inline-block; margin: 0 auto; cursor: pointer; padding-left: 10%;" onClick="javascript:location.href='<%= request.getContextPath() %>/jsb/worryingList.action'">
	<span class="well well-sm-w">여긴 주의해요</span>
</div>

<div style=" border: solid 0px red; padding-bottom: 5%; "  class="container">

<br/>	
<br/>
	<span style="font-size:28px; color: #00AF87; font-weight: bold; ">함께해요 </span><span style="font-size:24px;  ">글 목록</span>
	

	<table id="table"  class="table table-hover" >
		<tr>
			<th style="width: 70px; text-align: center;" align="center" >글번호</th>
			<th style="width: 300px;text-align: center;" align="center" >제목</th>
			<th style="width: 70px; text-align: center;" align="center">아이디</th>
			<th style="width: 100px; text-align: center;" align="center">날짜</th>
			<th style="width: 70px; text-align: center;" align="center">조회수</th>
			<th style="width: 70px; text-align: center;" align="center">추천</th>
			<th style="width: 70px; text-align: center;" align="center">비추천</th>
			
		</tr>
		
		<c:forEach var="boardvo" items="${boardList}" varStatus="status"> 
			<tr>
				<td align="center">${boardvo.seq}</td>
				
				
				 <td>
	             <!-- ===== #126. 답변글인 경우 제목앞에 공백(여백)과 함께 Re 라는 글자를 붙이도록 한다. ===== -->
	             <!-- 답변글이 아닌 원글인 경우 -->
	             
		             <c:if test="${boardvo.commentCount > 0}">			
					 <a href="<%= request.getContextPath() %>/jsb/togetherView.action?seq=${boardvo.seq}&writer=${boardvo.userid}">${boardvo.subject}<span style="color: red; font-weight: bold; font-style: italic; font-size: smaller; vertical-align: super; ">[${boardvo.commentCount}]</span></a>
					
					 </c:if>
					 
					 <c:if test="${boardvo.commentCount == 0}">
					 <a href="<%= request.getContextPath() %>/jsb/togetherView.action?seq=${boardvo.seq}&writer=${boardvo.userid}">${boardvo.subject}</a>
					
					 </c:if>
					  
					  
					 <!-- =====  첨부파일 여부 표시하기(이미지로 표시함) ===== --> 
					  <c:if test="${not empty boardvo.fileName}">
						<img src="<%= request.getContextPath() %>/resources/images/disk.gif" />
					 </c:if> 
	           
	             <%--
	             <!-- 답변글인 경우 --> 
	             <c:if test="${boardvo.depthno > 0}">
		             <c:if test="${boardvo.commentCount > 0}">			
					 <a href="<%= request.getContextPath() %>/view.action?seq=${boardvo.seq}"><span style="color: red; font-style: italic; padding-left: ${boardvo.depthno * 20}px;">┗Re</span>${boardvo.subject}<span style="color: red; font-weight: bold; font-style: italic; font-size: smaller; vertical-align: super; ">[${boardvo.commentCount}]</span></a> 
					 </c:if>
					 
					 <c:if test="${boardvo.commentCount == 0}">
					 <a href="<%= request.getContextPath() %>/view.action?seq=${boardvo.seq}"><span style="color: red; font-style: italic; padding-left: ${boardvo.depthno * 20}px;">┗Re</span>${boardvo.subject}</a>
					 </c:if>
	             </c:if>
	             --%>
				 </td> 
				<td align="center">${boardvo.userid}</td>
				<td align="center">${boardvo.regDate}</td>
				
				<td align="center">${boardvo.readCount}</td>
				<td align="center">${boardvo.tLikeCnt }</td>
				<td align="center">${boardvo.tDisLikeCnt }</td>
				
				
			</tr>
		</c:forEach>
		
		
	</table>
	
	<br/>
	<button class="btn" type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/jsb/togetherList.action'">글목록</button>&nbsp;
	<button class="btn" type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/jsb/togetherAdd.action'">글쓰기</button>
	
	<!-- ===== #115. 페이지바 보여주기 ===== -->
	<div align="center" style="width: 80%; margin-left: 5%;">
		${pagebar}
	</div>
	<br/>
	
	<!-- =====글검색 폼 추가하기 : 제목, 내용, 글쓴이로 검색하도록 한다. ===== -->
	<div style="padding-bottom: 20px;">
		<!-- =====글검색 폼 추가하기 : 제목, 내용, 글쓴이로 검색하도록 한다. ===== -->
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
		</form>
	</div>
	

	<div id="displayList" style="width:302px; margin-left: 3px; border: solid 1px gray; border-top: 0px;">
	</div>   
	 
	
	
	
	</div>
</div>
</div>
