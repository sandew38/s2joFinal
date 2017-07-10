<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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

<style type="text/css">
.wellChattingAdmin {
    min-height: 10px;
    padding: 13px;
    background-color: #FFB6C1;
    border: 1px solid #e3e3e3;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
    box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
}
.wellChattingUser {
    min-height: 10px;
    padding: 13px; 
    background-color: #E0FFFF;
    border: 1px solid #e3e3e3;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
    box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
}
.wellChattingNonUser {
    min-height: 10px;
    padding: 13px;
    background-color: #90EE90;
    border: 1px solid #e3e3e3;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
    box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
}
.hjs-background-panel{
    box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;

}

</style>

<!-- === # 웹채팅관련7 ===  -->
<script type="text/javascript" src="/board/resources/js/json2.js"></script>

<script type="text/javascript" >

    $(document).ready(function(){
    
        var url = window.location.host;          // 웹브라우저의 주소창의 포트까지 가져옴
    	//  alert("url : " + url);
    	    // 결과값  url: 192.168.10.2:9090
    	    
    	var pathname = window.location.pathname; // '/'부터 오른쪽에 있는 모든 경로
    	// 	alert("pathname : " + pathname);
    	    // 결과값  pathname : /board/chatting/multichat.action
    	 	
    	var appCtx = pathname.substring(0, pathname.indexOf("/",7));  // "전체 문자열".indexOf("검사할 문자", 시작순서인덱스번호);   
    	// 	alert("appCtx : " + appCtx);
    	    // 결과값  appCtx : /board/chatting
    	 	
    	var root = url+appCtx;
    	// 	alert("root : " + root);
    	 	// 결과값   root : 192.168.10.2:9090/board/chatting
    	 	
    	
    	var wsUrl = "ws://"+root+"/multichatstart.action";
    	// var websocket = new WebSocket("ws://192.168.10.2:9090/board/chatting/multichatstart.action");
    	var websocket = new WebSocket(wsUrl);        
        
    	// alert(wsUrl);
    	
    	// >>>> Javascript WebSocket 이벤트 정리 <<<< 
	    //      onopen    ==>  WebSocket 연결
	    //      onmessage ==>  메시지 수신
	    //      onerror   ==>  전송 에러 발생
	    //      onclose   ==>  WebSocket 연결 해제
    	
    	var messageObj = {};
    	
	    // === 웹소켓에 최초로 연결이 되었을 경우에 실행되어지는 콜백함수
    	websocket.onopen = function() {
    	//	alert("웹소켓 연결됨!!");
    		$("#chatStatus").text("Info: connection opened.");
    	
    	/*	
            messageObj = {};  // 초기화
            messageObj.message = "반갑습니다.";
            messageObj.type = "all";
            messageObj.to = "all";
        */    
            // 또는
            messageObj = { message : ""
        		         , type : "all"
        		         , to : "all" };  // 초기화
            
           // websocket.send(JSON.stringify(messageObj));
        };
    	
    	// === 메시지 수신 콜백함수
        websocket.onmessage = function(evt) {
            $("#chatMessage").append(evt.data);
            /* $("#chatMessage").append("<br />"); */
            $("#chatMessage").scrollTop(99999999);
        };
        
        // === 웹소캣 연결 해제 콜백함수
        websocket.onclose = function() {
            // websocket.send("채팅을 종료합니다.");
        }
         
        
        $("#message").keydown(function (event) {
             if (event.keyCode == 13) {
                $("#sendMessage").click();
             }
          });
         
        $("#sendMessage").click(function() {
            if( $("#message").val() != "") {
                 
            	messageObj = {};
            	messageObj.message = $("#message").val();
            	messageObj.type = "all";
            	messageObj.to = "all";
                 
                var to = $("#to").val();
                if ( to != "" ) {
                	messageObj.type = "one";
                	messageObj.to = to;
                }
                var userid = "${loginuser.userid}"; 
                //alert(userid);
                websocket.send(JSON.stringify(messageObj));
                if("${loginuser.userid}"=='asd'){ // 관리자인 아이디를 asd에 적는다.
               	 $("#chatMessage").append("<div class='wellChattingAdmin'><span style='color:red; font-weight:bold;'> [asd(관리자)] ▷" + $("#message").val() + "</div></span>");
              	}else if("${loginuser.userid}"!='asd' && userid.trim() != ""){
               	$("#chatMessage").append("<div class='wellChattingUser'><span style='color:navy; font-weight:bold;'> [${loginuser.userid}] ▷" + $("#message").val() + "</div></span>");
               }
                $("#chatMessage").scrollTop(99999999);
                $("#message").val("");
               
            }
        });
        
   
    });

    
</script>




</head>
<body>
	
	<c:if test="${loginuser != null}">
	<div class="hjs-background-panel" >
	<div id="chatStatus"></div>
	<div id="chatMessage" style="overFlow: auto; height: 300px; background-color:  white; border: solid 0px red;" class="form-control"></div>
	</div>
	<br/>
	<div align="center">
    <input type="text" id="message" style="width: 89%;" placeholder="메시지 내용" class="form-control col-sm-8"/>&nbsp;&nbsp;
    <input type="button" id="sendMessage" value="엔터" style="width: 10%; "class="form-control col-sm-2"/>
    </div>
    
    <input type="hidden" id="to" placeholder="귓속말대상"/>
    </c:if>
    <c:if test="${loginuser == null}">
    	<div align="center">로그인을 하셔야 이용하실 수 있습니다.</div>
    </c:if>
    

    
    
</body>
</html>