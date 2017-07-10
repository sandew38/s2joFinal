<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- SWAL -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.css"
   	  rel="stylesheet">
<script src=" https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.common.min.js"></script>


<style type="text/css">

.yjcontent
{
	font-family: 나눔고딕;
}

/*모달*/
.white_content {
    position: fixed;
    font-family: 나눔고딕;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    background-color: white;
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
//	border-radius : 20px;
	background-color: white;
	overflow: auto;	
}


/* progress bar 관련 css */
body{margin:40px;}

.stepwizard-step p {
    margin-top: 10px;    
}

.stepwizard-row {
    display: table-row;
}

.stepwizard {
    display: table;     
    width: 100%;
    position: relative;
}

.stepwizard-step button[disabled] {
    opacity: 1 !important;
    filter: alpha(opacity=100) !important;
}

.stepwizard-row:before {
    top: 14px;
    bottom: 0;
    position: absolute;
    content: " ";
    width: 100%;
    height: 1px;
    background-color: #ccc;
    z-order: 0;
    
}

.stepwizard-step {    
    display: table-cell;
    text-align: center;
    position: relative;
}

.btn-circle {
  width: 30px;
  height: 30px;
  text-align: center;
  padding: 6px 0;
  font-size: 12px;
  line-height: 1.428571429;
  border-radius: 15px;
}
/* progress bar 관련 css */

</style>

<script type="text/javascript">

// 회원 로그인
$(document).ready(function(){
	
	$("#btnLOGIN").click(function(){
		
		var userid = $("#userid").val();
		var pwd = $("#pwd").val(); 
		
		if(!userid || userid.trim() == "")
		{
//			alert("아이디를 입력해주세요!");
			
			sweetAlert("", "아이디를 입력해주세요!", "error");
		}
		else if (!pwd || pwd.trim() == "")
		{
//			alert("비밀번호를 입력해주세요!");
			
			sweetAlert("", "비밀번호를 입력해주세요!", "error");

		}
		
		var form_data = {userid : userid, pwd : pwd};
		
		$.ajax({
			url: "/khx/seatloginEnd.action",
			type: "POST",
			data: form_data,
			dataType: "JSON",
			success: function(data){
							
				close();
				
//				alert("로그인성공!");

				swal("로그인성공!", "", "success")
				
				var orderConfirmForm = document.orderConfirmForm;
				orderConfirmForm.method = "post";
				orderConfirmForm.action = "orderConfirm.action";
				
				orderConfirmForm.submit();		
				
			}, // end of success ----
			error: function(){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error); 
		}//end of error
			
		}); // end of ajax ----
		
	}); // end of click ----

	$("#pwd").keydown(function(event){
	      
	      if(event.keyCode == 13) { // 엔터를 했을 경우
	         
		    	var userid = $("#userid").val();
		  		var pwd = $("#pwd").val(); 
		  		
		  		if(!userid || userid.trim() == "")
		  		{
		  			swal("아이디를 입력해주세요!");
		  		}
		  		else if (!pwd || pwd.trim() == "")
		  		{
		  			swal("비밀번호를 입력해주세요!");
		  		}
		  		
		  		var form_data = {userid : userid, pwd : pwd};
		  		
		  		$.ajax({
			  			url: "/khx/seatloginEnd.action",
			  			type: "POST",
			  			data: form_data,
			  			dataType: "JSON",
			  			success: function(data){
			  							
			  				close();
			  				
			  				swal("로그인성공!");
			  				
			  				var orderConfirmForm = document.orderConfirmForm;
			  				orderConfirmForm.method = "post";
			  				orderConfirmForm.action = "orderConfirm.action";
			  				
			  				orderConfirmForm.submit();		
			  				
			  			}, // end of success ----
			  			error: function(){
			  			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error); 
			  		}//end of error
		  			
		  		}); // end of ajax ----

	      } // end of if ----
	      
	   
	   }); // end of $("#pwd").keydown();-----------------------
	
// 비회원 예매
	$("#nonbtnLOGIN").click(function(){
							
		var orderConfirmForm = document.orderConfirmForm;
		orderConfirmForm.method = "post";
		orderConfirmForm.action = "orderConfirm.action";
		
		orderConfirmForm.submit();		
		
	}); // end of click ----
	
	
// 통합회원가입
	$("#register").click(function(){
		
		location.href = "memberRegister.action";
				
	}); // end of click ----
	
	
}); // end of ready ----


//그냥 닫기 
function close()
{	location.href="#";	}

// 일반 수 증가
function plusnormal()
{
	var normal = document.getElementById("normalperson").innerHTML * 1;
	var student = document.getElementById("student").innerHTML * 1;
	var older = document.getElementById("olderperson").innerHTML * 1;
	
	var sum = normal + student + older;
	
//	alert("sum : " + sum);
	
	if(sum >= 4)
	{
//		alert("1인당 최대 4매까지만 구매하실 수 있습니다!");

		sweetAlert("", "1인당 최대 4매까지만 구매하실 수 있습니다!", "error");
	}
	
	else if(normal==0)
	{
		$("#normal").val("1");
		document.getElementById("normalperson").innerHTML = 1;	
	}
	else if(normal==1)
	{
		$("#normal").val("2");
		document.getElementById("normalperson").innerHTML = 2;	
	}
	else if(normal==2)
	{
		$("#normal").val("3");
		document.getElementById("normalperson").innerHTML = 3;	
	}
	else if(normal==3)
	{
		$("#normal").val("4");
		document.getElementById("normalperson").innerHTML = 4;	
	}
	else if(normal==4)
	{
//		alert("1인당 최대 4매까지만 구매하실 수 있습니다!");

		sweetAlert("", "1인당 최대 4매까지만 구매하실 수 있습니다!", "error");
	}
	
}

// 일반 수 감소
function minusnormal()
{
	var normal = document.getElementById("normalperson").innerHTML * 1;
	var student = document.getElementById("student").innerHTML * 1;
	var older = document.getElementById("olderperson").innerHTML * 1;

	var sum = normal + student + older;
	
//	alert("sum : " + sum);

	var seatcount = $("#seatcount").val()*1;
	var selectedseat = document.getElementById("selectedseat").innerHTML;
	
	if (sum <= seatcount)
	{
		sweetAlert("선택한 좌석보다 인원이 적을 수 없습니다!", "재선택을 원하실경우 새로고침 버튼을 눌러주세요.", "error");		
		return;
	}

	
	if(normal==0)
	{
		$("#normal").val("0");
		document.getElementById("normalperson").innerHTML = 0;	
	}
	else if(normal==1)
	{
		$("#normal").val("0");
		document.getElementById("normalperson").innerHTML = 0;	
	}
	else if(normal==2)
	{
		$("#normal").val("1");
		document.getElementById("normalperson").innerHTML = 1;	
	}
	else if(normal==3)
	{
		$("#normal").val("2");
		document.getElementById("normalperson").innerHTML = 2;	
	}
	else if(normal==4)
	{
		$("#normal").val("3");
		document.getElementById("normalperson").innerHTML = 3;
	}
}

