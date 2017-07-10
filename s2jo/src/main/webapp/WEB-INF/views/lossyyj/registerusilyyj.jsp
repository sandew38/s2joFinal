<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<div style="width: 860px; padding-left: 30%; float: left;">
<style type="text/css">
table, th, td, input, textarea {
   border: solid gray 1px;
}

#table {
   border-collapse: collapse;
   width: 600px;
}

#table th, #table td {
   padding: 5px;
}

#table th {
   width: 120px;
   background-color: #DDDDDD;
}

#table td {
   width: 480px;
}

.long {
   width: 470px;
}

.short {
   width: 120px;
}
</style>

<head>

<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>



<script type="text/javascript">
   function goWrite() {
      // 유효성 검사는 생략 하겠음.
      var writeFrm = document.writeFrm;
      var findplace = $("#findplace").val();
      var article = $("#article").val();
      var writepw =$("#writepw").val();
      
      /* writeFrm.action = "/khx/regiseterEnd.action";
      writeFrm.method = "post";
      writeFrm.submit();
       */
      if(findplace.trim() == ""){
    	  alert("습득장소를 입력하여주세요 ^-^");
          $("#findplace").val();
          $("#findplace").focus();
          event.preventDefault();
          return;
      }
      
      else if (article.trim() == ""){
    	  alert("습득물명을 입력하여주세여 ^-^");
    	  $("#article").val();
          $("#article").focus();
          event.preventDefault();
          return;
      } 
      else if (writepw.trim() == "") {
    	  alert("글암호를 입력하여주세여 ^-^");
    	  $("#writepw").val();
          $("#writepw").focus();
          event.preventDefault();
          return;
    	  
      }
       
      else{
    	  
    	  writeFrm.action = "/khx/regiseterEnd.action";
          writeFrm.method = "post";
          writeFrm.submit();
      }
      
      
      
   }

   
   </script>
   
<div style=" width:100%; margin-right:500px; border: solid 0px red; /* margin-top: 20px; */">
	  <div style=" /* width: 100%; */ margin-left: 200px;">
	<h1>유실물등록</h1>
</div>


<%--    <form name="writeFrm"
       action="<%=request.getContextPath()%>/regiseterEnd.action"  method="post"> --%>
      <!-- #132. 파일첨부하기
         먼저 위의 문장을 주석처리한 후 아래와 같이 한다.
        enctype = "multipart/form-data" 을 해주어야만 파일첨부가 된당.
        action="<%=request.getContextPath()%>/addEnd.action" method="post"
    -->

      <form name="writeFrm" enctype="multipart/form-data">
          <table id="table" style= "margin-top: 15%; margin-left: 160px;">
            <tr>
               <th>회원아이디</th>
               <td><input type="text" name="userid"
                   value="${sessionScope.loginuser.userid}"
                  class="short" readonly /></td>
            </tr>

              <tr>
               <th>분실물종류</th>
               <td><select name="losskind">
                     <option value="가방" selected>가방</option>
                     <option value="귀금속">귀금속</option>
                     <option value="도서용품">도서용품</option>
                     <option value="사무용품">사무용품</option>
               </select></td>
            </tr> 
            
              
         
         
            
            


   <tr>
<!--                <th>분실물종류</th>
               <td><input type="text" name="losskind" class="long" /></td>


               
            </tr>
 -->





            <tr>
               <th >습득일</th>
               <!-- <td><input type="text" name="finddate1" class="long" /></td>  습득일수정잊지말기
                -->
               
   
   
   
   
   
   
   
               
                 <td colspan="3"><select name="finddate1">
							<option value="1995" selected>1995</option>
							<option value="1996">1996</option>
							<option value="1997">1997</option>
							<option value="1998">1998</option>
							<option value="1999">1999</option>
							<option value="2000">2000</option>
							<option value="2001">2001</option>
							<option value="2002">2002</option>
							<option value="2003">2003</option>
							<option value="2004">2004</option>
							<option value="2005">2005</option>
							<option value="2006">2006</option>
							<option value="2007">2007</option>
							<option value="2008">2008</option>
							<option value="2009">2009</option>
							<option value="2010">2010</option>
							<option value="2011">2011</option>
							<option value="2012">2012</option>
							<option value="2013">2013</option>
							<option value="2014">2014</option>
							<option value="2015">2015</option>
							<option value="2016">2016</option>
							<option value="2017">2017</option>
							
</select>							
							<span>년</span>
							 
 <select name="finddate2">
 
<option value="1" selected>1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
<option value="11">11</option>
<option value="12">12</option>
</select>


             <span>월</span>


<select name="finddate3">
 
 
<option value="1" selected>1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
<option value="11">11</option>
<option value="12">12</option>
<option value="13">13</option>
<option value="14">14</option>
<option value="15">15</option>
<option value="16">16</option>
<option value="17">17</option>
<option value="18">18</option>
<option value="19">19</option>
<option value="20">20</option>
<option value="21">21</option>
<option value="22">22</option>
<option value="23">23</option>
<option value="24">24</option>
<option value="25">25</option>
<option value="26">26</option>
<option value="27">27</option>
<option value="28">28</option>
<option value="29">29</option>
<option value="30">30</option>
<option value="31">31</option>

</select>

<span>일</span>



</td>
                        </tr>

<tr>
              <th>파일첨부</th>
   
               <td><input type="file" name="fileimg" /></td>
            </tr>
   


            <tr>
               <th>습득장소</th>
               <td><input type="text" id="findplace" name="findplace" class="long" /></td>
            </tr>

            <tr>
               <th>비고</th>
               <td><textarea name="note" class="long"
                     style="height: 200px;"></textarea></td>
            </tr>

            <!-- #133.   파일첨부 타입 추가하기
            <tr>
              <th>파일첨부</th>
               <td><input type="file" name="attach" /></td>
            </tr>
          -->

            <tr>
               <th>분실자명</th>
               <td><input type="text" name="lossname" class="long" /></td>
            </tr>


            <tr>
               <th>습득물명</th>
               <td><input type="text" id="article" name="article" class="long" /></td>
            </tr>


            <tr>
               <th>암호</th>
               <td><input type="password" id="writepw" name="writepw" class="short" /></td>
            </tr>
         </table>
         <br/><br/>

         <span style="margin-left: 720px; "><button type="button" onClick="goWrite();">쓰기</button></span>
         <span style="margin-left: 720px; "><button type="button" onClick="javascript:history.back();">취소</button></span>

   
 </form>
</div>
</div>