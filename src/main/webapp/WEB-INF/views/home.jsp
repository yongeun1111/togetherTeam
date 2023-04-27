<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<c:import url="inc/headerScript.jsp"/>
<c:import url="inc/header.jsp"/>

<link rel="stylesheet" href="${contextPath}/resource/css/pages/main.css">
<link rel="stylesheet" href="${contextPath}/resource/css/pages/main_media.css">
<script src="${contextPath}/resource/js/jquery/gsap.min.js"></script>
<script src="${contextPath}/resource/js/jquery/ScrollTrigger.min.js"></script>
<script src="${contextPath}/resource/js/pages/main.js"></script>
<script type="text/javascript">
$(document).ready(function () {
    var categoryBtn = $('.categoryBtn');
    var categoryList = $('.categoryList');

    // 카테고리 버튼 클릭시 데이터 처리하기
    categoryBtn.click(function () {
        var category = $(this).data('category');

        $.ajax({
            type: 'GET',
            url: '/getProductsMain',
            data: {
                category: category
            },
            success: function (result) {
                // categoryList 영역 초기화
                categoryList.empty();

                // 전달받은 데이터를 순회하면서 동적으로 HTML 코드 생성
                var rowCount = 0;
                var html = "";
                $.each(result, function (index, item) {
                    var fileCallPath = encodeURIComponent(item.upload_path + "/s_" + item.uuid + "_" + item.file_name);

                    if (rowCount === 0) {
                        // 새로운 row 시작
                        html += "<div class=\"row\">";
                    }

                    // 상품 정보 추가
                    html += "<div class=\"col-lg pro-list mb50\">" +
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

                // row가 다 채워지지 않았을 경우, 마지막 row 닫아주기
                if (rowCount > 0) {
                    html += "</div>";
                }

                // 생성된 HTML 코드를 categoryList 영역에 추가
                categoryList.append(html);
                categoryList.append("<div class=\"more-btn\"><button>더보기</button></div>");
            },
            error: function () {
                alert('데이터를 가져오는데 실패하였습니다.');
            }
        });
    });
        
    $('.more-btn button').click(function() {
            window.location.href = '/proList';
    });
        
    $('.categoryList').on('click', '.more-btn button', function() {
        	  window.location.href = '/proList';
    });
    
	var themeBtn = $('.themeBtn');
	var themeList = $('.themeList');
    
    themeBtn.click(function () {
    	var theme = $(this).data('theme');
    	
    	$.ajax({
    		url : "/getProductsTheme",
    		type : 'GET',
    		data : {theme : theme},
    		success : function (result) {
                themeList.empty();

                var rowCount = 0;
                var html = "<div class=\"thema-img\">";
                $.each(result, function (index, item) {
                    var fileCallPath = encodeURIComponent(item.upload_path + "/s_" + item.uuid + "_" + item.file_name);

                    if (rowCount === 0) {
                        html +=	"<div class=\"lg-wrap\">" +
                        		  "<a href=\"/proView?pro_no=" + item.pro_no + "\">" +
                        		    "<div class=\"img-box\">" +
                        		      "<img src=\"/display?file_name=" + fileCallPath + "\" alt=\"\">" +
                        		      "<span class=\"over-box\">" +
                        		        "<p>" + item.maker + "</p>" +
                        		        "<p>" + item.pro_title + "</p>" +
                        		        "<p>" + item.pro_sale_price + "<span class=\"won\">원</span></p>" +
                        		      "</span>" +
                        		    "</div>" +
                        		  "</a>" +
                        		"</div>" +
                        		"<div class=\"sm-wrap\">";
                    }
                    
                    if (rowCount === 1 || rowCount === 2) {
                    	html += "<div class=\"sm-pro\">" +
			               		  "<a href=\"/proView?pro_no=" + item.pro_no + "\">" +
			               		    "<div class=\"img-box\">" +
			               		      "<img src=\"/display?file_name=" + fileCallPath + "\" alt=\"\">" +
			               		      "<span class=\"over-box\">" +
			               		  		"<p>" + item.maker + "</p>" +
                   		        		"<p>" + item.pro_title + "</p>" +
                   		        		"<p>" + item.pro_sale_price + "<span class=\"won\">원</span></p>" +
			               		      "</span>" +
			               		    "</div>" +
			               		  "</a>" +
			               		"</div>";
                    }       		
	                rowCount++;
                }); // 데이터 html로 추가
                
                if(rowCount > 0){
                	html += "</div>"; // sm-wrap
                }
                
                html += "</div>"; // theme-img
                themeList.append(html);
                
            }, // success
            error: function () {
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

    <div class="mv-img"></div>
  </div>

  <!-- 최근 등록 상품 영역 -->
  <section>
    <h2>최근 등록 상품</h2>
    <!--tab menu-->
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
          <a class="nav-link categoryBtn" data-category="토스트기" data-toggle="tab" href="#tab05">토스트기</a>
        </li>
        <li class="nav-item col">
          <a class="nav-link categoryBtn" data-category="헤어드라이기" data-toggle="tab" href="#tab06">헤어드라이기</a>
        </li>
        <li class="nav-item col">
          <a class="nav-link categoryBtn" data-category="공기청정기" data-toggle="tab" href="#tab07">공기청정기</a>
        </li>
      </ul>
    </div>
    <!-- tab menu // -->
    
    <!-- tab content-->
    <div class="tab-content">
      <!-- tab01 : ALL -->
      <div id="tab01" class="pro-m tab-pane active">
        <div class="row">
          <c:forEach var="vo" items="${allList}" varStatus="status">
            <div class="col-lg pro-list mb50">
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
        </div><!-- row // -->

        <div class="more-btn">
          <button>더보기</button>
        </div>

      </div>
      <!-- tab02 : 에어프라이어 -->
      <div id="tab02" class="pro-m tab-pane fade">
        <div class="categoryList"></div>
      </div>
      <!-- tab03 : 전기포트 -->
      <div id="tab03" class="pro-m tab-pane fade">
        <div class="categoryList"></div>      
      </div>
      <!-- tab04 : 전자렌지 -->
      <div id="tab04" class="pro-m tab-pane fade">
        <div class="categoryList"></div>      
      </div>
      <!-- tab05 : 토스트기 -->
      <div id="tab05" class="pro-m tab-pane fade">
        <div class="categoryList"></div>      
      </div>
      <!-- tab06 : 헤어드라이기 -->
      <div id="tab06" class="pro-m tab-pane fade">
        <div class="categoryList"></div>      
      </div>
      <!-- tab07 : 공기청정기 -->
      <div id="tab07" class="pro-m tab-pane fade">
        <div class="categoryList"></div>      
      </div>
    </div>
    <!-- tab-content // -->
  </section>

  <!-- 중간 배너 영역 -->
  <section>
    <div class="banner-wrap">
      <img src="${contextPath}/resource/images/mid_banner.png" alt="제품을 중고로 저렴하게 구매하고 싶은데
      중고 거래 사기가 걱정되사나요? 이제 그런 걱정은 NO!">
    </div>
  </section>

   <!-- 테마별 인기 상품 -->
   <section>
    <h2>테마별 인기 상품</h2>

  <div class="thema-list">
    <ul class="tabnav">
      <li><a class="themeBtn" data-theme="#슬기로운 자취 생활" href="#thema01"># 슬기로운 자취 생활</a></li>
      <li><a class="themeBtn" data-theme="#사회초년생 추천 상품" href="#thema02"># 사회초년생 추천 상품</a></li>
      <li><a class="themeBtn" data-theme="#나만의 싱글 라이프" href="#thema03"># 나만의 싱글 라이프</a></li>
      <li><a class="themeBtn" data-theme="#N년차 자취생 꿀템" href="#thema04"># N년차 자취생 꿀템</a></li>
    </ul>
    
    <div class="tabcontent">

      <!-- thema01 : # 슬기로운 자취 생활 -->
      <div class="themeList" id="thema01">
        <div class="thema-img">
		  <c:if test="${!empty themeList}">
          <c:forEach var="vo" items="${themeList}" varStatus="status">
          <c:if test="${status.index == 0}">
            <div class="lg-wrap">
              <a href="/proView?pro_no=${vo.pro_no}">
              <div class="img-box pro-img" data-pro_no="${vo.pro_no}" data-path="${vo.upload_path}" data-uuid="${vo.uuid}" data-file_name="${vo.file_name}">
                <img alt="">
                <span class="over-box">
                  <p>${vo.maker}</p>
                  <p>${vo.pro_title}</p>
                  <p>${vo.pro_sale_price}<span class="won">원</span></p>
                </span>
              </div>
              </a>
            </div>
            <div class="sm-wrap">
          </c:if>
            <c:if test="${status.index == 1 || status.index == 2}">
              <div class="sm-pro">
                <a href="/proView?pro_no=${vo.pro_no}">
                <div class="img-box pro-img" data-pro_no="${vo.pro_no}" data-path="${vo.upload_path}" data-uuid="${vo.uuid}" data-file_name="${vo.file_name}">
                  <img alt="">
                  <span class="over-box">
                    <p>${vo.maker}</p>
                    <p>${vo.pro_title}</p>
                    <p>${vo.pro_sale_price}<span class="won">원</span></p>
                  </span>
                </div>
                </a>
              </div>
            </c:if>
          </c:forEach>
            </div>
		  </c:if>
        </div>
      </div>

      <!-- thema02 : # 사회초년생 추천 상품 -->
      <div class="themeList" id="thema02">
      </div>

      <!-- thema03 : # 나만의 싱글 라이프 -->
      <div class="themeList" id="thema03">
      </div>

      <!-- thema04 : # N년차 자취생 꿀템 -->
      <div class="themeList" id="thema04">
      </div>

    </div>
  </div>
  </section>

</div>

<c:import url="inc/footer.jsp"/>
