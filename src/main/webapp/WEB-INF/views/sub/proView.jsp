<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
	var txt = $(".seller-txt").text();
	var modifyTxt = "";
	if (txt.length > 10) {
		modifyTxt = txt.slice(0, 10)+"...";
	} else {
		modifyTxt = txt;
	}
	$(".txt").text(modifyTxt);
	
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
            <p class="category">${pro.pro_category}</p>
            <p class="name pro-name">${pro.pro_title}</p>
            <p class="tag"># ${pro.pro_theme}</p>
            <p class="txt"></p>

            <div class="pro-price">
                <span class="tit">판매가</span>
                <span class="price">${pro.pro_sale_price}</span>
                <span class="won">원</span>
            </div>

            <table>
                <tr>
                    <td col="col" width="30%">구매 시 가격</td>
                    <td>${pro.pro_buy_price} 원</td>
                </tr>
                <tr>
                    <td>조회수</td>
                    <td>${pro.views}</td>
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
                    <td>${pro.buy_date}</td>
                </tr>
            </table>

            <div class="btn">
            	<form>
            	<input id="productNum" type="hidden" name="pro_no" value="">
                <input type="submit" value="찜하기" class="like-btn">
                </form>
                <form:form id="chatSubmit_form" action="/createChatRoom" method="GET" modelAttribute="chatRoom">
				<a href="javascript:{}" onclick="chatSubmit()">
				<form:input type="hidden" path="seller_mem_no" value="${vo.seller_mem_no}"/>
				<form:input type="hidden" path="seller_mem_id" value="${vo.mem_id}"/>
				<form:input type="hidden" path="pro_no" value="${vo.pro_no}"/>
				<form:input type="hidden" path="pro_title" value="${vo.pro_title}"/>
                <input type="button" id="cancelBtn" class="chat-btn" value="판매자에게 문의">
			</a>
		</form:form>
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
                        <p class="seller-txt">${pro.pro_content}</p>
                    </div>
                </div>
            </div>
            
        </div>

    </div>

    


    

	


	<c:import url="${contextPath}/WEB-INF/views/inc/footer.jsp"/>
