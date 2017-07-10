<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>


<!-- SWAL -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.css"
   	  rel="stylesheet">
<script src=" https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.common.min.js"></script>



<script type="text/javascript">

$(document).ready(function() {
	//	여기 링크를 꼭 참고하세용 http://www.iamport.kr/getstarted
   var IMP = window.IMP; // 생략가능

   IMP.init('imp50043848');  // 중요 

	// loginUser 세션 사용보다는 payVO 혹은 orderVO 생성 후 가져오는 것이 나을듯
	//  :  앞부분은 바꾸지 말것!
   IMP.request_pay({
       pg : 'danal_tpay', // 결제방식
       pay_method : 'card',	// 결제 수단
       merchant_uid : 'merchant_' + new Date().getTime(),
       name : '주문명:${sessionScope.departure}-${sessionScope.arrival}',	// order 테이블에 들어갈 주문명 혹은 주문 번호
       amount : '100',	// 결제 금액${sessionScope.totalPrice} 
       buyer_email : '',	// 구매자 email
       buyer_name : '',	// 구매자 이름 
       buyer_tel : '',
       buyer_addr : '',
       buyer_postcode : '',
       m_redirect_url : '/khx/payEnd.action'	// 결제 완료 후 action : 컨트롤러로 보내서 자체 db에 입력시킬것!
   }, function(rsp) {
       if ( rsp.success ) {
        /* var msg = '결제가 완료되었습니다.';
           msg += '고유ID : ' + rsp.imp_uid;
           msg += '상점 거래ID : ' + rsp.merchant_uid;
           msg += '결제 금액 : ' + rsp.paid_amount;
           msg += '카드 승인번호 : ' + rsp.apply_num;
           alert(msg); */
           
           swal("결제가 완료되었습니다!"
	       		   , "결제금액 : " + rsp.paid_amount 
	       		   , "success");
           
           location.href="/khx/payEnd.action";
           
       } else {
/*         var msg = '결제에 실패하였습니다.';
           msg += '에러내용 : ' + rsp.error_msg;
           alert(msg); */
           
           
           sweetAlert("결제에 실패하였습니다.", rsp.error_msg, "error");
           
//           location.href="/khx";
       }
       
   });

});


</script>


<div style="width : 100%; height: 100%; background-color: white;" align="center">
	<!-- <form name="pgForm">
	   <input type="hidden" name="Amt" value="1000">
	   <input type="hidden" name="BuyerName" value="홍길동">
	   <input type="hidden" name="OrderName" value="결제테스트">
	</form> -->
</div>