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
    
	let pro_cate = $(".category").text();
	let pro_name = $("#pro_name").val();
	let pro_de = $("#pro_de");
	let pro_deInf = "";
	
	$.ajax({
		url: "./resource/json/"+pro_cate+".json", // json 파일 경로
		dataType: "json",
   		success: function(data) {
			let pro_Ex = [];
			for(let i = 0; i < data.length; i++){
				if(data[i].title.includes(pro_name)){
					pro_Ex.push(data[i]);
					if(data[i].title == pro_name){
						pro_Ex = [];
						pro_Ex.push(data[i]);
					}
				}
			}
			console.log(pro_Ex[0]);
			$("#detailInformation").remove();
			if(pro_cate == '공기청정기'){
				pro_deInf += "<table id='detailInformation'>";
				pro_deInf += "<tr>";
				pro_deInf += "<td col='col' width='15%'> 제조사 </td>";
				pro_deInf += "<td width='35%'>" + pro_Ex[0].company +"</td>";
				pro_deInf += "<td col='col' width='15%'> 제품명 </td>";
				pro_deInf += "<td width='35%'>" + pro_Ex[0].title +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 카테고리 </td>";
				pro_deInf += "<td>" + pro_Ex[0].품목 +"</td>";
				pro_deInf += "<td> 용도 </td>";
				pro_deInf += "<td>" + pro_Ex[0].용도 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 공기청정방식 </td>";
				pro_deInf += "<td>" + pro_Ex[0].공기청정방식 +"</td>";
				pro_deInf += "<td> 사용면적 </td>";
				pro_deInf += "<td>" + pro_Ex[0].사용면적 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 인증 </td>";
				pro_deInf += "<td>" + pro_Ex[0].인증 +"</td>";
				pro_deInf += "<td> 필터단계 </td>";
				pro_deInf += "<td>" + pro_Ex[0].필터단계 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 필터 </td>";
				pro_deInf += "<td>" + pro_Ex[0].필터 +"</td>";
				pro_deInf += "<td> 이온 </td>";
				pro_deInf += "<td>" + pro_Ex[0].이온 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 센서 </td>";
				pro_deInf += "<td>" + pro_Ex[0].센서 +"</td>";
				pro_deInf += "<td> 주요기능 </td>";
				pro_deInf += "<td>" + pro_Ex[0].주요기능 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 미세먼지 </td>";
				pro_deInf += "<td>" + pro_Ex[0].미세먼지 +"</td>";
				pro_deInf += "<td> 풍량조절 </td>";
				pro_deInf += "<td>" + pro_Ex[0].풍량조절 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 모드 </td>";
				pro_deInf += "<td>" + pro_Ex[0].모드 +"</td>";
				pro_deInf += "<td> 청정도표시 </td>";
				pro_deInf += "<td>" + pro_Ex[0].청정도표시 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 부가기능 </td>";
				pro_deInf += "<td>" + pro_Ex[0].부가기능 +"</td>";
				pro_deInf += "<td> 에너지효율 </td>";
				pro_deInf += "<td>" + pro_Ex[0].에너지효율 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 소비전력 </td>";
				pro_deInf += "<td>" + pro_Ex[0].소비전력 +"</td>";
				pro_deInf += "<td> 크기 </td>";
				pro_deInf += "<td>" + pro_Ex[0].크기 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 무게 </td>";
				pro_deInf += "<td>" + pro_Ex[0].무게 +"</td>";
				pro_deInf += "<td> 소음 </td>";
				pro_deInf += "<td>" + pro_Ex[0].소음 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 필터등급 </td>";
				pro_deInf += "<td>" + pro_Ex[0].필터등급 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "</table>";
				pro_de.append(pro_deInf);
			}else if(pro_cate == '에어프라이어'){
				pro_deInf += "<table id='detailInformation'>";
				pro_deInf += "<tr>";
				pro_deInf += "<td col='col' width='15%'> 제조사 </td>";
				pro_deInf += "<td width='35%'>" + pro_Ex[0].company +"</td>";
				pro_deInf += "<td col='col' width='15%'> 제품명 </td>";
				pro_deInf += "<td width='35%'>" + pro_Ex[0].title +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 카테고리 </td>";
				pro_deInf += "<td>" + pro_Ex[0].품목 +"</td>";
				pro_deInf += "<td> 용량 </td>";
				pro_deInf += "<td>" + pro_Ex[0].용량 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 조작부 </td>";
				pro_deInf += "<td>" + pro_Ex[0].조작부 +"</td>";
				pro_deInf += "<td> 코팅 </td>";
				pro_deInf += "<td>" + pro_Ex[0].코팅 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 자동요리메뉴 </td>";
				pro_deInf += "<td>" + pro_Ex[0].자동요리메뉴 +"</td>";
				pro_deInf += "<td> 온도조절 </td>";
				pro_deInf += "<td>" + pro_Ex[0].온도조절 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 타이머 </td>";
				pro_deInf += "<td>" + pro_Ex[0].타이머 +"</td>";
				pro_deInf += "<td> 부가기능 </td>";
				pro_deInf += "<td>" + pro_Ex[0].부가기능 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 소비전력 </td>";
				pro_deInf += "<td>" + pro_Ex[0].소비전력 +"</td>";
				pro_deInf += "<td> 색상 </td>";
				pro_deInf += "<td>" + pro_Ex[0].색상 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 크기 </td>";
				pro_deInf += "<td>" + pro_Ex[0].크기 +"</td>";
				pro_deInf += "<td> 기름받이 </td>";
				pro_deInf += "<td>" + pro_Ex[0].기름받이 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 무게 </td>";
				pro_deInf += "<td>" + pro_Ex[0].무게 +"</td>";
				pro_deInf += "<td> 안전기능 </td>";
				pro_deInf += "<td>" + pro_Ex[0].안전기능 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "</table>";
				pro_de.append(pro_deInf);
			}else if(pro_cate == '전기포트'){
				pro_deInf += "<table id='detailInformation'>";
				pro_deInf += "<tr>";
				pro_deInf += "<td col='col' width='15%'> 제조사 </td>";
				pro_deInf += "<td width='35%'>" + pro_Ex[0].company +"</td>";
				pro_deInf += "<td col='col' width='15%'> 제품명 </td>";
				pro_deInf += "<td width='35%'>" + pro_Ex[0].title +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 카테고리 </td>";
				pro_deInf += "<td>" + pro_Ex[0].품목 +"</td>";
				pro_deInf += "<td> 용량 </td>";
				pro_deInf += "<td>" + pro_Ex[0].용량 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 수위표시창 </td>";
				pro_deInf += "<td>" + pro_Ex[0].수위표시창 +"</td>";
				pro_deInf += "<td> 받침대 </td>";
				pro_deInf += "<td>" + pro_Ex[0].받침대 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 거름망 </td>";
				pro_deInf += "<td>" + pro_Ex[0].거름망 +"</td>";
				pro_deInf += "<td> 부가기능 </td>";
				pro_deInf += "<td>" + pro_Ex[0].부가기능 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 안전기능 </td>";
				pro_deInf += "<td>" + pro_Ex[0].안전기능 +"</td>";
				pro_deInf += "<td> 소비전력 </td>";
				pro_deInf += "<td>" + pro_Ex[0].소비전력 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 크기 </td>";
				pro_deInf += "<td>" + pro_Ex[0].크기 +"</td>";
				pro_deInf += "<td> 형태 </td>";
				pro_deInf += "<td>" + pro_Ex[0].형태 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 재질 </td>";
				pro_deInf += "<td>" + pro_Ex[0].재질 +"</td>";
				pro_deInf += "<td> 온도조절 </td>";
				pro_deInf += "<td>" + pro_Ex[0].온도조절 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 온도범위 </td>";
				pro_deInf += "<td>" + pro_Ex[0].온도범위 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "</table>";
				pro_de.append(pro_deInf);
			}else if(pro_cate == '전자렌지'){
				pro_deInf += "<table id='detailInformation'>";
				pro_deInf += "<tr>";
				pro_deInf += "<td col='col' width='15%'> 제조사 </td>";
				pro_deInf += "<td width='35%'>" + pro_Ex[0].company +"</td>";
				pro_deInf += "<td col='col' width='15%'> 제품명 </td>";
				pro_deInf += "<td width='35%'>" + pro_Ex[0].title +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 카테고리 </td>";
				pro_deInf += "<td>" + pro_Ex[0].품목 +"</td>";
				pro_deInf += "<td> 용량 </td>";
				pro_deInf += "<td>" + pro_Ex[0].용량 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 조작부 </td>";
				pro_deInf += "<td>" + pro_Ex[0].조작부 +"</td>";
				pro_deInf += "<td> 조리실코팅 </td>";
				pro_deInf += "<td>" + pro_Ex[0].조리실코팅 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 자동요리 </td>";
				pro_deInf += "<td>" + pro_Ex[0].자동요리 +"</td>";
				pro_deInf += "<td> 조리기능 </td>";
				pro_deInf += "<td>" + pro_Ex[0].조리기능 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 온도조절 </td>";
				pro_deInf += "<td>" + pro_Ex[0].온도조절 +"</td>";
				pro_deInf += "<td> 스마트인버터 </td>";
				pro_deInf += "<td>" + pro_Ex[0].스마트인버터 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 부가기능 </td>";
				pro_deInf += "<td>" + pro_Ex[0].부가기능 +"</td>";
				pro_deInf += "<td> 유리 </td>";
				pro_deInf += "<td>" + pro_Ex[0].유리 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 안전기능 </td>";
				pro_deInf += "<td width='25%'>" + pro_Ex[0].안전기능 +"</td>";
				pro_deInf += "<td> 절전 </td>";
				pro_deInf += "<td>" + pro_Ex[0].절전 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 출력 </td>";
				pro_deInf += "<td width='25%'>" + pro_Ex[0].출력 +"</td>";
				pro_deInf += "<td> 소비전력 </td>";
				pro_deInf += "<td>" + pro_Ex[0].소비전력 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 색상 </td>";
				pro_deInf += "<td>" + pro_Ex[0].색상 +"</td>";
				pro_deInf += "<td> 크기 </td>";
				pro_deInf += "<td>" + pro_Ex[0].크기 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 도어열림 </td>";
				pro_deInf += "<td>" + pro_Ex[0].도어열림 +"</td>";
				pro_deInf += "<td> 무게 </td>";
				pro_deInf += "<td>" + pro_Ex[0].무게 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "</table>";
				pro_de.append(pro_deInf);
			}else if(pro_cate == '토스트기'){
				pro_deInf += "<table id='detailInformation'>";
				pro_deInf += "<tr>";
				pro_deInf += "<td col='col' width='15%'> 제조사 </td>";
				pro_deInf += "<td width='35%'>" + pro_Ex[0].company +"</td>";
				pro_deInf += "<td col='col' width='15%'> 제품명 </td>";
				pro_deInf += "<td width='35%'>" + pro_Ex[0].title +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 카테고리 </td>";
				pro_deInf += "<td>" + pro_Ex[0].품목 +"</td>";
				pro_deInf += "<td> 투입구 </td>";
				pro_deInf += "<td>" + pro_Ex[0].투입구 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 주요기능 </td>";
				pro_deInf += "<td>" + pro_Ex[0].주요기능 +"</td>";
				pro_deInf += "<td> 굽기조절 </td>";
				pro_deInf += "<td>" + pro_Ex[0].굽기조절 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 받침대 </td>";
				pro_deInf += "<td>" + pro_Ex[0].받침대 +"</td>";
				pro_deInf += "<td> 구성 </td>";
				pro_deInf += "<td>" + pro_Ex[0].구성 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 소비전력 </td>";
				pro_deInf += "<td>" + pro_Ex[0].소비전력 +"</td>";
				pro_deInf += "<td> 색상 </td>";
				pro_deInf += "<td>" + pro_Ex[0].색상 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 안전기능 </td>";
				pro_deInf += "<td>" + pro_Ex[0].안전기능 +"</td>";
				pro_deInf += "<td> 부가기능 </td>";
				pro_deInf += "<td>" + pro_Ex[0].부가기능 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 뚜껑기능 </td>";
				pro_deInf += "<td>" + pro_Ex[0].뚜껑기능 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "</table>";
				pro_de.append(pro_deInf);
			}else if(pro_cate == '헤어드라이기'){
				pro_deInf += "<table id='detailInformation'>";
				pro_deInf += "<tr>";
				pro_deInf += "<td col='col' width='15%'> 제조사 </td>";
				pro_deInf += "<td width='35%'>" + pro_Ex[0].company +"</td>";
				pro_deInf += "<td col='col' width='15%'> 제품명 </td>";
				pro_deInf += "<td width='35%'>" + pro_Ex[0].title +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 카테고리 </td>";
				pro_deInf += "<td>" + pro_Ex[0].품목 +"</td>";
				pro_deInf += "<td> 손잡이 </td>";
				pro_deInf += "<td>" + pro_Ex[0].손잡이 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 방식 </td>";
				pro_deInf += "<td>" + pro_Ex[0].방식 +"</td>";
				pro_deInf += "<td> 풍량조절 </td>";
				pro_deInf += "<td>" + pro_Ex[0].풍량조절 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 조작부 </td>";
				pro_deInf += "<td>" + pro_Ex[0].조작부 +"</td>";
				pro_deInf += "<td> 온도조절 </td>";
				pro_deInf += "<td>" + pro_Ex[0].온도조절 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 발생성분 </td>";
				pro_deInf += "<td>" + pro_Ex[0].발생성분 +"</td>";
				pro_deInf += "<td> 노즐 </td>";
				pro_deInf += "<td>" + pro_Ex[0].노즐 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 부가기능 </td>";
				pro_deInf += "<td>" + pro_Ex[0].부가기능 +"</td>";
				pro_deInf += "<td> 안전기능 </td>";
				pro_deInf += "<td>" + pro_Ex[0].안전기능 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 코드길이 </td>";
				pro_deInf += "<td>" + pro_Ex[0].코드길이 +"</td>";
				pro_deInf += "<td> 무게 </td>";
				pro_deInf += "<td>" + pro_Ex[0].무게 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "<tr>";
				pro_deInf += "<td> 소비전력 </td>";
				pro_deInf += "<td>" + pro_Ex[0].소비전력 +"</td>";
				pro_deInf += "</tr>";
				pro_deInf += "</table>";
				pro_de.append(pro_deInf);
			}
						
    	},
    	error: function(xhr, status, error){
        	console.log(xhr);
    	}
	
	})

    
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
                    <td>${pro.pro_period}</td>
                </tr>
            </table>

            <div class="btn">
            	<input id="result" type="hidden" value="${result}">
            	<input id="productNum" type="hidden" name="pro_no" value="${pro.pro_no}">
            	<input id="pro_name" type="hidden" name="pro_name" value="${pro.pro_name}">
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
                    <div class="de-table" id="pro_de">
                    <!-- 
                        <table>
                            <tr>
                                <td col="col" width="15%">제목</td>
                                <td>내용</td>
                            </tr>
                        </table>
                     -->
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
