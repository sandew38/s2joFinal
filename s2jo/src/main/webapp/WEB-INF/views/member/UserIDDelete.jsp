<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    


   <script type="text/javascript">
      <c:if test="${n == 1}">
      sweetAlert("","회원삭제 성공!!","warning");   
         location.href="<%= request.getContextPath() %>/"; 
         // 글목록을 보여주는 페이지로 이동
      </c:if>
      
      <c:if test="${n != 1}">
      sweetAlert("","회원삭제 실패!!","warning");   
         location.href="<%= request.getContextPath() %>/Mypage.action";  
         // 글목록을 보여주는 페이지로 이동
      </c:if>	
            
         
   </script>
   
   
   
   
   