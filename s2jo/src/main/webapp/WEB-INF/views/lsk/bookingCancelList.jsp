<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">


</style>

<!-- 
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
-->	

<script type="text/javascript">
	
</script>


<body>

	<c:if test="${map != null}">
    <c:forEach items="${map}" var="map">
    <div id="menu1" class="tab-pane fade">
    <div id="home" class="tab-pane fade in active" style="border: 2px solid red;">
    	<div class="square_main" style="border: 1px solid blue;">
    	${map.DEPARTUREDATE} ${map.DEPARTURETIME} 출발  / 
		결제금액 : <fmt:formatNumber pattern="###,###" value="${map.TOTALPRICE}"></fmt:formatNumber> 원
    	</div>
    	<div class="square_sub">
    	<ul>
                        <li class="area_s2">
                        <br/>
                                    출발 : ${map.DEPARTURE} <br/><br/>
                       	도착 : ${map.ARRIVAL}
                        </li>
                        <li class="reserve_num_s2">
                                    결제번호 : ${map.PAYMENTCODE} <br/>
                                    열차등급 :
                        <c:if test="${map.TRAINTYPE == 1 }" >
                        KHX 
                        </c:if>
                        <c:if test="${map.TRAINTYPE == 2 }" >
                                    무궁화 
                        </c:if> 
                        <br/>
                                    예약매수 : ${map.TQTY}
                        </li>
                        </ul>
    	</div>
    </div>
    </div>
    </c:forEach>
    </c:if>

    
    <%-- 
    <div id="home" class="tab-pane fade in active">
		<div class="content-wrap">
					<c:if test="${map != null}">
                    <c:forEach items="${map}" var="map">
					<form name="bookingInfo">
						<section id="section-bar-1">
                        
		     			<div class="date_s2">
		     			${map.DEPARTUREDATE} ${map.DEPARTURETIME} 출발  / 
		     			결제금액 : <fmt:formatNumber pattern="###,###" value="${map.TOTALPRICE}"></fmt:formatNumber> 원
		     			</div>
                        <ul>
                        <li class="area_s2">
                        <br/>
                                    출발 : ${map.DEPARTURE} <br/><br/>
                       	도착 : ${map.ARRIVAL}
                        </li>
                        <li class="reserve_num_s2">
                                    결제번호 : ${map.PAYMENTCODE} <br/>
                                    열차등급 :
                        <c:if test="${map.TRAINTYPE == 1 }" >
                        KHX 
                        </c:if>
                        <c:if test="${map.TRAINTYPE == 2 }" >
                                    무궁화 
                        </c:if> 
                        <br/>
                                    예약매수 : ${map.TQTY}
                        </li>
                        </ul>
                        <div class="btn_s2">
                        <a href="<%= request.getContextPath() %>/lsk/bookingEdit.action?paymentcode=${map.PAYMENTCODE}" class="button01_s2" >예약변경</a> 
                        <a href="" class="button02_s2">예약취소</a>
                        </div>
						
			</section>
					</form>
					</c:forEach>
					</c:if>
					</div>
    </div>
    <!-- /예매내역 -->
     --%>

  

</body>

	
					
