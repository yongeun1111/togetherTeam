var	stompClient = null;
var senderId = $("#senderId").val();
var senderNo = $("#senderNo").val();
var hisList = "";
var infoList = "";
$(document).ready(function(){
	
	$(".chatRoomList").click(function(){
		var listToChat = $(this).find('input').val()
		$.ajax({
			url : "/getChatHistory",
			type : "post",
			data : {"chatRoomNo":listToChat, "senderNo":senderNo},
			dataType : "json",
			success : chatRoom,
			error : function(){ alert("error") }
		});
	})
	// 채팅화면이 나오면 바로 가장 최근 방 클릭 상태
	$(".chatRoomList:first").click(); 
});
	
	function chatRoom(data){
		
		if(stompClient != null){
			stompClient.disconnect();
		}
		proList = "";
		infoList = "";
		hisList = "";
		
		var chatRoomNo = data.chatRoomInfo.chat_room_no;
		var proTitle = data.productInfo.pro_title;
		var proSalePrice = data.productInfo.pro_sale_price;
		var fileCallPath = encodeURIComponent(data.productInfo.upload_path + "/s_" + data.productInfo.uuid + "_" + data.productInfo.file_name);
		
		proList += '<p><img style="width:58px; height:58px;" alt="상품 썸네일" src="/display?file_name=' + fileCallPath + '"></p>'
		proList += '<div class="info-txt"></div>'
		infoList += '<p>'+proTitle+'<p>'
		infoList += '<p>'+proSalePrice+'<span class="won">원</span></p>'
		$(".pro-info").html(proList);
		$(".info-txt").html(infoList);
		
		$("#chatRoomNo").val(chatRoomNo);
		
		// 채팅 히스토리
	    var tempHisDate="";
		$.each(data.chatHistory,function(index, obj){
			var contextPath = getContextPath();
			var chatHisId=obj.chat_mem_id;
	        var chatHisContent=obj.chat_content;
	        var chatHisDate=obj.chat_date;
	        var chatHisRead=obj.chat_read;
	        var fileCallPath = encodeURIComponent(obj.opp_upload_path + "/s_" + obj.opp_uuid + "_" + obj.opp_file_name);
	        var formattedDate = dateFormat(chatHisDate);
	        if (tempHisDate != formattedDate){
	        	hisList += '<div class="chat-info"><p>'+formattedDate+'</p></div>'
	        	tempHisDate = formattedDate
	        }
	        if (obj.chat_mem_id == senderId){
		      	// 내가 보낸 메세지
				hisList += '<div class="my-message-wrap">' + chatHisRead
				hisList += '<span class="send-time" id="MessageSendTime">' + chatHisDate.substring(11, 16) + '</span>'
		        hisList += '<div class="row alert alert-info my-message"><div class="col_8"><span id="MessageSenderID">' + '</span></div>'
		        hisList += '<div class="col_4 text-right"><span id="MessageContent">' + chatHisContent + '</span></div>' 
	    	    hisList += '</div></div></div>' 	
	        } else {
	        	// 상대방이 보낸 메세지
	        	if (obj.opp_upload_path != null){
	        		hisList += '<div class="your-message-wrap"><div class="chat-your-profile"><img class="profile_image" src="display?file_name='+fileCallPath+'"alt="사용자 프로필 이미지"><span id="MessageSenderID"/>'+ chatHisId +'</span></div>'
		        	hisList += '<div class="row alert alert-info your-message"><div class="col_8"></div>'
			        hisList += '<div class="col_4 text-right"><span id="MessageContent">' + chatHisContent + '</span></div>' 
		    	    hisList += '</div><span class="send-time" id="MessageSendTime">' + chatHisDate.substring(11, 16)+ '</span></div></div>'
	        		
	        	} else {
				// 상대편 프로필 이미지가 없을 경우	        		
					hisList += '<div class="your-message-wrap"><div class="chat-your-profile"><img src="'+contextPath+'/resource/images/profile_i_02.png" alt="사용자 프로필 이미지"><span id="MessageSenderID">'+ chatHisId +'</span></div>'
		        	hisList += '<div class="row alert alert-info your-message"><div class="col_8"></div>'
			        hisList += '<div class="col_4 text-right"><span id="MessageContent">' + chatHisContent + '</span></div>' 
		    	    hisList += '</div><span class="send-time" id="MessageSendTime">' + chatHisDate.substring(11, 16)+ '</span></div></div>'
	        	}
	        }})
			$("#content").html(hisList);
			connect(chatRoomNo);
			scrollDown();
		}
	// STOMP 설정 및 메시지 전송
	// url : /user 로 시작
	// send : /app 으로 시작
	// send를 통해 메시지를 전송하면 broker 중개를 거쳐서 유저에게 전달
	// 메시지를 다이렉트로 전달 받는 경로는 subscribe로 설정
	function connect(chatRoomNo) {
		// map URL using SockJS
		var socket = new SockJS('/broadcast');
		var url = '/user/' + chatRoomNo + '/queue/messages';
		// webSocket 대신 SockJS를 사용
		// Stomp.client()가 아닌 Stomp.over()를 사용
		stompClient = Stomp.over(socket);
		stompClient.debug = null
		// connect(header, connectCallback(연결 성공 메소드))
		stompClient.connect({"chatRoomNo":chatRoomNo}, function(){
			// url : 채팅방 참여자에게 공유 경로
			// callback(function())
			// 클라이언트가 서버(Controller broker)로부터 메시지를 수신했을 때 실행
			// (STOMP send()가 실행되었을 때)
			stompClient.subscribe(url, function(output){
				// JSP <body>에 append 할 메시지 내용
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
		console.log(messageObj)
		var fileCallPath = encodeURIComponent(messageObj.opp_upload_path + "/s_" + messageObj.opp_uuid + "_" + messageObj.opp_file_name);
		if (messageObj.chat_mem_id == senderId){
			// 내가 보낸 메세지
			return '<div class="my-message-wrap">' +
			messageObj.chat_read +
			'<span class="send-time" id="MessageSendTime">' + 
			 messageObj.chat_date.substring(11, 16) +
			'</span><div class="row alert alert-info my-message"><div class="col_8">' +
			'</div><div class="col_4 text-right">' +
			messageObj.chat_content +
			'</div></div>';
		} else {
			// 상대방이 보낸 메세지
			if (messageObj.opp_upload_path != null){
				// 상대방 프로필 이미지가 있을 경우
				return '<div class="your-message-wrap"><div class="chat-your-profile"><img class="profile_image" src="display?file_name='+fileCallPath+'" alt="사용자 프로필 이미지"/><span id="MessageSenderID">'+
				messageObj.chat_mem_id +
				'</span></div><div class="row alert alert-info your-message"><div class="col_8"></div><div class="col_4 text-right"><span id="MessageContent">'+
				messageObj.chat_content + 
				'</span></div></div><span class="send-time" id="MessageSendTime">'+
				messageObj.chat_date.substring(11, 16) +
				'</span></div></div>';				
			} else {
				// 상대방 프로필 이미지가 없을 경우
				return '<div class="your-message-wrap"><div class="chat-your-profile"><img src="${contextPath}/resource/images/profile_i_02.png" alt="사용자 프로필 이미지"><span id="MessageSenderID">'+
				messageObj.chat_mem_id +
				'</span></div><div class="row alert alert-info your-message"><div class="col_8"></div><div class="col_4 text-right"><span id="MessageContent">'+
				messageObj.chat_content + 
				'</span></div></div><span class="send-time" id="MessageSendTime">'+
				messageObj.chat_date.substring(11, 16) +
				'</span></div></div>';
			}
		}
	}
	
	// HTML 형태의 메시지를 화면에 출력
	// 해당되는 id 태그의 모든 하위 내용들을 
	// message가 추가된 내용으로 갱신
	function showBroadcastMessage(message) {
		$("#content").html($("#content").html() + message);
		scrollDown();
	}
	
	// 채팅방에 입장하거나 메시지를 수신받으면 스크롤 자동 최하단
	function scrollDown(){
		$('#content').scrollTop($('#content')[0].scrollHeight);
	}
	
	// 날짜 문자열 년, 월, 일 처리
	function dateFormat(date){
		var year = date.substr(0, 4)
		var month = date.substr(5, 2)
		var day = date.substr(8, 2)
		return year+"년 "+month+"월 "+day+"일"
	}
	
	// contextPath 구하기
	function getContextPath(){
		var hostIndex = location.href.indexOf(location.host)+location.host.length;
		var contextPath = location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
		return contextPath;
	}