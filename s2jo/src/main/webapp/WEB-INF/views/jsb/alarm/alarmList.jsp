<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>





<div class="container" align="center" style=" width: 100%; height: 100%; background-color: white; border: solid 1px red;">
	
	<br/><br/><br/><br/>
	 <h2>알람기능</h2>
	 
	<table class="table table-hover"  id="table" style="pa: 20%; width: 60%; border: solid 0px red;">
		<tr>
			<th style="width: 50px; text-align: center;"  >글번호</th>
			<th style="width: 80px; text-align: center;" >글제목</th>
			<th style="width: 80px; text-align: center;" >게시판</th>
			<th style="width: 80px; text-align: center;">추가된 댓글 수</th>
		</tr>
		<c:forEach var="rAlarmvo" items="${rAlarmList}" varStatus="status">
				
				<c:if test="${rAlarmvo.count != 0 && rAlarmvo.userid == sessionScope.loginuser.userid }">
					<tr>
						<th style=" text-align: center;" ><a href="<%= request.getContextPath() %>/jsb/recommendView.action?seq=${rAlarmvo.boardSeq }&writer=${rAlarmvo.userid}">${rAlarmvo.boardSeq }</a></th>
						<th style="text-align: center;"><a href="<%= request.getContextPath() %>/jsb/recommendView.action?seq=${rAlarmvo.boardSeq }&writer=${rAlarmvo.userid}">${rAlarmvo.boardSubject }</a></th>
						<th style="text-align: center;">추천게시판</th>
						<th style="text-align: center;">${rAlarmvo.count }
					</tr>
				</c:if>
		</c:forEach>
		<c:forEach var="tAlarmvo" items="${tAlarmList}" varStatus="status">
				<c:if test="${tAlarmvo.count != 0 && tAlarmvo.userid == sessionScope.loginuser.userid }">
					<tr>
						<th style=" text-align: center;" ><a href="<%= request.getContextPath() %>/jsb/togetherView.action?seq=${tAlarmvo.boardSeq }&writer=${tAlarmvo.userid}">${tAlarmvo.boardSeq }</a></th>
						<th style="text-align: center;"><a href="<%= request.getContextPath() %>/jsb/togetherView.action?seq=${tAlarmvo.boardSeq }&writer=${tAlarmvo.userid}">${tAlarmvo.boardSubject }</a></th>
						<th style="text-align: center;">함께해요게시판</th>
						<th style="text-align: center;">${tAlarmvo.count }
					</tr>
				</c:if>
		</c:forEach>
		<c:forEach var="wAlarmvo" items="${wAlarmList}" varStatus="status">
				<c:if test="${wAlarmvo.count != 0 && wAlarmvo.userid == sessionScope.loginuser.userid }">
					<tr>
						<th style=" text-align: center;" ><a href="<%= request.getContextPath() %>/jsb/worryingView.action?seq=${wAlarmvo.boardSeq }&writer=${wAlarmvo.userid}">${wAlarmvo.boardSeq }</a></th>
						<th style="text-align: center;"><a href="<%= request.getContextPath() %>/jsb/worryingView.action?seq=${wAlarmvo.boardSeq }&writer=${wAlarmvo.userid}">${wAlarmvo.boardSubject }</a></th>
						<th style="text-align: center;">위험해요게시판</th>
						<th style="text-align: center;">${wAlarmvo.count }
					</tr>
				</c:if>
		</c:forEach>		
		
	</table>
	



</div>