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
<script src="${contextPath}/resource/js/jquery/gsap.min.js"></script>
<script src="${contextPath}/resource/js/jquery/ScrollTrigger.min.js"></script>
<script src="${contextPath}/resource/js/pages/main.js"></script>


<!-- #container -->
<div class="con-inner">

  <!-- main visual -->
 	<h1>테스트</h1>
 	<h2>${vo.pro_no}</h2>
 	<h2>${vo.pro_name}</h2>
 	<h2>${vo.seller_mem_no}</h2>
 	<h2>${vo.mem_id}</h2>
 	
 	<div class="buy_chat">
		<form:form id="chatSubmit_form" action="/chatMessage" method="GET" modelAttribute="chatRoom">
			<a href="javascript:{}" onclick="chatSubmit()">
				<form:input type="hidden" path="seller_mem_no" value="${vo.seller_mem_no}"/>
				<form:input type="hidden" path="seller_mem_id" value="${vo.mem_id}"/>
				<form:input type="hidden" path="pro_no" value="${vo.pro_no}"/>
				<form:input type="hidden" path="pro_title" value="${vo.pro_title}"/>
				<button id="btn_chat">
					판매자 문의
				</button>
			</a>
		</form:form>
		</div>

</div>

<script type="text/javascript">
		
	 	function chatSubmit() {
	 		document.getElementById('chatSubmit_form').submit();
	 	} 
</script>


<c:import url="inc/footer.jsp"/>
