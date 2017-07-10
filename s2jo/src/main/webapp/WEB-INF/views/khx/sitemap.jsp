<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">

h4{

 /*  font-weight: bolder; */

}

ul {
  list-style: none;
  padding: 0;
  margin: 0;
}
 
.yjli {
  padding-left: 1em; 
  text-indent: -.7em;
  display: list-item;
  font-size: small;
} 

.yjli::before {
  font-family:"Arial Black";
  content: "•";
/*  display: block; */
  color: #0d696c;
  margin-right: 1%; 
}

 a
  {
  	color: #545454;
  	text-decoration: none;
  	cursor: pointer;  	
  	font-weight: lighter;
  }

a:hover 
{
	color:#68b3ce;
	text-decoration: none;
	cursor: pointer;
}

</style>


<div style="background-color: white; width: 100%; height: 100%; margin: auto; padding-top: 2%; margin-bottom: 100px; text-align: center;">
	
	<span style="font-size: 25px;">KHX 홈페이지의 정보를 쉽고 빠르게 확인하실 수 있습니다.</span>
	
	<div align="center" style="padding-top: 2%;">
		<div style="width: 60%; height: 80%; text-align: center; border: 1px solid #0d696c;" align="center">
			<div style="float:left; padding-left: 2%; width:33.3%; height: 100%; border-right: 1px solid #0d696c;" >
				<h3 style="color: #0d696c;" align="left" >승차권</h3>
				
				<div style="text-align: left; padding-top: 5%; padding-left: 2%;">
					<h4>예매</h4>
					<ul>
						<li class="yjli"><a href="<%=request.getContextPath()%>/khx">열차 예매</a></li>
						<li class="yjli"><a href="<%=request.getContextPath()%>/lsk/bookingcheck.action">예매 확인/취소/변경</a></li>
						<li class="yjli"><a>영수증 발행</a></li>
					</ul>
				</div>
				
				<div style="text-align: left; padding-top: 5%; padding-left: 2%;">
					<h4>운행정보</h4>
					<ul>
						<li class="yjli"><a href="<%=request.getContextPath()%>/khx">도착시간 안내</a></li>
						<li class="yjli"><a href="<%=request.getContextPath()%>/khx">시간표 조회</a></li>
					</ul>
				</div>
				
			</div>
			<div style="float:left; padding-left: 2%;  width:33.3%; height: 100%; border-right: 1px solid #0d696c;" >
				<h3 style="color: #0d696c;" align="left" >회원</h3>
				
				<div style="text-align: left; padding-top: 5%; padding-left: 2%;">
					<h4>회원</h4>
					<ul>
						<li class="yjli"><a href="<%=request.getContextPath()%>/memberRegister.action">회원가입</a></li>
						<li class="yjli"><a href="<%=request.getContextPath()%>/loginform.action">로그인</a></li>
						<li class="yjli"><a href="<%=request.getContextPath()%>/nonloginform.action">비회원로그인</a></li>
						<li class="yjli"><a href="<%=request.getContextPath()%>/MypagePwdFind.action">비밀번호 찾기</a></li>
						<li class="yjli"><a href="<%=request.getContextPath()%>/Mypage.action">마이페이지</a></li>
					</ul>
				</div>
				
				<div style="text-align: left; padding-top: 5%; padding-left: 2%;">
					<h4>약관 및 처리방침</h4>
					<ul>
						<li class="yjli"><a>서비스 이용약관</a></li>
						<li class="yjli"><a>개인정보 처리방침</a></li>
						<li class="yjli"><a>열차 운송약관</a></li>
						<li class="yjli"><a>전자금융거래 이용약관</a></li>
					</ul>
				</div>
				
			</div>
			<div style="float:left; padding-left: 2%;  width:33.3%; height: 100%; border: 0px solid blue;" >
				<h3 style="color: #0d696c;" align="left" >기타</h3>
				
				<div style="text-align: left; padding-top: 5%; padding-left: 2%;">
					<h4>이용안내</h4>
					<ul>
						<li class="yjli"><a>예매안내</a></li>
						<li class="yjli"><a>결제수단 안내</a></li>
						<li class="yjli"><a>승차권 환불안내</a></li>
						<li class="yjli"><a>휴게소 환승안내</a></li>
						<li class="yjli"><a>기차역 안내</a></li>
						<li class="yjli"><a>운송사 안내</a></li>
						<li class="yjli"><a>할인제도 안내</a></li>
					</ul>
				</div>
				
				<div style="text-align: left; padding-top: 5%; padding-left: 2%;">
					<h4>고객센터</h4>
					<ul>
						<li class="yjli"><a>공지사항</a></li>
						<li class="yjli"><a>자주 찾는 질문</a></li>
						<li class="yjli"><a>유실물센터 안내</a></li>
					</ul>
				</div>
				
				<div style="text-align: left; padding-top: 5%; padding-left: 2%;">
					<h4>기타</h4>
					<ul>
						<li class="yjli"><a>전국KHX운송사업조합</a></li>
						<li class="yjli"><a>기차역사업자협회</a></li>
					</ul>
				</div>
				
			</div>
		</div>
	</div>
	
</div>