// 중고생 수 증가
function plusstudent()
{
	var normal = document.getElementById("normalperson").innerHTML * 1;
	var student = document.getElementById("student").innerHTML * 1;
	var older = document.getElementById("olderperson").innerHTML * 1;
	
	var sum = normal + student + older;
	
//	alert("sum : " + sum);
	
	if(sum >= 4)
	{
//		alert("1인당 최대 4매까지만 구매하실 수 있습니다!");
		
		sweetAlert("", "1인당 최대 4매까지만 구매하실 수 있습니다!", "error");
	}
	
	else if(student==0)
	{
		$("#students").val("1");
		document.getElementById("student").innerHTML = 1;	
	}
	else if(student==1)
	{
		$("#students").val("2");
		document.getElementById("student").innerHTML = 2;	
	}
	else if(student==2)
	{
		$("#students").val("3");
		document.getElementById("student").innerHTML = 3;	
	}
	else if(student==3)
	{
		$("#students").val("4");
		document.getElementById("student").innerHTML = 4;	
	}
	else if (student ==4)
	{
//		alert("1인당 최대 4매까지만 구매하실 수 있습니다!");
		
		sweetAlert("", "1인당 최대 4매까지만 구매하실 수 있습니다!", "error");
	}
	
}

// 중고생 수 감소
function minusstudent()
{
	var normal = document.getElementById("normalperson").innerHTML * 1;
	var student = document.getElementById("student").innerHTML * 1;
	var older = document.getElementById("olderperson").innerHTML * 1;

	var sum = normal + student + older;
	
//	alert("sum : " + sum);
	
	var seatcount = $("#seatcount").val()*1;
	var selectedseat = document.getElementById("selectedseat").innerHTML;
	
	if (sum <= seatcount)
	{
		sweetAlert("선택한 좌석보다 인원이 적을 수 없습니다!", "재선택을 원하실경우 새로고침 버튼을 눌러주세요.", "error");		
		return;
	}

	if(student==0)
	{
		$("#students").val("0");
		document.getElementById("student").innerHTML = 0;	
	}
	else if(student==1)
	{
		$("#students").val("0");
		document.getElementById("student").innerHTML = 0;	
	}
	else if(student==2)
	{
		$("#students").val("1");
		document.getElementById("student").innerHTML = 1;	
	}
	else if(student==3)
	{
		$("#students").val("2");
		document.getElementById("student").innerHTML = 2;	
	}
	else if(student==4)
	{
		$("#students").val("3");
		document.getElementById("student").innerHTML = 3;
	}
}

// 65세 이상 수 증가
function plusolder()
{
	var normal = document.getElementById("normalperson").innerHTML * 1;
	var student = document.getElementById("student").innerHTML * 1;
	var older = document.getElementById("olderperson").innerHTML * 1;
	
	var sum = normal + student + older;
	
//	alert("sum : " + sum);
	
	if(sum >= 4)
	{
//		alert("1인당 최대 4매까지만 구매하실 수 있습니다!");

		sweetAlert("", "1인당 최대 4매까지만 구매하실 수 있습니다!", "error");
	}
	
	else if(older==0)
	{
		$("#older").val("1");
		document.getElementById("olderperson").innerHTML = 1;	
	}
	else if(older==1)
	{
		$("#older").val("2");
		document.getElementById("olderperson").innerHTML = 2;	
	}
	else if(older==2)
	{
		$("#older").val("3");
		document.getElementById("olderperson").innerHTML = 3;	
	}
	else if(older==3)
	{
		$("#older").val("4");
		document.getElementById("olderperson").innerHTML = 4;	
	}
	else if(older==4)
	{
//		alert("1인당 최대 4매까지만 구매하실 수 있습니다!");

		sweetAlert("", "1인당 최대 4매까지만 구매하실 수 있습니다!", "error");
	}
	
}

// 65세 이상 수 감소
function minusolder()
{
	var normal = document.getElementById("normalperson").innerHTML * 1;
	var student = document.getElementById("student").innerHTML * 1;
	var older = document.getElementById("olderperson").innerHTML * 1;

	var sum = normal + student + older;
//	alert("sum : " + sum);

	var seatcount = $("#seatcount").val()*1;
	var selectedseat = document.getElementById("selectedseat").innerHTML;
	
	if (sum <= seatcount)
	{
		sweetAlert("선택한 좌석보다 인원이 적을 수 없습니다!", "재선택을 원하실경우 새로고침 버튼을 눌러주세요.", "error");		
		return;
	}
	
	
	if(older==0)
	{
		$("#older").val("0");
		document.getElementById("olderperson").innerHTML = 0;	
	}
	else if(older==1)
	{
		$("#older").val("0");
		document.getElementById("olderperson").innerHTML = 0;	
	}
	else if(older==2)
	{
		$("#older").val("1");
		document.getElementById("olderperson").innerHTML = 1;	
	}
	else if(older==3)
	{
		$("#older").val("2");
		document.getElementById("olderperson").innerHTML = 2;	
	}
	else if(older==4)
	{
		$("#older").val("3");
		document.getElementById("olderperson").innerHTML = 3;
	}
}

// 호차변경
function changeclassno(classno)
{
	var changeClass = document.changeClass;
	
	if (classno == 0)
	{
//		alert("이전 호차가 없습니다!");
		
		sweetAlert("", "이전 호차가 없습니다!", "error");
		
		return;
	}
	else if (classno == 9)
	{
//		alert("다음 호차가 없습니다!");
		
		sweetAlert("", "다음 호차가 없습니다!", "error");
		
		return;
	}
	
//	alert(classno);
	$("#trainclass").val(classno);
	
	changeClass.method = "post";
	changeClass.action = "selectseat.action";
	
	changeClass.submit();
	
}

