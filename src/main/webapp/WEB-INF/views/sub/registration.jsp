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
<div class="sub-inner">
	<h2>상품 등록</h2>

	<div class="info-box clearfix">
		<ul>
		  <li>아래 목록에서 내가 판매한 목록을 확인하실수 있습니다.</li>
		</ul>
	</div>	
  
	<form role="form" method="post" autocomplete="off">

		<div class="agree-wrap">
			<p><textarea cols="50" rows="10">여러분을 환영합니다.&#10; 다양한 네이버 서비스를 즐겨보세요. 회원으로 가입하시면 네이버 서비스를 보다 편리하게 이용할 수 있습니다.&#10; 여러분이 제공한 콘텐츠를 소중히 다룰 것입니다. 여러분의 개인정보를 소중히 보호합니다. 타인의 권리를 존중해 주세요. 네이버 서비스 이용과 관련하여 몇 가지 주의사항이 있습니다.&#10; 네이버에서 제공하는 다양한 포인트를 요긴하게 활용해 보세요. 부득이 서비스 이용을 제한할 경우 합리적인 절차를 준수합니다. 네이버의 잘못은 네이버가 책임집니다. 일부 네이버 서비스에는 광고가 포함되어 있습니다. 언제든지 네이버 서비스 이용계약을 해지하실 수 있습니다. 서비스 중단 또는 변경 시 꼭 알려드리겠습니다. 주요 사항을 잘 안내하고 여러분의 소중한 의견에 귀 기울이겠습니다. 여러분이 쉽게 알 수 있도록 약관 및 운영정책을 게시하며 사전 공지 후 개정합니다.</textarea></p>
			<div class="checks">
				<input type="checkbox" id="agree">
				<label for="agree">개인정보처리방침에 동의합니다.</label>
			  </div>
		</div>

		<!-- 상품 정보 등록 테이블 -->
		<div class="input input-wrap">
			<table class="inputArea">
				<tr>
					<td width="15%"><label>상품테마</label></td>
					<td class="category1" name="pro_theme">
						<select name="thema">
							<option value="">상품의 테마를 선택해 주세요.</option>
							<option value="#슬기로운 자취 생활">#슬기로운 자취 생활</option>
							<option value="#사회초년생 추천 상품">#사회초년생 추천 상품</option>
							<option value="#나만의 싱글 라이프">#나만의 싱글 라이프</option>
							<option value="#N년차 자취생 꿀템">#N년차 자취생 꿀템</option>
						</select>
					</td>
				</tr>
				<tr>
					<td><label for="pro_infor">상품 정보</label></td>
					<td>
						<div class="pro-infor-wrap">
							<!-- 상품 테마 선택 -->
							<select name="thema">
								<option value="">상품 카테고리</option>
								<option value="에어프라이어">에어프라이어</option>
								<option value="전기포트">전기포트</option>
								<option value="전자렌지">전자렌지</option>
								<option value="토스트기">토스트기</option>
								<option value="헤어드라이기">헤어드라이기</option>
								<option value="공기청정기">공기청정기</option>
							</select>
							<!-- 제조사 선택 -->
							<select name="category">
								<option value="">제조사</option>
								<option value="422">422</option>
								<option value="아이닉">아이닉</option>
								<option value="윈드피아">윈드피아</option>
								<option value="LG전자">LG전자</option>
								<option value="삼성전자">삼성전자</option>
								<option value="유닉스">유닉스</option>
								<option value="바비리스">바비리스</option>
								<option value="드롱기">드롱기</option>
								<option value="테팔">테팔</option>
							</select>
							<!-- 상품 모델 -->
							<input type="text" id="pro_name" name="pro_name" />

						</div>
						

					</td>
				</tr>
				<tr>
					<td><label for="gdsName">이미지등록</label></td>
					<td>
						<div class="filebox"> 
							
							<input type="file" id="fileItem" name="uploadFile" multiple="multiple">
							<label for="gdsName">이미지 등록</label> 
							<input class="upload-name" value="파일선택">
						</div>
						
						<div id="uploadResult">
							<!-- 
								<div id = "result_card">
									<div class="imgDeleteBtn">x</div>
									<img src="/display?file_name=fried.jpg">
								</div>
							 -->
						</div>
						<p class="file-info"><span>등록 상품</span> - 상품이 정보가 제대로 등록되지 않은 경우 직접 선택이 가능합니다.</p>
						<div class="img-info">
							<p class="bold"><이미지 업로드 시 주의사항></p>
							<ul>
								<li>1. 이미지는 최대 4장까지 업로드 가능합니다.</li>
								<li>2. 상품의 정면을 정면을 등록해 주세요.</li>
								<li>3. 상품 이미지를 업로드 하시면 해당 상품에 대한 정보가 자동으로 등록됩니다.   </li>
								<li>4. 이미지 형식은 jpg, png, jfjf만 가능합니다(이미지 용량 1mb 이하)</li>
							</ul>
						</div>
					</td>
				</tr>
				<tr>
					<td><label for="seller_mem_no">회원정보</label></td>
					<td><input type="text" readonly="readonly" value="${login.mem_no}" name="seller_mem_no" /></td>
				</tr>
				<tr>
					<td><label for="buy_price">상품구매가격</label></td>
					<td><input type="text" id="pro_buy_price" name="pro_buy_price" /></td>
				</tr>
				<tr>
					<td><label for="buy_date">사용기간</label></td>
					<td><input type="text" id="buy_date" name="buy_date" /></td>
				</tr>
				<tr>
					<td><label for="sale_price">판매가격</label></td>
					<td><input type="text" id="pro_sale_price" name="pro_sale_price" /></td>
				</tr>
				<tr>
					<td><label for="pro_title">제목</label></td>
					<td><input type="text" id="pro_title" name="pro_title" /></td>
				</tr>
				<tr>
					<td><label for="pro_category">상품정보</label></td>
					<td><textarea rows="5" cols="50" id="pro_category" name="pro_category"></textarea></td>
				</tr>
				<tr>
					<td><label for="pro_content">판매자 설명</label></td>
					<td><textarea rows="5" cols="50" id="gdsDes" name="pro_content"></textarea></td>
				</tr>
			</table>

			
			<div class="inputArea btn mt70">
				<input type="submit" value="확인">
				<input type="button" id="cancelBtn" value="취소" onclick="location.href='/'">
			  </div>
		</div>

	</form>

</div>
<c:import url="${contextPath}/WEB-INF/views/inc/footer.jsp"/>

