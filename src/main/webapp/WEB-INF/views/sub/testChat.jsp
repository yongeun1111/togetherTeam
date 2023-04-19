<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<c:import url="${contextPath}/WEB-INF/views/inc/headerScript.jsp"/>
<c:import url="${contextPath}/WEB-INF/views/inc/header.jsp"/>

<link rel="stylesheet" href="${contextPath}/resource/css/pages/main.css">
<link rel="stylesheet" href="${contextPath}/resource/css/pages/main_media.css">
<script src="${contextPath}/resource/js/jquery/gsap.min.js"></script>
<script src="${contextPath}/resource/js/jquery/ScrollTrigger.min.js"></script>


<!-- #container -->
<div class="main">
		<h2>채팅 테스트</h2>
		<p>${pro.pro_title}</p>
		<p>${pro.pro_name}</p>



</div>

<script src="/webjars/stomp-websocket/2.3.3-1/stomp.js" type="text/javascript"></script>
<script src="/webjars/sockjs-client/1.1.2/sockjs.js" type="text/javascript"></script>

<script type="text/javascript">
	
	var	stompClient = null;
	var buyer_id = $('#buyer_id').val();
	// STOMP 설정 및 메시지 전송
	// url : /user 로 시작
	// send : /app 으로 시작
	// send를 통해 메시지를 전송하면 broker 중개를 거쳐서 유저에게 전달
	// 메시지를 다이렉트로 전달 받는 경로는 subscribe로 설정
	function connect() {
		var socket = new SockJS('/boadcast');
		var url = '/user' + id + '/queue/messages';
		stompClient = stomp.over(socket);
		
		stompClient.connect({}, function(){
			stomClient.subscribe(url, function(output){
				console.log("broadcastMessage working");
				showBroadcastMessage(createTextNode(JSON.parse(output.body)));
				
			});	
				//setConnected(true);
			},
				function(err){
				alert('error' + err);
			});
	};
	
	function sendBroadcast(json) {
		stompClient.send("/app/broadcast", {}, JSON.stringify(json));
	}
</script>
<c:import url="${contextPath}/WEB-INF/views/inc/footer.jsp"/>
