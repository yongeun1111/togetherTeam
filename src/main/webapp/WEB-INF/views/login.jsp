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
<div class="container center">
  <h2>로그인</h2>
    <form class="login-form" action="/login" method="post">
      <p class="mb10"><input type="text" name="id" placeholder="아이디"></p>
      <p><input type="password" name="pwd" placeholder="비밀번호"></p>

      <ul>
        <li><a href="/join">회원가입</a></li>
        <li><a href="/findInfo">비밀번호찾기</a></li>
      </ul>

      <div class="login-btn">
        <input type="submit" value="로그인">
      </div>
    </form>

</div>

<c:import url="inc/footer.jsp"/>
