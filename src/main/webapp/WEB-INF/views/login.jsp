<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<c:import url="${contextPath}/WEB-INF/views/inc/headerScript.jsp"/>
<c:import url="${contextPath}/WEB-INF/views/inc/header.jsp"/>

<link rel="stylesheet" href="${contextPath}/resource/css/com/common.css">
<link rel="stylesheet" href="${contextPath}/resource/css/pages/sub.css">
<link rel="stylesheet" href="${contextPath}/resource/css/pages/sub_media.css">
<script src="${contextPath}/resource/js/jquery/gsap.min.js"></script>
<script src="${contextPath}/resource/js/jquery/ScrollTrigger.min.js"></script>
<script src="${contextPath}/resource/js/pages/sub.js"></script>
<script src="${contextPath}/resource/js/com/common.js"></script>

<!-- #container -->
<div class="fix-wrap">
  <div class="container">
    <div class="login-wrap">
      <h2>로그인</h2>
     
        <form class="login-form" action="/login" method="post">
        <div class="mb10"><input type="text" name="mem_id" placeholder="아이디"></div>
        <div><input type="password" name="mem_pwd" placeholder="비밀번호"></div>
        <c:if test="${!empty error}">
          <span>${error}</span>
        </c:if>
        <div>
          <ul class="mt20">
            <li>
                <a href="/join">회원가입</a>
            </li>
            <li>
                <a href="/search_idpw">아이디 찾기</a>
            </li>
            <li>
                <a href="/search_idpw">비밀번호 찾기</a>
            </li>
          </ul>
        </div>
    
        <div class="login-btn mt30">
          <input type="submit" value="로그인">
        </div>
      </form>
  
      
  
    </div>
  
</div>



