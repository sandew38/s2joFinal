<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
		<c:if test="${n == 1 && empty url}">
		sweetAlert("","로그인 성공 !!","warning");
		//alert("KHX에 오신것을 환영합니다!")
		location.href="<%= request.getContextPath()%>";      
		</c:if>

		<c:if test="${n == 1 && not empty url}">
		sweetAlert("","로그인 성공 !!","warning");
		//alert("KHX에 오신것을 환영합니다!!");
		location.href="<%= request.getContextPath()%>";
		</c:if>

		<c:if test="${n == 1 && sessionScope.loginuser != null && sessionScope.loginuser.userid.equals('admin')}">
	    //alert("관리자계정으로 로그인하였습니다!");
		location.href= "<%= request.getContextPath() %>/khxyyj.action";
	    </c:if>			
	      
	    <c:if test="${n == 1 && sessionScope.loginuser != null && !sessionScope.loginuser.userid.equals('admin')}">
	    //alert("정회원계정으로 로그인하였습니다!");
	    location.href= "<%= request.getContextPath() %>";
	    </c:if>				

	    <c:if test="${n == 0}">
		sweetAlert("","암호가 틀립니다 !!","warning");
		//alert("입력하신 비밀번호가 틀립니다. 확인해주세요!!");
			javascript:history.back();
			// 이전 페이지로 이동
		</c:if>
			
		<c:if test="${n == -1}">
		sweetAlert("","존재하지 않는 아이디 입니다. 회원가입 먼저 해주세요!!","warning");
		//alert("존재하지 않는 아이디 입니다. 회원가입 먼저 해주세요!!")
			location.href="<%= request.getContextPath()%>/memberRegister.action";       

		</c:if>	
		<c:if test="${n == 2}">
		//sweetAlert("","회원탈퇴처리중인 아이디입니다. 계정내용을 확인해주세요!","warning");
		alert("회원탈퇴처리중인 아이디입니다. 계정내용을 확인해주세요!");
		location.href="<%= request.getContextPath()%>/loginform.action";
		</c:if>

	      
</script>
    