<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<c:import url="${contextPath}/WEB-INF/views/inc/headerScript.jsp"/>
<c:import url="${contextPath}/WEB-INF/views/inc/header.jsp"/>

<link rel="stylesheet" href="${contextPath}/resource/css/com/common.css">
<link rel="stylesheet" href="${contextPath}/resource/css/pages/sub.css">
<link rel="stylesheet" href="${contextPath}/resource/css/pages/sub_media.css">
<script src="${contextPath}/resource/js/jquery/gsap.min.js"></script>
<script src="${contextPath}/resource/js/jquery/ScrollTrigger.min.js"></script>
<script src="${contextPath}/resource/js/pages/sub.js"></script>
<script src="${contextPath}/resource/js/com/common.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	  var categoryBtn = $('.categoryBtn');
	  var categoryList = $('.categoryList');
	  var pageBtn = $('.pageBtn');

	  // 카테고리 버튼 클릭시 데이터 처리하기
	  categoryBtn.click(function() {
	    var category = $(this).data('category');

	    $.ajax({
	      type: 'GET',
	      url: '/getProList',
	      data: { category: category },
	      success: function(result) {
	        // categoryList 영역 초기화
	        categoryList.empty();

	        // 전달받은 데이터를 순회하면서 동적으로 HTML 코드 생성
	        var rowCount = 0;
	        var html = ""; // html 변수 선언 추가
	        $.each(result.list, function (index, item) { // result.list에 대해서만 처리
	            var fileCallPath = encodeURIComponent(item.upload_path + "/s_" + item.uuid + "_" + item.file_name);

	            if (rowCount === 0) {
	                // 새로운 row 시작
	                html += "<div class=\"row\">";
	            }

	            // 상품 정보 추가
	            html += "<div class=\"col-lg-3 pro-list mb50\">" +
	                        "<a href=\"/proView?pro_no=" + item.pro_no + "\">" +
	                            "<div class=\"pro-img\"" + 
	                                "data-pro_no=\"" + item.pro_no + 
	                                "\" data-path=\"" + item.upload_path + 
	                                "\" data-uuid=\"" + item.uuid + 
	                                "\" data-file_name=\"" + item.file_name + "\">" +
	                                "<img alt=\"\"" + 
	                                "src=\"/display?file_name=" + fileCallPath + "\">" + 
	                            "</div>" + 
	                            "<div class=\"pro-info\">" + 
	                                "<p class=\"name\">" + item.pro_title + "</p>" + 
	                                "<p class=\"price\">" + item.pro_sale_price + "<span class=\"won\">원</span></p>" + 
	                            "</div>" + 
	                        "</a>" + 
	                    "</div>";

	            rowCount++;

	            if (rowCount === 4) {
	                // row 종료
	                html += "</div>";
	                rowCount = 0;
	            }
	        });

	        categoryList.append(html);

	        if (rowCount > 0) {
	            categoryList.append("</div>");
	        }
	        

	        // 페이지 버튼 생성
	        pageBtn.empty();
	        var pageMaker = result.pm;
	        var pageHtml = "<ul class=\"pagination justify-content-center\">";

	        if (pageMaker.prev) {
	          pageHtml += "<li class=\"page-item page-prev\"><a class=\"page-link\" href=\"" + (pageMaker.startPage - 1) + "\"></a></li>";
	        }

	        for (var i = pageMaker.startPage; i <= pageMaker.endPage; i++) {
	          var active = "";
	          if (pageMaker.cri.page == i) {
	            active = "active";
	          }

	          pageHtml += "<li class=\"page-item page-num " + active + "\"><a class=\"page-link\" href=\"#" + i + "\">" + i + "</a></li>";
	        }

	        if (pageMaker.next) {
	          pageHtml += "<li class=\"page-item page-next\"><a class=\"page-link\" href=\"" + (pageMaker.endPage + 1) + "\"></a></li>";
	        }

	        var pageFormHtml = "<form id=\"pageFrm\" action=\"get-proList\" method=\"get\">" +
	          "<input type=\"hidden\" id=\"page\" name=\"page\" value=\"" + pageMaker.cri.page + "\">" +
	          "<input type=\"hidden\" id=\"category\" name=\"category\" value=\"" + category + "\">" +
	          "</form>";
	        pageHtml += pageFormHtml;
	        pageHtml += "</ul>";
	        pageBtn.append(pageHtml);
	      },
          error: function(){
              alert('데이터를 가져오는데 실패하였습니다.');
          }
      });
  });
	        
	        
	        // 페이지 버튼 클릭 이벤트 처리
	        $('.page-num a').on('click', function(e){
	        	e.preventDefault(); // 기존 이벤트 방지

	        	var page = $(this).attr('href');
	        	var category = $('#category').val();

	        	if(category === undefined){ // 카테고리 값이 없을 때
	        	category = $('.categoryBtn.active').data('category'); // 활성화된 카테고리 값 가져오기
	        	}

	        	$('#page').val(page); // form에 페이지 정보 설정
	        	$('#category').val(category); // form에 카테고리 정보 설정
	        	$('#pageFrm').submit(); // form 전송
	        	});
    
});
</script>

