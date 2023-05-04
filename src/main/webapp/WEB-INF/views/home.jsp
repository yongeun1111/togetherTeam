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

<!-- in HEAD -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.5.1/gsap.min.js" integrity="sha512-IQLehpLoVS4fNzl7IfH8Iowfm5+RiMGtHykgZJl9AWMgqx0AmJ6cRWcB+GaGVtIsnC4voMfm8f2vwtY+6oPjpQ==" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.5.1/ScrollToPlugin.min.js" integrity="sha512-nTHzMQK7lwWt8nL4KF6DhwLHluv6dVq/hNnj2PBN0xMl2KaMm1PM02csx57mmToPAodHmPsipoERRNn4pG7f+Q==" crossorigin="anonymous"></script>

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
                var html = "<div class=\"thema-img\">";
                    html += "<div class=\"row\">"
                $.each(result, function (index, item) {
                    var fileCallPath = encodeURIComponent(item.upload_path + "/s_" + item.uuid + "_" + item.file_name);

                        html +=	  "<a href=\"/proView?pro_no=" + item.pro_no + "\">" +
                        		    "<div class=\"img-box pro-img\">" +
                        		      "<img src=\"/display?file_name=" + fileCallPath + "\" alt=\"\">" +
                        		      "<span class=\"over-box\">" +
                        		        "<p>" + item.maker + "</p>" +
                        		        "<p>" + item.pro_title + "</p>" +
                        		        "<p>" + item.pro_sale_price + "<span class=\"won\">원</span></p>" +
                        		      "</span>" +
                        		    "</div>" +
                        		  "</a>";

                }); // 데이터 html로 추가

                html += "</div></div>"; // row, theme-img
                themeList.append(html);
                
            }, // success
            error: function () {
                alert('데이터를 가져오는데 실패하였습니다.');
            }
    	});
    });

});   
    
</script>

<!-- main visual -->
<section id="mvWrap" class="slider-box">

  <div class="txt-wrap">
    <div class="mv-txt">
      <p class="wow bounceInLeft">쉽고, 편리하게!</p>
      <p class="wow bounceInLeft" data-wow-delay="0.5s">간편한 중고 거래</p>
      <p class="wow fadeInUp" data-wow-delay="1s"><span class="bold">자동 물품 등록</span>이 가능한 <span class="bold">중고 판매 서비스</span>,<br>
        지금 바로 경험해 보세요!</p>

      <!-- button 커스텀을 위한 요소 --> 
      <div class="mv-page">
        <div id="mvBtn" class="button">
          <div class="prev"></div>
          <div class="next"></div>
        </div>
      </div>

    </div>

   
  </div>

 
  <div class="regular slick-slider">
    <div>
      <img src="${contextPath}/resource/images/mv_img01.png">
      
    </div>
    <div>
      <img src="${contextPath}/resource/images/mv_img02.png">
    </div>
    <div>
      <img src="${contextPath}/resource/images/mv_img03.png">
    </div>
  </div>
  <div class="wrapper">
    <span class="floating1"></span>
    <span class="floating2"></span>
    <span class="floating3"></span>
   
  </div>
</section>
<!-- main visual // -->

