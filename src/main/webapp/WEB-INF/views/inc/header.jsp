<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<script type="text/javascript">
	$(document).ready(function(){
		var memNo = $("#member").val()
		var unReadCount = "";
		if (memNo != null){

			$.ajax({
			      type: 'POST',
			      url: '/chatReadCount',
			      data: {"memNo":memNo},
			      dataType: 'json', 
			      success: function(res){
			    	  if (res>0){
			    		  unReadCount += '<span style="color: #007bff; font-weight:bold;">'+' 채팅리스트 </span>' + '<span style="display: inline-block; width: 20px; height: 20px; background-color:#007bff; color:#fff; font-size: 0.8rem;line-height: 22px; text-align: center; border-radius:50%; text-align-center;">' + res + '</sapn>' 
				    	  $("#chatList").html(unReadCount)	    		  
			    	  }
			      },
			   	  error: function(){
			   		  console.log("error")
			   	  }
			    });
		}
		
	})


</script>
<body>
<!-- #wrap -->
<div id="wrap">
	<!--header-->
	
	<header>
		<div class="top-banner">
			<img src="${contextPath}/resource/images/top_banner.jpg" alt="">
		</div>
		<div class="container">
			
			<nav>
				<div class="nav-wrap">
					<div class="logo-wrap">
						<h1 id="logo">
							<a href="/">
								<img src="${contextPath}/resource/images/logo.png" alt="사이트 이름"><span class="ally-hidden">메인페이지 이동</span>
							</a>
						</h1>
					</div>
					
					<div class="gnb-wrap">
						<ul class="gnb">
							<li><a href="/proList">중고 상품</a></li>
							<li><a href="/registration">상품 등록</a></li>
							<li><a href="/proSearch">상품 검색</a></li>
						</ul>
					</div>
					<ul class="util-menu">
						<c:if test="${empty login}">
							<li class="after"><a href="login">로그인</a></li>
							<li><a href="join">회원가입</a></li>
						</c:if>
						<c:if test="${!empty login}">
							<li class="after"><a id="chatList" href="chat">채팅리스트</a>
							<li class="after"><a href="mypage_memInfo">My 페이지</a>
							
								<!-- <li class="after"><a href="mypage_memInfo">
								<c:if test="${!empty login.mem_upload_path}">
									<c:url var="url" value="/display?">
										<c:param name="file_name" value="${login.mem_upload_path}/s_${login.mem_uuid}_${login.mem_file_name}"/>
									</c:url>
									<img style="width:35px; height:35px;" src="${url}"/>
								</c:if>
								<c:if test="${empty login.mem_upload_path}">
									<img style="width:35px; height:35px;" src="${contextPath}/resource/images/profile_i_01.png"/>
								</c:if>
								${login.mem_id}
								</a>
							</li>	 -->
							<li><a href="logout">로그아웃</a></li>
							<input id="member" type=hidden value="${login.mem_no}"/>
						</c:if>
					</ul>
				</div>
			</nav>
		</div>
	</header>

	<!-- start :container-->
	<div id="container">