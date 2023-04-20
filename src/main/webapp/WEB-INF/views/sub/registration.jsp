<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<c:import url="${contextPath}/WEB-INF/views/inc/headerScript.jsp"/>
<c:import url="${contextPath}/WEB-INF/views/inc/header.jsp"/>

<link rel="stylesheet" href="${contextPath}/resource/css/pages/main.css">
<link rel="stylesheet" href="${contextPath}/resource/css/pages/main_media.css">
<script src="${contextPath}/resource/js/jquery/gsap.min.js"></script>
<script src="${contextPath}/resource/js/jquery/ScrollTrigger.min.js"></script>
<script src="${contextPath}/resource/js/pages/sub.js"></script>

<style type="text/css">
	#result_card img{
		max-width: 100%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;	
	}
	#result_card {
		position: relative;
	}
	.imgDeleteBtn{
	    position: absolute;
	    top: 0;
	    right: 5%;
	    background-color: #ef7d7d;
	    color: wheat;
	    font-weight: 900;
	    width: 30px;
	    height: 30px;
	    border-radius: 50%;
	    line-height: 26px;
	    text-align: center;
	    border: none;
	    display: block;
	    cursor: pointer;	
	}
	
</style>

<!-- #container -->
<div class="main">
    상품 등록 페이지
	<h2>상품 등록</h2>
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
