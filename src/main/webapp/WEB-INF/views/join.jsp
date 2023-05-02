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

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
  
 
  // 아이디 입력 필드에서 키보드 입력 시 중복 아이디 검사 수행
  $('#id').on('keyup', function() {
    check_id();
  });
  
  // 중복 아이디 검사 함수
  function check_id() {
    var id = $('#id').val();
    
    $.ajax({
      type: 'POST',
      url: '/check_id',
      data: { id : id },
      dataType: 'json',
      success: function(data) {
        if (data.result == 'success') {
          $('#check_id').html('사용가능한 아이디입니다.');
          $('#check_id').css('color', 'blue');
        } else {
          $('#check_id').html('이미 사용중인 아이디입니다.');
          $('#check_id').css('color', 'red');
        }

        if (id == ""){
          $('#check_id').html("");
        }
      }
    });
  }
  
  
  function checkForm() {
  if ($('#check_id').html() != '사용가능한 아이디입니다.') {
      alert("아이디 중복확인을 해주세요.");
      $('#id').focus();
      return false;
    } 
  if ($('#check').html() != '비밀번호가 일치합니다.') {
      alert("비밀번호가 일치하지 않습니다.");
      $('#pw2').focus();
      return false;
    }
  return true;
  }
  
  $('#submitBtn').on('click', function() {
	    if (checkForm() == false) {
	    	event.preventDefault(); // 제출 버튼의 기본 동작인 페이지 새로고침을 막음
	    }
	});
  
});
</script>

<!-- #container -->
<div class="container join-wrap">

  <div class="con-wrap center">
    <h2>회원가입</h2>
    <form class="join-form" action="/join" method="post" required>
      <!-- 프로필 이미지 -->
      <div class="field">

		<div class="filebox"> 
			<label>
				<input class="file_real" id="fileItem" name="uploadFile" multiple="multiple" type="file" accept="image/jpg, image/png, image/gif" />
				<input class="file_fake" type="text" placeholder="프로필 이미지 등록 *.jpg/png/gif Only" readonly tabindex="-1" />
				<input type="button" class="button" value="파일 찾기" />
			</label>

			<script>
				$('.file_real').on('change', function() {
					var files = $(this)[0].files[0];
					var fake = $('.file_fake');
					
					fake.val('');
					if ( files !== undefined ) {
						fake.val(files.name);
					}
				});
			</script>
		</div>
		<p class="join-txt">프로필 이미지 등록이 없으면 기본 프로필 이미지로 등록됩니다.</p>
		<div id="uploadResult">
			<!-- 
				<div id = "result_card">
					<div class="imgDeleteBtn">x</div>
					<img src="/display?file_name=fried.jpg">
				</div>
			 -->
		</div>
		<div class="img-info">
		</div>

      
      </div>
      <!-- 1. 아이디 -->
      <div class="field">
        <p><input id="id" type="text" name="mem_id" required placeholder="아이디"></p>
        <p class="join-txt">사용할 아이디를 입력해 주세요.</p>
      </div>

      <div class="field">
        <p><span id="check_id"></span></p>
      </div>
      
      <!-- 2. 비밀번호 -->
      <div class="field">
        <p><input id="pw" type="password" name="mem_pwd" required placeholder="비밀번호"></p>
        <p class="join-txt">사용할 비밀번호를 입력해 주세요.</p>
      </div>

      <!-- 3. 비밀번호 재확인 -->
      <div class="field">
        <p><input id="pw2" type="password" name="mem_pwd_confirm" required placeholder="비밀번호 확인"></p>
      </div>
      
      <div class="field">
        <p><span id="check"></span></p>
      </div>
      
      <!-- 4. 이름 -->
      <div class="field">
        <p><input type="text" name="mem_name" required placeholder="이름"></p>
      </div>

      <!-- 5. 핸드폰 -->
      <div class="field">
        <p><input type="text" name="mem_phone" required placeholder="핸드폰 번호(띄어쓰기 없이 숫자만 입력해주세요 / 예시:01012345678)"></p>
      </div>

      <!-- 6. 생년월일 -->
      <div class="field">
        <p><input type="text" name="mem_birth" required placeholder="생년월일을 입력해주세요 (예시:19950102)"></p>
      </div>
      
      <!-- 7. 메일주소 -->
      <div class="field">
        <p><input type="text" name="mem_email" required placeholder="이메일을 입력해주세요 (예시:abc@abc.com)"></p>
      </div>

      <div class="join-btn mt40">
        <input id="submitBtn" type="submit" value="회원가입">
      </div>

    </form>
      
  </div>
  

</div>
                    
