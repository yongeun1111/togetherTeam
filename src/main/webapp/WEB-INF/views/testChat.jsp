<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<c:import url="${contextPath}/WEB-INF/views/inc/headerScript.jsp"/>
<c:import url="${contextPath}/WEB-INF/views/inc/header.jsp"/>

<link rel="stylesheet" href="${contextPath}/resource/css/pages/main.css">
<link rel="stylesheet" href="${contextPath}/resource/css/pages/main_media.css">
<script src="${contextPath}/resource/js/jquery/gsap.min.js"></script>
<script src="${contextPath}/resource/js/jquery/ScrollTrigger.min.js"></script>
<script src="${contextPath}/webjars/stomp-websocket/2.3.3-1/stomp.js"></script>
<script src="${contextPath}/webjars/sockjs-client/1.1.2/sockjs.js"></script>


<!-- #container -->
<div class="main">
	<h2>채팅 테스트</h2>
	<div class="title_text">
		<p>${pro.pro_title}</p>
		<p>${pro.pro_name}</p>
	</div>
	<div>
		<!-- chatHistory와 사용자가 실시간으로 입력하는 메시지 출력 -->
		<div>
			<c:forEach var="chatRoom" items="${chatHistory}"> 
				<p>
					<span id="chatRoomSenderID">${chatRoom.sender_id}</span>
					<span id="chatRoomContent">${chatRoom.content}</span>
					<span id="chatRoomSendTime">${chatRoom.sendTime}</span>
				</p>
			</c:forEach>
		</div>
		<!-- 메시지 입력창, 보내기 버튼 -->
		<div>
			<div class="input_group" id="sendMessage">
				<input type="text" id="message" class="form_control" placeholder="입력입력"/>	
				<div class="input_group_append">
					<button id="send" onclick="send()">보내기</button>
					<input type="hidden" value="${login.mem_no}" id="sender_no"/>
					<input type="hidden" value="${login.mem_id}" id="sender_id"/>
					<input type="hidden" value="${chatRoomInfo.chat_room_no}" id="chat_room_no"/>
					<input type="hidden" value="${chatRoomInfo.pro_no}" id="pro_no"/>
					<input type="hidden" value="${chatRoomInfo.buyer_mem_no}" id="buyer_mem_no"/>
					<input type="hidden" value="${chatRoomInfo.seller_mem_no}" id="seller_mem_no"/>
				</div>
			</div>
		</div>
	</div>
	
</div>



<script type="text/javascript">
	
	var	stompClient = null;
	var chat_room_no = $("chat_room_no").val();
	var pro_no = $("#pro_no").val();
	var sender_no = $("#sender_no").val();
	var sender_id = $("#sender_id").val();
	var buyer_mem_no = $("#buyer_mem_no").val();
	var seller_mem_no = $("#seller_mem_no").val();
	
	
	$(document).ready(connect());
	// STOMP 설정 및 메시지 전송
	// url : /user 로 시작
	// send : /app 으로 시작
	// send를 통해 메시지를 전송하면 broker 중개를 거쳐서 유저에게 전달
	// 메시지를 다이렉트로 전달 받는 경로는 subscribe로 설정
	function connect() {
		// map URL using SockJS
		var socket = new SockJS('/broadcast');
		var url = '/user' + chat_room_no + '/queue/messages';
		console.log("url:",url)
		// webSocket 대신 SockJS를 사용
		// Stomp.client()가 아닌 Stomp.over()를 사용
		stompClient = Stomp.over(socket);
		
		// connect(header, connectCallback(연결 성공 메소드))
		stompClient.connect({}, function(){
			// url : 채팅방 참여자에게 공유 경로
			// callback(function())
			// 클라이언트가 서버(Controller broker)로부터 메시지를 수신했을 때 실행
			// (STOMP send()가 실행되었을 때)
			stompClient.subscribe(url, function(output){
				// JSP <body>에 append 할 메시지 내용
				console.log("broadcastMessage working");
				showBroadcastMessage(createTextNode(JSON.parse(output.body)));
				
			});	
			},
				// connect() 에러 발생 시 실행
				function(err){
				alert('error' + err);
			});
	};
	
	// WebSocket broker 경로로 JSON 타입 메시지 데이터를 전송
	function sendBroadcast(json) {
		stompClient.send("/app/broadcast", {}, JSON.stringify(json));
	}
	
	// 보내기 버튼 실행 메소드
	function send() {
		var content = $('#message').val();
		sendBroadcast({
			'chat_room_no':chat_room_no,
			'pro_no':pro_no,
			'sender_no':sender_no,
			'sender_id':sender_id,
			'buyer_mem_no':buyer_mem_no,
			'seller_mem_no':seller_mem_no
		});
		$("message").val("");
	}
	
	// 메시지 입력 창에서 Enter키가 보내기와 연동
	var inputMessage = document.getElementById("message");
	inputMessage.addEventListener("keyup", function enterSend(event){
		if (event.keyCode === null){
			event.preventDeault();
		}
		if (event.keyCode === 13){
			send();
		}
	});
	
	// 입력 메시지를 HTML 형태로 가공
	function createTextNode(messageObj) {
		console.log("createTextNode");
		console.log("messageObj: "+ messageObj.content);
		return "<p><div>" +
		messageObj.sender_id +
		"</div><div>" +
		messageObj.content +
		"</div><div>[" +
		messageObj.sendTime +
		"]</div></p>";
	}
	
	// HTML 형태의 메시지를 화면에 출력
	// 해당되는 id 태그의 모든 하위 내용들을 
	// message가 추가된 내용으로 갱신
	function showBroadcastMessage(message) {
		$("#content").html($("#content").html() + message);
	}
	
	function clearBoardcast() {
		$("#content").html("");
	}
	
</script>
<c:import url="${contextPath}/WEB-INF/views/inc/footer.jsp"/>
