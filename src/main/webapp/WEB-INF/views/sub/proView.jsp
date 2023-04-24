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
$(document).ready(function(){
    $(".like-btn").on("click", function(e) {
        var likeCount = $(".like-count").text();
        var heartShape = $(".heart-shape");
        var pro_no = $("#productNum").val();

        $.ajax({
            url: "/like",
            type: "POST",
            data: {pro_no : pro_no},
            success: function(result) {
                heartShape.text(result == 1 ? "♥" : "♡");
            },
            error: function(xhr, status, error) {
                alert("데이터를 가져오지 못했습니다.");
            }   
        });
        
    });
    
});
</script>


<!-- #container -->
<div class="container">
    <div class="view-wrap">
        <!-- 좌측 : 상품 이미지 -->
        <div class="represent">
            <img id="imgRepresent" src="${contextPath}/resource/images/thum_big.jpg"/>
            <!-- 작은 썸네일 -->
            <ul class="represent-list">
                <li>
                    <a href="javascript:;" onMouseover="changeRepresentImage('0');">
                        <img class="imgServe" src="${contextPath}/resource/images/thum_big.jpg"/>
                    </a>
                </li>
                <li>
                    <a href="javascript:;" onMouseover="changeRepresentImage('1');">
                        <img class="imgServe" src="${contextPath}/resource/images/thum02.jpg"/>
                    </a>
                </li>
                <li>
                    <a href="javascript:;" onMouseover="changeRepresentImage('2');">
                        <img class="imgServe" src="${contextPath}/resource/images/thum_big.jpg"/>
                    </a>
                </li>
                <li>
                    <a href="javascript:;" onMouseover="changeRepresentImage('3');">
                        <img class="imgServe" src="${contextPath}/resource/images/thum02.jpg"/>
                    </a>
                </li>
            </ul>
        </div>

        <!-- 우측 : 상품 정보 -->
        <div class="view-info">
            <p class="category">카테고리 명</p>
            <p class="name pro-name">상품 등록 시 제목 영역</p>
            <p class="tag"># 슬기로운 자취생활</p>
            <p class="txt">상품에 대한 간략한 내용이 노출되는 영역입니다. 상품에 대한 간략한 내용이 노출되
                는 영역입니다. 상품에 대한 간략한 내용이 노출되는 영역입니다. </p>

            <div class="pro-price">
                <span class="tit">판매가</span>
                <span class="price">10,000</span>
                <span class="won">원</span>
            </div>

            <table>
                <tr>
                    <td col="col" width="30%">구매 시 가격</td>
                    <td>10,000 원</td>
                </tr>
                <tr>
                    <td>조회수</td>
                    <td>1,124</td>
                </tr>
                <tr>
                    <td>찜 횟수</td>
                    <td class="like-count">10</td>
                    <td class="heart-shape">
                      <c:if test="${result == '1'}">♥</c:if>
                      <c:if test="${result != '1'}">♡</c:if>
                    </td>
                </tr>
                <tr>
                    <td>사용 기간</td>
                    <td>3년 6개월</td>
                </tr>
            </table>

            <div class="btn">
            	<form>
            	<input id="productNum" type="hidden" name="pro_no" value="">
                <input type="submit" value="찜하기" class="like-btn">
                </form>
                <input type="button" id="cancelBtn" class="chat-btn" value="판매자에게 문의" onClick="location.href='#'">
              </div>

        </div>

        <!-- 하단 : 상품 상세 정보 -->
        <div class="info-wrap clearfix">
            <div class="info-tit">
                <p>상세정보</p>
            </div>
           
            <div class="info-con">
                <!-- 상품 상세 정보 불러오기 -->
                <div class="detail">
                    <p class="de-tit">기본 사양</p>
                    <div class="de-table">
                        <table>
                            <tr>
                                <td col="col" width="15%">제목</td>
                                <td>내용</td>
                            </tr>
                        </table>
                    </div>
                </div>

                <!-- 판매자 설명 -->
                <div class="seller-info">
                    <p class="de-tit">판매자 설명</p>
                    <div class="sell-wrap">
                        <p class="seller-txt">판매자 설명이 들어가는 곳입니다. 판매자 설명이 들어가는 곳입니다. </p>
                    </div>
                </div>
            </div>
            
        </div>

    </div>

    


    

	


	<c:import url="${contextPath}/WEB-INF/views/inc/footer.jsp"/>