<!-- #container -->
<div class="container">
	<h2 class="pt80">중고 상품</h2>
	<div class="pro-list">

		<!-- Nav tabs -->
		<ul class="nav nav-tabs row">
			<li class="nav-item col">
				<a class="nav-link active" data-toggle="tab" href="#tab01">ALL</a>
			</li>
			<li class="nav-item col">
				<a class="nav-link categoryBtn" data-category="에어프라이어" data-toggle="tab" href="#tab02">에어프라이어</a>
			</li>
			<li class="nav-item col">
				<a class="nav-link categoryBtn" data-category="전기포트" data-toggle="tab" href="#tab03">전기포트</a>
			</li>
			<li class="nav-item col">
				<a class="nav-link categoryBtn" data-category="전자렌지" data-toggle="tab" href="#tab04">전자렌지</a>
			</li>
			<li class="nav-item col">
				<a class="nav-link categoryBtn" data-category="토스티기" data-toggle="tab" href="#tab05">토스트기</a>
			</li>
			<li class="nav-item col">
				<a class="nav-link categoryBtn" data-category="헤어드라이기" data-toggle="tab" href="#tab06">헤어드라이기</a>
			</li>
			<li class="nav-item col">
				<a class="nav-link categoryBtn" data-category="공기청정기" data-toggle="tab" href="#tab07">공기청정기</a>
			</li>
		</ul> 
		<!-- Tab panes -->
		<div class="tab-content">
		
			<!-- 01. ALL -->
			<div id="tab01" class="pro-m tab-pane active">
				<div class="row">
					<c:forEach var="vo" items="${list}" varStatus="status">
						<div class="col-lg-3">
							<a href="/proView?pro_no=${vo.pro_no}">
								<div class="pro-img" data-pro_no="${vo.pro_no}" data-path="${vo.upload_path}" data-uuid="${vo.uuid}" data-file_name="${vo.file_name}">
									<img alt="">
								</div>
								<div class="pro-info">
									<p class="name">${vo.pro_title}</p>
									<p class="price">
										${vo.pro_sale_price}<span class="won">원</span>
									</p>
								</div>
							</a>
						</div>
						<c:if test="${status.index % 4 == 3}">
				          </div><div class="row">
				        </c:if>
					</c:forEach>
				</div>
				<div class="pageMaker_wrap">
					<ul class="pagination justify-content-center">
					  <!-- 이전버튼 -->
					  <c:if test="${pm.prev}">
						<li class="page-item page-prev">
						  <a class="page-link" href="${pm.startPage-1}"></a>
						</li>
					  </c:if>
						
					  <!-- 페이지 번호 -->
					  <c:forEach var="pageNum" begin="${pm.startPage}" end="${pm.endPage}">
						<li class="page-item page-num ${pm.cri.page==pageNum ? 'active' : ''}">
						  <a class="page-link" href="${pageNum}">${pageNum}</a>
						</li>
					  </c:forEach>
						
					  <!-- 다음 버튼 -->
					  <c:if test="${pm.next}">
						<li class="page-item page-next">
						  <a class="page-link" href="${pm.endPage+1}"></a>
						</li>
					  </c:if>
					</ul>
				</div>
				
				<form id="pageFrm" action="proList" method="get">
					<input type="hidden" id="page" name="page" value="${pm.cri.page}">
				</form>
				
			</div>
					<!-- 02. 에어프라이어 -->
					<div id="tab02" class="container tab-pane fade"><br>
						<div class="categoryList"></div>
						<div class="pageBtn pageMaker_wrap"></div>
					</div>

					<!-- 03. 전기포트 -->
					<div id="tab03" class="container tab-pane fade"><br>
						<div class="categoryList"></div>
						<div class="pageBtn pageMaker_wrap"></div>
					</div>

					<!-- 04. 전자렌지 -->
					<div id="tab04" class="container tab-pane fade"><br>
						<div class="categoryList"></div>
						<div class="pageBtn pageMaker_wrap"></div>
					</div>

					<!-- 05. 토스트기 -->
					<div id="tab05" class="container tab-pane fade"><br>
						<div class="categoryList"></div>
						<div class="pageBtn pageMaker_wrap"></div>
					</div>

					<!-- 06. 헤어드라이기 -->
					<div id="tab06" class="container tab-pane fade"><br>
						<div class="categoryList"></div>
						<div class="pageBtn pageMaker_wrap"></div>
					</div>

					<!-- 07. 공기청정기 -->
					<div id="tab07" class="container tab-pane fade"><br>
						<div class="categoryList"></div>
						<div class="pageBtn pageMaker_wrap"></div>
					</div>

		</div>

		
		



	</div>

	<c:import url="${contextPath}/WEB-INF/views/inc/footer.jsp"/>