// 좌석 선택 
function goselect(seatno)
{
	var seatcount = $("#seatcount").val()*1;
	var selectedseat = document.getElementById("selectedseat").innerHTML;
	
//	alert("선택한 좌석번호 : " + seatno);	// 선택한 좌석번호
//	alert("선택좌석에 추가된 문자열 : " + selectedseat);	// span 태그에 들어있는 값

	var checkFlag = selectedseat.search(seatno);

//	alert("특정문자열이 포함되었는지 확인 : " + checkFlag);
	
	if(checkFlag > -1 )
	{
		sweetAlert("","이미 선택하신 좌석입니다!","error");
		return;
	}
	
	// 인원 수를 먼저 설정하게 한다.
	var normal = document.getElementById("normalperson").innerHTML * 1;
	var student = document.getElementById("student").innerHTML * 1;
	var older = document.getElementById("olderperson").innerHTML * 1;
	var sum = normal + student + older;
//	alert("sum : " + sum);	// 설정한 인원수

//	객실 등급을 알아온다.
	var trainclass = $("#trainclass").val();
//	alert(trainclass);
	
//	탑승 인원 선택을 안한 경우
	if(sum == 0)
	{
//		alert("예매할 인원을 먼저 선택해주세요!");

		sweetAlert("", "예매할 인원을 먼저 선택해주세요!", "error");
		
		return;
	}
	
	else if (sum == seatcount)
	{
		sweetAlert("좌석을 전부 선택하셨습니다!", "재선택을 원하실경우 새로고침 버튼을 눌러주세요.", "error");		
	}
	else
	{
		seatcount += 1;
		
		$("#seatcount").val(seatcount);
		
// [선택 좌석]에 해당 좌석 번호를 입력해준다.
	var selectedseat = document.getElementById("selectedseat").innerHTML;
//	alert(selectedseat);	// span 태그에 들어있는 값

	$("#selectedSeatList").val(selectedseat);
	
//	tqty input 값을 num으로 받는다.	
	var num = $("#tqty").val();
	
//	alert(num*1+1);
//	1 추가 해준다.
	num = num*1+1

//	설정한 인원수보다 많은 좌석을 선택한 경우	
	if ($("#tqty").val() >= sum)
	{
//		alert("선택하신 인원수보다 많이 선택할 수 없습니다!");

		sweetAlert("", "선택하신 인원수보다 많이 선택할 수 없습니다!", "error");

		return;
	}
//	1 추가한 값을 넣어준다. 
	$("#tqty").val(num);
	
//	선택한 좌석을 좌석선택 부분에 넣어준다. 
	document.getElementById("selectedseat").innerHTML += seatno + "번 ";


	var rate = $("#rate").val()*1;

	var normalSeatCnt = document.getElementById("normalSeatCnt").innerHTML*1;
	var studentSeatCnt = document.getElementById("studentSeatCnt").innerHTML*1;
	var olderSeatCnt = document.getElementById("olderSeatCnt").innerHTML*1;

// 탑승인원 및 요금에 정보를 추가해준다. 

// 일반이 선택된 경우
	if(normal > 0)
	{	
		var normalP = document.getElementById("normalPrice").innerHTML.replace(",","");
		
		var normalPrice = normalP*1;
		
		if(trainclass <4)
		{
			rate = rate *1.2;
//			alert("프리미엄 객실입니다!");		
//			alert(rate);
		}
		
//		alert("일반승객 : " + $("#normal").val() );
		// 인원 & 요금을 넣어준다.
		
		// 일반만 선택한 경우
		if(normal > 0 && student < 1 && older < 1)
		{
			
			if (normalSeatCnt == 0)
			{	document.getElementById("normalSeatCnt").innerHTML = 1;
				document.getElementById("normalPrice").innerHTML = rate.toLocaleString('en');	}
			else if(normalSeatCnt == 1)
			{	document.getElementById("normalSeatCnt").innerHTML = 2;
				document.getElementById("normalPrice").innerHTML = (normalPrice + rate).toLocaleString('en');	}
			else if(normalSeatCnt == 2)
			{	document.getElementById("normalSeatCnt").innerHTML = 3;
				document.getElementById("normalPrice").innerHTML = (normalPrice + rate).toLocaleString('en');	}
			else if(normalSeatCnt == 3)
			{	document.getElementById("normalSeatCnt").innerHTML = 4;
				document.getElementById("normalPrice").innerHTML = (normalPrice + rate).toLocaleString('en');	}
			
		} // end of 일반 선택
					
		
		// 일반 & 중고생 선택
		if( normal > 0 && student > 0 && older < 1)
		{
//			alert("중고생 탑승객 : " + $("#students").val());
						
			// 일반 & 중고생 선택
			// 일반좌석부터 증가
			if(normal > normalSeatCnt)
			{
//				alert("normal : " + normal + "normalSeatCnt : " + normalSeatCnt);
								
				if (normal != normalSeatCnt && normalSeatCnt == 0)
				{	document.getElementById("normalSeatCnt").innerHTML = 1;
					document.getElementById("normalPrice").innerHTML = rate.toLocaleString('en');	}
				else if(normal != normalSeatCnt && normalSeatCnt == 1)
				{	document.getElementById("normalSeatCnt").innerHTML = 2;
					document.getElementById("normalPrice").innerHTML = (normalPrice + rate).toLocaleString('en');	}
				else if(normal != normalSeatCnt && normalSeatCnt == 2)
				{	document.getElementById("normalSeatCnt").innerHTML = 3;
					document.getElementById("normalPrice").innerHTML = (normalPrice + rate).toLocaleString('en');	}	
			}

			// 일반 & 중고생 선택
			// 일반 선택 완료시 학생 추가
			else if (normal == normalSeatCnt)
			{
//				alert("일반좌석 선택 끝");
//				alert("학생추가");
				
				var studentP = document.getElementById("studentPrice").innerHTML.replace(",","");
				var studentPrice = studentP*1;
				
				if (studentSeatCnt == 0)
				{	document.getElementById("studentSeatCnt").innerHTML = 1;
					document.getElementById("studentPrice").innerHTML = Math.round(rate*0.80).toLocaleString('en');	}
				else if(studentSeatCnt == 1)
				{	document.getElementById("studentSeatCnt").innerHTML = 2;
					document.getElementById("studentPrice").innerHTML = (studentPrice + Math.round(rate*0.80)).toLocaleString('en');	}
				else if(studentSeatCnt == 2)
				{	document.getElementById("studentSeatCnt").innerHTML = 3;
					document.getElementById("studentPrice").innerHTML = (studentPrice + Math.round(rate*0.80)).toLocaleString('en');	}
			}
			
		} // end of 일반 & 중고생 선택 ----
		
		// 일반 & 65세 이상 선택
		if (normal > 0 && student < 1 && older > 0)
		{
//			alert("65세 이상 탑승객 : " + $("#older").val());
			
			// 일반 & 65세 이상 선택
			// 일반좌석부터 증가
			if(normal > normalSeatCnt)
			{
//				alert("normal : " + normal + "normalSeatCnt : " + normalSeatCnt);
								
				if (normal != normalSeatCnt && normalSeatCnt == 0)
				{	document.getElementById("normalSeatCnt").innerHTML = 1;
					document.getElementById("normalPrice").innerHTML = rate.toLocaleString('en');	}
				else if(normal != normalSeatCnt && normalSeatCnt == 1)
				{	document.getElementById("normalSeatCnt").innerHTML = 2;
					document.getElementById("normalPrice").innerHTML = (normalPrice + rate).toLocaleString('en');	}
				else if(normal != normalSeatCnt && normalSeatCnt == 2)
				{	document.getElementById("normalSeatCnt").innerHTML = 3;
					document.getElementById("normalPrice").innerHTML = (normalPrice + rate).toLocaleString('en');	}	
			}

			// 일반 & 65세 이상 선택
			// 일반 선택 완료시 65세 이상 추가
			else if (normal == normalSeatCnt)
			{
//				alert("일반좌석 선택 끝");
//				alert("65세 이상 추가");
				
				var olderP = document.getElementById("olderPrice").innerHTML.replace(",","");
				var olderPrice = olderP*1;
				
				if (olderSeatCnt == 0)
				{	document.getElementById("olderSeatCnt").innerHTML = 1;
					document.getElementById("olderPrice").innerHTML = Math.round(rate*0.75).toLocaleString('en');	}
				else if(olderSeatCnt == 1)
				{	document.getElementById("olderSeatCnt").innerHTML = 2;
					document.getElementById("olderPrice").innerHTML = (olderPrice + Math.round(rate*0.75)).toLocaleString('en');	}
				else if(olderSeatCnt == 2)
				{	document.getElementById("olderSeatCnt").innerHTML = 3;
					document.getElementById("olderPrice").innerHTML = (olderPrice + Math.round(rate*0.75)).toLocaleString('en');	}
			}
		} // end of 일반 & 65세 이상 선택 ----
		
		// 일반 & 중고생 , 65세 이상 전부 선택한 경우
		if (normal > 0 && student > 0 && older > 0)
		{
//			alert("전부 선택했군욧!");

			if(normal > normalSeatCnt)
			{
//				alert("normal : " + normal + "normalSeatCnt : " + normalSeatCnt);
								
				if (normal != normalSeatCnt && normalSeatCnt == 0)
				{	document.getElementById("normalSeatCnt").innerHTML = 1;
					document.getElementById("normalPrice").innerHTML = rate.toLocaleString('en');	}
				else if(normal != normalSeatCnt && normalSeatCnt == 1)
				{	document.getElementById("normalSeatCnt").innerHTML = 2;
					document.getElementById("normalPrice").innerHTML = (normalPrice + rate).toLocaleString('en');	}
			}

			// 일반 선택 완료시 
			// 중고생 추가
			if(normal == normalSeatCnt && student > studentSeatCnt)
			{
				var studentP = document.getElementById("studentPrice").innerHTML.replace(",","");
				var studentPrice = studentP*1;
				
				if (studentSeatCnt == 0)
				{	document.getElementById("studentSeatCnt").innerHTML = 1;
					document.getElementById("studentPrice").innerHTML = Math.round(rate*0.80).toLocaleString('en');	}
				else if(studentSeatCnt == 1)
				{	document.getElementById("studentSeatCnt").innerHTML = 2;
					
//					alert(studentPrice);
//					alert(Math.round(rate*0.80));
				
					document.getElementById("studentPrice").innerHTML = (studentPrice + Math.round(rate*0.80)).toLocaleString('en');	}
			}
			
			
			// 일반 & 중고생 선택 완료시 
			// 65세 이상 추가
			else if (normal == normalSeatCnt && student == studentSeatCnt && older > olderSeatCnt)
			{
				var olderP = document.getElementById("olderPrice").innerHTML.replace(",","");
				var olderPrice = olderP*1;
				
				if (olderSeatCnt == 0)
				{	document.getElementById("olderSeatCnt").innerHTML = 1;
					document.getElementById("olderPrice").innerHTML = Math.round(rate*0.75).toLocaleString('en');	}
				else if(olderSeatCnt == 1)
				{	document.getElementById("olderSeatCnt").innerHTML = 2;
					document.getElementById("olderPrice").innerHTML = (olderPrice + Math.round(rate*0.75)).toLocaleString('en');	}
			}

		} // end of 전부선택 ----
		
			
	}
	
	
	
	// 중고생만 선택한 경우
	else if (normal < 1 && student > 0 && older < 1)
	{	
//		alert('학생만 선택했군요!');
		var studentP = document.getElementById("studentPrice").innerHTML.replace(",","");
		var studentPrice = studentP*1;
		
		if(trainclass <4)
		{
			rate = rate *1.2;
//			alert("프리미엄 객실입니다!");		
//			alert(rate);
		}
		
		if (studentSeatCnt == 0)
		{	document.getElementById("studentSeatCnt").innerHTML = 1;
			document.getElementById("studentPrice").innerHTML = Math.round(rate*0.80).toLocaleString('en');	}
		else if(studentSeatCnt == 1)
		{	document.getElementById("studentSeatCnt").innerHTML = 2;
			document.getElementById("studentPrice").innerHTML = (studentPrice + Math.round(rate*0.80)).toLocaleString('en');	}
		else if(studentSeatCnt == 2)
		{	document.getElementById("studentSeatCnt").innerHTML = 3;
			document.getElementById("studentPrice").innerHTML = (studentPrice + Math.round(rate*0.80)).toLocaleString('en');	}
		else if(studentSeatCnt == 3)
		{	document.getElementById("studentSeatCnt").innerHTML = 4;
			document.getElementById("studentPrice").innerHTML = (studentPrice + Math.round(rate*0.80)).toLocaleString('en');	}
		
		// 65세 이상도 선택하였는지 확인
		
	}
	
	// 중고생 & 65세 이상 선택
	else if (normal < 1 && student > 0 && older >0)
	{
		if(trainclass <4)
		{
			rate = rate *1.2;
//			alert("프리미엄 객실입니다!");		
//			alert(rate);
		}
		
		// 중고생부터 증가 
		if(student > studentSeatCnt)
		{
//			alert("student : " + student + "studentSeatCnt : " + studentSeatCnt);
			var studentP = document.getElementById("studentPrice").innerHTML.replace(",","");
			var studentPrice = studentP*1;
							
			if (student != studentSeatCnt && studentSeatCnt == 0)
			{	document.getElementById("studentSeatCnt").innerHTML = 1;
				document.getElementById("studentPrice").innerHTML = (Math.round(rate*0.80)).toLocaleString('en');	}
			else if(student != studentSeatCnt && studentSeatCnt == 1)
			{	document.getElementById("studentSeatCnt").innerHTML = 2;
				document.getElementById("studentPrice").innerHTML = (studentPrice + Math.round(rate*0.80)).toLocaleString('en');	}
			else if(student != studentSeatCnt && studentSeatCnt == 2)
			{	document.getElementById("studentSeatCnt").innerHTML = 3;
				document.getElementById("studentPrice").innerHTML = (studentPrice + Math.round(rate*0.80)).toLocaleString('en');	}	
		}

		// 중고생 & 65세 이상 선택
		// 중고생 선택 완료시 학생 추가
		else if (student == studentSeatCnt)
		{
//			alert("중고생좌석 선택 끝");
//			alert("65세 이상 추가");
			
			var olderP = document.getElementById("olderPrice").innerHTML.replace(",","");
			var olderPrice = olderP*1;
			
			if (olderSeatCnt == 0)
			{	document.getElementById("olderSeatCnt").innerHTML = 1;
				document.getElementById("olderPrice").innerHTML = (Math.round(rate*0.75)).toLocaleString('en');	}
			else if(olderSeatCnt == 1)
			{	document.getElementById("olderSeatCnt").innerHTML = 2;
				document.getElementById("olderPrice").innerHTML = (olderPrice + Math.round(rate*0.75)).toLocaleString('en');	}
			else if(olderSeatCnt == 2)
			{	document.getElementById("olderSeatCnt").innerHTML = 3;
				document.getElementById("olderPrice").innerHTML = (olderPrice + Math.round(rate*0.75)).toLocaleString('en');	}
		}//////
	}
	
	
	// 65세 이상만 선택한 경우
	else if (normal < 1 && student < 1 && older != 0)
	{
//		alert('65세 이상만 선택했군요!');
		
		var olderP = document.getElementById("olderPrice").innerHTML.replace(",","");
		var olderPrice = olderP*1;
		
		if(trainclass <4)
		{
			rate = rate *1.2;
//			alert("프리미엄 객실입니다!");		
//			alert(rate);
		}
		
		if (olderSeatCnt == 0)
		{	document.getElementById("olderSeatCnt").innerHTML = 1;
			document.getElementById("olderPrice").innerHTML = Math.round(rate*0.75).toLocaleString('en');	}
		else if(olderSeatCnt == 1)
		{	document.getElementById("olderSeatCnt").innerHTML = 2;
			document.getElementById("olderPrice").innerHTML = (olderPrice + Math.round(rate*0.75)).toLocaleString('en');	}
		else if(olderSeatCnt == 2)
		{	document.getElementById("olderSeatCnt").innerHTML = 3;
			document.getElementById("olderPrice").innerHTML = (olderPrice + Math.round(rate*0.75)).toLocaleString('en');	}
		else if(olderSeatCnt == 3)
		{	document.getElementById("olderSeatCnt").innerHTML = 4;
			document.getElementById("olderPrice").innerHTML = (olderPrice + Math.round(rate*0.75)).toLocaleString('en');	}
	}


//	인원에 따라 탑승인원 종류를 탑승인원 부분에 넣어준다. 
//	document.getElementById("selectedPassengers").innerHTML += 종류 + "<br/>";
	
//	인원에 따라 탑승인원종류별 가격을 요금 부분에 넣어준다. 
//	document.getElementById("priceperPassengers").innerHTML += 가격 + "<br/>";

	
// 이미지를 바꿔준다. 
	var selected = document.getElementById("selectseat"+seatno);
//	alert(selected.src);
	
	selected.src="<%=request.getContextPath()%>/resources/images/seat_selected.png";
//	alert(selected.src);
	
// 정보에 따라 총 결제금액을 추가해준다. 
	var normalP = document.getElementById("normalPrice").innerHTML.replace(",","");
		var normalPrice = normalP*1;
	var studentP = document.getElementById("studentPrice").innerHTML.replace(",","");
		var studentPrice = studentP*1;
	var olderP = document.getElementById("olderPrice").innerHTML.replace(",","");
		var olderPrice = olderP*1;

	var sum = (normalPrice+studentPrice+olderPrice);
//	alert(normalPrice+studentPrice+olderPrice);
	
	document.getElementById("sumtotalPrice").innerHTML = (normalPrice+studentPrice+olderPrice).toLocaleString('en')+"원";
	
	$("#totalPrice").val(sum);
	}
}


