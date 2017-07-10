<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/editor2.css" type="text/css" />
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


<script src="<%=request.getContextPath() %>/resources/js/editor_loader.js" type="text/javascript" charset="utf-8"></script>
   
<style type="text/css">
/* 	table, th, td, input, textarea {border: solid gray 1px;}
	
	#table, #table2 {border-collapse: collapse;
	 		         width: 600px;
	 		        }
	#table th, #table td{padding: 5px;}
	#table th{width: 120px; background-color: #DDDDDD;}
	#table td{width: 480px;}
	.long {width: 470px;}
	.short {width: 120px;} 	
	
	a{text-decoration: none;}	 */

</style>
<script type="text/javascript">

$(document).ready(function(){

	goLikeDisLikeCountShow();
	
});// end of $(document).ready();------------------

function goLikeDisLikeCountShow() {
	
	var form_data = {"seq" : "${boardvo.seq}" };
	
	$.ajax({
		url: "/khx/jsb/rlikeDislike.action",
		type: "POST",
		data: form_data,
		dataType: "JSON",
		success: function(data){
			
			var likeCnt = data.likeCnt;
			var dislikeCnt = data.dislikeCnt;
			
			$("#likeCnt").html(likeCnt);
			$("#dislikeCnt").html(dislikeCnt);
		},
		error: function(){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error); 
		}
	});
	
}// end of function goLikeDisLikeCountShow()-------


function golikeAdd(seq, userid) {
	
	var form_data = { "userid" : userid
			        , "seq" : seq
			        };
	
	$.ajax({
		url: "/khx/jsb/rlikeAdd.action",
		type: "POST",
		data: form_data,
		dataType: "JSON",
		success: function(data){
			alert(data.msg);
			goLikeDisLikeCountShow();
		},
		error: function(){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error); 
		}
	});
	
}// end of function golikeAdd(seq)------------


function godislikeAdd(seq, userid) {

	var form_data = { "userid" : userid
			        , "seq" : seq
    			    };

	$.ajax({
		url: "/khx/jsb/rdislikeAdd.action",
		type: "POST",
		data: form_data,
		dataType: "JSON",
		success: function(data){
			alert(data.msg);
			goLikeDisLikeCountShow();
		},
		error: function(){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error); 
		}
	});
	
}// end of function godislikeAdd(seq)-----------


</script>


<script type="text/javascript">
    
    function goWrite(){
    	var addWriteFrm = document.addWriteFrm;
    	addWriteFrm.submit();
    }
    
</script>

<script type="text/javascript">
	function goDelete() {
		var delFrm = document.delFrm;
		delFrm.action = "/khx/jsb/recommendDel.action";
		delFrm.method = "post";
		delFrm.submit();
	}
</script>


