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
<div class="login-wrap">
  <div class="center">

    <h2>비밀번호 변경</h2>
    <form class="login-form" action="" method="post">
        <div class="mb10"><input type="password" name="mem_pwd" placeholder="변경할 비밀번호"></div>
        <div><input type="password" name="mem_pwd" placeholder="변경할 비밀번호 재입력"></div>

        <div class="login-btn mt30">
          <input type="submit" value="변경 완료">
        </div>
    </form>

  </div>
</div>
       

