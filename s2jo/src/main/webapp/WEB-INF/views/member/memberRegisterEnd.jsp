<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    


   <script type="text/javascript">
      <c:if test="${n == 1}">
         alert("회원가입 성공!!");
         location.href="/khx/khx.action"; 
         // 메인 페이지로 이동
      </c:if>
      
      <c:if test="${n != 1}">
         alert("회원가입 실패!! 입력한 사항을 확인해주세요!!");
         location.href="/khx/memberRegister.action";  
         // 회원가입 페이지로 다시 이동
      </c:if>
   </script>
