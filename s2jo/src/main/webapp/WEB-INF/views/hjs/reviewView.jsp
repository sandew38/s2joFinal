<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
   
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/editor2.css" type="text/css" />
<link href="http://code.jquery.com/ui/1.12.0-rc.2/themes/smoothness/jquery-ui.css" rel="Stylesheet"></link>
<script src="http://code.jquery.com/ui/1.12.0-rc.2/jquery-ui.js"></script>

<script src="<%=request.getContextPath() %>/resources/js/editor_loader.js" type="text/javascript" charset="utf-8"></script>
   
<style type="text/css">
	
	a{text-decoration: none;}	

	.hjs-background-panel{

	max-width: 96.5%;
	min-height: 80%;
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
	    font-size: 24px !important;
	    text-decoration: none !important;
	    padding: 11px 20px !important;
	    border-radius: 0px !important;
	    border: 2px solid #11939A !important;
	    text-transform: uppercase !important;
	    outline: none !important;
	    line-height: 55px !important;
	    font-family: ff-clan-web-pro, "Helvetica Neue", Helvetica, sans-serif !important;
	    display: inline-block !important;
	    vertical-align: middle !important;
	    text-align: center !important;
	    margin: 0 !important;
	    overflow: visible !important;
	    background-color: #0D696C !important;
	    border-color: #0D696C !important;
	}
	
</style>

