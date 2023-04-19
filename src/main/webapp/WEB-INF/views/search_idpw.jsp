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

        <p class="mb30">회원정보에 등록되어 있는 정보를 입력해 주세요. </p>
        
        <!-- 폼 입력 -->
        <div class="tabcontent">
          <!-- tab01 아이디 찾기 -->
          <div id="tab01">
            <form action="/search_id" method="post">         
              <!-- 1. 이름 -->
              <div class="field"><input type="text" name="mem_name" placeholder="이름"></div>
              <!-- 2. 핸드폰 번호 -->
              <div class="field mt10"><input type="text" name="mem_phone" placeholder="휴대폰 번호(- 없이 입력)"></div>
              <!-- 아이디 찾기 버튼 -->
              <div class="btn mt50"><input type="submit" value="아이디 찾기"></div>
            </form>
          </div>

          <!-- tab02 비밀번호 찾기 -->
          <div id="tab02">
            <form action="/search_pwd" method="post">
              <!-- 1. 아이디 -->
              <div class="field"><input type="text" name="mem_id" placeholder="아이디"></div>
              <!-- 2. 핸드폰 번호 -->
              <div class="field mt10"><input type="text" name="mem_phone" placeholder="휴대폰 번호(- 없이 입력)"></div>
              <!-- 3. 이메일-->
              <div class="field mt10"><input type="text" name="mem_email"  placeholder="이메일"></div>
              <!-- 비밀번호 찾기 버튼 -->
              <div class="btn mt50"><input type="submit" value="비밀번호 찾기"></div>
            </form>

          </div>
        </div>
      </div><!--아이디/비밀번호 tab // -->
      
    </div>
</div>
                    