function goConfirm()
{
	// 유효성 검사 
	var tqty = $("#tqty").val();	// 주문할 티켓 장 수 
	var normal = $("#normal").val()*1;	// 선택한 일반좌석
	var students = $("#students").val()*1; // 선택한 중고생 좌석
	var older = $("#older").val()*1;		// 선택한 65세 이상 좌석
	var totalPrice = $("#totalPrice").val();	// 티켓 총 가격 
	var selectedseat = document.getElementById("selectedseat").innerHTML; // 선택한 좌석번호들

	var sum = (normal+students+older);
	
	
	var normalSeatCnt = document.getElementById("normalSeatCnt").innerHTML*1;
	var studentSeatCnt = document.getElementById("studentSeatCnt").innerHTML*1;
	var olderSeatCnt = document.getElementById("olderSeatCnt").innerHTML*1;
	
	var seatsum = (normalSeatCnt + studentSeatCnt + olderSeatCnt );
	
//	alert("tqty : "+tqty);
//	alert("normal : "+normal);
//	alert("students : "+students);
//	alert("older : "+older);
//	alert("totalPrice : "+totalPrice);
//	alert("selectedseat : " + selectedseat);
//	alert("seatsum : "+seatsum);
//	alert("sum : "+sum);
		
	if(sum < 1)
	{
//		alert("매수와 좌석을 선택해주세요!");

		sweetAlert("", "매수와 좌석을 선택해주세요!", "error");

	}
	else if (selectedseat.length < 1 || sum != seatsum)
	{
//		alert("좌석을 선택해주세요!");

		sweetAlert("", "좌석을 선택해주세요!", "error");

	}

	
//	로그인 안한 경우 
	
	else if( ${sessionScope.loginuser.userid == null} && ${sessionScope.nonno == null} )
	{
		
		$("#selectedSeatList").val(selectedseat);
		
//		alert("로그인하셔야합니다!");
		
		swal("로그인이 필요한 서비스입니다!")
		
		location.href="#gologinForm";

	}
	else if(${sessionScope.loginuser.userid != null} || ${sessionScope.nonno != null})
	{
//	로그인 한 경우	


		// [선택 좌석]에 해당 좌석 번호를 입력해준다.
		var selectedseat = document.getElementById("selectedseat").innerHTML;
		//	alert(selectedseat);	span 태그에 들어있는 값
	
		$("#selectedSeatList").val(selectedseat);
		
//		alert("이거 나와야하는데 : "+$('#selectedSeatList').val());
		
		var orderConfirmForm = document.orderConfirmForm;
		orderConfirmForm.method = "post";
		orderConfirmForm.action = "orderConfirm.action";
		
		orderConfirmForm.submit();		
	}
}


