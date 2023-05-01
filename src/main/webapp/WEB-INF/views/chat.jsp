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

<div class="chat-wrap">

	<div class="chat-inner">
		<!-- 채팅 리스트 -->
		<div class="chat-list">
			<div class="chat-list-wrap">
				<!-- 사용자 프로필 -->
				<div class="profile-wrap">
					<c:if test="${!empty login.mem_upload_path}">
						<c:url var="url" value="/display?">
							<c:param name="file_name" value="${login.mem_upload_path}/s_${login.mem_uuid}_${login.mem_file_name}"/>
						</c:url>	
						<p><img class="profile_image" src="${url}"/><span>${login.mem_id}</span></p>
					</c:if>
					<c:if test="${empty login.mem_upload_path}">
						<p><img src="${contextPath}/resource/images/profile_i_02.png" alt="사용자 프로필 이미지"><span>${login.mem_id}</span></p>
					</c:if>
				</div>
				
				<!-- 대화 리스트 -->
				<c:forEach var="chatRoom" items="${chatList}">
					<div class="chatRoomList">
						<c:if test="${!empty chatRoom.opp_upload_path}">
							<c:url var="url" value="/display?">
							<c:param name="file_name" value="${chatRoom.opp_upload_path}/s_${chatRoom.opp_uuid}_${chatRoom.opp_file_name}"/>
							</c:url>	
							<p><img class="profile_image" src="${url}"/></p>
						</c:if>
						<c:if test="${empty chatRoom.opp_upload_path}">
							<p><img src="${contextPath}/resource/images/profile_i_02.png" alt="사용자 프로필 이미지"></p>				
						</c:if>
						<div>
							<c:if test="${login.mem_id eq chatRoom.buyer_mem_id}">
								<p>${chatRoom.seller_mem_id}</p>
							</c:if>
							<c:if test="${login.mem_id ne chatRoom.buyer_mem_id}">
								<p>${chatRoom.buyer_mem_id}</p>
							</c:if>
							<c:if test="${!empty chatRoom.recentChat}">
								<span>${chatRoom.recentChat}</span>
							</c:if>
							<c:if test="${chatRoom.unReadChat>0}">
								<span style="color:red; font-weight:bold;">${chatRoom.unReadChat}</span>
							</c:if>
						</div>
						<input type="hidden" value="${chatRoom.chat_room_no}"/>
					</div>
				</c:forEach>

			</div>
		</div>

		<!-- 채팅창 화면 -->
		<div class="chatting-wrap">
			
			<!-- 상품 정보 불러오는 곳 -->
			<div class="pro-info">
				<p><img src="${contextPath}/resource/images/chat_pro_thum.jpg" alt="상품 썸네일"></p>
				<div class="info-txt">
					
				</div>
			</div>
			
			<!-- chatHistory와 사용자가 실시간으로 입력하는 메시지 출력 -->
			<div id="content">
				<!-- 채팅창 설명 -->
				<div class="chat-info">
					<p>채팅을 통해 판매자와 소통할 수 있습니다. </p>
				</div>
			</div>

			<!-- 메시지 입력창, 보내기 버튼 -->
			<div class="message-wrap">
				<div class="input_group" id="sendMessage">
					<input type="text" id="message" class="form_control" placeholder="메세지를 입력해 주세요."/>	
					<div class="input_group_append">
						<button id="send" onclick="send()">전송</button>
						<input type="hidden" value="${login.mem_no}" id="senderNo"/>
						<input type="hidden" value="${login.mem_id}" id="senderId"/>
						<input type="hidden" id="chatRoomNo"/>
					</div>
				</div>
			</div>
		</div>
	</div>


<script src="${contextPath}/webjars/stomp-websocket/2.3.3-1/stomp.js" type="text/javascript"></script>
<script src="${contextPath}/webjars/sockjs-client/1.1.2/sockjs.js" type="text/javascript"></script>
<script src="${contextPath}/resource/js/pages/chat.js"></script>
