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
<div class="common-wrap">
    <div class="center">

      <h2>아이디/비밀번호 찾기</h2>

      <div class="tab search_idpw">
        <ul class="tabnav">
          <li><a href="#tab01">아이디 찾기</a></li>
          <li><a href="#tab02">비밀번호 찾기</a></li>
        </ul>
        <div class="tabcontent">
          <div id="tab01">
            <form action="/search_id" method="post">
              
              <!-- 1. 이름 -->
              <div class="field"><input type="text" name="mem_name"></div>

              <!-- 2. 핸드폰 번호 -->
              <div class="field mt10"><input type="text" name="mem_phone"></div>
              
              <!-- 아이디 찾기 버튼 -->
              <div class="btn mt50"><input type="submit" value="아이디 찾기"></div>
            
            </form>
          </div>
          <div id="tab02">
            <form action="/search_id" method="post">
              <input type="text" name="mem_name"><br>
              <input type="text" name="mem_phone"><br>
              <input type="submit" value="비밀번호 찾기"><br>
            </form>

          </div>

        </div>
      </div><!--tab-->
      

    </div>

    
</div>
                    


