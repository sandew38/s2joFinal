<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- SWAL -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.css" rel="stylesheet">
<script src=" https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.common.min.js"></script>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>

<style type="text/css">

.btn_s2{
	width:70%; 
	height:50px;
	margin:0 auto;
	padding-top:20px;
	}


.button01_s2 {
	float:left;
	width: 35%;
	height: 40px;
	background-color: #3498db;
	text-align: center;
	font-size: 20px;
	font-weight:bold;
	color: #f7f1e3;
	display: inline-block;
	cursor: pointer;
	}
	
.button02_s2 {
	float: right;
	width: 35%;
	height: 40px;
	margin-left: 50px;
	background-color: #e0e0e0;
	text-align: center;
	font-size: 20px;
	font-weight:bold;
	color: #5e5e5e;
	cursor: pointer;
} 



/* ////////////////////////////////// */



</style>
		
<script type="text/javascript">

function goCancel() {
	
	var cancelForm = document.cancelForm;
	cancelForm.method = "GET";
	cancelForm.action = "/khx/lsk/bookingCancel.action";
	
	cancelForm.submit();
	
}

/* 
function goCancel() {
	swal({
		  title: '예매한 티켓을 취소하시겠습니까?',
		  text: "예매취소후에는 다시 예매를 진행하실 수 있습니다.",
		  type: 'warning',
		  
		  showCancelButton: true,
		  confirmButtonColor: '#639eb0',
		  cancelButtonColor: '#d33',
		  confirmButtonText: '예매 취소!'
		}).then(function () {

		  swal({title : '예매가 취소되었습니다!',
			    text : '예매취소가 완료되었습니다. 이용하여 주셔서 감사합니다.',
			    type : 'success',
			    timer: 10000
		  })
		  	var cancelForm = document.cancelForm;
		  	cancelForm.method = "GET";
		  	cancelForm.action = "/khx/lsk/bookingCancel.action";
			
		  	cancelForm.submit();
		})
}
*/

</script>

<div class="#" style="background-color: white; padding-top: 7%;">

<div class="container">

  <ul class="nav nav-tabs" style="width: 100%; text-align: center;">
    <li class="active" style="margin-left: 15%; width: 35%; text-align: center; display: inline-block;" ><a data-toggle="tab" href="#home">예매내역</a></li>
    <li style="width: 35%;"><a data-toggle="tab" href="#menu1">취소내역</a></li>
  </ul>
  
	<div class="tab-content">
	
	<!-- form -->
	<!-- <form name="bookingInfo"> -->
	
	<div id="home" class="tab-pane fade in active">
	
	<c:if test="${bmap != null}">
    <c:forEach items="${bmap}" var="bmap">
    	<div class="date_s2" style="border: 1px solid #639EB0; text-align: center; margin-top: 7%;">
 			<h3>${bmap.DEPARTUREDATE} ${bmap.DEPARTURETIME} 출발  / 
 			결제금액 : <fmt:formatNumber pattern="###,###" value="${bmap.TOTALPRICE}"></fmt:formatNumber> 원</h3>
 		</div>
		<div class="#" style="width: 100%; text-align: center; height: 210px;">
        <div class="area_s2" style="margin-top: 5px; float: left; border: 1px solid #639EB0; width: 49%; height: 200px; display: inline-block;">
        <br/>
	        <h2>출발지 : ${bmap.DEPARTURE}</h2> <br/>
	       	<h2>도착지 : ${bmap.ARRIVAL}</h2>
        </div>
        <div class="reserve_num_s2" style="margin-top: 5px; float: right; border: 1px solid #639EB0; width: 49%; height: 200px; display: inline-block;">
	        <h3>결제번호 : ${bmap.PAYMENTCODE}</h3>
	        <h3>열차등급 :
        <c:if test="${bmap.TRAINTYPE == 1 }" >
        KHX 
        </c:if>
        <c:if test="${bmap.TRAINTYPE == 2 }" >
                    무궁화 
        </c:if></h3>
        <h3>예약매수 : ${bmap.TQTY}</h3>
        </div>
        </div>
        <div class="btn_s2" style="">
        <a href="<%= request.getContextPath() %>/lsk/bookingEdit.action?paymentcode=${bmap.PAYMENTCODE}" class="button01_s2">예약변경</a>
		<%-- <a href="" class="button02_s2" id="btnCancel" onClick="goCancel(${bmap.PAYMENTCODE}, ${bmap.ORDERSEQ});">예약취소</a> --%>
		<a href="<%= request.getContextPath() %>/lsk/bookingCancel.action?paymentcode=${bmap.PAYMENTCODE}&orderseq=${bmap.ORDERSEQ}" class="button02_s2">예약취소</a>
        </div>	
        
        <form name="cancelForm">
        <input type="hidden" 	id="paymentcode" 	name="paymentcode"	  value="${bmap.PAYMENTCODE}" />
        <input type="hidden" 	id="orderseq" 		name="orderseq" 	  value="${bmap.ORDERSEQ}" />
  		</form>
  		
  	</c:forEach>
  	</c:if>
  	
  	</div> <!-- /home -->
  	
  	<!-- </form> -->
  	<div id="menu1" class="tab-pane fade" name="cancelList" id="cancelList">
  	
  	<c:if test="${cmap != null}">
    <c:forEach items="${cmap}" var="cmap">
    	<div class="date_s2" style="border: 1px solid #639EB0; text-align: center; margin-top: 7%;">
 			<h3>${cmap.DEPARTUREDATE} ${cmap.DEPARTURETIME} 출발  / 
 			결제금액 : <fmt:formatNumber pattern="###,###" value="${cmap.TOTALPRICE}"></fmt:formatNumber> 원</h3>
 		</div>
		<div class="#" style="width: 100%; text-align: center; height: 210px;">
        <div class="area_s2" style="margin-top: 5px; float: left; border: 1px solid #639EB0; width: 49%; height: 200px; display: inline-block;">
        <br/>
	        <h2>출발지 : ${cmap.DEPARTURE}</h2> <br/>
	       	<h2>도착지 : ${cmap.ARRIVAL}</h2>
        </div>
        <div class="reserve_num_s2" style="margin-top: 5px; float: right; border: 1px solid #639EB0; width: 49%; height: 200px; display: inline-block;">
	        <h3>결제번호 : ${cmap.PAYMENTCODE}</h3>
	        <h3>열차등급 :
        <c:if test="${cmap.TRAINTYPE == 1 }" >
        KHX 
        </c:if>
        <c:if test="${cmap.TRAINTYPE == 2 }" >
                    무궁화 
        </c:if></h3>
        <h3>예약매수 : ${cmap.TQTY}</h3>
        </div>
        </div>
        
        
        
    </c:forEach>
    </c:if>
    
   	</div> <!-- /menu1 -->
    
  	
  	
  </div> <!-- /tab-content -->
  
</div> <!-- /container -->

</div> <!-- /# -->



					
