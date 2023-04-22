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
        <li><a href="/mypage_memInfo">회원정보 수정</a></li>
        <li class="on"><a href="javascript:;">내가 찜한 목록</a></li>
        <li><a href="/mypage_proSale">판매 내역</a></li>
      </ul>
    </div>

    <div class="info-box clearfix">
      <ul>
        <li>아래 목록에서 내가 판매한 목록을 확인하실수 있습니다.</li>
        <li>찜한 상품을 삭제하고 싶으시면 삭제 버튼을 클릭해 주세요.</li>
      </ul>
    </div>

    <div class="meminfo-wrap">
      <p class="mypage-tit mb10">내가 찜한 목록</p>
      <form action="#">
        <table class="meminfo-table like-table">
          <tr>
            <td col="col" width="15%">
              <img src="${contextPath}/resource/images/thum_img.jpg" alt="">
            </td>
            <td>
              <ul class="pro-info">
                <li class="pro-cate">상품카테고리</li>
                <li class="pro-com">제조사</li>
              </ul>
              <p class="name">상품 판매 제목이 노출되는 영역입니다.</p>
            </td>
            <td col="col" width="15%">
              <p class="price">249,000 <span class="won">원</span></p>
            </td>
            <td col="col" width="18%">
              <button class="del-btn">삭제</button>
            </td>
          </tr>
          <tr>
            <td>
              <img src="${contextPath}/resource/images/thum_img.jpg" alt="">
            </td>
            <td>
              <ul class="pro-info">
                <li class="pro-cate">상품카테고리</li>
                <li class="pro-com">제조사</li>
              </ul>
              <p class="name">상품 판매 제목이 노출되는 영역입니다.</p>
            </td>
            <td>
              <p class="price">249,000 <span class="won">원</span></p>
            </td>
            <td>
              <button class="del-btn">삭제</button>
            </td>
          </tr>
          <tr>
            <td>
              <img src="${contextPath}/resource/images/thum_img.jpg" alt="">
            </td>
            <td>
              <ul class="pro-info">
                <li class="pro-cate">상품카테고리</li>
                <li class="pro-com">제조사</li>
              </ul>
              <p class="name">상품 판매 제목이 노출되는 영역입니다.</p>
            </td>
            <td>
              <p class="price">249,000 <span class="won">원</span></p>
            </td>
            <td>
              <button class="del-btn">삭제</button>
            </td>
          </tr>
          <tr>
            <td>
              <img src="${contextPath}/resource/images/thum_img.jpg" alt="">
            </td>
            <td>
              <ul class="pro-info">
                <li class="pro-cate">상품카테고리</li>
                <li class="pro-com">제조사</li>
              </ul>
              <p class="name">상품 판매 제목이 노출되는 영역입니다.</p>
            </td>
            <td>
              <p class="price">249,000 <span class="won">원</span></p>
            </td>
            <td>
              <button class="del-btn">삭제</button>
            </td>
          </tr>
          <tr>
            <td>
              <img src="${contextPath}/resource/images/thum_img.jpg" alt="">
            </td>
            <td>
              <ul class="pro-info">
                <li class="pro-cate">상품카테고리</li>
                <li class="pro-com">제조사</li>
              </ul>
              <p class="name">상품 판매 제목이 노출되는 영역입니다.</p>
            </td>
            <td>
              <p class="price">249,000 <span class="won">원</span></p>
            </td>
            <td>
              <button class="del-btn">삭제</button>
            </td>
          </tr>
        </table>

        <div class="page">
          <p>페이징 처리</p>
        </div>
  
      </form>
    </div>

  </div>
  
</div>

<c:import url="../inc/footer.jsp"/>

                    
