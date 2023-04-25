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
					<p><img src="${contextPath}/resource/images/profile_i_01.png" alt="사용자 프로필 이미지"> <span>ghy0302</span></p>
				</div>
				<!-- 대화 리스트 -->
				<c:forEach var="chatList" items="${chatList}">
					<div class="chatRoomList">
						<p><img src="${contextPath}/resource/images/profile_i_02.png" alt="사용자 프로필 이미지"></p>
						<div>
							<p>${chatList.chat_room_no}</p>
							<p>${chatList.pro_no}</p>
						</div>
						<input type="hidden" value="${chatList.chat_room_no}"/>
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
					<p>상품 판매 제목 영역입니다.</p>
					<p>60,000 <span class="won">원</span></p>
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


</div>

<script src="${contextPath}/webjars/stomp-websocket/2.3.3-1/stomp.js" type="text/javascript"></script>
<script src="${contextPath}/webjars/sockjs-client/1.1.2/sockjs.js" type="text/javascript"></script>

<script type="text/javascript">	
	var	stompClient = null;
	var senderId = $("#senderId").val();
	var senderNo = $("#senderNo").val();
	var hisList = "";
	
	$(document).ready(function(){
		
		$(".chatRoomList").click(function(){
			var listToChat = $(this).find('input').val()
			$.ajax({
				url : "/getChatHistory",
				type : "post",
				data : {"chatRoomNo" : listToChat},
				dataType : "json",
				success : chatRoom,
				error : function(){ alert("error") }
			});
		})
	})
	
	function chatRoom(data){
		
		stompClient = null;
		console.log(data);
		
		var chatRoomNo = data.chatRoomInfo.chat_room_no;
		var proTitle = data.productInfo.pro_title;
		var proSalePrice = data.productInfo.pro_sale_price;
		
		$("#chatRoomNo").val(chatRoomNo);
		$.each(data.chatHistory,function(index, obj){
			var chatHisId=obj.chat_mem_id;
	        var chatHisContent=obj.chat_content;
	        var chatHisDate=obj.chat_date;
	        hisList += '<p><div class="row alert alert-info"><div class="col_8"><span id="MessageSenderID">'+ chatHisId + '</span></div>'
	        hisList += '<div class="col_4 text-right"><span id="MessageContent">' + chatHisContent + '</span></div>' 
	        hisList += '<span id="MessageSendTime">[' + chatHisDate.substring(11, 16) + ']</span></div></div></p>' 
		})
			$("#content").html(hisList);
		connect(chatRoomNo);
	}
	// STOMP 설정 및 메시지 전송
	// url : /user 로 시작
	// send : /app 으로 시작
	// send를 통해 메시지를 전송하면 broker 중개를 거쳐서 유저에게 전달
	// 메시지를 다이렉트로 전달 받는 경로는 subscribe로 설정
	function connect(chatRoomNo) {
		// map URL using SockJS
		console.log("connected");
		var socket = new SockJS('/broadcast');
		var url = '/user/' + chatRoomNo + '/queue/messages';
		console.log("url:",url)
		// webSocket 대신 SockJS를 사용
		// Stomp.client()가 아닌 Stomp.over()를 사용
		stompClient = Stomp.over(socket);
		
		// connect(header, connectCallback(연결 성공 메소드))
		stompClient.connect({}, function(){
			
			console.log("connected STOMP")
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
		console.log("sendBoradcast 성공")
		stompClient.send("/app/broadcast", {}, JSON.stringify(json));
	}
	
	// 보내기 버튼 실행 메소드
	function send() {
		var content = $('#message').val();
		var chatRoomNo= $('#chatRoomNo').val();
		var tempChatRoomNo = Number(chatRoomNo);
		sendBroadcast({
			'chat_room_no':tempChatRoomNo,
			'chat_mem_no':senderNo,
			'chat_mem_id':senderId,
			'chat_content':content,
		});
		$("#message").val("");
	}
	
	// 메시지 입력 창에서 Enter키가 보내기와 연동
	var inputMessage = document.getElementById("message");
	inputMessage.addEventListener("keyup", function enterSend(event){
		if (event.keyCode === null){
			event.preventDeault();
		}
		if (event.keyCode === 13){
			send();
			$("#message").val("");
		}
	});
	
	// 입력 메시지를 HTML 형태로 가공
	function createTextNode(messageObj) {
		console.log("createTextNode");
		console.log("messageObj: "+ messageObj.chat_content);
		return '<p><div class="row alert alert-info"><div class="col_8">' +
		messageObj.chat_mem_id +
		'</div><div class="col_4 text-right">' +
		messageObj.chat_content +
		"</div><div>[" +
		messageObj.chat_date.substring(11, 16) +
		"]</div></p>";
	}
	
	// HTML 형태의 메시지를 화면에 출력
	// 해당되는 id 태그의 모든 하위 내용들을 
	// message가 추가된 내용으로 갱신
	function showBroadcastMessage(message) {
		$("#content").html($("#content").html() + message);
	}
	
	function clearBoardcast() {
		$("#content").val("");
	}

		
		
		
	</script>

