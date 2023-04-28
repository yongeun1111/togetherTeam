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
            <div class="search-input-wrap">
                <input type="text" id="searchProduct" placeholder="어떤 상품을 찾고 계신가요?"/>
                <button id="search" class="search-btn">
                    <span><img src="${contextPath}/resource/images/search_icon.png" alt=""></span>
                </button>   
            </div>
        </div>       
    </div>

    <!-- 검색 결과 -->
    <div class="sub-inner">
        <div class="search-result">
            
        </div>
    </div> 

</div>

<c:import url="${contextPath}/WEB-INF/views/inc/footer.jsp"/>
