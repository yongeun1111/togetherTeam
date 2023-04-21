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
<script type="text/javascript">
$(document).ready(function(){
    var searchBtn = $('.search-btn');

    // 검색 버튼 클릭시 데이터 처리하기
    searchBtn.click(function(){
    	
        var search = $(this).data('search'); // 누르는 버튼이 무엇인지 판단 : 아이디 / 비밀번호

        if (search == '아이디') {
        	
        var name = $('.search-name').val();
        var phone = $('.search-phone').val();
        	
        $.ajax({
            type: 'POST',
            url: '/search_id',
            data: {mem_name : name, mem_phone : phone},
            success: function(result){
            	    if(result.length > 0){
            	    var mem_ids = []; // mem_id 값을 담을 배열 변수
            	    $.each(result, function(idx, vo){
                        mem_ids.push(vo.mem_id); // 추출한 mem_id 값을 배열에 추가
                    });
            	    
            	    
					alert(mem_ids.join(', '));
            	    } else {
            	    alert('이름과 휴대폰번호를 정확히 입력해주세요.');
            	    }
            },
            error: function(){
                alert('데이터를 가져오는데 실패하였습니다.');
            }
        });
        
        } else {
        	
        var id = $('.search-id').val();
        var phone = $('.search-phone').val();
        var email = $('.search-email').val();

        $.ajax({
            type: 'POST',
            url: '/search_pwd',
            data: {mem_id : id, mem_phone : phone, mem_email : email},
            success: function(result){
                if(result.length > 0){
                	var mem_emails = []; // mem_email 값을 담을 배열 변수
            	    $.each(result, function(idx, vo){
                        mem_emails.push(vo.mem_email); // 추출한 mem_email 값을 배열에 추가
                    });
                    alert('등록되어진 주소로 이메일을 발송하였습니다.');
                } else {
                    alert('아이디와 휴대폰번호, 이메일을 정확히 입력해주세요.');
                }
            },
            error: function(){
                alert('데이터를 가져오는데 실패하였습니다.');
            }
        });
        	
        }
    });
});
</script>




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
              <div class="field"><input class="search-name" type="text" name="mem_name" placeholder="이름"></div>
              <!-- 2. 핸드폰 번호 -->
              <div class="field mt10"><input class="search-phone" type="text" name="mem_phone" placeholder="휴대폰 번호(- 없이 입력)"></div>
              <!-- 아이디 찾기 버튼 -->
              <div class="btn mt50"><input class="search-btn" data-search="아이디" type="reset" value="아이디 찾기"></div>
            </form>
          </div>

          <!-- tab02 비밀번호 찾기 -->
          <div id="tab02">
            <form action="/search_pwd" method="post">
              <!-- 1. 아이디 -->
              <div class="field"><input class="search-id" type="text" name="mem_id" placeholder="아이디"></div>
              <!-- 2. 핸드폰 번호 -->
              <div class="field mt10"><input class="search-phone" type="text" name="mem_phone" placeholder="휴대폰 번호(- 없이 입력)"></div>
              <!-- 3. 이메일-->
              <div class="field mt10"><input class="search-email" type="text" name="mem_email"  placeholder="이메일"></div>
              <!-- 비밀번호 찾기 버튼 -->
              <div class="btn mt50"><input class="search-btn" data-search="비밀번호" type="reset" value="비밀번호 찾기"></div>
            </form>

          </div>
        </div>
      </div><!--아이디/비밀번호 tab // -->
      
    </div>
</div>
                    


