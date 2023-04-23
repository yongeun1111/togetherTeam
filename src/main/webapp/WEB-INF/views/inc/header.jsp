<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<body>
<!-- #wrap -->
<div id="wrap">
	<!--header-->
	<header>
		<div class="container">
			<nav>
				<div class="nav-wrap">
					<h1>
						<a href="/">
							<img src="${contextPath}/resource/images/logo.png" alt="사이트 이름"><span class="ally-hidden">메인페이지 이동</span>
						</a>
					</h1>
					<div class="gnb-wrap">
						<ul class="gnb">
							<li><a href="/proList">중고 상품</a></li>
							<li><a href="/registration">상품 등록하기</a></li>
							<li><a href="/proSearch">상품 검색</a></li>
						</ul>
					</div>
					<ul class="util-menu">
						<c:if test="${empty login}">
							<li class="after"><a href="login">로그인</a></li>
							<li><a href="join">회원가입</a></li>
						</c:if>
						<c:if test="${!empty login}">
							<li class="after"><a href="chat">채팅리스트</a>
							<li class="after"><a href="mypage_memInfo">마이 페이지</a>
							<li><a href="logout">로그아웃</a></li>
						</c:if>
					</ul>
				</div>
			</nav>
		</div>
	</header>

	<!-- start :container-->
	<div id="container" class="">