</script>



<div class="yjcontent" style="width: 100%; height: 96%; background-color: white; margin-bottom: 10%;" align="center">
	<div id = "outer" style="width: 80%; border: 0px #639EB0 solid; margin-bottom: 10%;" align="center">
	
		<br/><br/>
		<h3 style="font-weight: bold;">배차조회</h3>
		<br/>
		
		
		<!--  progress bar  -->
		<div class="stepwizard" style="width:70%; margin-right:5%;">
		    <div class="stepwizard-row">
		        <div class="stepwizard-step">
		            <button type="button" class="btn btn-primary btn-circle" style="background-color: #639EB0;">1</button>
		            <p>예약 정보 선택</p>
		        </div>
		        <div class="stepwizard-step">
		            <button type="button" class="btn btn-default btn-circle" disabled="disabled">2</button>
		            <p>결제 정보 입력</p>
		        </div>
		        <div class="stepwizard-step">
		            <button type="button" class="btn btn-default btn-circle" disabled="disabled">3</button>
		            <p>예매 완료</p>
		        </div> 
		    </div>
		</div>
		
		
		<br/>
		
		<div id = "infobox" style="float: left; background-color:#639EB0; margin-left:10%; padding-top:3%; margin-right: 1%; width: 18%; height: 93%;" >
		
			<div style="height: 5%; vertical-align: middle; border: 0px green solid;">
				${departuredate}
			</div>
			
			<div style="height : 40%; border: 0px dashed pink; font-size: large;">
				<img src ="<%=request.getContextPath() %>/resources/images/circle.png" style="position: relative; padding-left:10%; width: 40%; z-index: 1;" align="left"> 
				<div style="position : relative; z-index: 2; left: -46%; top: 8%;">출발</div><span style="font-size: larger; padding-right: 15%;">${departure}</span><br/>
				
				<br/>
				<img src ="<%=request.getContextPath() %>/resources/images/circle.png" style="position: relative; padding-left:10%; width: 40%; z-index: 1;" align="left"> 
				<div style="position : relative; z-index: 2; left: -46%; top: 8%;">도착</div><span style="font-size: larger; padding-right: 15%;">${arrival}</span><br/>
				
				<br/>
				<div style="font-size: normal; text-align: right; padding-right : 10%;">소요시간 : ${turnaroundrate} </div> <br/>
			</div>
			
			<div style="height : 50%;">
			
			</div>
		</div>
		
		<!-- detailbox -->
		<div id = "detailbox" style="float: left; border: 1px #639EB0 solid; width: 55%; height: 93%;" align="center">
			<div style="vertical-align:bottom; height: 10%; width: 100%; float : left; border-bottom : 1px #639EB0 solid;  
						text-align: center; font-size: x-large; padding-left: 10%;" align="center">
				<div align="left" style="float: left; padding-top : 3%; padding-left : 3%; cursor: pointer;">
					<div style="text-align: center;" align="left">
						<a onclick="changeclassno(${trainclass-1});" >◀</a>
					</div>			 
				</div>
				
				<div style="float: left; width : 80%; padding-top : 3%;" align="center">
					<div align="center" style="text-align: center;">
						${trainclass} 호차	
					</div>
				</div>
				<div align="right" style="float: left; padding-top : 3%; padding-right : 3%; cursor: pointer;">
					<div style="text-align: center;" align="right">
						<a onclick="changeclassno(${trainclass+1});" >▶</a>
					</div>
				</div>
			</div>
			<div style="max-height: 500px; clear: both; padding-top:2%; overflow-y: auto; text-align: center;" align="center">
			
				<div style="float: left; padding-bottom: 2%; border-bottom : 1px #639EB0 solid; width: 10%; height: 6%;">
					<!-- <a href="javascript:history.go(0)"> 다시 <br/>선택하기</a> -->
					<a href="javascript:history.go(0)">
						<img src="<%=request.getContextPath()%>/resources/images/btn_refresh.png"
							 style="width: 45%; padding: 2%; padding-top : 5%;  cursor: pointer;">
				 	</a>
					
				</div>
				
				<div style="float:left; font-size: large; padding-bottom: 2%; border-bottom : 1px #639EB0 solid; padding-right: 10%; width : 90%; height: 6%;">
					잔여 ${48-remainseatcnt} 석	/ 전체 48석
				</div>			
				
			</div>
			
			
			<!-- 탑승인원 선택부분 -->
			<div style="min-height : 82.5%; width : 15%; border-right: 1px solid #639EB0; float: left; font-size: large;">
				
				<div style="border-bottom: 1px solid #639EB0; height: 15%; width: 100%; text-align: center;">
					<br/>
					<div style="padding: 5%;">일반</div>
					<div style="margin-top: 10%;">
						<span id = "normalperson" style="font-weight: bold;">0</span>
						<!-- <input type="hidden" id = "normal" value="0" name = "normal"> --><br/>
						
					</div>
				</div>
				
				<div style="border-bottom: 1px solid #639EB0; height: 6%; width: 100%;">
					<div style="width: 50%; float: left;">
						<img alt="minus" src="<%=request.getContextPath()%>/resources/images/btn_minus.png" style="width: 87%; cursor: pointer;" onclick="minusnormal();" >
					</div>
					<div style="width: 50%; float: left;" >
						<img alt="plus" src="<%=request.getContextPath()%>/resources/images/btn_plus.png" style="width: 87%; cursor: pointer;"  onclick="plusnormal();">
					</div>
				</div>
				
				<div style="border-bottom: 1px solid #639EB0; height: 15%; width: 100%; text-align: center;">
					<br/>
					<div style="padding: 5%;">중고생</div>
					<div style="margin-top: 10%;">
						<span id = "student" style="font-weight: bold;">0</span>
						<!-- <input type="hidden" id = "students" value="0" name = "students"> --><br/>
					</div>
				</div>
				
				<div style="border-bottom: 1px solid #639EB0; height: 6%; width: 100%;">
					<div style="width: 50%; float: left;">
						<img alt="minus" src="<%=request.getContextPath()%>/resources/images/btn_minus.png" style="width: 87%; cursor: pointer;" onclick="minusstudent();" >
					</div>
					<div style="width: 50%; float: left;">
						<img alt="plus" src="<%=request.getContextPath()%>/resources/images/btn_plus.png" style="width: 87%; cursor: pointer;" onclick="plusstudent();" >
					</div>
				</div>
				
				<div style="border-bottom: 1px solid #639EB0; height: 15%; width: 100%; text-align: center;">
					<br/>
					<div style="padding: 5%;">65세이상</div>
					<div style="margin-top: 10%;">
						<span id = "olderperson" style="font-weight: bold;">0</span>
						<!-- <input type="hidden" id = "older" value="0" name = "older"> --><br/>
					</div>
				</div>
				
				<div style="border-bottom: 1px solid #639EB0; height: 6%; width: 100%;">
					<div style="width: 50%; float: left;">
						<img alt="minus" src="<%=request.getContextPath()%>/resources/images/btn_minus.png" style="width: 87%; cursor: pointer;" onclick="minusolder();" >
					</div>
					<div style="width: 50%; float: left;">
						<img alt="plus" src="<%=request.getContextPath()%>/resources/images/btn_plus.png" style="width: 87%; cursor: pointer;" onclick="plusolder();" >
					</div>
				</div>
				
			</div>
		
		<div style="float: inherit; text-align: center; border: 0px solid yellow; width : 50%; min-height:82.5%;" align="center">	 
		 
		<!-- 드디어 뽑았단.............. -->
			<%-- 	<table style="text-align: center; margin-left: 10%; margin-right:10%; margin-top: 10%; height: 70%;">
					<tr style="border-left : 0px solid #639EB0;">
					
						<c:forEach items="${AllSeatlist}" var="seatmap" varStatus="status">
						    <c:if test="${not empty seatmap.notsoldout}">
						    	좌석번호  ${seatmap.notsoldout} 판매가능<br/>
						    </c:if>
							<c:if test="${not empty seatmap.soldout}">
						    	좌석번호  ${seatmap.soldout} 매진<br/>
						    </c:if>
						</c:forEach>
			
					</tr>
				</table> --%>
	<div style="text-align: center; padding-top: 1.5%; border-bottom: 1px solid #639EB0; font-weight: bold; height: 5%; font-size: large;" align="center">
		<c:if test="${trainclass>=1 && trainclass< 4}">
			<span style="color: #639EB0;">프리미엄 객실</span> 
			<img src="<%=request.getContextPath() %>/resources/images/vip.png" style="width: 6%; vertical-align: super;" alt="vipclass">
		</c:if>
		<c:if test="${trainclass>=4}">
			<span style="color: #639EB0;">일반 객실</span> 
		</c:if>
	</div>

	<table style="text-align: center; margin-left: 10%; margin-right:10%; margin-top: 3%; height: 40%;">
               <tr style="border-left : 0px solid #639EB0; margin: auto;">
               
                  <c:forEach items="${AllSeatlist}" var="seatmap" varStatus="status">
                  
                     <c:if test="${status.count%4 == 2}"> <!-- 통로 바로 전 좌석인경우  -->
                        <td style=" border-left : 0px solid #639EB0; width: 10%; padding-top : 2%; cursor: pointer;">
                           <%-- ${status.count}<img src = "<%=request.getContextPath() %>/resources/images/seat_available.png" style="width: 60%;"> --%>
                           
								    <c:if test="${not empty seatmap.notsoldout}"> <!-- 판매중인 좌석 -->
								    	
									    	<div style="float: left; text-align: right;" align="center">${seatmap.notsoldout}</div>
									    	<img src = "<%=request.getContextPath() %>/resources/images/seat_available.png" 
								    			style="width: 60%; float: right;" onclick="goselect(${seatmap.notsoldout});" id = "selectseat${status.count}">&nbsp;<br/>
						    			
								    </c:if>
								    
									<c:if test="${not empty seatmap.soldout}"> <!-- 팔린 좌석 -->
										<span style="cursor:not-allowed;">
									    	<div style="float: left; text-align: right;" align="center">${seatmap.soldout}</div>
									    	<img src = "<%=request.getContextPath() %>/resources/images/seat_taken.png" 
									    		style="width: 60%; float: right;">&nbsp;<br/>
							    		</span>
								    </c:if>
								
                        </td>
                        <td style=" border-left : 0px solid #639EB0; border-right:0px solid #639EB0; width: 10%; padding-top : 2%;">
                        </td>
                     </c:if>
                     
                     <c:if test="${status.count%4 != 2}">   <!-- 통로 바로 전 좌석이 아닌경우! -->
                        <td style=" border-left : 0px solid #639EB0; width: 10%; padding-top : 2%; cursor: pointer;">
                        
                               <c:if test="${not empty seatmap.notsoldout}">	<!-- 판매중인 좌석 -->
                               		
								    	<div style="float: left; text-align: right;" align="center">${seatmap.notsoldout}</div>
								    	<img src = "<%=request.getContextPath() %>/resources/images/seat_available.png" 
								    		style="width: 60%; float: right;" onclick="goselect(${seatmap.notsoldout});" id = "selectseat${status.count}">&nbsp;<br/>
						    		
							    </c:if>
							    
								<c:if test="${not empty seatmap.soldout}">	<!-- 팔린 좌석 -->
									<span style="cursor:not-allowed;">
								    	<div style="float: left; text-align: right;" align="center">${seatmap.soldout}</div>
								    	<img src = "<%=request.getContextPath() %>/resources/images/seat_taken.png" 
								    		style="width: 60%; float: right;">&nbsp;<br/>
						    		</span>
							    </c:if>
							
                        </td>
                     </c:if>
                        
                           
                     <c:if test="${status.count%4 == 0}">
                        </tr>
                        <tr style="border-left : 0px solid #639EB0;">
                     </c:if>
                     
                  </c:forEach>

               </tr>
            </table>


			</div>
			
			
			<!-- 선택좌석 / 탑승인원 / 총 결제금액 부분 -->
			<div style="min-height : 82%; width : 35%; border-left: 1px solid #639EB0; float: right;">
			
				<!-- 선택한 좌석 -->
				<div style="border-bottom: 1px solid #639EB0; height: 10%; width: 100%; text-align: left; padding: 2%;">선택좌석
					<br/><br/>
					<div style="font-size: large; font-weight: bold; margin-right: 5%; text-align: center;">
						<span id = "selectedseat" ></span>
					</div>
				</div>
			
				<!-- 탑승인원 및 요금 -->	
				<div style="border-bottom: 1px solid #639EB0; height: 20%; width: 100%; text-align: left; padding: 2%;" align="center">
				<!-- 탑승 인원 및 요금 -->
					<table style="width: 96%; border : 0px solid #639EB0; height: 96%;">
						<tr>
							<td style="font-size: smaller;">탑승 인원 및 요금</td>
							<td></td>
						</tr>
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td style="color: #639EB0;">
								일반
								<span id = "normalSeatCnt">0</span> 명	
							</td>
							<td>
								<span id = "normalPrice">
								0</span>원
							</td>
						</tr>
						<tr>
							<td style="color: #639EB0;">
								중고생
								<span id = "studentSeatCnt">0</span> 명
							</td>
							<td>
								<span id = "studentPrice" >0</span>원
							</td>
						</tr>
						<tr>
							<td style="color: #639EB0;">
								65세이상
								<span id = "olderSeatCnt">0</span> 명
							</td>
							<td>
								<span id = "olderPrice" >0</span>원
							</td>
						</tr>
					</table>
				
				
					<!-- <br/><br/>
					<div style="font-size: medium; float: left; font-weight: bold; margin-right: 5%; text-align: center; width: 40%;">
						<span id = "selectedPassengers" >
						</span>
					</div>
					<div style="font-size: medium; float: left; font-weight: bold; margin-right: 5%; text-align: center; width: 40%;">
						<span id = "priceperPassengers" >
						</span>
					</div> -->
				</div>
				<div style="border-bottom: 1px solid #639EB0; height: 20%; width: 100%;"></div>
				<div style=" height: 20.2%; width: 100%; text-align: left; padding: 2%;">
					총 결제금액 <br/><br/>
					<div align="center" style="font-size: x-large; font-weight: bold; color: #639EB0;">
						<%-- <fmt:formatNumber pattern='###,###' value=" --%>
						<span id = 'sumtotalPrice'></span><%-- " ></fmt:formatNumber> --%>
					</div>
				</div>
				<div style="border-bottom: 1px solid #639EB0; height: 12%; width: 100%;">
					<button type="button" class = "btn" 
							style="width: 96%; height: 96%; background-color: #639EB0; 
							font-size: xx-large; color : white;"
							onclick="goConfirm();">선택 완료</button>
				</div>
			</div>
			
		</div>
	</div>    
