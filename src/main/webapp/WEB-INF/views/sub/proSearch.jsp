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
<script type="text/javascript">
	sessionStorage.setItem("contextPath", "${pageContext.request.contextPath}");
</script>

<!-- #container -->
<div class="con-inner mypage-wrap">
    <!-- 검색 창 -->
    <div class="search-wrap">
        <div class="search-con sub-inner">
            <h2>상품 검색</h2>
            <div class="search-input-wrap" style="dislay:flex;">
                <input type="text" id="searchProduct" placeholder="어떤 상품을 찾고 계신가요?"/ style="display:flex;">
                <button id="search" class="search-button">
                    <span><img src="${contextPath}/resource/images/search_icon.png" alt=""></span>
                </button>
                <div>
                  <div class="suggestions suggestions_panel"></div>
                </div>   
            </div>
        </div>       
    </div>

    <!-- 검색 결과 -->
    <div class="sub-inner">
        <div class="search-result">
        <p class="mypage-tit mb10">검색 결과</p>
        	<div class="empty-area">
				<p><img src="'+ contextPath +'/resource/images/empty_icon.png" alt=""></p>
			<p class="mt30">검색한 상품이 존재하지 않습니다.</p></div>
        </div>
    </div> 

</div>

<c:import url="${contextPath}/WEB-INF/views/inc/footer.jsp"/>
<script type="text/javascript" src="/stickcode/search/search_test.js"></script>
<script type="text/javascript">
$(document).ready(function(){

    const search_input = document.querySelector("#searchProduct");
    const suggestions_pannel = document.querySelector(".suggestions_panel");
    const search_btn = document.getElementById("search-btn");

    let suggestions_items = []; // 자동완성 결과 요소들을 저장하는 배열
    let current_selected_index = -1; // 현재 선택된 결과의 인덱스를 저장하는 변수
    
    let s_jsonArray = new Array();
    let s_json1 = new Object();
    let s_json2 = new Object();
    let s_json3 = new Object();
    let s_json4 = new Object();
    let s_json5 = new Object();
    let s_json6 = new Object();
    s_json1.name = "헤어드라이기";
    s_json1.count = 1;
    s_jsonArray.push(s_json1);
    s_json2.name = "전기포트";
    s_json2.count = 1;
    s_jsonArray.push(s_json2);
    s_json3.name = "전자렌지";
    s_json3.count = 1;
    s_jsonArray.push(s_json3);
    s_json4.name = "에어프라이어";
    s_json4.count = 1;
    s_jsonArray.push(s_json4);
    s_json5.name = "토스트기";
    s_json5.count = 1;
    s_jsonArray.push(s_json5);
    s_json6.name = "공기청정기";
    s_json6.count = 1;
    s_jsonArray.push(s_json6);

    search_input.addEventListener('keyup', function(){

        if (window.event.keyCode === 13) {
            window.event.preventDefault();
            suggestions_pannel.innerHTML='';
            search_btn.click();
        }
        
        if (event.key === "ArrowUp" || event.key === "ArrowDown") {
            event.preventDefault();

            // 이전에 선택한 결과의 스타일을 제거
            if (current_selected_index > -1) {
              suggestions_items[current_selected_index].classList.remove("selected");
            }

            // 위 버튼을 눌렀을 때
            if (event.key === "ArrowUp" && current_selected_index > 0) {
              current_selected_index--;
            } 
            // 아래 버튼을 눌렀을 때
            else if (event.key === "ArrowDown" && current_selected_index < suggestions_items.length - 1) {
              current_selected_index++;
            }

            // 선택된 결과에 스타일을 적용
            suggestions_items[current_selected_index].classList.add("selected");
            // 검색창에 선택한 결과 표시
            search_input.value = suggestions_items[current_selected_index].textContent;
          }

        suggestions_pannel.innerHTML='';
        let input = search_input.value;
        
        let suggestions = s_jsonArray.filter(function(exam){
            return exam.name.toLowerCase().startsWith(input);
        });

        suggestions.forEach(function(suggested){
            let div = document.createElement('div');
            div.innerHTML = suggested.name;
            suggestions_pannel.appendChild(div);
            // 클릭처리 
            div.onclick= () =>{
                search_input.value = div.innerHTML; 
                suggestions_pannel.innerHTML='';
            }
        });
    });
    
    suggestions.forEach(function(suggested) {
        let div = document.createElement('div');
        div.innerHTML = suggested.name;
        suggestions_pannel.appendChild(div);
        suggestions_items.push(div); // 요소를 배열에 추가

        // 클릭과 마우스오버 이벤트 처리
        div.addEventListener('click', function() {
          search_input.value = div.innerHTML;
          suggestions_pannel.innerHTML = '';
        });

        div.addEventListener('mouseover', function() {
          // 이전에 선택한 결과의 스타일을 제거
          if (current_selected_index > -1) {
            suggestions_items[current_selected_index].classList.remove("selected");
          }

          // 현재 선택한 결과에 스타일을 적용하고, 인덱스를 업데이트
          div.classList.add("selected");
          current_selected_index = suggestions_items.indexOf(div);
        });
      });
    
    
    
});
</script>