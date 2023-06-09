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

<script type="text/javascript">
$(document).ready(function() {
    $(".del-btn").on("click", function() {
        var pro_no = $(this).data("pro-no");
        var currentPage = parseInt($("#page").val());

        $.ajax({
            url: "/likeDelete_mypage",
            type: "POST",
            data: {pro_no : pro_no, page : currentPage},
            success: function() {
            	location.href = "/mypage_likeList?page=" + currentPage;
            },
            error: function() {
                alert("좋아요 제거에 실패하였습니다.");
            }
        });
    });
    if($("#next").data("value") == false){
		$("#next").click(function(e){
			// console.log(${pm.endPage});
			// e.preventDefault();
			$("#next").attr('href', '${pm.endPage}');
			$("#page").val(${pm.endPage});
			$("#pageForm").submit();
			})
		}
	
	if($("#prev").data("value") == false){
		$("#prev").click(function(e){
			$("#prev").attr('href', '${pm.startPage}');
			$("#page").val(${pm.startPage});
			$("#pageForm").submit();
		})
	}
});
</script>

<!-- #container -->
<div class="con-inner mypage-wrap">

  <div class="sub-inner">
    <h2 class="center">My 페이지</h2>
    <div class="tab-wrap">
      <ul class="tab-menu">
        <li><a href="mypage_memInfo">회원정보 수정</a></li>
        <li class="on"><a href="#">내가 찜한 목록</a></li>
        <li><a href="/mypage_proSale">판매 내역</a></li>
      </ul>
    </div>

    <div class="info-box clearfix">
      <ul>
        <li>아래 목록에서 내가 찜한 상품의 목록을 확인하실수 있습니다.</li>
        <li>찜한 상품을 삭제하고 싶으시면 삭제 버튼을 클릭해 주세요.</li>
      </ul>
    </div>

    <div class="meminfo-wrap">
      <p class="mypage-tit mb10">내가 찜한 목록</p>

      <table class="meminfo-table like-table">
        <!-- 리스트 내용 있을 경우 -->
        <c:if test="${!empty list}">
          <c:forEach items="${list}" var="vo">
            <tr class="trHover">
             <c:forEach var="i" begin="0" end="${fn:length(image)}">
               <c:forEach items="${image[i]}" var="image">
                <c:if test="${vo.pro_no == image.pro_no}">
                 <td class="meminfo-img" col="col" width="15%" data-pro_no="${vo.pro_no}" data-path="${image.upload_path}" data-uuid="${image.uuid}" data-file_name="${image.file_name}">
                  <a href="/proView?pro_no=${vo.pro_no}">
                  <img alt="">
                  </a>
                 </td>
                </c:if>
               </c:forEach>
              </c:forEach>
              <td>
                <a href="/proView?pro_no=${vo.pro_no}">
                  <ul class="pro-info">
                    <li class="pro-cate">${vo.pro_category}</li>
                    <li class="pro-com">${vo.maker}</li>
                  </ul>
                  <p class="name">${vo.pro_title}</p>
                </a>
              </td>
              <td col="col" width="15%">
                <p class="price">${vo.pro_sale_price} <span class="won">원</span></p>
              </td>
              <td col="col" width="18%">
                <button class="del-btn" data-pro-no="${vo.pro_no}">삭제</button>
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

	  
	  
      <div class="page">
        <ul class="pagination justify-content-center">
         	<!-- 이전버튼 -->
         	<c:if test="${!empty list}">
			<li class="page-item page-prev">
				<a class="page-link" id="prev" data-value="${pm.prev}" href="${pm.startPage-1}"></a>
			</li>
			</c:if>
			
			<!-- 페이지 번호 -->
          	<c:forEach var="pageNum" begin="${pm.startPage}" end="${pm.endPage}">
    			  <li class="page-item ${pm.cri.page==pageNum ? 'active' : ''}">
    			  	  <c:if test="${!empty list}">
    				  <a class="page-link" href="${pageNum}">${pageNum}</a>
    				  </c:if>
    			  </li>
  		 	</c:forEach>
  		 	
			<!-- 다음 버튼 -->
          	<c:if test="${!empty list}">
		  	<li class="page-item page-next">
  				<a class="page-link" id="next" data-value="${pm.next}" href="${pm.endPage+1}"></a>
  		  	</li>
  		  	</c:if>
          </ul>
        </div>

          <form id="pageForm" action="mypage_likeList" method="get">
            <input type="hidden" id="page" name="page" value="${pm.cri.page}">
          </form>
      </div>

    </div>

  </div>
  
</div>


<c:import url="../inc/footer.jsp"/>

                    
