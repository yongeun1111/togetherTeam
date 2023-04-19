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
    var categoryBtn = $('#categoryBtn');
    var categoryList = $('#categoryList');

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
                $.each(result, function(index, item){
                    var html = "<div style=\"border: 1px solid black\">" +
                    		     "<div>" + "이미지 들어가는 공간" + "</div>" +
                    		     "<div>" + "제품명/가격" +
                                   "<p>" + item.pro_name + "</p>" +
                                   "<p>" + item.pro_sale_price + "</p>" +
                                 "</div>" +
                               "</div>";

                                
                    // 생성된 HTML 코드를 categoryList 영역에 추가
                    categoryList.append(html);
                });
            },
            error: function(){
                alert('데이터를 가져오는데 실패하였습니다.');
            }
        });
    });
});
</script>



<!-- #container -->
<div class="main">

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
  <div class="tab">
    <ul class="tabnav">
      <li><a href="#tab01">ALL</a></li>
      <li><a id="categoryBtn" data-category="에어프라이어" href="#tab02">에어프라이어</a></li>
      <li><a href="#tab03">전기포트</a></li>
      <li><a href="#tab04">전자렌지</a></li>
      <li><a href="#tab05">토스트기</a></li>
      <li><a href="#tab06">헤어드라이기</a></li>
      <li><a href="#tab07">공기청정기</a></li>
    </ul>
    <div class="tabcontent">
      <div id="tab01">tab1 content
        <c:forEach var="vo" items="${allList}">
        <div style="border: 1px solid black">
          <div>이미지 들어가는 공간</div>
          <div>
            제품명/가격
            <p>${vo.pro_name}</p>
            <p>${vo.pro_sale_price}</p>
          </div>
        </div>
        </c:forEach>
      </div>
      <div id="tab02">tab2 content
		<div id="categoryList"></div>
      </div>
      <div id="tab03">tab3 content</div>
      <div id="tab04">tab4 content</div>
      <div id="tab05">tab5 content</div>
      <div id="tab06">tab6 content</div>
      <div id="tab07">tab7 content</div>
    </div>
  </div><!--tab-->
  




 
 
 

</div>

<c:import url="inc/footer.jsp"/>
