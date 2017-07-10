<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- === # 웹채팅관련8 === --%> 
<%@ page import="java.net.InetAddress" %>
<%
	// === 서버주소 알아오기 ===
	InetAddress inet = InetAddress.getLocalHost(); 
    String serverIP = inet.getHostAddress();
%>


<%-- ===== #37.  tiles 중 header 페이지 만들기  ===== --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- SWAL -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.css"
        rel="stylesheet">

<script src=" https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.common.min.js"></script>


<style type="text/css">

#header{
	margin-top: 3%;
 	color: #FFFFFF !important;
    font-weight: 600 !important;
    font-size: 52px !important;

}

</style>
<div align="right" style="text-align: right;">


   <span style="text-align: right; height: 100px;">   
      <!-- ==== #1.비회원 로그인하지 않았을 때 아래 메뉴 출력하기. -->
         <c:if test="${sessionScope.nonloginuser == null && sessionScope.loginuser == null}">
           <a href="<%=request.getContextPath()%>/nonloginform.action" style="color: white;   font-size: medium;">비회원로그인 |</a>
           <a href="<%=request.getContextPath()%>/loginform.action" style="color: white;   font-size: medium;">로그인 |</a>
           
           <!-- <i class="fa fa-commenting-o" style="font-size:24px"></i> -->
           
           <a href="<%=request.getContextPath()%>/memberRegister.action" style="color: white;   font-size: medium;">회원가입 |</a>
           </c:if>

      <!-- ===== #2.비회원 로그인 성공 시 사용자 성명 출력하기. ===== -->
        <c:if test="${sessionScope.nonloginuser != null}" >
              <span style="color: white; font-size: medium; font-weight: bold;">${sessionScope.nonloginuser.nhp} 님 |</span> 
              <a href="<%=request.getContextPath()%>/nonlogout.action">
              	<span style="color: white; font-size: medium; font-weight: bold;">로그아웃 |</span> 
              </a>
                 
        </c:if>
      <!-- ===== #2.정회원 로그인 성공 시 사용자 성명 출력하기. ===== -->
        <c:if test="${sessionScope.loginuser != null && !sessionScope.loginuser.userid.equals('admin')}">
              <span style="color: white; font-size: medium; font-weight: bold;">${sessionScope.loginuser.name} 님 |</span> 




              <a href="<%=request.getContextPath()%>/logout.action">
            	  <span style="color: white; font-size: medium; font-weight: bold;">로그아웃 |</span> 
              </a>
              <a href="<%=request.getContextPath()%>/lsk/bookingcheck.action" style="color: white; font-size: medium;">예매확인 |</a> 
        </c:if>  
            
      <!-- ===== 관리자로 로그인 시  ===== -->
      <c:if test="${sessionScope.loginuser != null && sessionScope.loginuser.userid.equals('admin')}" >
      		<span style="color: white; font-size: medium; font-weight: bold;">${sessionScope.loginuser.name} 님 |</span> 
            <a href="<%=request.getContextPath()%>/logout.action">
            <span style="color: white; font-size: medium; font-weight: bold;">로그아웃 |</span> 
            </a>
      </c:if>
            
        <!-- #3. 항상고정 출력-->
            <a href="<%=request.getContextPath()%>/Mypage.action" style="color: white; font-size: medium;">마이페이지 |</a> 

            <a href="<%=request.getContextPath()%>/sitemap.action" style="color: white; font-size: medium;">사이트맵</a>
            

   </span>
</div>
<div id="header" align="center">
	${sessionScope.header}
</div>