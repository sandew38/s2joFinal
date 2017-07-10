package com.s2jo.khx.hjs;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.web.context.annotation.SessionScope;


@Aspect
/* 공통관심사 클래스 객체로 등록한다.
- 기존의 XML <aop:aspect> 역할을 한다. */
@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. */
public class Header {
	
	@Pointcut("execution(public * com.s2jo.khx.*.*Controller.header_*(..))")
	public void header(){
		
		
	}//end of public void requireLogin(){

	
	@Before("header()")
	public void before(JoinPoint joinPoint){
		
		HttpServletRequest request = (HttpServletRequest)joinPoint.getArgs()[0];
		HttpSession session = request.getSession();
		
		String header = "";
		
    	HttpServletResponse response = (HttpServletResponse)joinPoint.getArgs()[1];

    		
		// >>>> 로그인 후 로그인 하기전 페이지로 돌아가는 작업 하기 <<<<
		// ===>>> 현재 페이지의 주소(URL) 알아내기 <<<=== //			
		String url = request.getRequestURL().toString();
		// 현재 페이지의 URL은 getRequestURL()을 이용해서 구한다.
		
		/* 
		     그런데 URL에 쿼리문자열이 섞여서 Get방식으로 값이 넘어온 페이지라면 
		   getRequestURL() 메소드는 쿼리문자열(? 부터 시작하는 것)을 잘라버리고 출력하게 된다. 
		     즉 아래의 쿼리문자열(?page=1&seq=10) 부분은 getRequestURL() 메소드로는 잡히지 않는다는 뜻이다.
		   http://localhost/board.action?page=1&seq=10
		   
		   Get방식으로 넘어온 쿼리문자열을 구하기 위한 request 객체의 메소드는 getQueryString() 이다. 
		     이 getQueryString() 메소드는 쿼리문자열이 없을때는 null을 리턴해준다.  
        */

		Boolean bool_mainCheck = url.endsWith("khx.action");//1
			
		Boolean bool_bookingCheck = url.endsWith("bookingcheck.action");//2

		Boolean bool_stationInfo = url.endsWith("stationInfo.action");//3
		
		Boolean bool_helpBoard = url.endsWith("helpBoard.action");//4

		Boolean bool_recommendList = url.endsWith("recommendList.action");//5_1
		Boolean bool_togetherList = url.endsWith("togetherList.action");//5_2
		Boolean bool_worryingList = url.endsWith("worryingList.action");//5_3

		Boolean bool_booking = url.endsWith("booking.action");//6
		
		Boolean bool_selectseat = url.endsWith("selectseat.action");//7
		
		Boolean bool_orderConfirm = url.endsWith("orderConfirm.action");//8
		
		Boolean bool_pay = url.endsWith("pay.action");//9
		
		Boolean bool_payEnd = url.endsWith("payEnd.action");//10
		
		Boolean bool_sitemap = url.endsWith("sitemap.action");//11

		Boolean bool_nonloginform = url.endsWith("nonloginform.action");//12
		
		Boolean bool_loginform = url.endsWith("loginform.action");//13
		
		Boolean bool_memberRegister = url.endsWith("memberRegister.action");//14
		
		Boolean bool_Mypage = url.endsWith("Mypage.action");//15

		Boolean bool_stationReview = url.endsWith("stationReview.action");//16
		
		
		
		if(bool_mainCheck){//1
			header = "";
		}
		
		if(bool_bookingCheck){//2
			header = "예매확인";
		}
		
		if(bool_stationInfo){//3
			header = "기차역 정보";
		}
		if(bool_helpBoard){//4
			header = "고객센터";
		}	
		if(bool_recommendList){//5_1
			header = "게시판";
		}
		if(bool_togetherList){//5_2
			header = "게시판";
		}
		if(bool_worryingList){//5_3
			header = "게시판";
		}
		if(bool_booking){//6
			header = "열차예매";
		}	
		if(bool_selectseat){//7
			header = "열차예매";
		}
		if(bool_orderConfirm){//8
			header = "열차예매";
		} 
		if(bool_pay){//9
			header = "열차예매";
		}
		if(bool_payEnd){//10
			header = "열차예매";
		}
		if(bool_sitemap){//11
			header = "사이트맵";
		}	
		if(bool_nonloginform){//12
			header = "로그인";
		}
		if(bool_loginform){//13
			header = "로그인";
		}		
		if(bool_memberRegister){//14
			header = "회원가입";
		}			
		if(bool_Mypage){//15
			header = "마이페이지";
		}	
		if(bool_stationReview){//16
			header = "역 이용후기";
		}
		
		session.setAttribute("header", header); //세션에 header 정보를 저장시켜둔다.
			
   }//end of public void before(JoinPoint joinPoint){
	
}//end of public class header {
