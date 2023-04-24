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
            <div class="meminfo-wrap">
                <p class="mypage-tit mb10">내가 찜한 목록</p>
                <form action="#">
        
                    <table class="meminfo-table like-table">
                        <!-- 리스트 내용 있을 경우 -->
                        <c:if test="${!empty list}">
                        <c:forEach items="${list}" var="list">
                            <tr>
                            <td class="meminfo-img" col="col" width="15%">
                                <img src="${contextPath}/resource/images/thum_img.jpg" alt="">
                            </td>
                            <td>
                                <ul class="pro-info">
                                <li class="pro-cate">${vo.pro_category}</li>
                                <li class="pro-com">제조사</li>
                                </ul>
                                <p class="name">${vo.pro_title}</p>
                            </td>
                            <td col="col" width="15%">
                                <p class="price">${vo.pro_sale_price} <span class="won">원</span></p>
                            </td>
                            <td col="col" width="18%">
                                <button class="del-btn">삭제</button>
                            </td>
                            </tr>
                        </c:forEach> 
                        </c:if>
                        
                        <!-- 리스트 내용 없을 경우 -->
                        <c:if test="${empty list}">
                        <tr>
                            <td class="empty-area">
                            <p><img src="${contextPath}/resource/images/empty_icon.png" alt=""></p>
                            <p class="mt30">찜한 상품이 존재하지 않습니다.</p>
                            </td>
                        </tr>
                        </c:if>
                    </table>

                   <!-- 리스트 내용 있을 경우 -->
                    <c:if test="${!empty list}">
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
                    </c:if>
            
                    <!-- 리스트 내용 없을 경우 -->
                    <c:if test="${empty list}">
                    
                    </c:if>
                    
                   
            
                </form>
            </div>
        </div>
    </div> 

</div>
<c:import url="${contextPath}/WEB-INF/views/inc/footer.jsp"/>
