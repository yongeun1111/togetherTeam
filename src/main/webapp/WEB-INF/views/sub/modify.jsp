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
	$("#pro_theme").val("${pro.pro_theme}").prop("selected",true);
	$("#pro_category").val("${pro.pro_category}").prop("selected",true);
	$("#maker").val("${pro.maker}").prop("selected",true);
	$("#pro_buy_price").val("${pro.pro_buy_price}");
	$("#pro_period").val("${pro.pro_period}");
	$("#pro_sale_price").val("${pro.pro_sale_price}");
	$("#pro_title").val("${pro.pro_title}");
	$("#pro_content").val("${pro.pro_content}");

	// 이미지 리스트
	let pro_no = ${pro.pro_no};
	let uploadResult = $("#uploadResult");
	console.log(pro_no);
	
	$.getJSON("/getProduceImageList", {pro_no : pro_no}, function(arr){	
		let obj = arr;
		console.log(obj);
		console.log(${fn:length(image)});
		
		for(let i=0; i < ${fn:length(image)}; i++){
			
			let fileCallPath = encodeURIComponent(obj[i].upload_path + "/s_" + obj[i].uuid + "_" + obj[i].file_name);
			let str = "";
		
			str += "<div id='result_card'";
            str += "data-path='" + obj[i].upload_path + "' data-uuid='" + obj[i].uuid + "' data-file_name='" + obj.file_name + "'";
            str += ">";
            str += "<img class='imgServe' src='/display?file_name="+fileCallPath + "'/>";
			str += "</div>";
            
			uploadResult.append(str);
		
		}
		
	});
	
	proDetail();
});

</script>

<!-- #container -->
<div class="sub-inner">
	<h2>등록 상품 수정</h2>

	<div class="info-box clearfix">
		<ul>
		  <li>아래 목록에서 내가 판매할 목록을 수정하실수 있습니다.${pro_no}</li>
		</ul>
	</div>	
  
	<form action="modify" method="post">


		<!-- 상품 정보 등록 테이블 -->
		<div class="input input-wrap">
			<table class="inputArea">
				<tr>
					<td width="15%"><label>상품 테마</label></td>
					<td class="category1">
						<select id="pro_theme" name="pro_theme">
							<option value="">상품의 테마를 선택해 주세요.</option>
							<option value="#슬기로운 자취 생활">#슬기로운 자취 생활</option>
							<option value="#사회초년생 추천 상품">#사회초년생 추천 상품</option>
							<option value="#나만의 싱글 라이프">#나만의 싱글 라이프</option>
							<option value="#N년차 자취생 꿀템">#N년차 자취생 꿀템</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<td><label for="gdsName">등록 이미지</label></td>
					<td>
						<div id="uploadResult">
						</div>
						<div class="img-info">
							<p class="bold"><주의사항></p>
							<ul>
								<li>이미지는 수정이 불가능합니다.</li>
							</ul>
						</div>
					</td>
				</tr>
				
				<tr>
					<td><label for="pro_infor">상품 정보</label></td>
					<td>
						<div class="pro-infor-wrap">
							<!-- 상품 테마 선택 -->
							<select disabled id="pro_category" name="pro_category">
								<option value="">상품 카테고리</option>
								<option value="에어프라이어">에어프라이어</option>
								<option value="전기포트">전기포트</option>
								<option value="전자렌지">전자렌지</option>
								<option value="토스트기">토스트기</option>
								<option value="헤어드라이기">헤어드라이기</option>
								<option value="공기청정기">공기청정기</option>
							</select>
							<!-- 제조사 선택 -->
							<select disabled id="maker" name="maker">
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
							<input type="text" id="pro_name" name="pro_name" readonly="readonly" value="${pro.pro_name}"/>
							<input type="hidden" id="pro_no" name="pro_no" value="${pro.pro_no}">

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
						<input type="text" id="pro_period" name="pro_period" placeholder="사용기간을 입력해주세요(ex:1년 2개월)">
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
				<input type="submit" id="modify_Btn" value="확인">
				<input type="button" id="cancelBtn" value="취소" onclick="location.href='/'">
			  </div>
		</div>

	</form>

</div>
<c:import url="${contextPath}/WEB-INF/views/inc/footer.jsp"/>