<div style="min-height:100%; background-color: white; border: solid 0px red;">
	<div style="padding-top: 5%;">
	<form id="tx_view">

	<table id="tablecontent1"class="table table-condensed"> 
		<tr>
           	<td><span style="font-weight: bold;">[추천게시판]${boardvo.subject}</span></td>
        </tr>
		<tr>
			<td>${boardvo.userid}&nbsp;|&nbsp;조회수 ${boardvo.readCount}&nbsp;|&nbsp;${boardvo.regDate} 
			&nbsp;|
			</td>
			<!-- ===== 첨부파일 이름 및 파일크기를 보여주고 첨부파일을 다운받게끔 만들기 ===== -->
			<td  align="right">	
					
			<a href="<%= request.getContextPath() %>/jsb/recDownload.action?seq=${boardvo.seq}"  > 
			${boardvo.orgFilename}</a> | 파일크기&nbsp;${boardvo.fileSize}(bytes)
			</td>
		</tr>	
	</table>
	<table id="tablecontent2" class="table table-condensed">	
		<tr>
			<td >
			<c:if test="${not empty boardvo.fileName}">
			<p align="center"><img src="<%=request.getContextPath()%>/resources/files/${boardvo.fileName}" style="width: 40%; height: 40%;"></p>
			</c:if>
			${boardvo.content}
			</td>	
		</tr>
		
		
	</table>
	</form>
		<form name="delFrm">    
			<input type="hidden"   name="seq" value="${boardvo.seq}" />
		</form>
	<br/>
	<br/>	
	<div align="right">
		<button type="button" class="btn  " onClick="javascript:location.href='<%= request.getContextPath() %>/jsb/recommendList.action'">목록보기</button>
		<button type="button" class="btn  " onClick="javascript:location.href='<%= request.getContextPath() %>/jsb/recommendEdit.action?seq=${boardvo.seq}&writer=${boardvo.userid}'">수정</button>
		<button type="button" class="btn  " onClick="goDelete();">삭제</button> 
	</div> 
		
	<br/>
	<br/>
	<div align="center"  >
		
		<button type="button" class="btn btn-primary" onClick="golikeAdd('${boardvo.seq}','${sessionScope.loginuser.userid}');">
			추천 :<span id="likeCnt" style="font-weight:bold; font-size:15px;"></span></button>
		
		<button type="button" class="btn btn-danger" onClick="godislikeAdd('${boardvo.seq}','${sessionScope.loginuser.userid}');">
			비추천 :<span id="dislikeCnt" style="font-weight:bold; font-size:15px;"></span></button>
			
	</div>
	<br/>
	
	
	<!-- ===== #93. 댓글 내용 보여주기 ===== -->
	<table id="table2" class="table">
		<c:if test="${empty commentList}">
			<tr class="active">
				<td align="center">작성된 댓글이 없습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="commentvo" items="${commentList}">
			<tr class="active">
				<td><font size="3em" color="green" style="font-weight: bold ;"> ${commentvo.userid}</font><br/>
				${commentvo.content}</td>
				<td align="right">
				<br/>
				${commentvo.regDate}
				</td>
			</tr>
		</c:forEach>
	</table>
	
	<!--  댓글쓰기 폼 추가 ===== -->
	<form name="addWriteFrm" action="<%= request.getContextPath() %>/jsb/recAddComment.action" method="get">  
	 <c:if test="${empty loginuser.userid }">
	  		<input type="text" name="content" class="form-control " placeholder="#회원로그인 후 댓글작성이 가능합니다." disabled />
				
	 </c:if>   
	 <c:if test="${not empty loginuser.userid }">
	  <div class="form-group">
		    <input type="hidden" name="name" value="${loginuser.name }">
		    <input type="hidden" name="boardSeq" value="${boardvo.seq }">
		      
			<input type="hidden" name="userid" value="${loginuser.userid }" class="short" readonly/>
		    <input type="text" name="content" class="form-control " placeholder="#댓글을 작성해 주세요." />
			<input type="hidden" name="writer" value = "${boardvo.userid}" />
		  
	    <!-- 댓글에 달리는 원게시물 글번호(즉, 댓글의 부모글) -->
		    <input type="hidden" name="parentSeq" value="${boardvo.seq}"/> 
		    
		    	<button type="button" onClick="goWrite();" class="btn "  >댓글쓰기</button>   
		    
	   </div>
	  </c:if>   
	    
	      
	</form>
	    <!-- 이전글 / 다음글 -->
	<div style="margin-top:30px; height: 5%; border: solid red 0px;">
		<c:forEach var="map" items="${prevNextList}" varStatus="status">
		<table>	
			<tr>
				<th>다음글</th>
				<td>
					<c:if test="${map.NEXT_SEQ != null}">     
						<a href="<%= request.getContextPath() %>/jsb/recommendView.action?seq=${map.NEXT_SEQ}&writer=${NEXT_USERID}">${map.NEXT_SUBJECT}</a>
					</c:if>
					<c:if test="${map.NEXT_SEQ == null}">     
						${map.NEXT_SUBJECT}
					</c:if>
				</td>
			</tr>
			
			<tr>
				<th>이전글</th>
				<td>
					<c:if test="${map.PRE_SEQ != null}">     
						<a href="<%= request.getContextPath() %>/jsb/recommendView.action?seq=${map.PRE_SEQ}&writer=${map.PRE_USERID}">${map.PRE_SUBJECT}</a>
					</c:if>
					<c:if test="${map.PRE_SUBJECT == null}">     
						${map.PRE_SUBJECT}
					</c:if>				
				</td>
			</tr>
		</table>
		</c:forEach>
	</div>
	
	</div>

	
</div>











