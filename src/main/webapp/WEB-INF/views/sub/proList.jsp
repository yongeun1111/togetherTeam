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
<script src="${contextPath}/resource/js/pages/main.js"></script>
<script type="text/javascript">
	



</script>

<!-- #container -->
<div class="main">
    상품 리스트 페이지
    <button class="proCategory">ALL</button>
    <button class="proCategory">에어프라이어</button>
    <button class="proCategory">전기포트</button>
    <button class="proCategory">전자레인지</button>
    <button class="proCategory">토스트기</button>
    <button class="proCategory">헤어드라이어</button>
    <button class="proCategory">공기청정기</button>
    </br>
	<c:forEach var="vo" items="${list}">
		<h1>${vo.pro_title}</h1>
		<p>${vo.pro_name}</p>
		<p>${vo.pro_content}</p>
		</br>
	</c:forEach>
</div>
<c:import url="${contextPath}/WEB-INF/views/inc/footer.jsp"/>
