<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%-- 구글맵 api --%>
<script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyArfqZtHfB6pqo03pUFV2_5EvSuVTrg-fk"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<script type="text/javascript" src="<%= request.getContextPath() %>/resources/highcharts/code/highcharts-3d.js"></script> <!-- 차트그리기 --> 
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/highcharts/code/modules/exporting.js"></script> <!-- 내보내기 기능(PDF) -->


<style type="text/css">

.btn-circle.btn-xl {
  width: 160px;
  height: 160px;
  padding: 10px 16px;
  font-size: 24px;
  line-height: 1.33;
  border-radius: 80px;
  border-width: 10px;
}

.banner{
	float:left; 
	position: absolute; 
	top: 50%; 
	width: 150px;
	padding:10px; 
	border: solid 1px #b3b3b3; 
	border-radius: 15px; 
    box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;
}

.hjs-background-panel{
	position: relative;
	max-width: 96.5%;
	min-height: 75%;
    background-color: white;
    padding: 0.01em 16px;
    margin: 20px 0;
	margin-left: 3%;
    box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;

}

.well-sm{
    position: relative !important;
    color: #FFFFFF !important;
    font-weight: 600 !important;
    font-size: 18px !important;
    text-decoration: none !important;
    padding: 11px 20px !important;
    border-radius: 0px !important;
    border: 2px solid #11939A !important;
    text-transform: uppercase !important;
    outline: none !important;
    line-height: 18px !important;
    font-family: ff-clan-web-pro, "Helvetica Neue", Helvetica, sans-serif !important;
    display: inline-block !important;
    vertical-align: middle !important;
    text-align: center !important;
    margin: 0 !important;
    overflow: visible !important;
    background-color: #0D696C !important;
    border-color: #0D696C !important;
}

.panel-body{

	font-size: 16px;

}

.hjs-like{
	cursor:pointer;
	font-family: Comic Sans MS !important;
	color: white;
	font-weight: 600 !important;
    font-size: 18px !important;
    text-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;
}


.hjs-well2{

    border-color: #00AF87 #2f582c #2f582c #00AF87;
    background-color: #00AF87;
    box-shadow: 1px 1px 0 0 rgba(0,0,0,0.25);
    color: #fff;

}

#stationList{

	 height:30%;
	 overflow-y:auto; 
}	

#tourList{
	 width:100%;
	 height:50%;
	 display: inline-block;
	 overflow-x:hidden; 
	 overflow-y:auto; 
}	

#tourDetail{
	 width: 100%;
	 height:18%;
	 display: inline-block;
	 overflow-x:hidden; 
	 overflow-y:auto; 
}	

#map{
	 width: 100%;
	 height:18%;
	 display: inline-block;
	 overflow-x:hidden; 
	 overflow-y:auto; 
}	



</style>

