<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



 	
 
 <!DOCTYPE html>
 <head>
 
 <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/js/jquery-ui.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>      <!-- jQuery 라이브러리 -->  
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/highcharts/code/highcharts.js"></script> <!-- 차트그리기 -->
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/highcharts/code/highcharts-3d.js"></script> <!-- 차트그리기 --> 
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/highcharts/code/modules/exporting.js"></script> <!-- 내보내기 기능(PDF) -->


     <title>DASHGUM - FREE Bootstrap Admin Template</title>
    <!-- Bootstrap core CSS -->
    <link href="<%= request.getContextPath() %>/resources/assets/css/bootstrap.css" rel="stylesheet">
    <!--external css-->
<!--     <link href="resources/assets/font-awesome/css/font-awesome.css" rel="stylesheet" /> -->
   
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/assets/css/zabuto_calendar.css">
    
    
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/assets/js/gritter/css/jquery.gritter.css" />
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/assets/lineicons/style.css">    
    
    <!-- Custom styles for this template -->
    <link href="<%= request.getContextPath() %>/resources/assets/css/style.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/resources/assets/css/style-responsive.css" rel="stylesheet">
<!-- 
       <script src="/resources/assets/js/chart-master/Chart.js"></script>
 -->    
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  
  
  <script>

  
$(document).ready(function(){
      
      getdisplaylikerankChart();
                     
 //     $("#userjoin").hide();
   }); 



