<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<c:import url="${contextPath}/WEB-INF/views/inc/headerScript.jsp"/>
<c:import url="${contextPath}/WEB-INF/views/inc/header.jsp"/>

<link rel="stylesheet" href="${contextPath}/resource/css/pages/sub.css">
<link rel="stylesheet" href="${contextPath}/resource/css/pages/sub_media.css">
<script src="${contextPath}/resource/js/jquery/gsap.min.js"></script>
<script src="${contextPath}/resource/js/jquery/ScrollTrigger.min.js"></script>
<script src="${contextPath}/resource/js/pages/sub.js"></script>

<!-- #container -->
<div class="container mypage-wrap">

  <div class="">
    <h2 class="center">마이페이지</h2>
    <ul class="tab-menu">
      <li><a href="#">회원정보 수정</a></li>
      <li><a href="#">내가 찜한 목록</a></li>
      <li><a href="#">판매 내역</a></li>
    </ul>

    <div class="info-box">
      <ul>
        <li>LOGO에 가입해 주신 회원님의 개인정보는 소중히 보관되며, 회원님의 동의없이는 기재하신 회원정보가 공개되지 않습니다.</li>
        <li>보다 다양한 서비스를 받으시려면 정확한 정보를 입력해야 합니다.</li>
      </ul>
    </div>

    <div class="meminfo-wrap">
      <p>※ 변경하시려는 정보를 입력해 주세요.</p>
      <form action="">
        <table class="meminfo-table">
          <tr>
            <td col="col" width="10%">아이디</td>
            <td>abc1234</td>
          </tr>
          <tr>
            <td>이름</td>
            <td>홍길동</td>
          </tr>
          <tr>
            <td>비밀번호</td>
            <td><input type="password" name="mem_pwd" required placeholder="비밀번호"></td>
          </tr>
          <tr>
            <td>비밀번호 재입력</td>
            <td><input type="password" name="mem_pwd" required placeholder="비밀번호 재입력"></td>
          </tr>
          <tr>
            <td>휴대폰 번호</td>
            <td><input type="text" name="mem_phone" required placeholder="핸드폰 번호(띄어쓰기 없이 숫자만 입력해주세요 / 예시:01012345678)"></td>
          </tr>
          <tr>
            <td>이메일</td>
            <td><input type="text" name="mem_email" required placeholder="이메일을 입력해주세요 (예시:abc@abc.com)"></td>
          </tr>
        </table>

        <div class="btn">
          <input type="submit" value="확인">
          <input type="button" id="cancelBtn" value="취소" onClick="location.href='/'">
        </div>
  
      </form>
    </div>

  </div>
  
</div>
                    
