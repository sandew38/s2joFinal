<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<link rel="stylesheet" href="resources/BootStrapStudy/css/bootstrap.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>



<style type="text/css">
  .carousel-inner > .item > img,
  .carousel-inner > .item > a > img {
      width: 70%;
      margin: auto;
  }
  
  .myborder {
   border: navy solid 1px;
  }

.find_info_name {
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 30px;
}

.img_area {
    width: 370px;
    height: 370px;
    background: #eee;
    border: 1px solid #eee;
}



.find_info_txt {
    clear: both;
    width: 820px;
    padding: 20px 20px 50px 20px;
    font-size: 14px;
    line-height: 22px;
}



.detailcontent{
background-image:none;
}






.red{
    background-color:red;
}
.blue{
    background-color:blue;
}
.green{
    background-color:green;
}
.yellow{
    background-color:yellow;
}
.col-xs-5ths,
.col-sm-5ths,
.col-md-5ths,
.col-lg-5ths {
    position: relative;
    min-height: 1px;
    padding-right: 15px;
    padding-left: 15px;
}

.col-xs-5ths {
    width: 20%;
    float: left;
}

@media (min-width: 768px) {
    .col-sm-5ths {
        width: 20%;
        float: left;
    }
}

@media (min-width: 992px) {
    .col-md-5ths {
        width: 20%;
        float: left;
    }
}

@media (min-width: 1200px) {
    .col-lg-5ths {
        width: 20%;
        float: left;
    }
}





</style>



<br/>
<div  style="background-color:white; width:100%; height:100%; margin: auto; padding-top: 30px;  margin-bottom: 100px;">

<div class="detailcontent" style="width: 860px; padding-left:17%; float: left; padding-top: 3%;">

	<div class="contents_common" style="width: 100%; margin-right: 250px;">
		<nav class="sub_topnav">
			
		</nav>
	<br/>
	
		<h2>습득물 상세보기</h2>
	
	<br/><br/>
	</div>


<div class="row" style="width: 1000px;" >
		<div class="col-md-5ths col-sm-5ths red" style="width: 1000px;">
		</div>

<br/><br/><br/>
</div>

<div style="width: 860px; margin-bottom: 30px;">







<div style="float: right;
    width: 400px;
    height: 380px;
    font-size: 20px;
    padding-left: 10%;">

<p class=find_info_name>습득물명 : ${lossDetailMap.losttype} </p>
<li>관리번호 : ${lossDetailMap.lostno}</li>
<li>습득일 : ${lossDetailMap.lostdate1}년 - ${lossDetailMap.lostdate2}월 - ${lossDetailMap.lostdate3} 일</li>
<li>습득장소 : ${lossDetailMap.lostplace}</li>
<li>보관장소 : ${lossDetailMap.storageplace}</li>
 <li> 유실물상태:    
  <c:choose>
      <c:when test="${lossDetailMap.losthave == 1}">
         <span style="color: green; font-weight: bold; font-size: 15pt;">보관중</span>
         </c:when>
         <c:when test="${lossDetailMap.losthave == 2}">
         <span style="color: red; font-weight: bold; font-size: 20pt;">찾아감</span>
         </c:when>
      </c:choose>
     </li> 


</div>


<div style="float: left; "> 
<p>　첨부파일 : 　<img src="<%=request.getContextPath()%>/resources/files/${lossDetailMap.orgfilename}" style="width: 360px; height: 360px; padding-bottom: 30px;"> </p> <!-- 추후 thumbnailfilename 로 수정 -->

</div>

<div class="row" style="width: 1000px;">
		<div class="col-md-5ths col-sm-5ths red" style="width: 1000px;">
		</div>
</div>

<br/><br/><br/>

<div class="find_info_txt" style="margin-top: 20px;">
<span style="font-size:  25px;"><p> 비고 : ${lossDetailMap.lostcontent}</p></span>
<br/><br/><br/><br/><br/><br/>

<button type="button" class="btn btn-success" onClick="javascript:history.back();"style="margin-left: 900px; background-color: #01DF74; font-size: 20px;" >목록</button>

</div>





</div>


</div>

</div>
<!-- <div id="largeImg" align="center" style="border: green solid 0px; width: 45%; padding: 2%; margin: 2% auto;">
		
</div>  
 -->