function getdisplaylikerankChart() {
	
	$.ajax({
		url: "likeStatistics.action",
		type: "GET",
		dataType: "JSON",
		success: function(data){
			var likeArr = [];
	 		
			$.each(data, function(entryIndex, entry){ 
				likeArr.push({
	                			   name: entry.name,
	                			   y: parseFloat(entry.cnt),
	                             });
			});	// end of $.each(data, function(entryIndex, entry)----------------
					
			// Create the chart
			Highcharts.chart('displaylikerankChart', {
			    chart: {
			        plotBackgroundColor: null,
			        plotBorderWidth: null,
			        plotShadow: false,
			        type: 'pie'
			    },
			    title: {
			        text: '협력사 좋아요 비율'
			    },
			    tooltip: {
			        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
			    },
			    plotOptions: {
			        pie: {
			            allowPointSelect: true,
			            cursor: 'pointer',
			            dataLabels: {
			                enabled: true,
			                format: '<b>{point.name}</b>: {point.percentage:.1f} %',
			                style: {
			                    color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
			                }
			            }
			        }
			    },
			    series: [{
			        name: '판매율',
			        colorByPoint: true,
			        data: likeArr   // **** 위에서 구한값을 대입시킴. ****
			        /* [{
			            name: 'Microsoft Internet Explorer',
			            y: 56.33
			        }, {
			            name: 'Chrome',
			            sliced: true,
			            y: 24.03,
			            selected: true
			        }, {
			            name: 'Firefox',
			            y: 10.38
			        }, {
			            name: 'Safari',
			            y: 4.77
			        }, {
			            name: 'Opera',
			            y: 0.91
			        }, {
			            name: 'Proprietary or Undetectable',
			            y: 0.2
			        }] */
			    }]
			});
			
		}, // end of success: function(data){ }-------------------------
		error: function(request, status, error){
			   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		} 
	});
	
}// end of function getOrderRankChart() { }-----------------------
	
	

  
  
  
  
  
  $(document).ready(function(){
      
      getsummarychart();
                     
 //     $("#userjoin").hide();
      
   });  

  function getsummarychart() { 
     
     $.ajax({ 
        url: "trainStatistics.action",
        type: "GET",
        dataType: "JSON",
        success: function(data){
           
           if(data.length == 0) {
              $("#summarychart").html("<div align='center' style='margin-top:50px;'><span style='font-size:14pt;'>주문내역이 없습니다.</span></div>");
           }
           
           
           else {
              var priceArr = [];
              var dateArr = [];
              // 또는 var subArr = new Array();
  			 
              var d = new Date();
              
              $.each(data, function(entryIndex, entry){ 
               
             	 priceArr.push(Number(entry.TOTALPRICE));
             	 dateArr.push(Number(entry.PAYDATE));
            
              });   
              	   
              
              
                // Create the chart
           
                
              Highcharts.chart('summarychart', {
             	    xAxis: {
             	       categories:dateArr,
             	       
             	    },
             	    yAxis: {
             	        min: 1
             	    },
             	    title: {
             	        text: '금월 수익표 (단위:1,000)'
             	    },
             	    series: [{
             	        type: 'line',
             	        categories:dateArr, // 추후삭제
             	        data:  priceArr,
             	        	
             	        marker: {
             	            enabled: false
             	        },
             	        states: {
             	            hover: {
             	                lineWidth: 1
             	            }
             	        },
             	        enableMouseTracking: false
             	    }, {
             	        type: 'scatter',
             	        categories:dateArr, // 추후삭제
             	        data: priceArr,
             	        marker: {
             	            radius: 4
             	        }
             	    }]
             	});
             	
             	
             	
             	
             	
             }// end of if~else---------------------------   
             
          }, // end of success: function(data){ }-------------------------
          error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
          } 
       });
       
    }// end of function getOrderRankChart() { }---------------------------
    

	
	
	
	

	
  </script>
   

 
 
   <body>
 <!--main content start-->
 
    
   
      <section id="main-content">
          <section class="wrapper">
                      
                      <div class="row mt" style= " float:left; margin-left:5%; margin-right: -25px; width:1000px; ">
                      <!-- SERVER STATUS PANELS -->
                      
                      
				 
				 
				 
				 
				 
					<div class="row mt" style="margin-top: 5px;">
                      <!--CUSTOM CHART START -->
                      <div class="zzzzz">
                          
                          <h3>금월 수익금</h3>
                          
                          <div id="summarychart" style="text-align: right;">
                          
                          
                          </div>
                          
                          
                          
                          
                          
                      </div>
                    
                      <!--custom chart end-->
					</div><!-- /row -->	
					
					<BR/><BR/>
					
					<div>
					   <h3> 협력사 좋아요 비율 </h3>
					  
					   <div id="displaylikerankChart" style="text-align: right;">  
					   
					   
					   </div>
					
					</div>
					
					
					
                  </div><!-- /col-lg-9 END SECTION MIDDLE -->
                  
                   
      <!-- **********************************************************************************************************************************************************
      RIGHT SIDEBAR CONTENT
      *********************************************************************************************************************************************************** -->                  
                
                  <div class="col-lg-3 ds" id="userjoin" style=" float:right; margin-right: 25px; margin-top: 80px; height:900px;">
                    <!--COMPLETED ACTIONS DONUTS CHART-->
                     
						<a href="http://localhost:9090/khx/adminuser.action"><h3>최근 가입 유저</h3></a>
                        </a>
                     
                     <span style="font-size: 17px; font-style: inherit;">
                      <c:forEach items="${timelinelist}" var="tl">                 
                     
                     <!-- Fourth Action -->
                     
                      <div class="desc">
                      	<div class="thumb">
                      		<span class="badge bg-theme"><i class="fa fa-clock-o"></i></span>
                      	</div>
                      	<div class="details">
                      		<p style="width: 500px;"><muted>
                      		
                      		 <c:if test="${tl.day!=0}">
                      		 <span style="font-size:15px;"> ${tl.day } 일 전</span>
                      		 </c:if>
                      		 
                      		 <c:if test="${tl.day==0 || tl.hour !=0}">
                      		 <span style="font-size:14px;">${tl.hour } 시간 전</span>
	                      		 </c:if>
                      		 
                      		 <c:if test="${tl.day==0 || tl.hour ==0 || tl.minute != 0}">
                      		 <span style="font-size:12px;">${tl.minute } 분 전</span>
                      		 </c:if>
                      		 
                      		 <c:if test="${tl.day==0 || tl.hour ==0 || tl.minute == 0 || tl.second != 0}"></span>
                      		 <span style="font-size:11px;">${tl.second } 초 전</span>
                      		 </c:if>
                      		 
                      		 
                      		 </muted><br/>
                      		   <a href="#">
                      		   <c:if test="${tl.userid!=null}">
                      		   ${tl.userid } 님이
                      		   </c:if>
                      		   
                      		   <c:if test="${tl.userid==null}">
                      		   null값님이
                      		   </c:if>
                      		   
                      		   </a>가입했습니다.<br/>
                      		
                      		</p>
                      		</div>
                      	</div>
                      
                     
                      </c:forEach>
                      </span>
                      
                      
                       <!-- USERS ONLINE SECTION -->
						<h3>회원</h3>
                      <!-- First Member -->
                      <div class="desc">
                      	<div class="thumb">
                      		<img class="img-circle" src="resources/assets/img/yyj.jpg" width="45px" height="45px" align="">
                      	</div>
                      	<div class="details">
                      		<p><a href="http://localhost:9090/khx/userdetailList.action?userid=smrjaak333">유원제</a><br/>
                      		   <muted>24</muted>
                      		</p>
                      	</div>
                      </div>
                      <!-- Second Member -->
                      <div class="desc">
                      	<div class="thumb">
                      		<img class="img-circle" src="" width="35px" height="35px" align="">
                      	</div>
                      	<div class="details">
                      		<p><a href="#">DJ SHERMAN</a><br/>
                      		   <muted>I am Busy</muted>
                      		</p>
                      	</div>
                      </div>
                      <!-- Third Member -->
                      <div class="desc">
                      	<div class="thumb">
                      		<img class="img-circle" src="" width="35px" height="35px" align="">
                      	</div>
                      	<div class="details">
                      		<p><a href="#">DAN ROGERS</a><br/>
                      		   <muted>Available</muted>
                      		</p>
                      	</div>
                      </div>
                      <!-- Fourth Member -->
                      <div class="desc">
                      	<div class="thumb">
                      		<img class="img-circle" src="" width="35px" height="35px" align="">
                      	</div>
                      	<div class="details">
                      		<p><a href="#">Zac Sniders</a><br/>
                      		   <muted>Available</muted>
                      		</p>
                      	</div>
                      </div>
                    

                        <!-- CALENDAR-->
                        <!-- <div id="calendar" class="mb">
                            <div class="panel green-panel no-margin">
                                <div class="panel-body">
                                    <div id="date-popover" class="popover top" style="cursor: pointer; disadding: block; margin-left: 33%; margin-top: -50px; width: 175px;">
                                        <div class="arrow"></div>
                                        <h3 class="popover-title" style="disadding: none;"></h3>
                                        <div id="date-popover-content" class="popover-content"></div>
                                    </div>
                                    <div id="my-calendar"></div>
                                </div>
                            </div>
                        </div> --><!-- / calendar -->
                      
                  </div><!-- /col-lg-3 -->
              
          </section>
      </section>

      <!--main content end-->





  </body>
</html>
 