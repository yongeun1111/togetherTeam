<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<c:import url="inc/headerScript.jsp"/>
<c:import url="inc/header.jsp"/>

<link rel="stylesheet" href="${contextPath}/resource/css/pages/main.css">
<link rel="stylesheet" href="${contextPath}/resource/css/pages/main_media.css">
<link rel="stylesheet" href="${contextPath}/resource/css/pages/chat.css">

<script src="${contextPath}/resource/js/jquery/gsap.min.js"></script>
<script src="${contextPath}/resource/js/jquery/ScrollTrigger.min.js"></script>
<script src="${contextPath}/resource/js/pages/main.js"></script>

<div class="chat-main">


	<form action="listToChat" method="get">
		<c:forEach var="chat" items="${chatList}">
			<h3>${chat.chat_room_no}</h3>
			<h5>${chat.pro_no}</h5>
			</br>
			<button class="sendChatRoomNo">채팅입장</button>
			<input type="hidden" value="${chat.chat_room_no}" name="chatRoomNo"/>
			<input type="hidden" value="${chat.pro_title}" name="proTitle"/>
		</c:forEach>
	</form>