<script type="text/javascript">
    

	$(document).ready(function(){

		goLikeDisLikeCountShow();
		
	});// end of $(document).ready();------------------
    
    
    
    function goWrite(){
    	var addWriteFrm = document.addWriteFrm;
    	addWriteFrm.submit();
    }
    

	function goLikeDisLikeCountShow() {
		
		var form_data = {"seq" : "${rboardvo.seq}" };
		
		$.ajax({
			url: "likeDislike.action",
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
			url: "likeAdd.action",
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
			url: "dislikeAdd.action",
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


<div  style="background-color:white; width:100%; height:100%; margin: auto; padding-top: 30px;  margin-bottom: 100px;">

<div class="hjs-background-panel" style="padding-top:3%;" >

<div align="left" style="width:90%; margin: 0 auto;  /* border: solid red 1px; */">
	<span class="well well-sm">${sessionScope.station}역 게시판</span>
</div>

<div align="left" style="width:90%; padding-left:8%; margin-left: 3%; margin-top:3%;">
	
	<table id="contentTable1"class="table table-condensed"> 
		<tr>
           	<td colspan=2>
           		<span style="font-weight: bold;">${rboardvo.subject}</span>
           	</td>
        </tr>
        
		<tr>
			<td>
				${rboardvo.name} | 조회수 ${rboardvo.readCount} | 추천수 ${rboardvo.recCount} | ${rboardvo.regDate}
			</td>
			
			<!-- ===== 첨부파일 ===== -->
			<td align="right">	
				<a href="<%= request.getContextPath() %>/hjs/download.action?seq=${rboardvo.seq}"> 
				${rboardvo.orgFilename}</a> | 파일크기&nbsp;${rboardvo.fileSize}(bytes)
			</td>
		</tr>	
		
		<tr>
			<td colspan=2>
				<c:if test="${not empty rboardvo.fileName}">
					<img src="<%= request.getContextPath() %>/resources/files/${rboardvo.thumbnailFileName}" style="margin-top: 10px;" /><br/>
				</c:if>
				${rboardvo.content}
			</td>
		</tr>	
	</table>
	

	<br/>
	
	<!-- ===== 답변글쓰기 버튼 추가하기(현재 보고 있는 글이 작성하려는 답변글의 원글(부모글)이 된다.) ===== -->
	<div class="col-sm-4" align="left">
		
		<button type="button" class="btn btn-primary" onClick="golikeAdd('${rboardvo.seq}','${sessionScope.loginuser.userid}');">
			추천 :<span id="likeCnt" style="font-weight:bold; font-size:15px;"></span></button>
		
		<button type="button" class="btn btn-danger" onClick="godislikeAdd('${rboardvo.seq}','${sessionScope.loginuser.userid}');">
			비추천 :<span id="dislikeCnt" style="font-weight:bold; font-size:15px;"></span></button>
			
	</div>

	
	<div align="right" style="margin-left:60%;">
		<button type="button" class="btn" onClick="javascript:location.href='<%= request.getContextPath() %>/hjs/addReview.action?fk_seq=${rboardvo.seq}&groupno=${rboardvo.groupno}&depthno=${rboardvo.depthno}'">답변글쓰기</button> 
		<button type="button" class="btn" onClick="javascript:location.href='<%= request.getContextPath() %>/hjs/stationReview.action?station=${sessionScope.station}'">목록보기</button>
		<button type="button" class="btn" onClick="javascript:location.href='<%= request.getContextPath() %>/hjs/reviewEdit.action?seq=${rboardvo.seq}'">수정</button>
		<button type="button" class="btn" onClick="javascript:location.href='<%= request.getContextPath() %>/hjs/reviewDel.action?seq=${rboardvo.seq}'">삭제</button>
	</div>
		
	<br/>

	
	<!-- ===== 댓글 내용 보여주기 ===== -->
	<table id="table2" class="table">
		<c:if test="${empty rcommentList}">
			<tr class="active">
				<td align="center">작성된 댓글이 없습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="rcommentvo" items="${rcommentList}">
			<tr class="active">
				<td>
					<font size="3em" color="green" style="font-weight: bold ;"> ${rcommentvo.name}</font><br/>
					${rcommentvo.content}
				</td>
				<td align="right">
					<br/>
					${rcommentvo.regDate}
				</td>
			</tr>
		</c:forEach>
	</table>
	
	
	
	<!--  댓글쓰기 폼 추가 ===== -->
	<form name="addWriteFrm" action="<%= request.getContextPath() %>/hjs/addComment.action" method="get">   
	
	 <c:if test="${empty sessionScope.loginuser.userid}">
	  		<input type="text" name="content" class="form-control " placeholder="#회원로그인 후 댓글작성이 가능합니다." disabled />				
	 </c:if>   
	 
	 <c:if test="${not empty sessionScope.loginuser.userid}">
	  <div class="form-group">
		    <input type="hidden" name="userid" value="${sessionScope.loginuser.userid}">
		    <input type="hidden" name="boardSeq" value="${rboardvo.seq}">
		      
			<input type="hidden" name="name" value="${sessionScope.loginuser.name}" class="short" readonly/>
		    <input type="text" name="content" class="form-control " placeholder="#댓글을 작성해 주세요." />
		  
	    <!-- 댓글에 달리는 원게시물 글번호(즉, 댓글의 부모글) -->
		    <input type="hidden" name="parentSeq" value="${rboardvo.seq}"/> 	    
	    	<button type="button" onClick="goWrite();" class="btn"  >댓글쓰기</button>       
	   </div>
	  </c:if>         
	</form>


	<!-- 이전글 / 다음글 -->
	<div style="margin-top:30px; height: 5%; border: solid red 0px; margin-bottom:4%;">
		<c:forEach var="map" items="${prevNextList}" varStatus="status">
		<table>	
			<tr>
				<th>다음글&nbsp;&nbsp;</th>
				<td>
					<c:if test="${map.NSEQ != null}">     
						<a href="<%= request.getContextPath() %>/hjs/reviewView.action?seq=${map.NSEQ}">${map.NSUBJECT}</a>
					</c:if>
					<c:if test="${map.NSEQ == null}">     
						${map.NSUBJECT}
					</c:if>
				</td>
			</tr>
			
			<tr>
				<th>이전글&nbsp;&nbsp;</th>
				<td>
					<c:if test="${map.PSEQ != null}">     
						<a href="<%= request.getContextPath() %>/hjs/reviewView.action?seq=${map.PSEQ}">${map.PSUBJECT}</a>
					</c:if>
					<c:if test="${map.PSEQ == null}">     
						${map.PSUBJECT}
					</c:if>				
				</td>
			</tr>
		</table>
		</c:forEach>
	</div>

</div>

</div>
</div>
