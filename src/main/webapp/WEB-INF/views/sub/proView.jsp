<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- \n을 <br>태그로 바꿔서 개행 설정 부분 -->
<% pageContext.setAttribute("newLineChar", "\n"); %>
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
	
	$("#like-btn").on("click", function() {
		var pro_no = $("#productNum").val();
    	var heartShape = $(".heart-shape");
    	var result = $("#result").val();
    	var like_count = $(".like-count");
    	
    	if(typeof result !== "undefined" && result === "1"){
    		$.ajax({
    			url : '/likeDelete',
    			type : 'POST',
    			data : {pro_no : pro_no},
    			success : function(map){
    				heartShape.text("♡");
    				like_count.text(map.likeCnt);
    				$("#result").val("0");
    				alert("찜목록에서 제거되었습니다.");
    			},
    			error : function(){
    				alert("좋아요 제거에 실패하였습니다.");
    			}
    		});
    	} else {
    		$.ajax({
    			url : '/likeInsert',
    			type : 'POST',
    			data : {pro_no : pro_no},
    			success : function(map){
    				heartShape.text("♥");
    				like_count.text(map.likeCnt);
    				$("#result").val("1");
    				alert("찜목록에 추가되었습니다.");
    			},
    			error : function(){
    				alert("좋아요 추가에 실패하였습니다.");
    			}
    		});
    	}
    });
	
	// 이미지 리스트
	let pro_no = '<c:out value="${pro.pro_no}"/>';
	let represent_list = $(".represent-list");
	console.log(pro_no)
	
	$.getJSON("/getProduceImageList", {pro_no : pro_no}, function(arr){	
		
		let obj = arr;
		for(let i=0; i < ${fn:length(image)}; i++){
			let fileCallPath = encodeURIComponent(obj[i].upload_path + "/s_" + obj[i].uuid + "_" + obj[i].file_name);

			let str = "";
		
			str = "<li>";
            str += "<a href='javascript:;' onMouseover='changeRepresentImage("+ i +");'";
            str += "data-path='" + obj[i].upload_path + "' data-uuid='" + obj[i].uuid + "' data-file_name='" + obj.file_name + "'";
            str += ">";
            str += "<img class='imgServe' src='/display?file_name="+fileCallPath + "'/>";
            str += "</a>";
            str += "</li>";
            
            represent_list.append(str);
		
		}
		
	});	
    
});

function chatSubmit() {
		document.getElementById('chatSubmit_form').submit();
	} 
</script>


<!-- #container -->
<div class="container">
    <div class="view-wrap">
        <!-- 좌측 : 상품 이미지 -->
        <div class="represent" data-pro_no="${image[0].pro_no}" data-path="${image[0].upload_path}" data-uuid="${image[0].uuid}" data-file_name="${image[0].file_name}">
            <img id="imgRepresent"/>
            <!-- 작은 썸네일 -->
            <ul class="represent-list">
            
            </ul>
        </div>

        <!-- 우측 : 상품 정보 -->
        <div class="view-info">
            <p class="category">${pro.pro_category}</p>
            <p class="name pro-name">${pro.pro_title}</p>
            <p class="tag">${pro.pro_theme}</p>
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
                    <td class="like-count">${pro.pro_like}</td>
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
            	<input id="result" type="hidden" value="${result}">
            	<input id="productNum" type="hidden" name="pro_no" value="${pro.pro_no}">
                <c:if test="${!empty login}">
                  <input id="like-btn" type="button" value="찜하기" class="like-btn">
                </c:if>
                <c:if test="${empty login}">
					<a href="login">
					 <input type="button" value="찜하기" class="like-btn">
					</a>
				</c:if>
                <c:if test="${!empty login && pro.seller_mem_no ne login.mem_no}">
                	<form:form id="chatSubmit_form" action="/createChatRoom" method="GET" modelAttribute="chatRoom">
						<a href="javascript:{}" onclick="chatSubmit()">
						<form:input type="hidden" path="seller_mem_no" value="${pro.seller_mem_no}"/>
						<form:input type="hidden" path="seller_mem_id" value="${pro.mem_id}"/>
						<form:input type="hidden" path="pro_no" value="${pro.pro_no}"/>
						<form:input type="hidden" path="pro_title" value="${pro.pro_title}"/>
                		<input type="button" id="chat_btn" class="chat-btn" value="판매자에게 문의">
						</a>
					</form:form>
				</c:if>
				<c:if test="${!empty login && pro.seller_mem_no eq login.mem_no}">
					<input type="button" id="chat_btn" class="chat-btn" value="내 상품">
				</c:if>
				<c:if test="${empty login}">
					<a href="login">
					<input type="button" id="chat_btn" class="chat-btn" value="판매자에게 문의">
					</a>
				</c:if>
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
                        <p class="seller-txt">${fn:replace(pro.pro_content, newLineChar, "<br/>")}</p>
                    </div>
                </div>
            </div>
            
        </div>

    </div>

    


    

	


	<c:import url="${contextPath}/WEB-INF/views/inc/footer.jsp"/>
