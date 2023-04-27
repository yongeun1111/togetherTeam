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

<script>

  $(document).ready(function(){
		$(".del-btn").each(function(){
			if ($(this).val() === 'Y'){
				$(this).prop('disabled', true);
				$(this).html('거래 완료');
			}
		})
		
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
		
		
	})
	
	function conf(pro_no){
		if(confirm("거래완료로 변경하시겠습니까? \n다시 거래중으로 되돌릴 수 없습니다. \n수락 하시겠습니까?")){
			// console.log(pro_no);
			
			$.ajax({
				url : '/proSaleChange',
				type : 'POST',
				data : {"pro_no" : pro_no},
				dataType : 'json',
				success : function(result){
					if(result.pro.pro_sale == 'Y'){
						$(".del-btn[value='"+pro_no+"']").prop('disabled', true);
						$(".del-btn[value='"+pro_no+"']").html('거래 완료');
						alert("거래가 완료되었습니다.");
						location.reload(); // 새로고침
					}
				},
				error : function(e){
					console.log(e);
					alert("거래 완료에 실패하였습니다.");
				}
						
			});
		}else{
			return;
		}
	}

</script>

<!-- #container -->
<div class="con-inner mypage-wrap">

  <div class="sub-inner">
    <h2 class="center">마이페이지</h2>
    <div class="tab-wrap">
      <ul class="tab-menu">
        <li><a href="/mypage_memInfo">회원정보 수정</a></li>
        <li><a href="/mypage_likeList">내가 찜한 목록</a></li>
        <li class="on"><a href="#">판매 내역</a></li>
      </ul>
    </div>

    <div class="info-box clearfix">
      <ul>
        <li>아래 목록에서 내가 판매한 목록을 확인하실수 있습니다.</li>
      </ul>
    </div>

    <div class="meminfo-wrap">
      <p class="myapge-tit mb10">판매 내역</p>
      <table class="meminfo-table">
        <!-- 리스트 내용 있을 경우 -->
        <c:if test="${!empty list}">
          <c:forEach items="${list}" var="list">
            <tr class="trHover">
              <td col="col" width="13%" class="memSaleImage">
              <a href="/proView?pro_no=${list.pro_no}">
                <div class="image_wrap" data-pro_no="${list.pro_no}" data-path="${list.upload_path}" data-uuid="${list.uuid}" data-file_name="${list.file_name}">
                  <img>
                </div>
              </a>
              </td>
              <td>
              <a href="/proView?pro_no=${list.pro_no}">
                <!-- 상품 카테고리, 제조사, 제목 -->
                <ul class="pro-info">
                  <li class="pro-cate">${list.pro_category}</li\>
                  <li class="pro-com">${list.maker}</span>
                </ul>
                <p class="name">${list.pro_title}</p>
              </a>
              </td>
              <td col="col" width="15%">
                <p class="price">${list.pro_sale_price} <span class="won">원</span></p>
              </td>
              <td col="col" width="18%">
                <!-- 버튼 n이면 활성화, y면 비활성화/${list.pro_sale} -->
                <button class="del-btn" value="${list.pro_sale}" onclick="conf(${list.pro_no})">거래 중</button>
              </td>
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
        <ul class="pagination justify-content-center">
         	<!-- 이전버튼 -->
			<li class="page-item page-prev">
				<a class="page-link" id="prev" data-value="${pm.prev}" href="${pm.startPage-1}"></a>
			</li>
          	
          <!-- 페이지 번호 -->
          <c:forEach var="pageNum" begin="${pm.startPage}" end="${pm.endPage}">
    			  <li class="page-item page-num ${pm.cri.page==pageNum ? 'active' : ''}">
    				  <a class="page-link" href="${pageNum}">${pageNum}</a>
    			  </li>
  		 </c:forEach>
          	
          <!-- 다음 버튼 -->
		  <li class="page-item page-next">
  				<a class="page-link" id="next" data-value="${pm.next}" href="${pm.endPage+1}"></a>
  		  </li>
        </ul>
      </div>
  		
  		<form id="pageForm" action="/mypage_proSale" method="get" >
 			  <input type="hidden" id="page" name="page" value="${pm.cri.page}"/>
      	</form>      
        
    </div>
  </div>
  
</div>

<c:import url="../inc/footer.jsp"/>

                    
