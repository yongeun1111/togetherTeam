<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<c:import url="inc/headerScript.jsp"/>
<c:import url="inc/header.jsp"/>

<link rel="stylesheet" href="${contextPath}/resource/css/pages/main.css">
<link rel="stylesheet" href="${contextPath}/resource/css/pages/main_media.css">
<script src="${contextPath}/resource/js/jquery/gsap.min.js"></script>
<script src="${contextPath}/resource/js/jquery/ScrollTrigger.min.js"></script>
<script src="${contextPath}/resource/js/pages/main.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    var categoryBtn = $('.categoryBtn');
    var categoryList = $('.categoryList');

    // 카테고리 버튼 클릭시 데이터 처리하기
    categoryBtn.click(function(){
        var category = $(this).data('category');

        $.ajax({
            type: 'GET',
            url: '/get-products',
            data: {category: category},
            success: function(result){
                // categoryList 영역 초기화
                categoryList.empty();

             // 전달받은 데이터를 순회하면서 동적으로 HTML 코드 생성
                var rowCount = 0;
                $.each(result, function(index, item){
                    if (rowCount === 0) {
                        // 새로운 row 시작
                        var html = "<div class=\"row\">";
                    }
                    
                    // 상품 정보 추가
                    html += "<div class=\"col-sm-2\">" +
                        "<a href=\"/proView?pro_no=" + item.pro_no + "\">" +
                        "<div class=\"pro-img\">" +
                        "<img src=\"${contextPath}/resource/images/thum_img.jpg\" alt=\"\">" +
                        "</div>" +
                        "<div class=\"pro-info\">" +
                        "<p class=\"name\">" + item.pro_title + "</p>" +
                        "<p class=\"price\">" +
                        item.pro_sale_price + "<span class=\"won\">원</span>" +
                        "</p>" +
                        "</div>" +
                        "</a>" +
                        "</div>";
                    
                    rowCount++;

                    if (rowCount === 5) {
                        // row 종료
                        html += "</div>";
                        rowCount = 0;
                    }

                    // 생성된 HTML 코드를 categoryList 영역에 추가
                    categoryList.append(html);
                });

                // row가 다 채워지지 않았을 경우, 마지막 row 닫아주기
                if (rowCount > 0) {
                    categoryList.append("</div>");
                }
                
                categoryList.append("<div align=\"center\"><button>더보기</button></div>");

            },
            error: function(){
                alert('데이터를 가져오는데 실패하였습니다.');
            }
        });
    });
});
</script>



<!-- #container -->
<div class="container">

  <!-- main visual -->
  <div class="mv-wrap">
    <div class="mv-txt">
      <p class="sm-txt">쉽고, 편리하게!</p>
      <p class="lg-txt">안전한 중고 거래</p>
      <p class="mv-txt">
        <span class="bold">믿을 수 있는 중고 거래 서비스 플랫폼</span>을 지금 바로 경험해 보세요!
      </p>
    </div>

    <div class="mv-img">

    </div>
  </div>

  <!-- 최근 등록 상품 -->
  <h2>최근 등록 상품</h2>
  <div class="pro-list">
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
			<a class="nav-link categoryBtn" ata-category="공기청정기" data-toggle="tab" href="#tab07">공기청정기</a>
		  </li>
	  </ul>
  </div>  
  
  
    <div class="tab-content">
    
      <div id="tab01" class="pro-m tab-pane active">
        <div class="row">
        <c:forEach var="vo" items="${allList}" varStatus="status">
          <div class="col-sm">
		    <a href="/proView?pro_no=${vo.pro_no}">
			  <div class="pro-img">
				<img src="${contextPath}/resource/images/thum_img.jpg" alt="">
			  </div>
		      <div class="pro-info">
		        <p class="name">${vo.pro_title}</p>
		        <p class="price">
			      ${vo.pro_sale_price}<span class="won">원</span>
		        </p>
		      </div>
		    </a>
		  </div>
		  <c:if test="${status.index % 5 == 4}">
           </div><div class="row">
          </c:if>
          </c:forEach>
        </div><!--row-->
        <div align="center">
          <button>더보기</button>
        </div>
      </div>
        <div id="tab02" class="pro-m tab-pane fade">tab2 content
		  <div class="categoryList"></div>
        </div>
        <div id="tab03" class="pro-m tab-pane fade">tab3 content
		  <div class="categoryList"></div>      
        </div>
        <div id="tab04" class="pro-m tab-pane fade">tab4 content
		  <div class="categoryList"></div>      
        </div>
        <div id="tab05" class="pro-m tab-pane fade">tab5 content
		  <div class="categoryList"></div>      
        </div>
        <div id="tab06" class="pro-m tab-pane fade">tab6 content
		  <div class="categoryList"></div>      
        </div>
        <div id="tab07" class="pro-m tab-pane fade">tab7 content
		  <div class="categoryList"></div>      
        </div>
      
    </div><!--tab-content-->

</div>

<c:import url="inc/footer.jsp"/>
