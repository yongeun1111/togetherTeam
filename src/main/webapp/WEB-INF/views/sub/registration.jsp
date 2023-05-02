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

<script>
$(document).ready(function(){
	
	// 확인 버튼 활성화
	$("#agree").change(function(){
		if($("#agree").is(":checked")==true){
			$('#register_Btn').prop('disabled', false);
		}else{
			$('#register_Btn').prop('disabled', true);
		}
	})

});
</script>

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
					<td width="15%"><label>상품 테마</label></td>
					<td class="category1">
						<select name="pro_theme">
							<option value="">상품의 테마를 선택해 주세요.</option>
							<option value="#슬기로운 자취 생활">#슬기로운 자취 생활</option>
							<option value="#사회초년생 추천 상품">#사회초년생 추천 상품</option>
							<option value="#나만의 싱글 라이프">#나만의 싱글 라이프</option>
							<option value="#N년차 자취생 꿀템">#N년차 자취생 꿀템</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<td><label for="gdsName">이미지 등록</label></td>
					<td>
						<div class="filebox"> 
							
							<label>
								<input class="file_real" id="fileItem" name="uploadFile" multiple="multiple" type="file" accept="image/jpeg, image/png, image/gif" />
								<input class="file_fake" type="text" placeholder="*.jpg/png/gif Only" readonly tabindex="-1" />
							  
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
					<td><label for="pro_infor">상품 정보</label></td>
					<td>
						<div class="pro-infor-wrap">
							<!-- 상품 테마 선택 -->
							<select id="pro_category" name="pro_category">
								<option value="">상품 카테고리</option>
								<option value="에어프라이어">에어프라이어</option>
								<option value="전기포트">전기포트</option>
								<option value="전자렌지">전자렌지</option>
								<option value="토스트기">토스트기</option>
								<option value="헤어드라이기">헤어드라이기</option>
								<option value="공기청정기">공기청정기</option>
							</select>
							<!-- 제조사 선택 -->
							<select id="maker" name="maker">
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
					<td><label for="seller_mem_no">회원 정보</label></td>
					<td>
					  <input type="hidden" readonly="readonly" value="${login.mem_no}" name="seller_mem_no" />
					  <input type="text" readonly="readonly" value="${login.mem_id}"/>
					</td>
				</tr>
				<tr>
					<td><label for="buy_price">상품 구매 시 가격</label></td>
					<td><input type="text" id="pro_buy_price" name="pro_buy_price" /> <span>원</span></td>
				</tr>
				<tr>
					<td><label for="buy_date">사용 기간</label></td>
					<td>
						<input type="text" id="buy_date" name="pro_period" placeholder="사용기간을 입력해주세요(ex:1년 2개월)">
					</td>
				</tr>
				<tr>
					<td><label for="sale_price">판매 가격</label></td>
					<td><input type="text" id="pro_sale_price" name="pro_sale_price" /> <span>원</span></td>
				</tr>
				<tr>
					<td><label for="pro_title">제목</label></td>
					<td class="regi-tit"><input type="text" id="pro_title" name="pro_title" placeholder="제목을 입력해 주세요."/></td>
				</tr>
				<tr>
					<td><label for="pro_detail">상품 정보</label></td>
					<td>
						<div id="pro_detail" name="pro_detail" class="fake_textarea"></div>
					</td>
				</tr>
				<tr>
					<td><label for="pro_content">판매자 설명</label></td>
					<td><textarea rows="5" cols="50" id="pro_content" name="pro_content"></textarea></td>
				</tr>
			</table>

			
			<div class="inputArea btn mt70">
				<input type="submit" id="register_Btn" disabled value="확인">
				<input type="button" id="cancelBtn" value="취소" onclick="location.href='/'">
			  </div>
		</div>

	</form>

</div>
<c:import url="${contextPath}/WEB-INF/views/inc/footer.jsp"/>

