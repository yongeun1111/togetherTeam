<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<c:import url="${contextPath}/WEB-INF/views/inc/headerScript.jsp"/>
<c:import url="${contextPath}/WEB-INF/views/inc/header.jsp"/>

<link rel="stylesheet" href="${contextPath}/resource/css/com/style.css">
<link rel="stylesheet" href="${contextPath}/resource/css/pages/sub.css">
<link rel="stylesheet" href="${contextPath}/resource/css/pages/sub_media.css">
<script src="${contextPath}/resource/js/jquery/gsap.min.js"></script>
<script src="${contextPath}/resource/js/jquery/ScrollTrigger.min.js"></script>
<script src="${contextPath}/resource/js/pages/sub.js"></script>



<!-- #container -->
<div class="con-inner mypage-wrap">

  <div class="sub-inner">
    <h2 class="center">마이페이지</h2>
    <div class="tab-wrap">
      <ul class="tab-menu">
        <li><a href="/mypage_memInfo">회원정보 수정</a></li>
        <li><a href="javascript:;">내가 찜한 목록</a></li>
        <li class="on"><a href="/mypage_proSale">판매 내역</a></li>
      </ul>
    </div>

    <div class="info-box clearfix">
      <ul>
        <li>아래 목록에서 내가 판매한 목록을 확인하실수 있습니다.</li>
      </ul>
    </div>

    <div class="meminfo-wrap">
      <p class="mb20">※ 판매 내역</p>
      <table class="meminfo-table">
        <!-- 리스트 내용 있을 경우 -->
        <c:if test="${!empty list}">
          <c:forEach items="${list}" var="list">
            <tr>
              <td col="col" width="13%" class="memSaleImage">
                <div class="image_wrap" data-pro_no="${list.pro_no}" data-path="${list.upload_path}" data-uuid="${list.uuid}" data-file_name="${list.file_name}">
                  <img>
                </div>
              </td>
              <td>카테고리 : ${list.pro_category}, 메이커 : ${list.maker}, 제목 : ${list.pro_title}</td>
              <td>${list.pro_sale_price}</td>
              <td>버튼 n이면 활성화, y면 비활성화/${list.pro_sale}</td>
            </tr>
          </c:forEach>
        </c:if>
        <!-- 리스트 내용 없을 경우 -->
        <c:if test="${empty list}">
            <tr>
              <td class="empty-area">
                <p><img src="${contextPath}/resource/images/empty_icon.png" alt=""></p>
                <p class="mt30">판매 내역 존재하지 않습니다.</p>
              </td>
            </tr>
        </c:if>
      </table>

      <div class="pageMaker_wrap">
        <ul class="pagination justify-content-center" style="margin: 20px 0">
         	<!-- 이전버튼 -->
         	<c:if test="${pm.prev}">
				    <li class="page-item">
					    <a class="page-link" href="${pm.startPage-1}">◁</a>
				    </li>
			    </c:if>
          	
          <!-- 페이지 번호 -->
          <c:forEach var="pageNum" begin="${pm.startPage}" end="${pm.endPage}">
    			  <li class="page-item ${pm.cri.page==pageNum ? 'active' : ''}">
    				  <a class="page-link" href="${pageNum}">${pageNum}</a>
    			  </li>
  			  </c:forEach>
          	
          <!-- 다음 버튼 -->
	        <c:if test="${pm.next}">
  				  <li class="page-item">
  					  <a class="page-link" href="${pm.endPage+1}">▷</a>
  				  </li>
  			  </c:if>
        </ul>
      </div>
  		
  		<form id="pageForm" action="/mypage_proSale" method="get" >
 			  <input type="hidden" id="page" name="page" value="${pm.cri.page}"/>
      </form>      
        
    </div>
  </div>
  
</div>

<c:import url="../inc/footer.jsp"/>

                    