</div>
<div style="margin-bottom: 10%;">&nbsp;</div>
<!-- 좌석선택수 -->
<input type="hidden" value="0" id="seatcount" name="seatcount">

<form name = "changeClass">
	<!-- 소요시간	:  --><input type="hidden" value = "${turnaroundrateint}" name = "turnaroundrateint" id = "turnaroundrateint">
				  <input type="hidden" value = "${turnaroundrate }" name = "turnaroundrate" id ="turnaroundrate">
	<!-- 가는날 :  --><input type = "hidden" value = "${departuredate }" name = "departuredate" id = "departuredate">
	<!-- 오는날 :  --><input type = "hidden" value = "${arrivaldate }" name = "arrivaldate" id = "arrivaldate">
	<!-- 출발지 :  --><input type="hidden" value="${departure}" name = "departure" id="departure">
	<!-- 도착지 :  --><input type="hidden" value="${arrival}" name = "arrival" id="arrival">
	<!-- 등급 :  --><input type="hidden" value = "${trainclass}" name = "trainclass" id = "trainclass">
	<!-- 기차번호 --><input type = "hidden" value="${trainno}" name = "trainno" id = "trainno">
	<!-- 기준요금 --><input type="hidden" id = "rate" value="${rate}" name = "rate">
</form>

