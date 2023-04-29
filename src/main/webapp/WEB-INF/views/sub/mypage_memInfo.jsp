<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<c:import url="${contextPath}/WEB-INF/views/inc/headerScript.jsp"/>
<c:import url="${contextPath}/WEB-INF/views/inc/header.jsp"/>

<link rel="stylesheet" href="${contextPath}/resource/css/com/style.css">
<link rel="stylesheet" href="${contextPath}/resource/css/pages/sub.css">
<link rel="stylesheet" href="${contextPath}/resource/css/pages/sub_media.css">
<script src="${contextPath}/resource/js/jquery/gsap.min.js"></script>
<script src="${contextPath}/resource/js/jquery/ScrollTrigger.min.js"></script>
<script src="${contextPath}/resource/js/pages/sub.js"></script>

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
			    } else if (checkForm() == 2) {
			    	$('#pw').preventDefault();
			    }
			});
	  
});
</script>


<!-- #container -->
<div class="con-inner mypage-wrap">

  <div class="sub-inner">
    <h2 class="center">마이페이지</h2>
    <div class="tab-wrap">
      <ul class="tab-menu">
        <li class="on"><a href="#">회원정보 수정</a></li>
        <li><a href="/mypage_likeList">내가 찜한 목록</a></li>
        <li><a href="/mypage_proSale">판매 내역</a></li>
      </ul>
    </div>

    <div class="info-box clearfix">
      <ul>
        <li>LOGO에 가입해 주신 회원님의 개인정보는 소중히 보관되며, 회원님의 동의없이는 기재하신 회원정보가 공개되지 않습니다.</li>
        <li>보다 다양한 서비스를 받으시려면 정확한 정보를 입력해야 합니다.</li>
      </ul>
    </div>

    <div class="meminfo-wrap">
      <p class="mb10">※ 변경하시려는 정보를 입력해 주세요.</p>
      <form action="/change_info" method="post">
        <input type="hidden" name="mem_id" value="${login.mem_id}">
        <table class="meminfo-table">
          <tr>
            <td col="col" width="13%">아이디</td>
            <td>${login.mem_id}</td>
          </tr>
          <tr>
            <td>이름</td>
            <td>${login.mem_name}</td>
          </tr>
          <tr>
            <td>비밀번호</td>
            <td>
              <input id="pw" type="password" name="mem_pwd" placeholder="변경할 비밀번호를 입력해 주세요. ">
              <p class="pw_txt">영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자</p>
            </td>
          </tr>
          <tr>
            <td>비밀번호 재입력</td>
            <td>
            <input id="pw2" type="password" placeholder="변경할 비밀번호를 다시 한번  입력해 주세요. "><br>
            <span id="check"></span>
            </td>
          </tr>
          <tr>
            <td>휴대폰 번호</td>
            <td><input type="text" name="mem_phone" required value="${login.mem_phone}"></td>
          </tr>
          <tr>
            <td>이메일</td>
            <td><input type="text" name="mem_email" required value="${login.mem_email}"></td>
          </tr>
        </table>

        <div class="btn mt70">
          <input id="submitBtn" type="submit" value="확인">
          <input type="button" id="cancelBtn" value="취소" onClick="location.href='/'">
        </div>
  
      </form>
    </div>

  </div>
  
</div>

<c:import url="../inc/footer.jsp"/>

                    
