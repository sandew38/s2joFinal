<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- ===== #38.  tiles 중 sideinfo 페이지 만들기 ===== --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<style type="text/css">
	${demo.css}
	
	li 
	{
		padding-bottom: 8%;
		font-size: large;
	}
	
	.badge
	{
		background-color: red;
		color: white;
	}
	
	.ho:hover{color: black; font-weight: bolder;}
	
	
	a {text-decoration:none; color:black;}
	
	/* mouse over link */
	a:hover {text-decoration:none; color: #68b3ce; }
</style>

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/highcharts/code/js/highcharts.js"></script>        <!-- 차트그리기 --> 
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/highcharts/code/js/modules/data.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/highcharts/code/js/modules/drilldown.js"></script>

<script type="text/javascript">

	$(document).ready(function() {
		loopshowNowTime();
//		showRank();
	}); // end of ready(); ---------------------------------

	function showNowTime() {
		
		var now = new Date();
	
		var strNow = now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();
		
		var hour = "";
		if(now.getHours() > 12) {
			hour = " 오후 " + (now.getHours() - 12);
		} else if(now.getHours() < 12) {
			hour = " 오전 " + now.getHours();
		} else {
			hour = " 정오 " + now.getHours();
		}
		
		var minute = "";
		if(now.getMinutes() < 10) {
			minute = "0"+now.getMinutes();
		} else {
			minute = ""+now.getMinutes();
		}
		
		var second = "";
		if(now.getSeconds() < 10) {
			second = "0"+now.getSeconds();
		} else {
			second = ""+now.getSeconds();
		}
		
		strNow += hour + ":" + minute + ":" + second;
		
		$("#clock").html("<span style='color:#639EB0; font-weight:bold;'>"+strNow+"</span>");
	
		
	}// end of function showNowTime() -----------------------------


	function loopshowNowTime() {
		showNowTime();
		
		var timejugi = 1000;   // 시간을 1초 마다 자동 갱신하려고.
		
		setTimeout(function() {
						loopshowNowTime();	
					}, timejugi);
		
	}// end of loopshowNowTime() --------------------------
	
</script>

<div id = "outer" style=" margin-top: 56px;">
	<div id = "logo" align="center" style="margin-top: 10%; margin-bottom: 10%;">
		<a href="<%=request.getContextPath()%>/khx.action" style = "color : #0D696C; text-decoration: none;">
			<img alt="khxlogo" src="<%=request.getContextPath()%>/resources/images/khxlogo1.png" style="width: 50%; position: relative; z-index: 1; right : -60px;"/>
			
 	
			<a href="<%=request.getContextPath() %>/jsb/alarmList.action" style="color: white; font-size: medium;">댓글알람
		       
				
				<span class="fa fa-commenting-o ho" style="font-size:30px; color:#639EB0; text-align: left; position: relative; z-index: 2; left:-10px;"> 
	
				<c:if test="${sessionScope.loginuser != null}">	
					<c:if test="${sessionScope.getResultAlarm.resultCount != 0 && sessionScope.getResultAlarm.resultCount != null}">
						<span class="badge" style=" left:-20px; font-weight: bold; font-size: small; vertical-align: super; position: relative; z-index: 3;">					
							${sessionScope.getResultAlarm.resultCount}
						</span> 
				</span>	
					</c:if>
					
					<c:if test="${sessionScope.getResultAlarm.resultCount == null }">
						<span class="badge" style=" left:-20px; font-weight: bold; font-size: small; vertical-align: super; position: relative; z-index: 3;">					
							0
						</span> 
				</span>	
					</c:if>
							
				</c:if>
			</a>
			
			 <h4>KHX 통합 예매</h4>
		
		</a>

		
	</div>
	<div align="center" >
		<ul style="list-style: none; margin-top: 30%; padding-bottom: 30%;" >
		
		<%-- 관리자가 아닌 경우  --%>
		<c:if test="${sessionScope.loginuser == null || !sessionScope.loginuser.userid.equals('admin')}">
			<li><a href="<%=request.getContextPath()%>/khx.action">기차예매</a></li>
			<li></li>
			<%-- <li><a href="<%=request.getContextPath()%>/lsk/bookingcheck.action">예매확인</a></li> --%>
					      <!-- ===== #2.정회원 로그인 성공 시 사용자 성명 출력하기. ===== -->
        <c:if test="${sessionScope.loginuser != null && !sessionScope.loginuser.userid.equals('admin')}">

             <li><a href="<%=request.getContextPath()%>/lsk/bookingcheck.action">예매확인</a></li>
             <li></li>
        </c:if> 
			
			<li><a href="<%=request.getContextPath()%>/khx.action">운행정보</a></li>
			<!-- <li>이용안내</li> -->
			<li></li>
			<li><a href="<%=request.getContextPath()%>/hjs/stationInfo.action">기차역정보</a></li>
			<li></li>
			<li><a href="<%=request.getContextPath() %>/jsb/helpBoard.action">고객센터</a></li>
			<li></li>
			<li><a href="<%=request.getContextPath()%>/jsb/recommendList.action">게시판</a></li>
			<li></li>
			<li><a href="<%=request.getContextPath()%>/alluserloss.action">유실물센터</a></li>
		</c:if>
			
		<%-- 관리자인경우 --%>
		<c:if test="${sessionScope.loginuser != null && sessionScope.loginuser.userid.equals('admin')}">
			<li><a href="<%=request.getContextPath()%>/khx.action">기차예매</a></li>
			<li></li>
			<%-- <li><a href="<%=request.getContextPath()%>/lsk/bookingcheck.action">예매확인</a></li> --%>
					      <!-- ===== #2.정회원 로그인 성공 시 사용자 성명 출력하기. ===== -->
        <c:if test="${sessionScope.loginuser != null && !sessionScope.loginuser.userid.equals('admin')}">

             <li><a href="<%=request.getContextPath()%>/lsk/bookingcheck.action">예매확인</a></li>
        </c:if> 
			<li></li>
			<li><a href="<%=request.getContextPath()%>/khx.action">운행정보</a></li>
			<!-- <li>이용안내</li> -->
			<li></li>
			<li><a href="<%=request.getContextPath()%>/hjs/stationInfo.action">기차역정보</a></li>
			<li></li>
			<li><a href="<%=request.getContextPath() %>/jsb/helpBoard.action">고객센터</a></li>
			<li></li>
			<li><a href="<%=request.getContextPath()%>/jsb/recommendList.action">게시판</a></li>
			<li></li>
			<li><a href="<%=request.getContextPath()%>/alluserloss.action">유실물센터</a></li>
			<li></li>
			<li><a href="<%=request.getContextPath()%>/khxyyj.action">관리자전용페이지</a></li>
			
			
			
		</c:if>

		</ul>
	</div>
	<div style="margin: 0 auto;" align="center">
		현재시각 :&nbsp; 
		<div id="clock" style="display:inline;"></div>
	</div>
	<%-- <div id="displayRank" style="min-width: 90%; margin: 0 auto;  margin-top: 20px; margin-bottom: 70px; padding-left: 10px; padding-right: 10px;"></div>
	<div id="chart-container" style="min-width: 90%; min-height: 400px; margin: 0 auto; border: solid #F0FFFF 5px;"></div>
	 --%>	
	
</div>
	
	