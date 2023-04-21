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
<div class="main">
	<h2>상품 등록</h2>

	<div class="info-box clearfix">
		<ul>
		  <li>아래 목록에서 내가 판매한 목록을 확인하실수 있습니다.</li>
		</ul>
	</div>

	<div class="agree-wrap">
		<p><textarea cols="50" rows="10">여러분을 환영합니다.&#10; 다양한 네이버 서비스를 즐겨보세요. 회원으로 가입하시면 네이버 서비스를 보다 편리하게 이용할 수 있습니다.&#10; 여러분이 제공한 콘텐츠를 소중히 다룰 것입니다. 여러분의 개인정보를 소중히 보호합니다. 타인의 권리를 존중해 주세요. 네이버 서비스 이용과 관련하여 몇 가지 주의사항이 있습니다.&#10; 네이버에서 제공하는 다양한 포인트를 요긴하게 활용해 보세요. 부득이 서비스 이용을 제한할 경우 합리적인 절차를 준수합니다. 네이버의 잘못은 네이버가 책임집니다. 일부 네이버 서비스에는 광고가 포함되어 있습니다. 언제든지 네이버 서비스 이용계약을 해지하실 수 있습니다. 서비스 중단 또는 변경 시 꼭 알려드리겠습니다. 주요 사항을 잘 안내하고 여러분의 소중한 의견에 귀 기울이겠습니다. 여러분이 쉽게 알 수 있도록 약관 및 운영정책을 게시하며 사전 공지 후 개정합니다.</textarea></p>
		<input type="checkbox" id="agree" name="agree"><span></span>
		<div class="checks">
			<input type="checkbox" id="agree">
			<label for="agree">개인정보처리방침에 동의합니다.</label>
		  </div>
	</div>
  

	<form role="form" method="post" autocomplete="off">

		<div class="inputArea">
			<label>상품테마</label>
			<select class="category1" name="pro_theme">
				<option value="all">전체</option>
			</select> 
		</div>

		<div class="inputArea">
			<label for="gdsName">이미지등록</label>
			<input type="file" id="fileItem" name="uploadFile" multiple="multiple" style="height: 30px;"/>
			<div id="uploadResult">
			<!-- 
				<div id = "result_card">
					<div class="imgDeleteBtn">x</div>
					<img src="/display?file_name=fried.jpg">
				</div>
			 -->
			</div>
		</div>
		
		<div class="inputArea">
			<label for="gdsName">이미지 추가 등록</label> <input type="text" id="gdsName"
				name="gdsName" />
		</div>
		
		<div class="inputArea">
			<label for="seller_mem_no">회원정보</label>
			<input type="text" readonly="readonly" value="${login.mem_no}" name="seller_mem_no" />
		</div>
		
		<div class="inputArea">
			<label for="pro_name">상품명</label>
			<input type="text" id="pro_name" name="pro_name" />
		</div>

		<div class="inputArea">
			<label for="buy_price">상품구매가격</label>
			<input type="text" id="pro_buy_price" name="pro_buy_price" />
		</div>

		<div class="inputArea">
			<label for="buy_date">사용기간</label>
			<input type="text" id="buy_date" name="buy_date" />
		</div>
		
		<div class="inputArea">
			<label for="sale_price">판매가격</label>
			<input type="text" id="pro_sale_price" name="pro_sale_price" />
		</div>
		
		<div class="inputArea">
			<label for="pro_title">제목</label>
			<input type="text" id="pro_title" name="pro_title" />
		</div>

		<div class="inputArea">
			<label for="pro_category">상품정보</label>
			<textarea rows="5" cols="50" id="pro_category" name="pro_category"></textarea>
		</div>
		
		<div class="inputArea">
			<label for="pro_content">판매자 설명</label>
			<textarea rows="5" cols="50" id="gdsDes" name="pro_content"></textarea>
		</div>

		<div class="inputArea">
			<button type="submit" id="register_Btn" class="btn btn-primary">등록</button>
		</div>

	</form>

</div>
<c:import url="${contextPath}/WEB-INF/views/inc/footer.jsp"/>
