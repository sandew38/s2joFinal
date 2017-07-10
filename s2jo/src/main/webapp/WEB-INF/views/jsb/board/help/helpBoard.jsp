<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/style.css">
    <link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
    <link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style type="text/css">
	   /*Responsive CSS*/
	* {
	  margin: 0;
	  padding: 0;
	}
	
	body {
	  font-family: 'roboto', sans-serif;
	  color: #666;
	  font-size: 16px;
	  background: #f9f9f9;
	  line-height: 1.6em;
	}
	
	ul, li { list-style: none; }
	
	
	h1 {
	  text-align: center;
	  margin-bottom: 20px;
	}
	
	
	.faq li { padding: 20px; }
	
	.faq li.q {
	  background: #4FC2E;
	  font-weight: bold;
	  font-size: 120%;
	  border-bottom: 1px #ddd solid;
	  cursor: pointer;
	}
	
	.faq li.a {
	  background: #F0F8FF;
	  display: none;
	 
	}
	
	.rotate {
	  -moz-transform: rotate(90deg);
	  -webkit-transform: rotate(90deg);
	  transform: rotate(90deg);
	}
	@media (max-width:800px) {
	
	#container { width: 90%; }
	}
</style>

<script type="text/javascript">
//Accordian Action
	var action = 'click';
	var speed = "500";
	
	
	//Document.Ready
	$(document).ready(function(){
	  //Question handler
		$('li.q').on(action, function(){
			  //gets next element
			  //opens .a of selected question
			$(this).next().slideToggle(speed)
			    //selects all other answers and slides up any open answer
			    .siblings('li.a').slideUp();
			  
			  //Grab img from clicked question
			var img = $(this).children('img');
			  //Remove Rotate class from all images except the active
			  $('img').not(img).removeClass('rotate');
			  //toggle rotate class
			  img.toggleClass('rotate');
		
		});//End on click
		
	
		
	
		
	});//End Ready
 </script>

  <div id="container" style="min-height: 100%; background-color: white; padding-top: 2%; padding-bottom: 5%; padding-left: 15%;" >
  		<h2>무엇을 도와드릴까요?</h2>
		<p>관련된 질문에 더 간편히 찾을 수 있게 도와드리겠습니다.</p>
		<br /> <br />
   <ul class="nav nav-pills">
  <li class="active"><a data-toggle="pill" href="#home">자추찾는도움말</a></li>
  <li><a data-toggle="pill" href="#menu1">회원아이디/비밀번호</a></li>
  <li><a data-toggle="pill" href="#menu2">결제문의</a></li>
  <li><a data-toggle="pill" href="#menu3">1:1 이메일 질문</a></li>
  <li style="margin-left: 200px;"><a data-toggle="pill" href="#menu6">채팅</a></li>
  
</ul>