<form name = "orderConfirmForm">
	<!-- 객실 등급 (1~3 : 프리미엄 / 4~8 : 일반) --><input type="hidden" value = "${trainclass}" id = "trainclass" name = "trainclass">
	<!-- 티켓 구매 장 수 (ticket quentity) --><input type="hidden" value = "0" id = "tqty" name = "tqty"> 
	<!-- 일반 탑승인 수 --><input type="hidden" id = "normal" value="0" name = "normal">
	<!-- 중고생 탑승인 수 --><input type="hidden" id = "students" value="0" name = "students">
	<!-- 65세 이상 탑승인 수 --><input type="hidden" id = "older" value="0" name = "older">
	<!-- 가는날 :  --><input type = "hidden" value = "${departuredate}" name = "departuredate" id = "departuredate">
	<!-- 기준요금 --><input type="hidden" id = "rate" value="${rate}" name = "rate">
	<!-- 총 가격 --><input type="hidden" id = "totalPrice" value ="0" name = "totalPrice">
	<!-- 선택한 좌석번호 --><input type="hidden" id = "selectedSeatList" name = "selectedSeatList" value = "0">
</form>

<!-- 로그인 모달창 -->				
	<div class="white_content" id="gologinForm">
        <div align="center">				            
           <div style="clear: both; margin-top : 5%; margin-bottom : 5%; margin-left: 5%; width : 94%; height: 80%;" align="center">
   				<br/>
				<div style="float : left; height:48%; width: 90%; margin-left: 2%; margin-right: 0%;  border: 1px solid #639EB0;">				
					<div>
						<form name="loginFrm" id="loginFrm" class="loginFrm">
						
							<table style="vertical-align: middle; width: 86%; margin-top: 3%;">
								
								<tr>
								 	<th style="font-size: larger;">
								 		일반회원로그인<br/>
							 		</th>
								</tr>
								<tr>
									<td>&nbsp;</td>	
								<tr/>
								<tr>
									<td>
										<input type="text" class="form-control" name="userid" id="userid" placeholder="회원아이디"/>
									</td>
									<td>&nbsp;</td>
									<td rowspan="3">
										 <button class="btn btn-lg btn-primary btn-block" style="height: 89px; width: 100%;" type="button" id="btnLOGIN">Login</button>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td>
										<input  type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호" style="color : black;">
									</td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr align="center">
									<td style="width : 70%;">
									
									<a href="" style="text-decoration: none;">
										<img src = "<%=request.getContextPath()%>/resources/images/forgotID.png" style="height: 10%;">
											<span style="font-size: small;"> forgot ID? </span> &nbsp;&nbsp;&nbsp;
									</a>
										
									<a href="<%=request.getContextPath() %>/loginform.action" style="text-decoration: none;">
										<img src = "<%=request.getContextPath()%>/resources/images/forgotPW.png" style="height: 10%;"> 
											<span style="font-size: small;"> forgot PW? </span>
									</a>
											
									</td>
									<td></td>
									<td>&nbsp;</td>
								</tr>
							</table>
						</form>
					</div>
				</div> <!-- 일반회원 예매  끝-->
				
				<!-- 비회원 예매  -->
				<div style="float : left; height:48%; width: 90%; margin-left: 2%; margin-right: 0%;  border: 1px solid #639EB0; border-top: none;">
										
						<div>
							<table style="vertical-align: middle;">
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<th style="font-size: larger;">
										비회원 예매
									</th>
									<td>&nbsp;</td>
									<td rowspan="2">
										 <button class="btn btn-lg btn-primary btn-block" style="height: 89px; width: 100%;" type="button" id="nonbtnLOGIN">비회원 예매</button>
									</td>
								</tr>
								<tr>
									<td style="font-size: smaller;">비회원 예매 시 일부 서비스 이용이 제한됩니다.</td>
									<td>&nbsp;</td>
									<td></td>
								</tr>
							</table>
							
							<div style="width: 90%; margin-top: 2%; font-size: medium; border: 1px solid #639EB0; padding: 3%;" align="left">
								<table>
									<tr>
										<td>
											KHX 통합회원으로 가입하시면
											홈페이지와 모바일앱과의 예매내역 공유로
											더욱 편리한 KHX 이용이 가능합니다.
										</td>
										<td style="width: 30%;">
											 <button class = "btn btn-warning" style="height: 89px; width: 100%;" type="button" id="register">통합회원가입</button>
										</td>
									</tr>
								</table>
							</div>
							
						</div>
				</div> <!-- 비회원 예매 끝 -->
				
			</div>
						
           <a href="#"
           		style="clear: both; cursor: pointer; font-size: 20; color: white; height: 10%; 
           		font-weight: bold; background-color: #639EB0; width: 96%;" class="btn" >닫기
      		</a>
           
           
        </div>
    </div>
