<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!-- //code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/js/jquery-ui.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 
 

   
   
    <aside>
          <div id="sidebar"  class="nav-collapse ">
              <!-- sidebar menu start-->
              <ul class="sidebar-menu" id="nav-accordion">
              
                   <p class="centered"><a href="<%=request.getContextPath()%>/khxyyj.action"><img src="<%=request.getContextPath()%>/resources/images/khxlogo1.png" class="img-circle" width="60"></a></p>
                   <h5 class="centered">KHX 관리자페이지</h5>
                      
                  <li class="mt">
                      <a href="<%=request.getContextPath()%>/myorderchart.action">
                          <i class="fa fa-dashboard"></i>
                          <span style="font-size: 15px;">금월수익통계</span>
                      </a>
                  </li>

                  <li class="sub-menu">
                    <a href="<%=request.getContextPath()%>/plustrain.action">
                          <i class="fa fa-dashboard"></i>
                          <span style="font-size: 15px;">배차추가</span>
                      </a>
                     <!--  <ul class="sub">
                          <li><a  href="general.html">General</a></li>
                          <li><a  href="buttons.html">Buttons</a></li>
                          <li><a  href="panels.html">Panels</a></li>
                      </ul> -->
                  </li>

                  <li class="sub-menu">
                      <a href="<%=request.getContextPath()%>/allocation.action">
                          <i class="fa fa-cogs"></i>
                          <span style="font-size: 15px;">배차조정</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="calendar.html">Calendar</a></li>
                          <li><a  href="gallery.html">Gallery</a></li>
                          <li><a  href="todo_list.html">Todo List</a></li>
                      </ul>
                  </li>
                  <li class="sub-menu">
                    <a href="<%=request.getContextPath()%>/lossuseryyj.action">
                          <i class="fa fa-book"></i>
                          <span style="font-size: 15px;">유실물센터</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="blank.html">Blank Page</a></li>
                          <li><a  href="login.html">Login</a></li>
                          <li><a  href="lock_screen.html">Lock Screen</a></li>
                      </ul>
                  </li>
                  <li class="sub-menu">
                     <a href="<%=request.getContextPath()%>/alluserloss.action">
                          <i class="fa fa-tasks"></i>
                          <span style="font-size: 15px;">유실물센터(비회원확인)</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="form_component.html">Form Components</a></li>
                      </ul>
                  </li>
                  <li class="sub-menu">
                      <a href="<%=request.getContextPath()%>/adminuser.action">
                          <i class="fa fa-th"></i>
                          <span style="font-size: 15px;">회원관리</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="basic_table.html">Basic Table</a></li>
                          <li><a  href="responsive_table.html">Responsive Table</a></li>
                      </ul>
                  </li>
                  <li class="sub-menu">
                     <a href="<%=request.getContextPath()%>/screenlock.action">
                          <i class=" fa fa-bar-chart-o"></i>
                          <span style="font-size: 15px;">스크린Lock</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="morris.html">Morris</a></li>
                          <li><a  href="chartjs.html">Chartjs</a></li>
                      </ul>
                  </li>
                  
                                    <li class="sub-menu">
                     <a href="<%=request.getContextPath()%>/khx.action">
                          <i class=" fa fa-bar-chart-o"></i>
                          <span style="font-size: 15px;">일반페이지로</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="morris.html">Morris</a></li>
                          <li><a  href="chartjs.html">Chartjs</a></li>
                      </ul>
                  </li>
                  
                  
                  
    



              </ul>
              <!-- sidebar menu end-->
          </div>
      </aside>
      <!--sidebar end-->
   
   
   
   
   