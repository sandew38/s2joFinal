<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- ===== #35. tiles 를 사용하는 레이아웃 페이지 만들기  ===== --%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>tiles 를 사용한 게시판 페이지 작성하기</title>

  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
  <script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>
  
  <style type="text/css">
  
 
    
 
   
  	#mycontainer	{ width:90%; margin:0 auto; padding:20px; font-family: 나눔고딕;}
	#myheaderyyj		{ background: #ffd777; border-bottom: 1px solid #c9aa5f;/*  margin-bottom: 50px; */ font-family: 나눔고딕;	 }
	#mycontent		{background-color:#F5F5F5; min-height:1000px; /* padding-top: auto; */ padding-left:auto; font-family: 나눔고딕;}
	/* #myfooter		{ background-color:#000000; height:100px; font-family: 나눔고딕; } */
	#sideinfoyyj	{  background: #424a5d; width: 210px;  height: 100%; padding-left:auto; font-family: 나눔고딕;}
	/* #displayRank 	{ margin:20px; height:200px;} */
	
	
}
	
	#myheader a {text-decoration:none;}
	
	/* mouse over link */
	#myheader a:hover {color: navy; font-weight: bolder;}
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


	<div id="sideinfoyyj">
		<div id="mysideinfo" style="border-left : 1px solid #1CE3A9; border-top: #1CE3A9 1px solid; border-bottom: #1CE3A9 1px solid; margin-right: 30px;">
			<tiles:insertAttribute name="sideinfoyyj" />
		</div>
</div>
	<div id="myheaderyyj">
		<div id="myheaderyyj">
			<tiles:insertAttribute name="myheaderyyj" />
		</div>
	</div>
		<div id="mycontent">
		  <div id="content">
			<tiles:insertAttribute name="content" />
		</div>
	
	
	</div>
</body>
</html>