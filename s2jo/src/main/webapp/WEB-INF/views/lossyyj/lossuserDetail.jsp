<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<style type="text/css">
  .carousel-inner > .item > img,
  .carousel-inner > .item > a > img {
      width: 70%;
      margin: auto;
  }
  
  .myborder {
   border: navy solid 1px;
  }
</style>





<script>


</script>


<div style="padding-left: 30%; border: solid 0px red; padding-top: 2%;">


<div class="container" style="margin-right: 60%; font-size: 25px; margin-top: 15%;">
	<div class="row">
        <div class="span12">
    		<table class="table table-condensed table-hover">
    			<thead>
    				<tr>
    				
    			</thead>
    			<tbody>
    		
    				<tr>
    					<td>글번호</td>
    					<td>${lossuserDetailMap.seq}</td>
    				</tr>
    				<tr>
    					<td>회원아이디</td>
    					<td>${lossuserDetailMap.userid}</td>
    				</tr>
    				<tr>
    					<td>분실물종류</td>
    					<td>${lossuserDetailMap.losskind}</td>
    				</tr>
    				<tr>
    					<td>습득일</td>
    					<td>${lossuserDetailMap.finddate1}년-${lossuserDetailMap.finddate2}월-${lossuserDetailMap.finddate3}일</td>
    				</tr>
    				<tr>
    					<td>습득장소</td>
    					<td>${lossuserDetailMap.findplace}</td>
    				</tr>
    			
    				<tr>
    					<td>비고</td>
    					<td>${lossuserDetailMap.note}</td>
    				
    				</tr>
    				<tr>
    					<td>분실자명</td>
    					<td>${lossuserDetailMap.lossname}</td>
    					
    				</tr>
    				<tr>
    					<td>습득물명</td>
    					<td>${lossuserDetailMap.article}</td>
    				
    				</tr>
    				
    				
    				
    				<tr>
    					<td>글비밀번호</td>
    					<td>${lossuserDetailMap.writepw}</td>
    					
    				</tr>
    				<tr>
    					<td>파일이미지</td>
    					<td> <img src="<%=request.getContextPath()%>/resources/userregistfiles/${lossuserDetailMap.orgfile}" /></td>
    				
    				</tr>
    				
    				
    							
    				
    			</tbody>
    		</table>
    	</div>
	</div>
</div>



<%-- 
<div align="left" style="width: 80%; padding-left: 5%; margin: 1%; font-size: 14pt; line-height: 160%;">
    <ol style="list-style-type: decimal;">
     
       
      <li>글번호 : ${lossuserDetailMap.seq} </li>
      <li>회원아이디: ${lossuserDetailMap.userid}</li>
      <li>분실물종류 : ${lossuserDetailMap.losskind}</li>
      <li>습득일 : ${lossuserDetailMap.finddate1}년-${lossuserDetailMap.finddate2}월-${lossuserDetailMap.finddate3}일</li>
      <li>습득장소 : ${lossuserDetailMap.findplace}</li>
      <li>비고 : ${lossuserDetailMap.note}</li>
      <li>분실자명 : ${lossuserDetailMap.lossname}</li>
      <li>습득명 : ${lossuserDetailMap.article}</li>
      <li>글비밀번호 : ${lossuserDetailMap.writepw}</li>
      <li>파일이미지:   ${lossuserDetailMap.orgfilename}</li> 
      <div style="width: 500px; height: 500px;">
      <li>첨부파일:<img src="<%=request.getContextPath()%>/resources/userregistfiles/${lossuserDetailMap.orgfile}" ></li>
      </div>
        
        <button type="button" onClick="javascript:history.back();">목록</button>
       
       
    </ol>
</div> --%>

<!-- 폴더안에 저장되있는 파일을 뽑아오는 -->



<%-- 
<div class="container" align="center">
  <br>
  <div id="myCarousel" class="carousel slide" data-ride="carousel" style="width: 60%;">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <c:forEach var="viewProductImagemap" items="${viewProductImageList}" varStatus="status">
         <c:if test="${status.index == 0}">
            <li data-target="#myCarousel" data-slide-to="${status.index}" class="active"></li>
         </c:if>
         <c:if test="${status.index > 0}">
            <li data-target="#myCarousel" data-slide-to="${status.index}"></li>
         </c:if>
      </c:forEach>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
     <c:forEach var="viewProductImagemap" items="${viewProductImageList}" varStatus="status">
          <c:if test="${status.index == 0}">
             <div class="item active">
          </c:if>
          <c:if test="${status.index > 0}">
             <div class="item">
          </c:if>
              <img src="<%= request.getContextPath() %>/resources/files/${viewProductImagemap.IMAGEFILENAME}" width="460px" height="345px">
              <div class="carousel-caption">
                   <h3>${viewProductmap.PRODNAME}</h3>
                   <p><fmt:formatNumber value="${viewProductmap.SALEPRICE}" pattern="###,###" /> 원</p>
              </div>
            </div>
     </c:forEach>
    </div>  end of <div class="carousel-inner" role="listbox">


    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
  </div> end of <div id="myCarousel" class="carousel slide" data-ride="carousel">
</div> end of <div class="container">

<hr style="border: dotted 5px red;">
   
<div id="largeImg" align="center" style="border: green solid 0px; width: 45%; padding: 2%; margin: 2% auto;">
      
</div>  
   
<div align="center" style="border: red solid 0px; width: 80%; margin: auto; padding: 20px;">
   <c:forEach var="viewProductImagemap" items="${viewProductImageList}" varStatus="status">
      <img src="<%= request.getContextPath() %>/resources/files/${viewProductImagemap.THUMBNAILFILENAME}" class="my_thumbnail" style="margin-right: 10px;" onClick="goLargeImgView('${viewProductmap.PRODSEQ}','${viewProductImagemap.THUMBNAILFILENAME}');" />
   </c:forEach>
</div>
   
<div align="center" style="margin-top: 10px; height: 100px; border: solid red 0px;">
   <button type="button" class="btn btn-success" style="width: 80px; height: 40px;" onClick="javascript:location.href='<%= request.getContextPath() %>/product/listProduct.action'">제품목록</button>
</div>

    --%>
   </div>
   