<div class="tab-content" style="width: 80%;" >
  <div id="home" class="tab-pane fade in active">
     <ul class="faq">
        <li class="q"><img src="<%=request.getContextPath()%>/resources/images/helpimg/arrow.png">비밀번호찾기</li>
        <li class="a">
        	<div align="center">
			 암호를 잃어버려셨을 경우 : <a href="<%=request.getContextPath()%>/loginform.action" >암호찾기</a> 를 눌러 암호를 찾으세요
			<br/>
			<img src="<%=request.getContextPath()%>/resources/images/helpimg/pw_find.png" style="">
			<br/>
			<span style="color: red;">forgot password 를 눌러서  <a href="<%=request.getContextPath()%>/loginform.action" >암호찾기</a> 를 진행하시면 됩니다.</span>
			</div>
		</li>
		<li class="q"><img src="<%=request.getContextPath()%>/resources/images/helpimg/arrow.png">티켓구매방법</li>
		<li class="a">
			<div align="center" >
				티켓구매를 하실려면 <a href="<%=request.getContextPath()%>/khx/khx.action">여기</a>를 눌러주세요
				<br/>
				<img src="<%=request.getContextPath()%>/resources/images/helpimg/buy_ticket1.png" ></div>
				<br/>
				1. 편도인지 왕도인지 먼저 선택해 주세요. <br/>
				2. 클릭시 출발지와 도착지를 선택하는 선택창이 나옵니다. <br/>   
			   	3. 기차종류를 선택해 주세요.<br/>
			   	4. 일반실인지 특실인지 선택해 주세요.<br/>
			   	5. 클릭시 날짜를 눌러 가는날짜를 선택하실 수 있습니다.<br/>
			   	6. 모든 사항을 선택 하셨다면 조회하기를 눌러주세요.<br/>
			   	<br/>
			   	더욱이 자세히 보시려면 결제문의란에서 확인해주세요.
			
		</li>
	 </ul>
	</div>
	  <div id="menu1" class="tab-pane fade">
		<ul class="faq">
			<li class="q"><img src="<%=request.getContextPath()%>/resources/images/helpimg/arrow.png">비밀번호찾기</li>
       		 <li class="a">
	        	<div align="center">
				 암호를 잃어버려셨을 경우 : <a href="<%=request.getContextPath()%>/loginform.action" >암호찾기</a> 를 눌러 암호를 찾으세요
				<br/>
				<img src="<%=request.getContextPath()%>/resources/images/helpimg/pw_find.png" style="">
				<br/>
				<span style="color: red;">forgot password 를 눌러서  <a href="<%=request.getContextPath()%>/loginform.action" >암호찾기</a> 를 진행하시면 됩니다.</span>
				</div>
			</li>
			<li class="q"><img src="<%=request.getContextPath()%>/resources/images/helpimg/arrow.png">회원탈퇴</li>
			<li class="a">
			    <div align="center">
					<a href="<%=request.getContextPath()%>/Mypage.action">회원탈퇴</a>를 눌러 회원탈퇴를 진행하실 수 있습니다.
					<br/>
					<img src="<%=request.getContextPath()%>/resources/images/helpimg/user_withdraw.png" style="">
					<br/><span style="color: red;">회원탈퇴 를 눌러서  <a href="<%=request.getContextPath()%>/Mypage.action">회원탈퇴</a> 를 진행하시면 됩니다.</span>
					<br/><br/><br/>
									 
					<span style="color: red; font-size: 15px;">주의! 회원탈퇴를 하면 30일간 동일한 아이디로 가입하실 수 없습니다.</span>
					<br/>
					<img src="<%=request.getContextPath()%>/resources/images/helpimg/user_withdraw2.png" style="">
				</div>
			</li>
		</ul>
	  </div>
	  <div id="menu2" class="tab-pane fade">
			<ul class="faq">
			<li class="q"><img src="<%=request.getContextPath()%>/resources/images/helpimg/arrow.png">출도작지 선택</li>
			<li class="a">
			<div align="center" >
				티켓구매를 하실려면 <a href="<%=request.getContextPath()%>/khx/khx.action">여기</a>를 눌러주세요
				<br/>
				<img src="<%=request.getContextPath()%>/resources/images/helpimg/buy_ticket1.png" ></div>
				<br/>
				1. 편도인지 왕도인지 먼저 선택해 주세요. <br/>
				2. 클릭시 출발지와 도착지를 선택하는 선택창이 나옵니다. <br/>   
			   	3. 기차종류를 선택해 주세요.<br/>
			   	4. 일반실인지 특실인지 선택해 주세요.<br/>
			   	5. 클릭시 날짜를 눌러 가는날짜를 선택하실 수 있습니다.<br/>
			   	6. 모든 사항을 선택 하셨다면 조회하기를 눌러주세요.<br/>
			</li>			
			<li class="q"> 
			<img src="<%=request.getContextPath()%>/resources/images/helpimg/arrow.png">기차조회</li>
			<li class="a">
			<div align="center">
			조회를 하시려면 먼저 티켓구매 설정을 완료 하셔야 합니다.(위 참조)<br/>
			<img src="<%=request.getContextPath()%>/resources/images/helpimg/buy_ticket3.png" ><br/></div>
			위 그림의 빨간란 옆의 시간을 참조하여 원하는 시간대를 선택하여 선택을 눌러주세요.
			</li>
			<li class="q"> 
			<img src="<%=request.getContextPath()%>/resources/images/helpimg/arrow.png">좌석선택</li>
			<li class="a">
			<div align="center">
			좌석 조회를 하시려면 먼저 위의 순서를 따른 후 할 수 있습니다.(위 참조)<br/>
			<img src="<%=request.getContextPath()%>/resources/images/helpimg/buy_ticket4.png" ><br/></div>
			1. 먼저 일반고객(만 19~64세), 중고생(만 13~18세), (만)65세 이상 으로 기차를 이용하실<br/>
			&nbsp;&nbsp;고객님의 나이를 체크하고 타실 인원 수 만큼 +, -를 해주세요.<br/>
			<span style="color: red;">[최대 4명까지 가능합니다. (중고생-20%할인, 65세이상-25%할인)]</span><br/>
			2. 앉으실 좌석을 선택해주세요.<br/>
			<span style="color: red;">[이미 차있는 좌석은 선택하실 수 없습니다.]</span><br/>
			3. 가격을 확인하시고 선택완료를 눌러주세요.
			</li>
			<li class="q"> 
			<img src="<%=request.getContextPath()%>/resources/images/helpimg/arrow.png">결제</li>
			<li class="a">
			<div align="center">
			좌석 조회를 하시려면 먼저 위의 순서를 따른 후 할 수 있습니다.(위 참조)<br/>
			<img src="<%=request.getContextPath()%>/resources/images/helpimg/buy_ticket5.png" ><br/>
			결제정보를 확인 후 무엇으로 결제방법을 설정하고 '결제하기버튼'을 눌러주세요<br/>
			<br/><br/>
			
			<img src="<%=request.getContextPath()%>/resources/images/helpimg/buy_ticket7.png" ><br/>
			'다날페이카드' 로 연결하여 결제를 진행합니다.
			<br/><br/>
		
			결제가 완료됐다면 아래와 같은 화면이 나옵니다. 즐거운 여행 되길바랍니다.
			
			<img src="<%=request.getContextPath()%>/resources/images/helpimg/buy_ticket8.png" ><br/></div>
			</li>
			
		</ul>
	  </div>
	  <div id="menu3" class="tab-pane fade">
		<jsp:include page="mailForm.jsp" />
	  </div>
	  
	   <div id="menu6" class="tab-pane fade">
		 <jsp:include page="../../chatting/multichat.jsp" />
	  </div>
	  
