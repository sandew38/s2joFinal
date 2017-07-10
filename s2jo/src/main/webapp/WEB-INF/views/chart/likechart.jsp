<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>      <!-- jQuery 라이브러리 -->  
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/highcharts/code/highcharts.js"></script> <!-- 차트그리기 -->
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/highcharts/code/highcharts-3d.js"></script> <!-- 차트그리기 --> 
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/highcharts/code/modules/exporting.js"></script> <!-- 내보내기 기능(PDF) -->

<div id="displaylikerankChart" style="width: 40%; height: 400px; display: inline-block; border: solid 1px red; margin-left: 10%;">
	<!-- style="min-width: 310px; height: 400px; max-width: 600px; margin: 0 auto" -->
	</div>


<div id="likechart" style="width: 50%; height: 300px; margin: 30px auto; border: solid 1px red;">
   
</div>



<SCRIPT>


$(document).ready(function(){
    
	getlikechart();
                   
 });
 
 
 function getlikechart() { 
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
			
		}// end of function getOrderRankChart() { }---------------------------
		
</script>
<input type="hidden" name="sido" id="sido"  />
<input type="hidden" name="cnt" id="cnt" />