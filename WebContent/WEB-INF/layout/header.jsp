<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% response.setHeader("Pragma", "no-cache"); response.setHeader("Cache-Control", "no-cache"); response.setHeader("Cache-Control", "no-store"); response.setDateHeader("Expires", 0L); %>
<div class="card">
  <div class="card-body" style="width:1200px; margin:0 auto;display:flex; flex-direction:row; justify-content:space-between; height:100px; align-items: center;">
  	<h1><a href="main" onclick="$('.wrap-loading').removeClass('display-none');"><img src="images/ezv.png"></a><img src="images/ezv-mean.png" style="width:200px; height:40px; margin-top:30px;"></h1> <!-- 간단한 로고 ? 로고 클릭시 메인 이동 -->
	  <ul class="list-group" style="display:flex; flex-direction:row;  align-items:cetner;">
				<c:choose>
					<c:when test="${userid!=null}">
						<li class="list-group-item" ><a class="badge badge-light"
							href="logout.do">로그아웃</a></li>
					</c:when>
					<c:otherwise>
						<li class="list-group-item" ><a class="badge badge-light"
							href="login">로그인</a></li>
					</c:otherwise>
				</c:choose>
	  	<li class="list-group-item" ><a class="badge badge-light" href="join" onclick="$('.wrap-loading').removeClass('display-none');">회원가입</a></li>
	  	<li class="list-group-item" ><a class="badge badge-light" href="myPage?userid=${userid}" onclick="$('.wrap-loading').removeClass('display-none');">마이페이지</a></li>
	  	<li class="list-group-item" ><a class="badge badge-light" href="information" onclick="$('.wrap-loading').removeClass('display-none');">고객센터</a></li>
	  </ul>
  </div>
  <nav class="navbar navbar-expand-lg navbar-light" style="width:1200px; margin:0 auto;">
	 <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  	</button>
  	<div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="movieList" onclick="$('.wrap-loading').removeClass('display-none');">영화</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="movieTicket" onclick="$('.wrap-loading').removeClass('display-none');">예매하기</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="event" onclick="$('.wrap-loading').removeClass('display-none');">이벤트</a>
      </li>
       <li class="nav-item">
        <a class="nav-link" href="#" onclick="alert('미구현');">혜택</a>
      </li>
    </ul>
     <form class="form-inline my-2 my-lg-0" action="search.do" id="searchform">

      <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search" name="search" required="required" id="search"
      onkeypress="if(event.keyCode=='13'){event.preventDefault(); searchEvt();}">
      <button class="btn btn-outline-secondary my-2 my-sm-0" type="button" onclick="movieSearch()">Search</button>
    </form> 
  </div>
</nav>
</div>
<div class="wrap-loading display-none" style="z-index: 10000;"> <img src="images/loading.gif" alt="Loading..." style="border:0; position:fixed; left:45%; top:35%;"/></div>