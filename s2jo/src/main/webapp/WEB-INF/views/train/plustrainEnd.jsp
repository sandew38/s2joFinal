<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    


   <script type="text/javascript">
      <c:if test="${n == 1}">
         alert("입력 성공!!");
         location.href="<%= request.getContextPath() %>/plustrain.action"; 
         // 글목록을 보여주는 페이지로 이동
      </c:if>
      
      <c:if test="${n != 1}">
         alert("입력 실패!!");
         location.href="<%= request.getContextPath() %>/plustrain.action";  
         // 글목록을 보여주는 페이지로 이동
      </c:if>
   </script>