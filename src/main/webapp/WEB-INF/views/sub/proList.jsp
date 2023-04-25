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


<!-- #container -->
<div class="container">
	<h2 class="pt80">중고 상품</h2>
	<div class="pro-list">

		<!-- Nav tabs -->
		<ul class="nav nav-tabs row">
			<li class="nav-item col">
				<a class="nav-link active" data-toggle="tab" href="#tab01">ALL</a>
			</li>
			<li class="nav-item col">
				<a class="nav-link" data-toggle="tab" href="#tab02">에어프라이어</a>
			</li>
			<li class="nav-item col">
				<a class="nav-link" data-toggle="tab" href="#tab03">전기포트</a>
			</li>
			<li class="nav-item col">
				<a class="nav-link" data-toggle="tab" href="#tab04">전자렌지</a>
			</li>
			<li class="nav-item col">
				<a class="nav-link" data-toggle="tab" href="#tab05">토스트기</a>
			</li>
			<li class="nav-item col">
				<a class="nav-link" data-toggle="tab" href="#tab06">헤어드라이기</a>
			</li>
			<li class="nav-item col">
				<a class="nav-link" data-toggle="tab" href="#tab07">공기청정기</a>
			</li>
		</ul>
	  
		<!-- Tab panes -->
		<div class="tab-content">

			<!-- 01. ALL -->
			<div id="tab01" class="pro-m tab-pane active">
				<div class="row">
					<c:forEach var="vo" items="${list}">
						<div class="col-sm">
							<a href="/proView?pro_no=${vo.pro_no}">
								<div class="pro-img" data-pro_no="${vo.pro_no}" data-path="${vo.upload_path}" data-uuid="${vo.uuid}" data-file_name="${vo.file_name}">
									<img alt="">
								</div>
								<div class="pro-info">
									<p class="name">${vo.pro_title}</p>
									<p class="price">
										${vo.pro_sale_price}<span class="won">원</span>
									</p>
								</div>
							</a>
						</div>
					</c:forEach>

					<!-- 02. 에어프라이어 -->
					<div id="tab02" class="container tab-pane fade"><br>
						<h3>Menu 1</h3>
						<p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
					</div>

					<!-- 03. 전기포트 -->
					<div id="tab03" class="container tab-pane fade"><br>
						<h3>Menu 2</h3>
						<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
					</div>

					<!-- 04. 전자렌지 -->
					<div id="tab04" class="container tab-pane fade"><br>
						<h3>Menu 2</h3>
						<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
					</div>

					<!-- 05. 토스트기 -->
					<div id="tab05" class="container tab-pane fade"><br>
						<h3>Menu 2</h3>
						<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
					</div>

					<!-- 06. 헤어드라이기 -->
					<div id="tab06" class="container tab-pane fade"><br>
						<h3>Menu 2</h3>
						<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
					</div>

					<!-- 07. 공기청정기 -->
					<div id="tab07" class="container tab-pane fade"><br>
						<h3>Menu 2</h3>
						<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
					</div>
				</div>
			</div>
		</div>

		
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

		<form id="pageFrm" action="proList" method="get">
			<input type="hidden" id="page" name="page" value="${pm.cri.page}">
		</form>

	</div>

	<c:import url="${contextPath}/WEB-INF/views/inc/footer.jsp"/>
