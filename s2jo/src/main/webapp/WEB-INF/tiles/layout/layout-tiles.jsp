<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- ===== #35. tiles 를 사용하는 레이아웃 페이지 만들기  ===== --%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<style type="text/css">

#khxbackgroundimg 
{
	background:url("<%=request.getContextPath()%>/resources/images/khxbackground.png") no-repeat;
	background-size: 100%;
	width : 100%;
	height: 100%;
	z-index: 1;
	
}

</style>

    
<!DOCTYPE html>
<html>
<head>


<meta charset="UTF-8">
<title>여행의 시작은 KHX와 함께</title>

  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
  <script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>
  
  <style type="text/css">
  	#mycontainer	{ width:1900px; padding-left:20px; padding-right:20px; padding-top:20px; font-family: 나눔고딕;}
	#myheader		{ float:right; height:20%; width :85%; padding-left:10px; padding-right:10px; padding-top:10px; font-family: 나눔고딕;}
	#mycontent		{ float:left; width:85%; min-height: 85%; font-family: 나눔고딕;}
	#mysideinfo		{ background-color:#FFFFFF; float:left; width:15%; height: 100%; font-family: 나눔고딕;}
	#sideinfoyyj	{ background-color:#FFFFFF; float:left; width:15%; min-height:1200px; padding-top: 10px; font-family: 나눔고딕;}
	#myfooter		{ float:right; background-color:#000000; clear:both; width:85%; height:20%; font-family: 나눔고딕;}
	/* #displayRank 	{ margin:20px; height:200px;} */
	
	#myheader a {text-decoration:none; color:black;}
	
	/* mouse over link */
	#myheader a:hover {text-decoration:none; color: #68b3ce; font-weight: bolder;}
	/* 
	  unvisited link 
	a:link {color: #FF0000;}
		
	  visited link 
	a:visited {color: #00FF00;}
		
	  selected link 
	a:active {color: #0000FF;}
	*/
	
	#myheader .mynav {font-size: 13pt;}
	.myrank {font-weight:bold; color:red; font-size:13pt;}
	.mynumber {text-align:center;}
	
	</style>
</head>


<body>

	<div id="mycontainer" style="overflow:auto;">
		<div id="mysideinfo">
			<tiles:insertAttribute name="sideinfo" />
		</div>

		<div id = "khxbackgroundimg">
			<div id="myheader">	
				<tiles:insertAttribute name="header" />
			</div>
			<div id="mycontent" style="overflow-y: auto;">
				<div class="scrollBlind">
					<tiles:insertAttribute name="content" />
				</div>
			</div>
			<div id="myfooter" >
				<tiles:insertAttribute name="footer" />
			</div>
		</div>		
			
	</div>

</body>
</html>