</div>
	
</div>



<%-- 
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link
	href="http://code.jquery.com/ui/1.12.0-rc.2/themes/smoothness/jquery-ui.css"
	rel="Stylesheet"></link>
<script src="http://code.jquery.com/ui/1.12.0-rc.2/jquery-ui.js"></script>

<div style="min-height:100%; background-color: white; border: solid 0px red;">

	<div class="container" style="padding-top: 5%;">
		<h2>무엇을 도와드릴까요?</h2>
		<p>관련된 질문에 더 간편히 찾을 수 있게 도와드리겠습니다.</p>
		<br /> <br />

		<ul class="nav nav-pills">
			<li class="active"><a data-toggle="pill" href="#home">자추찾는도움말</a></li>
			<li><a data-toggle="pill" href="#menu1">회원아이디/비밀번호</a></li>
			<li><a data-toggle="pill" href="#menu2">결제문의</a></li>
			<li><a data-toggle="pill" href="#menu3">1:1 이메일 질문</a></li>

			<li style="margin-left: 200px;"><a data-toggle="pill"
				href="#menu6">채팅</a></li>


		</ul>
		<h2>자동완성기능</h2>
		<form id="searchFrm">
			<input id="autocomplete" type="text" />
			<a onClick="goSearch();"><img src="<%=request.getContextPath() %>/resources/images/btn_help_sch.gif"></a>
		</form>

		<div class="tab-content">
			<div id="home" class="tab-pane fade in active">
				<h3>자주찾는 도움말</h3>
				<div class="panel-group" id="accordion">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapse1"> 비밀번호찾기</a>
							</h4>
						</div>
						<div id="collapse1" class="panel-collapse collapse">
							<div class="panel-body">
								<div align="center">
								 암호를 잃어버려셨을 경우 : <a href="<%=request.getContextPath()%>/loginform.action" >암호찾기</a> 를 눌러 암호를 찾으세요
								 <br/>
								 <img src="<%=request.getContextPath()%>/resources/images/helpimg/pw_find.png" style="">
								 <br/><span style="color: red;">forgot password 를 눌러서  <a href="<%=request.getContextPath()%>/loginform.action" >암호찾기</a> 를 진행하시면 됩니다.</span>
								</div>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapse2"> 티켓구매방법</a>
							</h4>
						</div>
						<div id="collapse2" class="panel-collapse collapse">
							<div class="panel-body">
								<a href="#">티켓구매</a>를 눌러 티켓을 구매해보세요.
							</div>
						</div>
					</div>
				</div>
			</div>

			<div id="menu1" class="tab-pane fade ">
				<h3>회원계정</h3>
				<div class="panel-group" id="accordion">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapse3"> 아이디 비밀번호찾기</a>
							</h4>
						</div>
						<div id="collapse3" class="panel-collapse collapse">
							<div class="panel-body">
								<div align="center">
								암호를 잃어버려셨을 경우 : <a href="<%=request.getContextPath()%>/loginform.action" >암호찾기</a> 를 눌러 암호를 찾으세요
								 <br/>
								 <img src="<%=request.getContextPath()%>/resources/images/helpimg/pw_find.png" style="">
								 <br/><span style="color: red;">forgot password 를 눌러서  <a href="<%=request.getContextPath()%>/loginform.action" >암호찾기</a> 를 진행하시면 됩니다.</span>
								 </div>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapse4"> 회원탈퇴</a>
							</h4>
						</div>
						<div id="collapse4" class="panel-collapse collapse">
							<div class="panel-body">
								<div align="center">
								<a href="<%=request.getContextPath()%>/Mypage.action">회원탈퇴</a>를 눌러 회원탈퇴를 진행하실 수 있습니다.
								 <br/>
								 <img src="<%=request.getContextPath()%>/resources/images/helpimg/user_withdraw.png" style="">
								 <br/><span style="color: red;">회원탈퇴 를 눌러서  <a href="<%=request.getContextPath()%>/Mypage.action">회원탈퇴</a> 를 진행하시면 됩니다.</span>
								 <br/><br/><br/>
								 
								 <span style="color: red; font-size: 15px;">주의! 회원탈퇴를 하면 30일간 동일한 아이디로 가입하실 수 없습니다.</span>
								 <br/>
								 <img src="<%=request.getContextPath()%>/resources/images/helpimg/user_withdraw2.png" style="">
								 </div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div id="menu2" class="tab-pane fade">
				<h3>결제문의</h3>
				<div class="panel-group" id="accordion">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapse5"> 티켓구매</a>
							</h4>
						</div>
						<div id="collapse5" class="panel-collapse collapse">
							<div class="panel-body">
								<a href="#">티켓구매</a>를 눌러 티켓을 구매해보세요.
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapse6">결제취소</a>
							</h4>
						</div>
						<div id="collapse6" class="panel-collapse collapse">
							<div class="panel-body">
								결제를 취소하고 싶다면 <a href="#">결제 취소</a>를 눌러 예약을 취소하세요.
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapse7">결제방법</a>
							</h4>
						</div>
						<div id="collapse7" class="panel-collapse collapse">
							<div class="panel-body">저희는 이러한 결제방법을 사용하고 있습니다. 참고해주세요.</div>
						</div>
					</div>
				</div>
			</div>
		

			<div id="menu3" class="tab-pane fade">
				<jsp:include page="mailForm.jsp" />
			</div>
	
			<div id="menu6" class="tab-pane fade">
				<jsp:include page="../../chatting/multichat.jsp" />
			</div>
		</div>
	</div>
