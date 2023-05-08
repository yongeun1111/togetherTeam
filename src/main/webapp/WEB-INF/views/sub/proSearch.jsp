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
    const suggestions_panel = document.querySelector(".suggestions_panel");
    const search_btn = document.getElementById("search");
    
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
    
    let suggestionElements = [];
    let selectionIndex = -1;
    let inputs = [];
    
    search_input.addEventListener('keyup', function(event){

        suggestions_panel.innerHTML='';
        let input = search_input.value;
        
    	let suggestions = s_jsonArray.filter(function(exam){
	        if (event.keyCode === 38 || event.keyCode === 40) {
	        	inputs.push(input);
	            return exam.name.toLowerCase().includes(inputs[0]);
	        } else {
	        	inputs = [];
            	return exam.name.toLowerCase().includes(input);
	        }
        });
		
        if(input === ""){
            suggestions_panel.innerHTML='';
        } else {
        suggestions.forEach(function(suggested){
            let div = document.createElement('div');
            div.innerHTML = suggested.name;
            suggestions_panel.appendChild(div);
            // 클릭처리 
            div.onclick= () =>{
                search_input.value = div.innerHTML; 
                suggestions_panel.innerHTML='';
            }
        });
        }
        suggestionElements = Array.from(
        	    document.querySelectorAll(".suggestions_panel div")
        );
        
        if (event.keyCode === 13) {
            event.preventDefault();
            suggestions_panel.innerHTML='';
            search_btn.click();
        }
        if (event.keyCode === 8) {
      	    selectionIndex = -1;
      	    suggestionElements.forEach(function(div) {
      	    div.classList.remove("selected");
      	  });
        }
        if (event.keyCode === 38) {
            event.preventDefault();
            if (selectionIndex > 0) {
              selectionIndex--;
              selectDiv();
            } else if (selectionIndex <= 0 ) {
            	selectionIndex = -1 ;
            	search_input.value = inputs[0];
            }
        } 
        if (event.keyCode === 40) {
            event.preventDefault();
            if (selectionIndex < suggestions.length -1) {
              selectionIndex++;
              selectDiv();
            } else if (selectionIndex >= suggestions.length -1) {
            	selectionIndex = suggestions.length -1;
            	selectDiv();
            }
        }
        
        console.log(inputs[0]);
        console.log(inputs.length);
        console.log(input);
   
    });
    
    search_btn.addEventListener('click', function() {
    	search_input.value = "";
    	suggestions_panel.innerHTML = "";
    });
    
    function selectDiv() {
    	  suggestionElements.forEach(function(div) {
    	    div.classList.remove("selected");
    	  });
    	  if (selectionIndex >= 0 && selectionIndex < suggestionElements.length) {
    	    let selectedDiv = suggestionElements[selectionIndex];
    	    selectedDiv.classList.add("selected");
    	    search_input.value = selectedDiv.innerHTML;
    	  }
    	}
    
});
</script>