<script type="text/javascript"> 

	
	// 관광지 목록 보여주는 함수
	function goStationInfo(SIDO, GUGUN, STATION) {
	
		form_data = {SIDO : SIDO,
					GUGUN : GUGUN};
	
		
		var station = STATION; 
		var html = "";
		html += "<span style='font-size:18px;'>"+station+"</span><br/>";
		html += "<a style='cursor:pointer;' onClick='goStationReview(&quot;"+station+"&quot;); return false'>이용후기 작성하기</a>";
		
		$("#stationReview").html(html);
		
		$.ajax({ 
			url : "tourList.action", 	
			type : "POST",
			data : form_data,  
			dataType : "JSON",  // 응답은 JSON 타입으로 받아라.
			success: function(data) { // 데이터 전송이 성공적으로 이루어진 후 처리해줄 callback 함수
				// data 는 ajax 요청에 의해 url 페이지 tourList.action 으로 부터 리턴받은 데이터
		   		
			   $("#tourList").empty();
			   // <div id="tourList"> 엘리먼트를 모두 비워서 새로운 데이터를 받을수 있게 해라
			   var html = "";
			   
				$.each(data, function(entryIndex, entry) {
						
				    	html += "<div onClick='goTourInfo(&quot;"+entry.SIDO+"&quot;, &quot;"+entry.GUNGU+"&quot;, &quot;"+entry.RES_NM+"&quot;); return false' style='cursor:pointer;' class='panel panel-default'><div class='panel-body'>";
						html += "<span style='font-size:14px;'>";
						html += entry.SctnNm+"</span>"; 
						html += "<p style='margin-top:10px; font-size:18px; font-weight:bold; color:#003399; '>"+entry.RES_NM+"</p>";  
						html += "</div></div>"; 
					});

	   	   	   $("#tourList").html(html);   // html을  <div id="tourList"> 에 넣어라
		
		}, // end of success: function(data) ---------------------
		
		error: function(request, status, error){
			
			 var html = "";
			html += "<span style='font-size:14px;'>";
			html += "조회할 정보가 없습니다. </span></br>"; 
			 $("#tourList").html(html);  
			 $("#tourDetail").html(html);  
			 $("#map").html(html);	
			// alert("에러 발생 code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	    } // end of error: function(request,status,error)
			
		}); // end of $.ajax --------------------

	}// end of function goStationInfo(SIDO, GUGUN, STATION) ------------------
	
	
	
	
	// 역 이용후기 쓰는 함수
	function goStationReview(STATION) {
		
		var stationReviewFrm = document.stationReviewFrm;
		
		$("#station").val(STATION);
		stationReviewFrm.action = "<%= request.getContextPath() %>/hjs/stationReview.action";
		stationReviewFrm.method = "GET";
		stationReviewFrm.submit();
		
	}// end of function goStationReview(STATION) ------------------
		
	
	
	
	// 관광지 상세정보 보여주는 함수
	function goTourInfo(SIDO, GUNGU, RES_NM) {
		
		
		$("#tsido").val(SIDO);
		$("#tname").val(RES_NM);
		
		
		form_data = {SIDO  : SIDO,
					GUGUN  : GUNGU,
					RES_NM : RES_NM};
		   
		goTourLikeShow();
			
		$.ajax({ 
			url : "tourDetail.action", 	
			type : "POST",
			data : form_data,  
			dataType : "JSON",  // 응답은 JSON 타입으로 받아라.
			success: function(data) { // 데이터 전송이 성공적으로 이루어진 후 처리해줄 callback 함수
				// data 는 ajax 요청에 의해 url 페이지 tourDetail.action 으로 부터 리턴받은 데이터
	
			   $("#tourDetail").empty();
			   // <div id="tourDetail"> 엘리먼트를 모두 비워서 새로운 데이터를 받을수 있게 해라
			   $("#tourLike").empty();
			
				var html = "";
			    	html += "<div class='panel panel-default'><div class='panel-body'";
					html += "<span style='font-size:16px;'>";
					html +=  data.BResNm+" [ "+data.HEnglishNm+" ] ("+ data.KPhone +")</span></br></br>"; 
					html += "<span style='font-size:14px; '>";
					html +=  data.Desc+"</span>"; 
					html += "</div></div>"; 
				
	   	   	   $("#tourDetail").html(html);   // html을  <div id="sidoInfo"> 에 넣어라
				
	   	   	   var html2 = "";
	   	   	   	   html2 += "<br/><br/><span class='hjs-well2' style='font-size:16px; font-weight:bold;'>";
	   	   	 	   html2 += "&nbsp;&nbsp;아래 버튼을 눌러&nbsp;&nbsp;<br/>&nbsp;관광지를 추천해보세요!&nbsp;";
 	   	   	       html2 += "</span><br/><br/>";
 	   	   		   html2 += "<img class='heart'; onClick='goTourLike(&quot;"+data.CSido+"&quot;, &quot;"+data.BResNm+"&quot;); return false'";
 	   	       	   html2 += "src='<%= request.getContextPath() %>/resources/images/heart.png' style='width:110px; height:95px; cursor:pointer;' />";
 	   	       	   html2 += "</a>";
	   	   	
 	   	       $("#tourLike").html(html2);    
	   	   		   
	   	   	   var ResNm = data.BResNm;
	   	   	   
	   	   if (data.x != null && data.y != null){
	   		   
	   	   	   var x = data.x; // string
	   	   	   var y = data.y;
	   	   
	   	   	   x = Number(x);
	   	   	   y = Number(y);
	   	   	   
	   	   	   // alert(y +" , "+ x);
	
			   	var myLatlng = new google.maps.LatLng(y, x);
			   	var mapOptions = {
			   	  zoom: 10,
			   	  center: myLatlng
			   	}
			   	var map = new google.maps.Map(document.getElementById("map"), mapOptions);
		
			   	var marker = new google.maps.Marker({
			   	    position: myLatlng,
			   	    title:ResNm
			   	});
		
			   	// To add the marker to the map, call setMap();
			   	marker.setMap(map);
	   	   	   }
	   	   
		}, // end of success: function(data) ---------------------
		
		error: function(request, status, error){
			 var html = "";
				html += "<span style='font-size:14px; '>";
				html += "조회할 정보가 없습니다. </span>"; 
				 $("#tourDetail").html(html);  
				 $("#map").html(html);
			//alert("에러 발생 code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	    } // end of error: function(request,status,error)
			
		}); // end of $.ajax --------------------

	}// end of function goTourInfo(SIDO, GUNGU, RES_NM) ------------------
	
	
	
	
	// 관광지 좋아요 함수
	function goTourLike(SIDO, RES_NM) {
		
		if(SIDO == null){
			SIDO = $("#tsido").val();
			RES_NM = $("#tname").val();
		}
		
		form_data = {sido  : SIDO,
				    name : RES_NM};
		
		$.ajax({
			url: "tourLike.action",
			type: "POST",
			data: form_data,
			dataType: "JSON",
			success: function(data){
				alert(data.msg);
				goTourLikeShow();
			},
			error: function(){
				//alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error); 
			}
		});
	}// end of function goTourLike(SIDO, RES_NM) ------------------
	
	
	
	
	
	// 관광지 좋아요 수 알아오기
	function goTourLikeShow() {
		
		tsido = $("#tsido").val();
		tname = $("#tname").val();
		
		goTourLikeShowEnd(tsido, tname);
		
		
	}// end of function goLikeDisLikeCountShow()-------
	
	
	
	function goTourLikeShowEnd(tsido, tname){
		
		var form_data = {sido : tsido,
						 name : tname};
		
		$.ajax({
			url: "tourLikeShow.action",
			type: "POST",
			data: form_data,
			dataType: "JSON",
			success: function(data){
			
				$("#likeCnt").empty();
				
				var likeCnt = data.likeCnt;
				$("#likeCnt").html(likeCnt+"&nbsp;Likes!");
			},
			error: function(){
				//alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error); 
			}
		});
	}

	
	

	    
	    
</script>

<div  style="background-color:white; width:100%; height:100%; margin: auto; padding-top: 30px;  margin-bottom: 100px;">

<div class="hjs-background-panel" style="padding-top:3%; padding-bottom: 1%; " >

<!-- 현재 운행중인 역 목록 div -->
<div class="panel panel-default" style="float:left; width:15%; margin: 0 auto; margin-left: 5%; margin-bottom: 40px; border: solid red 0px; ">

	<div align="center" style="width:90%; margin: 0 auto; margin-bottom: 40px; /* border: solid red 1px; */">
		<span class="well well-sm">현재 운행중인 역</span>
	</div>

	<!-- 역 선택해서 관광지 목록 조회하기 -->
	<div id="stationList" align="center" style="width:100%; margin: 0 auto; margin-bottom: 50px;  border: solid red 0px; ">	
			
		<c:forEach var="map" items="${stationList}" varStatus="status">
		
		    <div class="panel panel-default" style="cursor: pointer;">
		      <div class="panel-body" onClick="goStationInfo('${map.SIDO}', '${map.GUGUN}', '${map.STATION}');" >${map.STATION}</div>
		    </div>
		    
		</c:forEach>
		
	</div align="center" style="width:90%; margin: 0 auto; margin-bottom: 50px;" >
	
	<div>
		<div align="center" style="width:90%; margin: 0 auto; margin-top: 60px; margin-bottom: 10px; /* border: solid red 1px; */">
				<span class="well well-sm">역 이용후기 남기기</span>
		</div>
		
		<!-- 현재 선택한 기차역 이용후기 남기기 -->
		<div class="panel panel-default"  align="center" style="width:90%; margin: 0 auto;  border: solid red 0px; margin-bottom: 30px;">	
			<div class="panel-body" id="stationReview">
			
			</div>
		</div>	    
		
		<!-- 기차역별 이용후기 게시판 폼 생성 -->
		<form name="stationReviewFrm">     
			<input type="hidden" id="station" name="station" /> 
		</form>
		
	</div>
</div>	



<!-- 역 주변 관광지 목록 div -->
<div class="panel panel-default" style=" float:left; width:25%; margin: 0 auto; margin-left:4%; margin-bottom: 40px; border: solid green 0px; ">

	<div align="center" style="width:90%; margin: 0 auto; margin-bottom: 40px; /* border: solid red 1px; */">
		<span class="well well-sm">역 주변 관광지 목록</span>
	</div>
	
	
	<div id="tourList" align="center" style=" margin: 0 auto; margin-bottom: 40px; ">
		<!-- 관광지 목록 -->
	</div>
	
</div>



<!-- 관광지 상세정보 div -->
<div class="panel panel-default" style="background-color: white; float:left; width:25%; margin: 0 auto; margin-left:4%; margin-bottom: 40px; border: solid green 0px; ">

	<div align="center" style="width:90%; margin: 0 auto; margin-bottom: 40px; /* border: solid red 1px; */">
		<span class="well well-sm detail">관광지 상세정보</span>
	</div>
	
	<div id="tourDetail" align="center" style="width:100%; margin: 0 auto; margin-bottom: 40px;  border: solid orange 0px; ">
		<!-- 관광지 정보 -->
	</div>
	
	<div style="padding:10px;">
		<div id="map" align="center" style="width: 100%; height: 30%; border: solid black 0px; margin: auto;">
			<!-- 지도 -->
		</div>
	</div>
	
	<!-- 기차역별 이용후기 게시판 폼 생성 -->

	<input type="hidden" id="tsido" name="sido" value="" /> 
	<input type="hidden" id="tname" name="name" value="" /> 
	
</div>


<!-- 관광지 좋아요 -->
<div class="panel panel-default" style="background-color: white; float:left; width:13%; margin: 0 auto; margin-left:3%; max-height:50%; margin-bottom: 40px; border: solid red 0px;  ">
	
	<div align="center" style="width:90%; margin: 0 auto; margin-bottom: 40px; /* border: solid red 1px; */">
		<span class="well well-sm detail">관광지 추천</span>
	</div>

	<div id="tourLike" align="center" style="width:100%; margin: 0 auto; margin-bottom: 40px;  border: solid orange 0px; ">
		<!-- 관광지 좋아요 처리 -->
	</div>
	
	<div style="text-align:center; margin-top:-107px;" >
		<span class="hjs-like" id="likeCnt" onClick="goTourLike()"></span>
	</div>

	
</div>



<!-- 배너 -->
<div style="background-color: white; float:left; width:13%; margin: 0 auto; margin-left:3%; max-height:50%; margin-bottom: 40px; border: solid orange 0px;  ">
	
	<a href="<%=request.getContextPath()%>/khx.action" data-toggle="tooltip" title="KHX와 함께 여행을 시작해보세요!">
		<img alt="khxlogo" src="<%=request.getContextPath()%>/resources/images/khxlogo1.png"  style="background-color: white; padding-right:40px; float:left; position: absolute; top: 50%; width: 200px; padding:10px; border: solid 0px #cccccc; border-radius: 15px; box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 1px 5px 0 rgba(0,0,0,0.06)!important;" />
	</a>
	
	<a href="http://192.168.10.8:9090/hajota/" data-toggle="tooltip" title="HAJOTA 에서 숙소를 예약해보세요!">
		<img alt="HAJOTAlogo" src="<%=request.getContextPath()%>/resources/images/HAJOTA.png"  style="margin-top:100px; background-color: white; float:left; position: absolute; top: 55%; height: 100px; width: 200px; padding:20px; border: solid 0px #cccccc; border-radius: 15px; box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 1px 5px 0 rgba(0,0,0,0.06)!important;" />
	</a>

</div>




</div>

</div>