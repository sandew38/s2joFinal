<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

 
<style type="text/css">

#oneway, #roundway
{
	border : 2px solid #639EB0;
	font-size: large;
	text-align: center;
	height: 100px;
	padding-top : 20px;
	border-radius: 20px;
	font-weight: bold;
	font-size: 25pt;
	margin: 1%; 
	width : 96%;
	
	background-color: white;
}


.left, .right
{
	width : 96%;
	border: 2px solid #639EB0;
	height: 100px;
	vertical-align: middle;
	padding-top : 20px;
	border-radius: 20px;
	margin: 1%; 
	
	background-color: white;
	opacity: 30%;
}

#leftside, #rightside
{
	border : 0px solid #639EB0;
	float: left;
	width : 50%;
	text-align: center;
	height: 100%;
	vertical-align: middle;
}

.floatleft
{
	float: left;
	text-align: center;
}

.deselected {

	color: #cccccc;
    background: gray; /* For browsers that do not support gradients */    
    background: -webkit-linear-gradient(left, white , #cccccc); /* For Safari 5.1 to 6.0 */
    background: -o-linear-gradient(right, white, #cccccc); /* For Opera 11.1 to 12.0 */
    background: -moz-linear-gradient(right, white, #cccccc); /* For Firefox 3.6 to 15 */
    background: linear-gradient(to right, white , #cccccc); /* Standard syntax (must be last) */
   
}

.departure, .singledeparture, .doubledeparture, .arrival, .departuredate, .traintype, .trainclass
{
	cursor: pointer;
}

/*모달*/
.white_content {
    position: fixed;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    background: rgba(0, 0, 0, 0.8);
    opacity:0;
    -webkit-transition: opacity 400ms ease-in;
    -moz-transition: opacity 400ms ease-in;
    transition: opacity 400ms ease-in;
    pointer-events: none;
}
.white_content:target {
    opacity:1;
    pointer-events: auto;
}
.white_content > div {
	position: absolute;
	top: 25%;
	left: 40%;
	width: 30%;
	height: 70%;
/* 	padding: 16px; */
	border: 2px solid #639EB0;
	border-radius : 20px;
	background-color: white;
	overflow: auto;	
}



</style>



<script type="text/javascript">

$(document).ready(function(){

// 페이지 로드 시 
	$(".oneway").hide();	
	$(".roundway_selected").hide();
	$("#roundway").addClass("deselected");
	$("#waytype").val("oneway");

	$(".doubledeparture").hide();
	$(".singledeparture").show();
	
	var traintype = $("#pictraintype option:selected").val();
	$("#traintype").val(traintype);	

	$("#vipselected").hide();
  	$("#normalselected").hide();
	
  	
// 기차 종류 선택시 
// select로 고를 수 있게 한다. 
	$("#pictraintype").change(function(event){
	//	alert("변경됨!");
		
		$("#pictraintype").hide();
	
	 	var traintype = $("#pictraintype option:selected").val();
	//	alert(traintype);	
	
		document.getElementById("finpictraintype").innerHTML = traintype;
		$("#traintype").val(traintype);
	}); // end of $("#pictraintype").change(function(event) ----
		
			
// 열차 종류를 선택했다가 다시 클릭했을 때 
// 종류를 재선택할 수 있게 한다.
	$("#finpictraintype").click(function(){
		
		$("#pictraintype").show();
		document.getElementById("finpictraintype").innerHTML = "";
		$("#traintype").val("-1");
		
	}); // end of $("#finpictraintype").click(function() ----
	

//	특실 선택시
	$("#vip").click(function(){
		
			$(this).hide();
			$("#vipselected").show();	
			
			$("#normal").show();
			$("#normalselected").hide();
			
			$("#trainclass").val("vip");

	});

//	일반실 선택시
	$("#normal").click(function(){
		
			$(this).hide();
			$("#normalselected").show();
			
			$("#vip").show();
			$("#vipselected").hide();
			
			$("#trainclass").val("normal");

	});
			
// 캘린더 선택시 
/* 	 $( "#calender" ).click(function(){
		 
		 $(this).datepicker({
			  dateFormat : 'yy/mm/dd',
		      showButtonPanel: true,
		      showMonthAfterYear : true
		    }); 
	 });	*/
	 
// 출발일자 선택 (편도) 
	 $("#departuredatepicker").datepicker({
		  dateFormat : 'yy/mm/dd',
	      showButtonPanel: true,
	      showMonthAfterYear : true
	      
	    });
		 
// 출발일자 선택 (왕복) 
	 $("#departuredatepickerR").datepicker({
		  dateFormat : 'yy/mm/dd',
	      showButtonPanel: true,
	      showMonthAfterYear : true
	      
	    });
// 도착일자 선택 (왕복)
	 $("#arrivaldatepickerR").datepicker({
		  dateFormat : 'yy/mm/dd',
	      showButtonPanel: true,
	      showMonthAfterYear : true
	      
	    });
	 
		 
	//	 var departuredate = $("#departuredatepicker").val();
	//      alert(departuredate);
		 // 이거 안된다.
		 
	//	 $("#departuredate").val($("#departuredatepicker").val());	 
			
	$("#departuredatepicker").change(function(){
		
		// 출발일자를 넣어준다.
		var departuredate = $("#departuredatepicker").val();
		$("#departuredate").val(departuredate);
		
		alert(departuredate);
	
	});
	
	$("#departuredatepickerR").change(function(){
		
		var departuredateR = $("#departuredatepickerR").val();
        $("#departuredate").val(departuredateR);
        
	});
	
	$("#arrivaldatepickerR").change(function(){
		
	  	var arrivaldate = $("#arrivaldatepickerR").val();
        $("#arrivaldate").val(arrivaldate);
		
	});
	
	$("#today").click(function(){
		
	    var date = new Date();

	    var year  = date.getFullYear();
	    var month = date.getMonth() + 1; // 0부터 시작하므로 1더함 더함
	    var day   = date.getDate();

	    if (("" + month).length == 1) { month = "0" + month; }
	    if (("" + day).length   == 1) { day   = "0" + day;   }
		
	    $("#departuredatepicker").val(year+"/"+month+"/"+day);
		
	    $("#departuredate").val(year+"/"+month+"/"+day);
	    
	});
			
	$("#tomorrow").click(function(){
		
	    var date = new Date();

	    var year  = date.getFullYear();
	    var month = date.getMonth() + 1; // 0부터 시작하므로 1더함 더함
	    var day   = date.getDate()+1;

	    if (("" + month).length == 1) { month = "0" + month; }
	    if (("" + day).length   == 1) { day   = "0" + day;   }
		
	    $("#departuredatepicker").val(year+"/"+month+"/"+day);		
	    
	    $("#departuredate").val(year+"/"+month+"/"+day);
	    
	});
	
});// end of $(document).ready(function() ----

		
   
// 출발지 선택 모달
function picdeparture()
{	location.href="#picdeparture";	}

// 도착지 선택 모달
function picarrival()
{	location.href="#picarrival";	}

// 출발지 선택 후  
function finishDpic(event)
{	
	var arrival = $("#arrival").val();
	
	if(event==arrival)
	{
		alert("출발지와 도착지는 같을 수 없습니다!");
		return;
	}
	
	
	if (arrival=="")
	{	
		// 출발지 값을 넣어준다.
		$("#departure").val(event);
		document.getElementById("departurefromD").innerHTML = event;
		document.getElementById("departurefromA").innerHTML = event;
		document.getElementById("departurefromM").innerHTML = event;
		
		// 도착지 선택 창으로 넘어간다.
		location.href="#picarrival";	
		
	} // end of if ----
	
	if (event!=arrival && arrival!="")
	{
		
		// 출발지 값을 넣어준다.
		$("#departure").val(event);
		document.getElementById("departurefromD").innerHTML = event;
		document.getElementById("departurefromA").innerHTML = event;
		document.getElementById("departurefromM").innerHTML = event;
		
		// 출,도착지 창을 닫는다.
		location.href="#picarrival";	
		
	} // end of if ----	
} // end of function finishDpic(event) ----

// 도착지 선택 후
function finishApic(event)
{
	var departure = $("#departure").val();
	
	if(event==departure)
	{
		alert("출발지와 도착지는 같을 수 없습니다!");
		return;
	}
	
	if(departure=="")
	{
		alert("출발지를 선택해주세요!");		
		
		// 도착지 값을 넣어준다.
		$("#arrival").val(event);
		document.getElementById("arrivalfromD").innerHTML = event;
		document.getElementById("arrivalfromA").innerHTML = event;
		document.getElementById("arrivalfromM").innerHTML = event;
		
		
		location.href="#picdeparture";
	}
	
	if (event!=departure && departure!="")
	{
		// 도착지 값을 넣어준다.
		$("#arrival").val(event);
		document.getElementById("arrivalfromD").innerHTML = event;
		document.getElementById("arrivalfromA").innerHTML = event;
		document.getElementById("arrivalfromM").innerHTML = event;
	
		// 출,도착지 창을 닫는다.
		location.href="#";
		
	} // end of if ----
	
} // end of function finishApic(event) ----


// 그냥 닫기 
function finishpic()
{	location.href="#";	}

// 편도 선택시
function oneway(event)
{
	onewayOn();
	roundwayOff();
	$("#waytype").val("oneway");
	
	$(".doubledeparture").hide();
	$(".singledeparture").show();

}

//왕복 선택시
function roundway(event)
{
	roundwayOn();
	onewayOff();	
	$("#waytype").val("roundway");
	$("#departuredatepickerR").val($("#departuredatepicker").val());
	$("#arrivaldatepickerR").val($("#departuredatepicker").val());
	
	var arrivaldate = $("#arrivaldatepickerR").val();
    $("#arrivaldate").val(arrivaldate);
	
	$(".singledeparture").hide();
	$(".doubledeparture").show();
}

// 편도 on
function onewayOn()
{
	$(".oneway").hide();
	$(".oneway_selected").show();	
	$("#oneway").removeClass("deselected");

}

// 편도 off
function onewayOff()
{
	$(".oneway_selected").hide();	
	$("#oneway").addClass("deselected");
	$(".oneway").show();
}

// 왕복 on
function roundwayOn()
{
	$(".roundway").hide();
	$(".roundway_selected").show();	
	$("#roundway").removeClass("deselected");
}

// 편도 off
function roundwayOff()
{
	$(".roundway_selected").hide();	
	$("#roundway").addClass("deselected");
	$(".roundway").show();
}

//조회하기
function goBooking() 
{
	var waytype = $("#waytype").val();
	var departure = $("#departure").val();
	var arrival = $("#arrival").val();
	var traintype = $("#traintype").val();
	var trainclass = $("#trainclass").val();
	
	var departuredate = $("#departuredatepicker").val();
	var departuredateR = $("#departuredatepickerR").val();
	var arrivaldate = $("#arrivaldatepickerR").val();
	
	if(departure == -1)
	{
		alert("출발지를 선택하세요!");
		return;
	}
	
	else if(arrival == -1)
	{
		alert("도착지를 선택하세요!");
		return;
	}
	
	else if(traintype=="기차 종류를 선택해주세요.")
	{
		alert("기차 종류를 선택하세요!");
		return;
	}
	
	else if(trainclass == -1)
	{
		alert("등급을 선택하세요!");
		return;
	}

	else if(waytype == "oneway")
	{
		if(departuredate == -1 || departuredate=="")
		{
			alert("가는 날짜를 선택해주세요!");
			return;
		}		
	}
	else if(waytype == "roundway")
	{
		if(departuredateR == -1 || departuredateR =="")
		{
			alert("가는 날짜를 선택해주세요!");
			return;
		}
		else if (arrivaldate == -1 || arrivaldate =="")
		{
			alert("오는 날짜를 선택해주세요!");
			return;
		}
		
	}
	
	
	var browseForm = document.browseForm;
	browseForm.method = "get";
	browseForm.action = "booking.action";
	
	browseForm.submit();
	
	// 조회 페이지로 넘어감
//	location.href="booking.action";
}


</script>

<!-- content 전체 div -->
<div align="center" style="border: solid gold 0px; height: 100%; ">

	<div align="center" style="width:90%; margin: 0 auto; margin-bottom: 40px; color: white; font-weight: bold;">
		<h2>즐거운 여행의 시작과 끝, KHX와 함께!</h2>

	</div>
	
	<!-- 전체 div -->
	<div style="width:60%; margin: 0 auto; border: solid #639EB0 0px; min-height: 400px; " align="center">
	
	
		<!-- 왼쪽 메뉴 -->
		<div id="leftside" align="center"  >
		
			<!-- 편도 -->
			<div id = "oneway" align="center" style="cursor: pointer; " onclick="oneway();">
					 
				
					 
				 <span class = "oneway" >
				 
					 <img src = "<%=request.getContextPath()%>/resources/images/oneway.png"
						alt="편도" style="width: 20%; ">
						
					 <span style="color : #cccccc;"> &nbsp;&nbsp;&nbsp;&nbsp; 편도  </span>		
					 
				 </span>
										
				 <span class = "oneway_selected">

					<img src = "<%=request.getContextPath()%>/resources/images/oneway_selected.png"
						alt="편도선택" style="width: 20%; cursor: pointer;">
						
					<span style="color : #639EB0;">  &nbsp;&nbsp;&nbsp;&nbsp; 편도 </span>
					
				 </span>
					
			</div>
			
			<!-- 출발지, 도착지 선택 -->
			<div style="clear: both; margin-bottom : 3%; width : 96%;">
			
				<div class="floatleft left departure" style="width:48%;" 
						id = "choosedeparture" onclick="picdeparture();" >
					출발지 <br/>
					<span id = "departurefromM" style="font-size: x-large; color : #639EB0; font-weight: bold;"></span>
			
				</div>
				<div class="floatleft left arrival" style="width:48%; margin-left: 2%; margin-right: 0%;"
						id="choosedeparture" onclick="picarrival();">
					도착지 <br/>
					<span id = "arrivalfromM" style="font-size: x-large; color : #639EB0; font-weight: bold;"></span>
				</div>
				
			</div>
			
			<!-- 기차 선택 -->
			<div style="clear: both; text-align: left; padding-left: 5%;" class = "left traintype"
					onclick="pictraintype();">
				기차 <br/>
				
				<!-- 기차 선택 select -->
				<div align="center" style="text-align: center;">
					<select id="pictraintype" style="text-align: right; width:60%; height: 60%; border-collapse: collapse; border-style: none; font-size: large;">
						<option selected> 기차 종류를 선택해주세요. </option>
						<option value = "KHX" > KHX </option>
						<option value = "무궁화호" > 무궁화호 </option>
						<option value = "새마을호" > 새마을호 </option>
					</select>
					
					<span id = "finpictraintype" style="font-size: xx-large; color : #639EB0; font-weight: bold;">
					
					</span>
				</div>
				
			</div>
			
			<!-- 특실, 일반실 선택 -->
			<div style="clear: both; text-align: left; padding-left: 5%; margin-top: 2%;" class = "left trainclass">
				등급 <br/>
				
				<div align="center" style="vertical-align: top;" >
				   <span id="vip" class="trainclass" >
	                  특실<img src = "<%=request.getContextPath()%>/resources/images/vipseat.png"
	                           alt="특실"  style="width: 12%; ">
	               </span>   
	               
	               <span id="vipselected" class="trainclass" >
	                  특실<img src = "<%=request.getContextPath()%>/resources/images/vipseat_selected.png"
	                           alt="특실선택" style="width: 12%; ">
	               </span>
	               
	               <span id="normal" class="trainclass" >
	                  일반실<img src = "<%=request.getContextPath()%>/resources/images/normalseat.png"
	                           alt="일반실" style="width: 12%; ">
	               </span>
	               <span id="normalselected" class="trainclass" >
	                  일반실<img src = "<%=request.getContextPath()%>/resources/images/normalseat_selected.png"
	                           alt="일반실선택" style="width: 12%; ">
	               </span>
	               <br/>
				</div>		
			
			</div>
		
		
		
		</div>
		
		
		
		
		<!-- 오른쪽 메뉴 -->
		<div id="rightside" >
		
			<!-- 왕복 -->
			<div id = "roundway" align="center" style="cursor: pointer;" onclick="roundway();">
				
					 <span class = "roundway" >
					 
					 	<img src = "<%=request.getContextPath()%>/resources/images/roundway.png"
							alt="왕복" style="width: 20%; ">
							
						<span style="color : #cccccc;">  &nbsp;&nbsp;&nbsp;&nbsp; 왕복 </span>
						
					 </span>
											
					 <span class = "roundway_selected">
					 
					 	<img src = "<%=request.getContextPath()%>/resources/images/roundway_selected.png"
							alt="왕복선택" style="width: 20%; cursor: pointer;">
					
						<span style="color : #639EB0;"> &nbsp;&nbsp;&nbsp;&nbsp; 왕복 </span>		
						
					 </span>
						
				</div>
				
			<!-- 편도일 경우 가는날 선택 -->
			<div style="clear: both; width:96%; margin: 2%; margin-bottom: 1%; " class = "right singledeparture" >
				<div style="float: left;  text-align: left; padding-left: 5%; width: 100%"  class = "departuredate singledeparture">
					가는 날 <br/>
					
					<div align="left">
						
						<div style="float: left; border: 0px solid black; margin-left :5%; width: 18%; text-align: right;">
							<label for = "departuredatepicker">
								<img src = "<%= request.getContextPath() %>/resources/images/datepicker.png" style="width:50%;">
							</label> 
						</div>
						
						<div style="float: left; border: 0x solid black; width: 70%;">
							<input type="text" id = "departuredatepicker" style="width: 50%; text-align: center; height: 60%; font-size: large;">
							&nbsp;						
							<span id="today" style="cursor: pointer; font-size: large;">오늘</span> &nbsp;
							<span id="tomorrow" style="cursor: pointer; font-size: large;">내일</span>
						</div>
						
					</div>				
					
				</div>
			</div>
			
			<!-- 왕복일 경우 가는날, 오는날 선택 -->
			<div style="clear: both; height: 100px; margin: 1%;  margin-bottom: 3%;" class = "doubledeparture" >
				<div style="float: left; width:48%; text-align: left; padding-left: 5%;"  class = "right departuredate doubledeparture">
					가는 날 <br/>
					
					<div align="left">
						
						<div style="float: left; border: 0px solid black; margin-left :5%; width: 20%; text-align: right;">
							<label for = "departuredatepickerR">
								<img src = "<%= request.getContextPath() %>/resources/images/datepicker.png" style="width:100%;">
							</label> 
						</div>
						
						<div style="float: left; border: 0x solid black; width: 65%; vertical-align: bottom;">
							<input type="text" id = "departuredatepickerR" style="width: 90%; text-align: center; height: 56%; font-size: medium;">
						</div>
						
					</div>	 
				</div>
			
				<div style="float: left; width:48%; text-align: left; padding-left: 5%; " class = "right departuredate doubledeparture">
					오는 날 <br/>
					
					<div align="left">
						
						<div style="float: left; border: 0px solid black; margin-left :5%; width: 20%; text-align: right;">
							<label for = "arrivaldatepickerR">
								<img src = "<%= request.getContextPath() %>/resources/images/datepicker.png" style="width:100%;">
							</label> 
						</div>
						
						<div style="float: left; border: 0x solid black; width: 65%; vertical-align: bottom;">
							<input type="text" id = "arrivaldatepickerR" style="width: 90%; text-align: center; height: 56%; font-size: medium;">
						</div>
						
					</div>	 
					
					
				</div>
			</div>
				
			<!-- 조회하기 -->
			<div id="browse" class="browse right" style="height: 200px; margin-top : 2%; padding-top: 70px; cursor: pointer; background-color: #639EB0;" onclick="goBooking();">
					<span style="height: 90%; width: 90%; margin: 1%; color: white; font-weight: bold; font-size: xx-large;"> 조회하기 </span>
		  		</div>
		
		</div>
		
	</div>


<!-- 넘겨줄 폼 -->
<form name = "browseForm">
	<br/><br/> 
	<!-- waytype :  --><input type="hidden" id ="waytype" name = "waytype">
	<br/><br/> 
	<!-- departure :  --><input type ="hidden" id = "departure" name = "departure" value = "-1">
	<br/><br/> 
	<!-- arrival :  --><input type ="hidden" id = "arrival" name = "arrival" value ="-1">
	<br/><br/> 
	<!-- traintype :  --><input type ="hidden" id = "traintype" name = "traintype" value = "-1">
	<br/><br/>
	<!-- trainclass :  --><input type ="hidden" id = "trainclass" name = "trainclass" value = "-1">
	<br/><br/>
	<!-- departuredate :  --><input type="text" id="departuredate" name = "departuredate" value = "-1" >
	<br/><br/>
	<!-- arrivaldate :  --><input type="text" id="arrivaldate" name = "arrivaldate" value = "-1" >	
	
	
</form>
    
</div>



<!-- 출발지 선택 모달창 -->				
	<div class="white_content" id="picdeparture">
        <div align="center">				            
           <div style="clear: both;width : 96%;">
           
				<div class="floatleft left box-shadow" style="width:48%; border: 5px solid #639EB0; cursor: pointer; " 
					 id="choosedeparture" onclick="picdeparture();">
					출발지 선택	<br/>
					<span id = "departurefromD" style="font-size: large; font-weight: bold;"></span>
				</div>
				
				<div class="floatleft left" style="width:48%; margin-left: 2%; margin-right: 0%; cursor: pointer;"
					id="choosearrival" onclick="picarrival();">
					도착지 선택	<br/>
					<span id = "arrivalfromD" style="font-size: large; font-weight: bold;"></span>
					
				</div>
				
			</div>
			
			<div style="clear: both; margin-top : 5%; width : 96%; border: 2px solid #639EB0; 
				 height:10%; border-radius: 20px; text-align: center; padding-top : 4%;" align="center">
				 
				<span style="font-weight: bold;">주요 출발지 : </span> 
					<c:forEach items="${departureList}" var="dList">
						<span onclick="finishDpic('${dList}');" style="cursor: pointer;"> 	${dList}	|</span>	
						<input type="hidden" value="${dList}">
					</c:forEach>			
					
			</div>
			
			
			<div style="clear: both; margin-top : 3%; margin-bottom:0%; margin-left: 0%; margin-right: 0%; width : 96%; 
				 border: 2px solid #639EB0; height:60%; border-radius: 20px; 
				 paddind-top: 3%; text-align: center;" align="center">
				<ul style="list-style: none;">
					<c:forEach items="${departureList}" var="dList">
						<li>
							<span onclick="finishDpic('${dList}');" style="cursor: pointer;"> ${dList}	</span>
							<input type="hidden" value="${dList}">
						</li>
					</c:forEach>			
				</ul>
			</div>
            
           
           <div id = "dclose" onclick="finishpic();"
           		style="clear: both; cursor: pointer; font-size: 20; color: white; 
           		font-weight: bold; background-color: #639EB0; margin-top: 3%; width: 96%;" align="center" class="btn" >닫기</div>
           
           
        </div>
    </div>

<!-- 도착지 선택 모달창 -->				
	<div class="white_content" id="picarrival">
        <div align="center">				            
           <div style="clear: both; margin-bottom : 5%; width : 96%;">
           
				<div class="floatleft left box-shadow" style="width:48%; cursor: pointer; " 
						id="choosedeparturefromA" onclick="picdeparture();">
					출발지 선택	<br/>
					<span id = "departurefromA" style="font-size: large; font-weight: bold;"></span>
				</div>
				
				<div class="floatleft left" style="width:48%; margin-left: 2%; margin-right: 0%;  border: 5px solid #639EB0;
						cursor: pointer;"
						id="choosearrivalfromA" onclick="picarrival();">
					도착지 선택	<br/>
					<span id = "arrivalfromA" style="font-size: large; font-weight: bold;"></span>
				</div>
				
			</div>
			
			<div style="clear: both; margin-top : 5%; width : 96%; border: 2px solid #639EB0; 
				 height:10%; border-radius: 20px; text-align: center; padding-top : 4%;" align="center">
				 
				<span style="font-weight: bold;">주요 도착지 : </span> 
					<c:forEach items="${arrivalList}" var="aList">
						<span onclick="finishApic('${aList}');" style="cursor: pointer;">	${aList}	|</span>
						<input type="hidden" value="${aList}">
					</c:forEach>			
					
			</div>
			
			
			<div style="clear: both; margin-top : 3%; margin-bottom:0%; margin-left: 0%; margin-right: 0%; width : 96%; 
				 border: 2px solid #639EB0; height:60%; border-radius: 20px; 
				 paddind-top: 3%; text-align: center;" align="center">
				<ul style="list-style: none;">
					<c:forEach items="${arrivalList}" var="aList">
						<li>
							<span onclick="finishApic('${aList}');" style="cursor: pointer;"> ${aList}	</span>
							<input type="hidden" value="${aList}">
						</li>
					</c:forEach>			
				</ul>
			</div>
            
           
           <div id = "aclose" onclick="finishpic();"
           		style="clear: both; cursor: pointer; font-size: 20; color: white; 
           		font-weight: bold; background-color: #639EB0; margin-top: 3%; width: 96%;" align="center" class="btn" >닫기</div>
           
           
        </div>
    </div>





