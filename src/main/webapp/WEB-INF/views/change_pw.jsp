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

<script src="${contextPath}/resource/js/pages/main.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	function check_pw() {
	    var pw = $('#pw').val();
	    var pw2 = $('#pw2').val();
	    
	    $.ajax({
	      type: 'POST',
	      url: '/check_password',
	      data: { pw: pw, pw2: pw2 },
	      dataType: 'json', // 데이터 타입을 json으로 설정
	      success: function(data) {
	        if (data.result == 'success') {
	          $('#check').html('비밀번호가 일치합니다.');
	          $('#check').css('color', 'blue');
	        } else {
	          $('#check').html('비밀번호가 일치하지 않습니다.');
	          $('#check').css('color', 'red');
	        }

	        if (pw == "" && pw2 == ""){
	        	$('#check').html("")
	        }
	      }
	    });
	  }
	
	  $('#pw').on('keyup', check_pw);
	  $('#pw2').on('keyup', check_pw);	

	  
	  function checkForm() {
		  if ($('#check').html() == '비밀번호가 일치하지 않습니다.') {
		      alert("비밀번호가 일치하지 않습니다.");
		      $('#pw2').focus();
		      return 1;
		  } else if ($('#check').html() == ''){
			  return 2;
		  }
		  return 3;
		  }
		  
		  $('#submitBtn').on('click', function() {
			    if (checkForm() == 1) {
			    	event.preventDefault(); // 제출 버튼의 기본 동작인 페이지 새로고침을 막음
			    }
			});
	  
});

</script>

<!-- #container -->
<div class="login-wrap">
  <div class="center">

    <h2>비밀번호 변경</h2>
    <form class="login-form" action="/change_pwd" method="post">
    	<input type="hidden" name="mem_id" value="${mem_id}">
        <div class="mb10"><input id="pw" type="password" name="mem_pwd" placeholder="변경할 비밀번호" required></div>
        <div><input id="pw2" type="password" placeholder="변경할 비밀번호 재입력"></div>
        <div class=field><span id="check"></span></div>

        <div class="login-btn mt30">
          <input id="submitBtn" type="submit" value="변경 완료">
        </div>
    </form>

  </div>
</div>
       

