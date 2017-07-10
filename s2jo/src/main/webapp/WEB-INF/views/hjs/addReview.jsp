<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/editor.css" type="text/css" />

<script src="<%=request.getContextPath() %>/resources/js/editor_loader.js" type="text/javascript" charset="utf-8"></script>

<style type="text/css">
	.filebox input[type="file"] {
	
			 position: absolute; 
			 width: 1px; 
			 height: 1px; 
			 padding: 0; 
			 margin: -1px; 
			 overflow: hidden; 
			 clip:rect(0,0,0,0); 
			 border: 0; 
	} 
	
	.filebox label { 
	
			display: inline-block; 
			padding: .5em .75em; 
			color: #999; 
			font-size: inherit; 
			line-height: normal;
		 	vertical-align: middle; 
		 	background-color: #fdfdfd; 
		 	cursor: pointer; 
		 	border: 1px solid #ebebeb; 
			border-bottom-color: #e2e2e2; 
			border-radius: .25em; 
	} 
	
	/* named upload */
	.filebox .upload-name { 
	
			display: inline-block; 
			padding: .5em .75em; /* label의 패딩값과 일치 */
			font-size: inherit; 
			font-family: inherit; 
			line-height: normal; 
			vertical-align: middle;
			background-color: #f5f5f5; 
			border: 1px solid #ebebeb; 
			border-bottom-color: #e2e2e2; 
			border-radius: .25em;
		    -webkit-appearance: none; /* 네이티브 외형 감추기 */ 
		    -moz-appearance: none; 
		    appearance: none; 
	}
	
	table, th, td, input, textarea {border: solid gray 1px;}	
	#table {border-collapse: collapse;
	 		width: 600px;
	 		}
	#table th, #table td{padding: 5px;}
	#table th{width: 120px; background-color: #DDDDDD;}
	#table td{width: 480px;}
	.long {width: 470px;}
	.short {width: 120px;} 	
	
	
	.hjs-background-panel{

	max-width: 96.5%;
	min-height: 70%;
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


<div  class="body" style="background-color:white; width:100%; height:100%; margin: auto; padding-top: 30px;  margin-bottom: 100px;">
<div class="hjs-background-panel" style="padding-top:3%; padding-bottom: 1%; " >

	<span class="well well-sm">${sessionScope.station}역 후기작성</span>
	<!-- 에디터2 시작 -->
	<!--
		@decsription
		등록하기 위한 Form으로 상황에 맞게 수정하여 사용한다. Form 이름은 에디터를 생성할 때 설정값으로 설정한다.
	-->
	<div style="width: 80%; height: 80%; padding-top:5%;" >
	<form name="tx_editor_form2" id="tx_editor_form2" enctype="multipart/form-data" accept-charset="utf-8" style="margin-left: 24%;">
	<div><input type="text" id="subject" name="subject" placeholder="#제목을 입력해 주세요." class="form-control" /></div>
	
	<div class="filebox"> 
	<input class="upload-name" value="파일첨부" disabled="disabled" style="width: 300px;" > 
	<label for="ex_filename">업로드</label> 
	<input type="file" id="ex_filename" class="upload-hidden" name="attach"> 
	</div>


	<br/>
		<!-- 에디터 컨테이너 시작 -->
		<div id="tx_trex_container2" class="tx-editor-container" align="center">
		
			<div id="tx_sidebar2" class="tx-sidebar">
				<div class="tx-sidebar-boundary">
					<ul class="tx-bar tx-bar-left tx-nav-attach">
					
					</ul>
					<ul class="tx-bar tx-bar-right">
						<li class="tx-list">
							<div unselectable="on" class="tx-btn-lrbg tx-fullscreen" id="tx_fullscreen2">
								<a href="javascript:;" class="tx-icon" title="넓게쓰기 (Ctrl+M)">넓게쓰기</a>
							</div>
						</li>
					</ul>
					<ul class="tx-bar tx-bar-right tx-nav-opt">
						<li class="tx-list">
							<div unselectable="on" class="tx-switchtoggle" id="tx_switchertoggle2">
								<a href="javascript:;" title="에디터 타입">에디터</a>
							</div>
						</li>
					</ul>
				</div>
			</div> 


			<div id="tx_toolbar_basic2" class="tx-toolbar tx-toolbar-basic">
				<div class="tx-toolbar-boundary">
					<ul class="tx-bar tx-bar-left">
						<li class="tx-list">
							<div id="tx_fontfamily2" unselectable="on" class="tx-slt-70bg tx-fontfamily">
								<a href="javascript:;" title="글꼴">굴림</a>
							</div>
							<div id="tx_fontfamily_menu2" class="tx-fontfamily-menu tx-menu" unselectable="on">
							</div>
						</li>
					</ul>
					<ul class="tx-bar tx-bar-left">
						<li class="tx-list">
							<div unselectable="on" class="tx-slt-42bg tx-fontsize" id="tx_fontsize2">
								<a href="javascript:;" title="글자크기">9pt</a>
							</div>
							<div id="tx_fontsize_menu2" class="tx-fontsize-menu tx-menu" unselectable="on">
							</div>
						</li>
					</ul>
					<ul class="tx-bar tx-bar-left tx-group-font">
						<li class="tx-list">
							<div unselectable="on" class="		 tx-btn-lbg 	tx-bold" id="tx_bold2">
								<a href="javascript:;" class="tx-icon" title="굵게 (Ctrl+B)">굵게</a>
							</div>
						</li>
						<li class="tx-list">
							<div unselectable="on" class="		 tx-btn-bg 	tx-underline" id="tx_underline2">
								<a href="javascript:;" class="tx-icon" title="밑줄 (Ctrl+U)">밑줄</a>
							</div>
						</li>
						<li class="tx-list">
							<div unselectable="on" class="		 tx-btn-bg 	tx-italic" id="tx_italic2">
								<a href="javascript:;" class="tx-icon" title="기울임 (Ctrl+I)">기울임</a>
							</div>
						</li>
						<li class="tx-list">
							<div unselectable="on" class="		 tx-btn-bg 	tx-strike" id="tx_strike2">
								<a href="javascript:;" class="tx-icon" title="취소선 (Ctrl+D)">취소선</a>
							</div>
						</li>
						<li class="tx-list">
							<div unselectable="on" class="		 tx-slt-tbg 	tx-forecolor" id="tx_forecolor2">
								<a href="javascript:;" class="tx-icon" title="글자색">글자색</a>
								<a href="javascript:;" class="tx-arrow" title="글자색 선택">글자색 선택</a>
							</div>
							<div id="tx_forecolor_menu2" class="tx-menu tx-forecolor-menu tx-colorpallete" unselectable="on">
							</div>
						</li>
						<li class="tx-list">
							<div unselectable="on" class="		 tx-slt-brbg 	tx-backcolor" id="tx_backcolor2">
								<a href="javascript:;" class="tx-icon" title="글자 배경색">글자 배경색</a>
								<a href="javascript:;" class="tx-arrow" title="글자 배경색 선택">글자 배경색 선택</a>
							</div>
							<div id="tx_backcolor_menu2" class="tx-menu tx-backcolor-menu tx-colorpallete" unselectable="on">
							</div>
						</li>
					</ul>
					<ul class="tx-bar tx-bar-left tx-group-align">
						<li class="tx-list">
							<div unselectable="on" class="		 tx-btn-lbg 	tx-alignleft" id="tx_alignleft2">
								<a href="javascript:;" class="tx-icon" title="왼쪽정렬 (Ctrl+,)">왼쪽정렬</a>
							</div>
						</li>
						<li class="tx-list">
							<div unselectable="on" class="		 tx-btn-bg 	tx-aligncenter" id="tx_aligncenter2">
								<a href="javascript:;" class="tx-icon" title="가운데정렬 (Ctrl+.)">가운데정렬</a>
							</div>
						</li>
						<li class="tx-list">
							<div unselectable="on" class="		 tx-btn-bg 	tx-alignright" id="tx_alignright2">
								<a href="javascript:;" class="tx-icon" title="오른쪽정렬 (Ctrl+/)">오른쪽정렬</a>
							</div>
						</li>
						<li class="tx-list">
							<div unselectable="on" class="		 tx-btn-rbg 	tx-alignfull" id="tx_alignfull2">
								<a href="javascript:;" class="tx-icon" title="양쪽정렬">양쪽정렬</a>
							</div>
						</li>
					</ul>
					<ul class="tx-bar tx-bar-left tx-group-tab">
						<li class="tx-list">
							<div unselectable="on" class="		 tx-btn-lbg 	tx-indent" id="tx_indent2">
								<a href="javascript:;" title="들여쓰기 (Tab)" class="tx-icon">들여쓰기</a>
							</div>
						</li>
						<li class="tx-list">
							<div unselectable="on" class="		 tx-btn-rbg 	tx-outdent" id="tx_outdent2">
								<a href="javascript:;" title="내어쓰기 (Shift+Tab)" class="tx-icon">내어쓰기</a>
							</div>
						</li>
					</ul>
					<ul class="tx-bar tx-bar-left tx-group-list">
						<li class="tx-list">
							<div unselectable="on" class="tx-slt-31lbg tx-lineheight" id="tx_lineheight2">
								<a href="javascript:;" class="tx-icon" title="줄간격">줄간격</a>
								<a href="javascript:;" class="tx-arrow" title="줄간격">줄간격 선택</a>
							</div>
							<div id="tx_lineheight_menu2" class="tx-lineheight-menu tx-menu" unselectable="on">
							</div>
						</li>
						<li class="tx-list">
							<div unselectable="on" class="tx-slt-31rbg tx-styledlist" id="tx_styledlist2">
								<a href="javascript:;" class="tx-icon" title="리스트">리스트</a>
								<a href="javascript:;" class="tx-arrow" title="리스트">리스트 선택</a>
							</div>
							<div id="tx_styledlist_menu2" class="tx-styledlist-menu tx-menu" unselectable="on">
							</div>
						</li>
					</ul>
					<ul class="tx-bar tx-bar-left tx-group-etc">
						<li class="tx-list">
							<div unselectable="on" class="		 tx-btn-lbg 	tx-emoticon" id="tx_emoticon2">
								<a href="javascript:;" class="tx-icon" title="이모티콘">이모티콘</a>
							</div>
							<div id="tx_emoticon_menu2" class="tx-emoticon-menu tx-menu" unselectable="on">
							</div>
						</li>
						<li class="tx-list">
							<div unselectable="on" class="		 tx-btn-bg 	tx-link" id="tx_link2">
								<a href="javascript:;" class="tx-icon" title="링크 (Ctrl+K)">링크</a>
							</div>
							<div id="tx_link_menu2" class="tx-link-menu tx-menu">
							</div>
						</li>
						<li class="tx-list">
							<div unselectable="on" class="		 tx-btn-bg 	tx-specialchar" id="tx_specialchar2">
								<a href="javascript:;" class="tx-icon" title="특수문자">특수문자</a>
							</div>
							<div id="tx_specialchar_menu2" class="tx-specialchar-menu tx-menu">
							</div>
						</li>
						<li class="tx-list">
							<div unselectable="on" class="		 tx-btn-bg 	tx-table" id="tx_table2">
								<a href="javascript:;" class="tx-icon" title="표만들기">표만들기</a>
							</div>
							<div id="tx_table_menu2" class="tx-table-menu tx-menu" unselectable="on">
								<div class="tx-menu-inner">
									<div class="tx-menu-preview">
									</div>
									<div class="tx-menu-rowcol">
									</div>
									<div class="tx-menu-deco">
									</div>
									<div class="tx-menu-enter">
									</div>
								</div>
							</div>
						</li>
						<li class="tx-list">
							<div unselectable="on" class="		 tx-btn-rbg 	tx-horizontalrule" id="tx_horizontalrule2">
								<a href="javascript:;" class="tx-icon" title="구분선">구분선</a>
							</div>
							<div id="tx_horizontalrule_menu2" class="tx-horizontalrule-menu tx-menu" unselectable="on">
							</div>
						</li>
					</ul>
					<ul class="tx-bar tx-bar-left">
						<li class="tx-list">
							<div unselectable="on" class="		 tx-btn-lbg 	tx-richtextbox" id="tx_richtextbox2">
								<a href="javascript:;" class="tx-icon" title="글상자">글상자</a>
							</div>
							<div id="tx_richtextbox_menu2" class="tx-richtextbox-menu tx-menu">
								<div class="tx-menu-header">
									<div class="tx-menu-preview-area">
										<div class="tx-menu-preview">
										</div>
									</div>
									<div class="tx-menu-switch">
										<div class="tx-menu-simple tx-selected">
											<a><span>간단 선택</span></a>
										</div>
										<div class="tx-menu-advanced">
											<a><span>직접 선택</span></a>
										</div>
									</div>
								</div>
								<div class="tx-menu-inner">
								</div>
								<div class="tx-menu-footer">
									<img class="tx-menu-confirm" src="<%=request.getContextPath() %>/resources/images/icon/editor/btn_confirm.gif?rv=1.0.1" alt=""/><img class="tx-menu-cancel" hspace="3" src="<%=request.getContextPath() %>/resources/images/icon/editor/btn_cancel.gif?rv=1.0.1" alt=""/>
								</div>
							</div>
						</li>
						<li class="tx-list">
							<div unselectable="on" class="		 tx-btn-bg 	tx-quote" id="tx_quote2">
								<a href="javascript:;" class="tx-icon" title="인용구 (Ctrl+Q)">인용구</a>
							</div>
							<div id="tx_quote_menu2" class="tx-quote-menu tx-menu" unselectable="on">
							</div>
						</li>
						<li class="tx-list">
							<div unselectable="on" class="		 tx-btn-bg 	tx-background" id="tx_background2">
								<a href="javascript:;" class="tx-icon" title="배경색">배경색</a>
							</div>
							<div id="tx_background_menu2" class="tx-menu tx-background-menu tx-colorpallete" unselectable="on">
							</div>
						</li>
						<li class="tx-list">
							<div unselectable="on" class="		 tx-btn-rbg 	tx-dictionary" id="tx_dictionary2">
								<a href="javascript:;" class="tx-icon" title="사전">사전</a>
							</div>
						</li>
					</ul>
					<ul class="tx-bar tx-bar-left tx-group-undo">
						<li class="tx-list">
							<div unselectable="on" class="		 tx-btn-lbg 	tx-undo" id="tx_undo2">
								<a href="javascript:;" class="tx-icon" title="실행취소 (Ctrl+Z)">실행취소</a>
							</div>
						</li>
						<li class="tx-list">
							<div unselectable="on" class="		 tx-btn-rbg 	tx-redo" id="tx_redo2">
								<a href="javascript:;" class="tx-icon" title="다시실행 (Ctrl+Y)">다시실행</a>
							</div>
						</li>
					</ul>
					<ul class="tx-bar tx-bar-right">
						<li class="tx-list">
							<div unselectable="on" class="tx-btn-nlrbg tx-advanced" id="tx_advanced2">
								<a href="javascript:;" class="tx-icon" title="툴바 더보기">툴바 더보기</a>
							</div>
						</li>
					</ul>
				</div>
			</div>
			<!-- 툴바 - 기본 끝 --><!-- 툴바 - 더보기 시작 -->
			<div id="tx_toolbar_advanced2" class="tx-toolbar tx-toolbar-advanced">
				<div class="tx-toolbar-boundary">
					<ul class="tx-bar tx-bar-left">
						<li class="tx-list">
							<div class="tx-tableedit-title">
							</div>
						</li>
					</ul>
					<ul class="tx-bar tx-bar-left tx-group-align">
						<li class="tx-list">
							<div unselectable="on" class="tx-btn-lbg tx-mergecells" id="tx_mergecells2">
								<a href="javascript:;" class="tx-icon2" title="병합">병합</a>
							</div>
							<div id="tx_mergecells_menu2" class="tx-mergecells-menu tx-menu" unselectable="on">
							</div>
						</li>
						<li class="tx-list">
							<div unselectable="on" class="tx-btn-bg tx-insertcells" id="tx_insertcells2">
								<a href="javascript:;" class="tx-icon2" title="삽입">삽입</a>
							</div>
							<div id="tx_insertcells_menu2" class="tx-insertcells-menu tx-menu" unselectable="on">
							</div>
						</li>
						<li class="tx-list">
							<div unselectable="on" class="tx-btn-rbg tx-deletecells" id="tx_deletecells2">
								<a href="javascript:;" class="tx-icon2" title="삭제">삭제</a>
							</div>
							<div id="tx_deletecells_menu2" class="tx-deletecells-menu tx-menu" unselectable="on">
							</div>
						</li>
					</ul>
					<ul class="tx-bar tx-bar-left tx-group-align">
						<li class="tx-list">
							<div id="tx_cellslinepreview2" unselectable="on" class="tx-slt-70lbg tx-cellslinepreview">
								<a href="javascript:;" title="선 미리보기"></a>
							</div>
							<div id="tx_cellslinepreview_menu2" class="tx-cellslinepreview-menu tx-menu" unselectable="on">
							</div>
						</li>
						<li class="tx-list">
							<div id="tx_cellslinecolor2" unselectable="on" class="tx-slt-tbg tx-cellslinecolor">
								<a href="javascript:;" class="tx-icon2" title="선색">선색</a>
								<div class="tx-colorpallete" unselectable="on">
								</div>
							</div>
							<div id="tx_cellslinecolor_menu2" class="tx-cellslinecolor-menu tx-menu tx-colorpallete" unselectable="on">
							</div>
						</li>
						<li class="tx-list">
							<div id="tx_cellslineheight2" unselectable="on" class="tx-btn-bg tx-cellslineheight">
								<a href="javascript:;" class="tx-icon2" title="두께">두께</a>
							</div>
							<div id="tx_cellslineheight_menu2" class="tx-cellslineheight-menu tx-menu" unselectable="on">
							</div>
						</li>
						<li class="tx-list">
							<div id="tx_cellslinestyle2" unselectable="on" class="tx-btn-bg tx-cellslinestyle">
								<a href="javascript:;" class="tx-icon2" title="스타일">스타일</a>
							</div>
							<div id="tx_cellslinestyle_menu2" class="tx-cellslinestyle-menu tx-menu" unselectable="on">
							</div>
						</li>
						<li class="tx-list">
							<div id="tx_cellsoutline2" unselectable="on" class="tx-btn-rbg tx-cellsoutline">
								<a href="javascript:;" class="tx-icon2" title="테두리">테두리</a>
							</div>
							<div id="tx_cellsoutline_menu2" class="tx-cellsoutline-menu tx-menu" unselectable="on">
							</div>
						</li>
					</ul>
					<ul class="tx-bar tx-bar-left">
						<li class="tx-list">
							<div id="tx_tablebackcolor2" unselectable="on" class="tx-btn-lrbg tx-tablebackcolor" style="background-color:#9aa5ea;">
								<a href="javascript:;" class="tx-icon2" title="테이블 배경색">테이블 배경색</a>
							</div>
							<div id="tx_tablebackcolor_menu2" class="tx-tablebackcolor-menu tx-menu tx-colorpallete" unselectable="on">
							</div>
						</li>
					</ul>
					<ul class="tx-bar tx-bar-left">
						<li class="tx-list">
							<div id="tx_tabletemplate2" unselectable="on" class="tx-btn-lrbg tx-tabletemplate">
								<a href="javascript:;" class="tx-icon2" title="테이블 서식">테이블 서식</a>
							</div>
							<div id="tx_tabletemplate_menu2" class="tx-tabletemplate-menu tx-menu tx-colorpallete" unselectable="on">
							</div>
						</li>
					</ul>
				</div>
			</div>
			<!-- 툴바 - 더보기 끝 --><!-- 편집영역 시작 -->
			<div id="tx_canvas2" class="tx-canvas" ">
				<div id="tx_loading2" class="tx-loading">
					<div>
						<img src="<%=request.getContextPath() %>/resources/images/icon/editor/loading2.png" width="113" height="21" align="absmiddle"/>
					</div>
				</div>
				<div id="tx_canvas_wysiwyg_holder2" class="tx-holder" style="display:block;">
					<iframe id="tx_canvas_wysiwyg2" name="tx_canvas_wysiwyg2" allowtransparency="true" frameborder="0">
					</iframe>
				</div>
				<div class="tx-source-deco">
					<div id="tx_canvas_source_holder2" class="tx-holder">
						<textarea id="tx_canvas_source2" rows="30" cols="30">
						</textarea>
					</div>
				</div>
				<div id="tx_canvas_text_holder2" class="tx-holder">
					<textarea id="tx_canvas_text2" rows="30" cols="30">
					</textarea>
				</div>
			</div>
			<!-- 높이조절 Start -->
			<div id="tx_resizer2" class="tx-resize-bar">
				<div class="tx-resize-bar-bg">
				</div>
				<img id="tx_resize_holder2" src="<%=request.getContextPath() %>/resources/images/icon/editor/skin/01/btn_drag01.gif" width="58" height="12" unselectable="on" alt="" />
			</div>
			<div class="tx-side-bi" id="tx_side_bi2">
				<div style="text-align: right;">
					<img hspace="4" height="14" width="78" align="absmiddle" src="<%=request.getContextPath() %>/resources/images/icon/editor/editor_bi.png" />
				</div>
			</div><!-- 편집영역 끝 --><!-- 첨부박스 시작 --><!-- 파일첨부박스 Start -->
			<div id="tx_attach_div2" class="tx-attach-div">
				<div id="tx_attach_txt2" class="tx-attach-txt">
					파일 첨부
				</div>
				<div id="tx_attach_box2" class="tx-attach-box">
					<div class="tx-attach-box-inner">
						<div id="tx_attach_preview2" class="tx-attach-preview">
							<p>
							</p>
							<img src="<%=request.getContextPath() %>/resources/images/icon/editor/pn_preview.gif" width="147" height="108" unselectable="on"/>
						</div>
						<div class="tx-attach-main">
							<div id="tx_upload_progress2" class="tx-upload-progress">
								<div>
									0%
								</div>
								<p>
									파일을 업로드하는 중입니다.
								</p>
							</div>
							<ul class="tx-attach-top">
								<li id="tx_attach_delete2" class="tx-attach-delete">
									<a>전체삭제</a>
								</li>
								<li id="tx_attach_size2" class="tx-attach-size">
									파일: <span id="tx_attach_up_size2" class="tx-attach-size-up"></span>/<span id="tx_attach_max_size2"></span>
								</li>
								<li id="tx_attach_tools2" class="tx-attach-tools">
								</li>
							</ul>
							<ul id="tx_attach_list2" class="tx-attach-list">
							</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- 첨부박스 끝 -->
		</div>


		<!-- 에디터 컨테이너 끝 -->
		<input type="hidden" id="content" name="content"/>
		<input type="hidden" id="boardSeq" name="boardSeq" />
		<input type="hidden" id="userid" name="userid" value="${sessionScope.loginuser.userid}">
		<input type="hidden" id="name"  name="name" value="${sessionScope.loginuser.name}" />


		<!-- ===== 답변글쓰기인 경우
                   부모글의 seq 값인 fk_seq 값과
                   부모글의 groupno 값과
                   부모글의 depthno 값을 hidden 타입으로 보내준다. ===== -->

		<input type="hidden" id="fk_seq" name="fk_seq"  value="${fk_seq}" />                   		
		<input type="hidden" id="groupno" name="groupno" value="${groupno}" />
		<input type="hidden" id="depthno" name="depthno" value="${depthno}" />
		<input type="hidden" id="station" name="station" value="${sessionScope.station}"/>
		
		
		
		<div class="desc">
			<!-- <button onclick="checkContent();">에디터 내용 확인</button> -->
			<input align="right" type="password" id="pw" name="pw" placeholder="#게시글 암호를 입력해주세요." style="margin-bottom:10px; width: 300px;" class="form-control" />
			<button onclick='saveContent()' class="btn">저장</button> 
			<button type="button" onClick="javascript:history.back();" class="btn">취소</button>
		</div>
		

	</div>
	
</div>

</div>

<!-- 에디터2 끝 -->

<!-- 에디터2 config 시작 -->

<!-- 에디터2 config 시작 -->
<script type="text/javascript">
	var config2 = {
		txHost: '', /* 런타임 시 리소스들을 로딩할 때 필요한 부분으로, 경로가 변경되면 이 부분 수정이 필요. ex) http://xxx.xxx.com */
		txPath: '', /* 런타임 시 리소스들을 로딩할 때 필요한 부분으로, 경로가 변경되면 이 부분 수정이 필요. ex) /xxx/xxx/ */
		txService: 'sample', /* 수정필요없음. */
		txProject: 'sample', /* 수정필요없음. 프로젝트가 여러개일 경우만 수정한다. */
		initializedId: "2", /* 대부분의 경우에 빈문자열 */
		wrapper: "tx_trex_container2", /* 에디터를 둘러싸고 있는 레이어 이름(에디터 컨테이너) */
		form: "tx_editor_form2"+"", /* 등록하기 위한 Form 이름 */
		txIconPath: "<%=request.getContextPath() %>/resources/images/icon/editor/", /*에디터에 사용되는 이미지 디렉터리, 필요에 따라 수정한다. */
		txDecoPath: "<%=request.getContextPath() %>/resources/images/deco/contents/", /*본문에 사용되는 이미지 디렉터리, 서비스에서 사용할 때는 완성된 컨텐츠로 배포되기 위해 절대경로로 수정한다. */
		canvas: {
			styles: {
				color: "#123456", /* 기본 글자색 */
				fontFamily: "굴림", /* 기본 글자체 */
				fontSize: "10pt", /* 기본 글자크기 */
				backgroundColor: "#fff", /*기본 배경색 */
				lineHeight: "1.5", /*기본 줄간격 */
				padding: "8px" /* 위지윅 영역의 여백 */
			},
			showGuideArea: false
		},
		events: {
			preventUnload: false
		},
		sidebar: {
			attachbox: {
				show: true
			},
			attacher: {
				file: {
					popPageUrl: "pages/trex/file.html?config=2"
				}
			}
		},
		size: {
			contentWidth: 700 /* 지정된 본문영역의 넓이가 있을 경우에 설정 */
		}
	};
	
	$(document).ready(function(){ 
		var fileTarget = $('.filebox .upload-hidden'); 
		fileTarget.on('change', function(){ // 값이 변경되면 
			if(window.FileReader){ // modern browser
		 		var filename = $(this)[0].files[0].name; } 
			else { // old IE 
				var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출 
			} // 추출한 파일명 삽입 
			$(this).siblings('.upload-name').val(filename); 
			}); 
	}); 




</script>
<!-- 에디터2 config 끝 -->

<hr/>
<script type="text/javascript">
	var currentEditorId = "3";
	var switchEditor = function () {
		if (currentEditorId === "2") {
			currentEditorId = "3"
		} else {
			currentEditorId = "2";
		}
		Editor.switchEditor(currentEditorId);
		document.getElementById("currentEditorId").innerHTML = "현재 에디터는 에디터" + currentEditorId + "입니다.";
	};
	var pasteContent = function () {
		var content = "<p>에디터" + currentEditorId + "입니다.<br/>" + new Date() + "</p>";
		Editor.getCanvas().pasteContent(content);
	};
	var checkContent = function () {
		/* var content = Editor.getContent();
		alert(content); */
		var tx_editor_form2 = document.tx_editor_form2;
		tx_editor_form2.content.value = Editor.getContent();
		alert(tx_editor_form2.content.value);
	};
</script>


<script type="text/javascript">
	function saveContent() {

		var subject = $("#subject").val();
		tx_editor_form2.content.value = Editor.getContent();
		
		if(subject.trim() == "") {
			alert("제목을 입력하세요!");
			event.preventDefault();
		} 
		else if (tx_editor_form2.content.value.trim()=="<p><br></p>"){
			alert("내용을 입력하세요!");
			event.preventDefault();
		}
		else if (tx_editor_form2.pw.value.trim()==""){
			alert("게시글 암호를 입력하세요!");
			event.preventDefault();
		}
		else{
		tx_editor_form2.action = "<%= request.getContextPath() %>/hjs/addReviewEnd.action";
		tx_editor_form2.method = "POST";
		tx_editor_form2.submit();
		}
	}
	
	


</script>


<!-- 에디터 2,3 초기화 시작 -->
<script type="text/javascript">
	EditorJSLoader.ready(function (Editor) {
		new Editor(config2);
		Editor.getCanvas().observeJob(Trex.Ev.__IFRAME_LOAD_COMPLETE, function() {
			Editor.modify({
				content: 'Editor2'
			});
			new Editor(config3);
			Editor.getCanvas().observeJob(Trex.Ev.__IFRAME_LOAD_COMPLETE, function(ev) {
				Editor.modify({
					content: 'Editor3'
				});
			});
		});
	});
	
</script>
<!-- 에디터 2,3 초기화 끝 -->




