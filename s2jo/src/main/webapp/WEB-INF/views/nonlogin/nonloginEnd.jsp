<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
		<c:if test="${n == 1 && empty url}">
		sweetAlert("","비회원 로그인 성공 !!!","warning");
			location.href="<%= request.getContextPath() %>";       
		</c:if>
		
		<c:if test="${n == 1 && not empty url}">
		sweetAlert("","비회원 로그인 성공 !!!","warning");
			location.href="${url}";       
		</c:if>
		
		<c:if test="${n == 0}">
		sweetAlert("","비회원 암호가 틀립니다 !!!","warning");
			javascript:history.back();
			// 이전 페이지로 이동
		</c:if>
			
		<c:if test="${n == -1}">
		sweetAlert("","비회원 회원가입 부터 먼저 하세요 !!","warning");
			javascript:history.back();
			// 이전 페이지로 이동
		</c:if>		
			
</script>
    