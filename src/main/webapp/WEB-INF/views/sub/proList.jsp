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
	  var categoryList = $('#categoryList');
	  var pageBtn = $('.pageBtn');
	  
	  // 카테고리 버튼 클릭시 데이터 처리하기
	  categoryBtn.click(function() {
	    var category = $(this).data('category');
	    $.ajax({
	      type: 'GET',
	      url: '/getProList',
	      data: { category: category },
	      success: function(result) {
	    	console.log(result)
	        var rowCount = 0;
	        var loadCount = 0;
	        var html = ""; // html 변수 선언 추가
	        $.each(result, function (index, item) { // result.list에 대해서만 처리
	            var fileCallPath = encodeURIComponent(item.upload_path + "/s_" + item.uuid + "_" + item.file_name);

				if (loadCount < 8) {
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
		            loadCount++;
		            
		            if (rowCount === 4) {
		                // row 종료
		                html += "</div>";
		                rowCount = 0;
		            };		            
				} else {
					if (rowCount === 0) {
		                // 새로운 row 시작
		                html += "<div class=\"row\" style='display:none;'>";
			            }
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
                	loadCount++;
	                if (rowCount === 4) {
		                // row 종료
		                html += "</div>";
		                rowCount = 0;
		            };		
				};

	        });

			
	        if (loadCount > 8){
	        	html += '</div><div class="more-btn"><button id="load" onclick="moreInfo()">더 보기</button></div>'
	        }
	        	categoryList.html(html);
	        
	        

	      },
          error: function(){
              alert('데이터를 가져오는데 실패하였습니다.');
          }
      });
  });
	  
	$("#categoryALL").click();      
	        
    
});


</script>

<!-- #container -->
<div class="sub-inner container">
	<h2>중고 상품</h2>
	<div class="pro-list">

		<!-- Nav tabs -->
		<ul class="nav nav-tabs row">
			<li class="nav-item col">
				<a id="categoryALL" class="nav-link active categoryBtn" data-category="ALL" data-toggle="tab" href="#tab01">ALL</a>
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
				<a class="nav-link categoryBtn" data-category="토스트기" data-toggle="tab" href="#tab05">토스트기</a>
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
				<div id="categoryList">
				</div>
			</div>

		
		
</div>

<script type="text/javascript">
//더보기 버튼 
function moreInfo(e){
	$("div:hidden").slice(0,16).show();
	if ($("div:hidden").length == 0) {
		$("#load").fadeOut(100);
	};
    
};
</script>

	<c:import url="${contextPath}/WEB-INF/views/inc/footer.jsp"/>