<!-- #container -->
<div class="container">

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
            <div class="col-lg-3 pro-list mb50">
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
          <button>중고 상품 페이지 GO</button>
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
  <section class="wow fadeInUp" data-wow-duration="500">
    <div class="banner-wrap">
      <img src="${contextPath}/resource/images/mid_banner.png" alt="제품을 중고로 저렴하게 구매하고 싶은데
      중고 거래 사기가 걱정되사나요? 이제 그런 걱정은 NO!">
    </div>
  </section>

   <!-- 테마별 인기 상품 -->
   <section class="wow fadeInUp" data-wow-duration="500">
    <h2>테마별 인기 상품</h2>

  <div class="thema-list">
    <ul class="tabnav">
      <li><a class="themeBtn" data-theme="#슬기로운 자취 생활" href="#thema01"># 슬기로운 자취 생활</a></li>
      <li><a class="themeBtn" data-theme="#사회초년생 추천 상품" href="#thema01"># 사회초년생 추천 상품</a></li>
      <li><a class="themeBtn" data-theme="#나만의 싱글 라이프" href="#thema01"># 나만의 싱글 라이프</a></li>
      <li><a class="themeBtn" data-theme="#N년차 자취생 꿀템" href="#thema01"># N년차 자취생 꿀템</a></li>
    </ul>
    
    <div class="tabcontent">

      <!-- thema01 : # 슬기로운 자취 생활 -->
      <div class="themeList" id="thema01">
        <div class="thema-img">
		  <div class="row">
          <c:forEach var="vo" items="${themeList}" varStatus="status">
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
          </c:forEach>
          </div>
        </div>
    </div>
  </div>
  </div>
  </section>
  <!-- 테마별 인기 상품 // -->

</div>
<!-- #container -->

<c:import url="inc/footer.jsp"/>

<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
<script src="${contextPath}/resource/js/jquery/slick.js" type="text/javascript" charset="utf-8"></script>

<script type="text/javascript">
  // 메인비주얼
  $(document).on('ready', function () {

      $(".regular").slick({
          dots: true,
          infinite: true,
          slidesToShow: 1,
          slidesToScroll: 1,
          speed: 800, // 다음 버튼 누르고 다음 화면 뜨는데까지 걸리는 시간(ms)
          arrows: true, // 옆으로 이동하는 화살표 표시 여부
          dots: true, // 스크롤바 아래 점으로 페이지네이션 여부
          autoplay: true, // 자동 스크롤 사용 여부
          autoplaySpeed: 4000, // 자동 스크롤 시 다음으로 넘어가는데 걸리는 시간 (ms)
          pauseOnHover: false, // 슬라이드 이동 시 마우스 호버하면 슬라이더 멈추게 설정
          vertical: false, // 세로 방향 슬라이드 옵션
          prevArrow: ".prev", // 이전 화살표 모양 설정
          nextArrow: ".next", // 다음 화살표 모양 설정
          responsive: [
              { // 반응형 웹 구현 옵션
                  breakpoint: 1024, //화면 사이즈 960px
                  settings: {
                      //위에 옵션이 디폴트 , 여기에 추가하면 그걸로 변경
                      slidesToShow: 1
                  }
              }, {
                  breakpoint: 768, //화면 사이즈 768px
                  settings: {
                      //위에 옵션이 디폴트 , 여기에 추가하면 그걸로 변경
                      slidesToShow: 1
                  }
              }
          ]
      });


  });



</script>


<script>

  // 범위 랜덤 함수(소수점 2자리까지)
function random(min, max) {
  // `.toFixed()`를 통해 반환된 문자 데이터를,
  // `parseFloat()`을 통해 소수점을 가지는 숫자 데이터로 변환
  return parseFloat((Math.random() * (max - min) + min).toFixed(2))
}

function floatingObject(selector,delay,size){
  // gsap.to(요소, 시간, 옵션)
  gsap.to(selector, random(1.5,2.5), {
    y: size,
    repeat: -1, // -1 무한반복
    yoyo: true, // 애니메이션 되돌아오기(설정안할 시 끈킴)
    ease: Power1.easeInOut, // 타이밍함수
    delay: random(0,delay) // 지연시간
  })
}
floatingObject('.floating1',1,15)
floatingObject('.floating2',.5,15)
floatingObject('.floating3',1.5,20)
</script>

<!-- wow -->
<script src="${contextPath}/resource/js/com/wow.js"></script>
<script>
  wow = new WOW(
    {
      animateClass: 'animated',
      offset:       100,
      callback:     function(box) {
        console.log("WOW: animating <" + box.tagName.toLowerCase() + ">")
      }
    }
  );
  wow.init();
</script>
