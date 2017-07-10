<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>      <!-- jQuery 라이브러리 -->  
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/highcharts/code/highcharts.js"></script> <!-- 차트그리기 -->
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/highcharts/code/highcharts-3d.js"></script> <!-- 차트그리기 --> 
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/highcharts/code/modules/exporting.js"></script> <!-- 내보내기 기능(PDF) -->



<div style="padding-left: 30%; border: solid 0px red; padding-top: 5%;">
   <h2>금월 날자별 수익금</h2>
</div>

<div id="summarychart" style="width: 50%; height: 300px; margin: 30px auto; border: solid 1px red;">
   
</div>



<SCRIPT>



$(document).ready(function(){
      
    getdisplaylikerankChart();

  	getGoChart();
  	
  	getsummarychart();
  	
  	
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
			        	size: 190,
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
			        data: likeArr,   // **** 위에서 구한값을 대입시킴. ****
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
</script>	
 <div style="padding-left: 30%; border: solid 0px red; padding-top: 5%;">
   <h2>협력사별 좋아요 퍼센트에이지</h2>
</div>

<div id="displaylikerankChart" style="width: 50%; height: 300px; margin: 30px auto; border: solid 1px red;">
   
</div>
 
 
 <script>
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
            	 
            	//jepumObjArr.push([ entry.TOTALPRICE, entry(entry.PAYDATE)]);
              /*
                priceArr[entryIndex] = Number(entry.TOTALPRICE);
                
                d = Date(entry.PAYDATE);
                
                dateArr[entryIndex] = d;
          
                //alert(entry.TOTALPRICE);
                //alert(entry.PAYDATE);
                  
                var price = priceArr[0];
                var date = dateArr[0];

                alert(d);
                alert(typeof d);
                alert(priceArr);
                alert(dateArr);
               */

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
            	        text: '금월 수익표 (단위:1,000원)'
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
   
   <div style="padding-left: 30%; border: solid 0px red; padding-top: 5%;">
   <h2>많이간 지역별 퍼센트에이지</h2>

</div>

<div id="GoChart" style="width: 50%; height: 300px; margin: 30px auto; border: solid 1px red;">
   
</div>
 
   <script>

	    function getGoChart() { 
   			$.ajax({
   				url: "GoStatistics.action",
   				type: "GET",
   				dataType: "JSON",
   				success: function(data){
   					var goArr = [];
   	    	 		
   					$.each(data, function(entryIndex, entry){ 
   						goArr.push({
   											name: entry.arrival,
   			                			   y: parseFloat(entry.count),
   			                             });
   					});	// end of $.each(data, function(entryIndex, entry)----------------
   							
   					// Create the chart
   					Highcharts.chart('GoChart', {
   					    chart: {
   					        plotBackgroundColor: null,
   					        plotBorderWidth: null,
   					        plotShadow: false,
   					        type: 'pie'
   					    },
   					    title: {
   					        text: '많이간 지역별 퍼센트에이지'
   					    },
   					    tooltip: {
   					        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
   					    },
   					    plotOptions: {
   					        pie: {
   					        	size: 200,
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
   					        data: goArr,   // **** 위에서 구한값을 대입시킴. ****
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
   			
   		}// end of function getOrderRankChart() { }---------------------------
   		
 
   
</script>
<input type="hidden" name="totalprice" id="totalprice"  />
<input type="hidden" name="patdate" id="paydate" />
<input type="hidden" name="sido" id="sido"  />
<input type="hidden" name="cnt" id="cnt" />
<input type="hidden" name="arrival" id="arrival" />
<input type="hidden" name="count" id="count" />


