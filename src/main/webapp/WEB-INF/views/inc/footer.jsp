<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

				</div>
				<!-- end :container-->
				<footer>
					<div class="info_contact main"> 
						<img src="${contextPath}/resource/images/logo.png" alt="사이트 이름"><span class="ally-hidden">메인페이지 이동</span>
						<div class="info-wrap">
							<ul>   
								<li>(주)SHOPPLE</li>
								<li>대표자 : 이소정</li>
								<li>사업자 등록번호 : 123-45-67890</li>
								<li>통신판매신고번호 : 제1234-광주송암-1234호</li>
								<li>주소 : 광주광역시 남구 송암로 60 광주CGI센터 2층</li>
								<li>Tel : 062-655-3506, 9</li>
								<li>E-mail : abc@smart.com</li>
							</ul>
							<p class="clearfix">Copyright © LOGO. All rights reserved.</p>
						</div>
						
					</div>
				</footer>
				
			</div>
			<!-- #wrap-->

			<script>
				// 리스트 마우스 오버시
				let trHover = document.querySelectorAll(".trHover");

				$(document).ready(function () {
					$(".trHover").mouseover(function () {
						// Java Script 		document.getElementsByClassName("cls").style.backgroundColor;
						// $(this).css('background', '#00ff00');
						$(this).css('background', 'rgba(0, 0, 0, 0.01)');
					});
					$(".trHover").mouseout(function () {
						$(this).css('background', 'rgba(255, 255, 255, 0)');
					});
				});
			</script>
		</body>
</html>
		