</div> --%>
<!-- <a  data-url="http://naver.com">네이버</a>
<a data-url="http://daum.net">다음</a>
<a  data-url="http://nate.com">네이트</a>
<iframe id="iframe" width="1024" height="500" src="http://b.redinfo.co.kr"></iframe> -->





<!-- jquery 를 사용하기 위해 jquery 파일을 로드 -->
<!-- <script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
 -->
<script>
	$(document).ready(function(e) {
		/* a요소를 클릭 했을 시 */
		$('a').click(function() {
			/* iframe 요소의 src 속성값을 a 요소의 data-url 속성값으로 변경 */
			$('#iframe').attr('src', $(this).attr('data-url'));
		})
	});
</script>

<script type="text/javascript">
	$(function() {
		var autocomplete_text = [ "아이디찾기", "비밀번호찾기", "티켓구매", "국이" ];
		$("#autocomplete").autocomplete({
			source : autocomplete_text
		});
	})

	function goSearch() {
		var searchFrm = document.searchFrm;

		var search = $("#autocomplete").val();

		if (search.trim() == "") {
			alert("검색어를 입력하세요!!");
		}
	}

	/* 	$(function() {
	 $("#autocomplete").autocomplete({
	 source : function(request, response) {
	 $.ajax({
	 type : 'get',
	 url : "/khx/jsb/autocomplete.action",
	 dataType : "json", 
	 //request.term = $("#autocomplete").val()
	 data : {
	 value : request.term
	 },
	 success : function(data) {
	 //서버에서 json 데이터 response 후 목록에 뿌려주기 위함
	 response($.map(data, function(item) {
	 return {
	 label : item.data,
	 value : item.data
	 }
	 }));
	 }
	 });
	 },
	 //조회를 위한 최소글자수
	 minLength : 2,
	 select : function(event, ui) {
	 // 만약 검색리스트에서 선택하였을때 선택한 데이터에 의한 이벤트발생
	 }
	 });
	 })  */
</script>

