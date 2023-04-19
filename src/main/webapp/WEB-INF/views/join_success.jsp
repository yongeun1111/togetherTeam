<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<c:import url="inc/headerScript.jsp"/>
<c:import url="inc/header.jsp"/>

<link rel="stylesheet" href="${contextPath}/resource/css/pages/main.css">
<link rel="stylesheet" href="${contextPath}/resource/css/pages/main_media.css">
<link rel="stylesheet" href="${contextPath}/resource/css/pages/sub.css">

<script src="${contextPath}/resource/js/jquery/gsap.min.js"></script>
<script src="${contextPath}/resource/js/jquery/ScrollTrigger.min.js"></script>
<script src="${contextPath}/resource/js/pages/main.js"></script>

<!-- #container -->
<div class="join-wrap">
    <div class="join-suc-wrap center">

        <h2>회원가입 완료</h2>

        <p class="check-img"><img src="${contextPath}/resource/images/check_icon.png" alt=""></p>

        <div class="suc-info mt30">
            <p>ghy0302님 환영합니다!</p>
            <p>LOGO 회원가입이 정상적으로 처리되었습니다.</p>
            <div class="btn mt30"><a href="/">메인으로 이동</a></div>
        </div>

    </div>
</div>
                    


