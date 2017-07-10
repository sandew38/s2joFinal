<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- ===== #37.  tiles 중 header 페이지 만들기  ===== --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%-- <link rel="stylesheet" href="<%= request.getContextPath() %>//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 --%>

<script type="text/javascript">

function goLogout(){
	
/* 	session.invalidate();
 */	
	 location.href="logout.action";
}



</script>



<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/js/jquery-ui.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 

<style type="text/css">


</style>



<body>

     <!--header start-->
      <header class="header black-bg">
              <div class="sidebar-toggle-box">
                  <div class="fa fa-bars tooltips" data-placement="right" data-original-title="Toggle Navigation"></div>
              </div>
            <!--logo start-->
            <a href="<%= request.getContextPath() %>/khxyyj.action" class="logo"><b>관리자페이지</b></a>
            <!--logo end-->
            <div class="top-menu">
            	<ul class="nav pull-right top-menu">
                    <li><a class="logout" onClick="goLogout();" <%-- href="<%=request.getContextPath()%>/login.html" --%>>Logout</a></li>
            	</ul>
            </div>
        </header>
      <!--header end-->
</body>


