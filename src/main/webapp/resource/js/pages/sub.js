$(document).ready(function(){
	// 페이지 번호 클릭 시 이동
	$(".page-link").on("click", function(e) {
		// .preventDefault(); : 기능을 막음
		e.preventDefault();
		var page = $(this).attr("href");
		$("#page").attr("value", page);
		// $("#pageFrm").find("#page").val(page)
		$("#pageFrm").submit();

	});
	
	$(".proCategory").click(function(){
		var category = $(this).text()
		console.log(category)
		$.ajax({
			url : "/getCategory",
			type : "post",
			data : {"category" : category},
			dataType : "json",
			success : function(data){
				console.log(data)
			},
			error : function(){ alert("error") }
		});
	});
	
	$("#search").on('click', function(){
			var query = $("#searchProduct").val();
			if (query != ""){
				$.ajax({
					url : "/searchProduct",
					type : "post",
					data : {"query" : query},
					dataType : "json",
					success : searchProduct,
					error : function(){ alert("error") }
				});
			}
	});
	
	/* 이미지 업로드 */
	$("input[type='file']").on("change", function(e){
		
		var selectedFiles = $(this).get(0).files; // 선택된 파일 리스트 가져오기
	    var maxFileCount = 4; // 최대 파일 개수 설정
	    console.log("selectedFiles", selectedFiles);
	    
	 	// 선택된 파일 개수 체크
	    if (selectedFiles.length > maxFileCount) {
	      alert("최대 4개까지 선택할 수 있습니다."); // 메시지 출력
	      $(this).val(''); // 선택된 파일 초기화
	      return false; // 업로드 버튼 비활성화
	    }else{
		
		/* 이미지 존재시 삭제 */
		if($(".imgDeleteBtn").length > 0){
			deleteFile();
		}
		
		let formData = new FormData();
		let formDataImage = new FormData();
		let fileInput = $('input[name="uploadFile"]');
		let fileList = fileInput[0].files;
		let fileObj = fileList[0];
		// console.log(fileObj)
		
		// formData.append("uploadFile", fileObj);
		
		for(let i = 0; i < fileList.length; i++){
			formData.append("uploadFile", fileList[i]);
			// console.log(fileList[i])
		}
		
		$.ajax({
			url: '/uploadAjaxAction',
	    	processData : false,
	    	contentType : false,
	    	data : formData,
	    	type : 'POST',
	    	dataType : 'json',
	    	success : function(result){
				// console.log(result);
				showUploadImage(result);
			},
			error : function(result){
				alert("이미지 파일이 아닙니다.");
			}
		});

		formDataImage.append("image", fileObj);
		
		$.ajax({
			url: "http://localhost:5000/predict",
			type: "POST",
			data: formDataImage,
			processData: false,
			contentType: false,
			success: function(response){
				// console.log("predict", response);
				let class_id = response.class_id[0];
				let findDex = class_id.indexOf('_');
				const cate = class_id.slice(0, findDex);
				const productName = class_id.slice(findDex+1);
				console.log(productName);
				console.log(cate);
				
				$.ajax({
				    url: "./resource/json/"+cate+".json", // json 파일 경로
				    dataType: "json",
   					success: function(data) {
						let proEx = [];
						for(let i = 0; i < data.length; i++){
							if(data[i].title.includes(productName)){
								// console.log(productName);
								proEx.push(data[i]);
								// console.log(proEx);
								if(data[i].title == productName){
									proEx = [];
									proEx.push(data[i]);
								}
							}
						}
						console.log(proEx[0]);
						$("#pro_category").val(cate).prop("selected", true);
						$("#maker").val(proEx[0].company).prop("selected", true);
						$("#pro_name").val(proEx[0].title)
						// $("#pro_detail")
						
						proDetail();
						
    				},
    				error: function(xhr, status, error){
        				console.log(xhr);
    				}
				});
				
				
			},
			error: function(xhr, status, error){
				console.log(xhr);
			}
			
		});
		
		}
	});
	
	// 이미지 삭제 버튼 동작
	$("#uploadResult").on("click", ".imgDeleteBtn", function(e){
		
		deleteFile();
		
	});
	
	// 이미지 파일만 받기
	// 크기 정하기
	let regex = new RegExp("(.*?)\.(jpg|png)$");
	let maxSize = 1048576; //1MB
			
	function fileCheck(fileName, fileSize){
	
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
				  
		if(!regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
			
		return true;
	}
	
	// 이미지 출력 함수
	function showUploadImage(uploadResultArr){
		console.log(uploadResultArr)
		// 전달받은 데이터 검증
		if(!uploadResultArr || uploadResultArr.length == 0){return}
		
		let uploadResult = $("#uploadResult");
		let str = "";
		for(let i = 0; i < uploadResultArr.length; i++){
		let obj = uploadResultArr[i];
		
		// replace(/\\/g, '/') : \를 /로 변경
		let fileCallPath = encodeURIComponent(obj.upload_path.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.file_name);
		
		str += "<div id='result_card'>";
		str += "<img src='/display?file_name=" + fileCallPath +"'>";
		str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
		str += "<input type='hidden' name='imageList["+i+"].file_name' value='"+ obj.file_name +"'>";
		str += "<input type='hidden' name='imageList["+i+"].uuid' value='"+ obj.uuid +"'>";
		str += "<input type='hidden' name='imageList["+i+"].upload_path' value='"+ obj.upload_path +"'>";
		str += "</div>";
		}
		uploadResult.append(str);
		
	}
	
	// 파일 삭제 함수
	function deleteFile(){
		
		let targetFile = $(".imgDeleteBtn").data("file");
		
		let targetDiv = $("#result_card");
		
		$.ajax({
			url: '/deleteFile',
			data : {file_name : targetFile},
			dataType : 'text',
			type : 'POST',
			success : function(result){
				console.log(result);
				
				// 미리 보기 이미지 삭제, input 태그 초기화
				$("#uploadResult").empty();
				$("input[type='file']").val("");
			},
			error : function(result){
				console.log(result);
				
				alert("파일을 삭제하지 못하였습니다.")
			}
       });

	}
	
	// 페이지 이동 버튼
	let pageFrm = $('#pageForm');
	
	$(".page-item a").on("click", function(e){
		
		// 브라우저의 동작을 중단시키는 역할, submit이 동작했을때 페이지를 새로고침 안시키기 위해서 사용
		e.preventDefault();
		
		var page = $(this).attr("href");
			pageFrm.find("#page").val(page);
			pageFrm.submit();
		
	})
	
	// 이미지 삽입
	$(".image_wrap, .pro-img, .represent, .meminfo-img").each(function(i, obj){
		
		const bobj = $(obj);
		
		const upload_path = bobj.data("path");
		const uuid = bobj.data("uuid");
		const file_name = bobj.data("file_name");

		const fileCallPath = encodeURIComponent(upload_path + "/s_" + uuid + "_" + file_name);
		console.log(fileCallPath)
		$(this).find("img").attr('src', '/display?file_name=' + fileCallPath);
		
	})
	
// proSearch.jsp에서 검색버튼 엔터키 가능
	
	var clickSearch = document.getElementById("searchProduct");
	if (clickSearch != null){
		
		clickSearch.addEventListener("keyup", function enterSend(event){
			if (event.keyCode === null){
				event.preventDeault();
			}
			if (event.keyCode === 13){
				$("#search").click();
				$("#searchProduct").val("");
			}
		});	
		
		
	}
	
	
	
});

// 상품 정보
function proDetail(){

	let pro_cate = $("#pro_category").val();
	let pro_name = $("#pro_name").val();
	let pro_detail = $("#pro_detail")
	let proDetailInfo = "";

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
				proDetailInfo += "<table id='detailInformation'>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 제조사 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].company +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 제품명 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].title +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 상품 카테고리 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].품목 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 용도 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].용도 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 공기청정방식 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].공기청정방식 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 사용면적 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].사용면적 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 인증 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].인증 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 필터단계 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].필터단계 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 필터 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].필터 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 이온 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].이온 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 센서 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].센서 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 주요기능 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].주요기능 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 미세먼지 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].미세먼지 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 풍량조절 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].풍량조절 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 모드 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].모드 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 청정도표시 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].청정도표시 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 부가기능 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].부가기능 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 에너지효율 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].에너지효율 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 소비전력 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].소비전력 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 크기 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].크기 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 무게 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].무게 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 소음 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].소음 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 필터등급 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].필터등급 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "</table>";
				pro_detail.append(proDetailInfo);
			}else if(pro_cate == '에어프라이어'){
				proDetailInfo += "<table id='detailInformation'>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 제조사 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].company +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 제품명 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].title +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 상품 카테고리 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].품목 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 용량 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].용량 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 조작부 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].조작부 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 코팅 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].코팅 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 자동요리메뉴 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].자동요리메뉴 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 온도조절 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].온도조절 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 타이머 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].타이머 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 부가기능 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].부가기능 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 소비전력 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].소비전력 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 색상 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].색상 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 크기 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].크기 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 기름받이 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].기름받이 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 무게 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].무게 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 안전기능 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].안전기능 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "</table>";
				pro_detail.append(proDetailInfo);
			}else if(pro_cate == '전기포트'){
				proDetailInfo += "<table id='detailInformation'>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 제조사 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].company +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 제품명 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].title +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 상품 카테고리 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].품목 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 용량 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].용량 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 수위표시창 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].수위표시창 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 받침대 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].받침대 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 거름망 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].거름망 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 부가기능 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].부가기능 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 안전기능 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].안전기능 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 소비전력 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].소비전력 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 크기 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].크기 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 형태 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].형태 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 재질 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].재질 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 온도조절 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].온도조절 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 온도범위 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].온도범위 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "</table>";
				pro_detail.append(proDetailInfo);
			}else if(pro_cate == '전자렌지'){
				proDetailInfo += "<table id='detailInformation'>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 제조사 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].company +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 제품명 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].title +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 상품 카테고리 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].품목 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 용량 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].용량 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 조작부 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].조작부 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 조리실코팅 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].조리실코팅 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 자동요리 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].자동요리 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 조리기능 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].조리기능 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 온도조절 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].온도조절 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 스마트인버터 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].스마트인버터 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 부가기능 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].부가기능 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 유리 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].유리 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 안전기능 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].안전기능 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 절전 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].절전 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 출력 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].출력 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 소비전력 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].소비전력 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 색상 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].색상 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 크기 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].크기 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 도어열림 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].도어열림 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 무게 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].무게 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "</table>";
				pro_detail.append(proDetailInfo);
			}else if(pro_cate == '토스트기'){
				proDetailInfo += "<table id='detailInformation'>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 제조사 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].company +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 제품명 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].title +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 상품 카테고리 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].품목 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 투입구 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].투입구 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 주요기능 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].주요기능 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 굽기조절 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].굽기조절 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 받침대 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].받침대 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 구성 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].구성 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 소비전력 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].소비전력 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 색상 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].색상 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 안전기능 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].안전기능 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 부가기능 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].부가기능 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 뚜껑기능 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].뚜껑기능 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "</table>";
				pro_detail.append(proDetailInfo);
			}else if(pro_cate == '헤어드라이기'){
				proDetailInfo += "<table id='detailInformation'>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 제조사 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].company +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 제품명 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].title +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 상품 카테고리 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].품목 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 손잡이 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].손잡이 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 방식 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].방식 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 풍량조절 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].풍량조절 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 조작부 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].조작부 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 온도조절 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].온도조절 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 발생성분 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].발생성분 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 노즐 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].노즐 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 부가기능 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].부가기능 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 안전기능 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].안전기능 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 코드길이 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].코드길이 +"</td>";
				proDetailInfo += "<td col='col' width='20%'> 무게 </td>";
				proDetailInfo += "<td>" + pro_Ex[0].무게 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "<tr>";
				proDetailInfo += "<td col='col' width='20%'> 소비전력 </td>";
				proDetailInfo += "<td width='25%'>" + pro_Ex[0].소비전력 +"</td>";
				proDetailInfo += "</tr>";
				proDetailInfo += "</table>";
				pro_detail.append(proDetailInfo);
			}
						
    	},
    	error: function(xhr, status, error){
        	console.log(xhr);
    	}
	})

};	


// 취소 버튼 처리
$(function(){
	$("#cancelBtn").click(function(){
		alert("회원정보 변경이 취소되었습니다.");
	})
})

// contextPath 가져오기
function getContextPath() {
    return sessionStorage.getItem("contextPath");
}

// proSearch.jsp 검색 결과
function searchProduct(data){
	var searchHtml = "";
	var rowCount = 0;
	var loadCount = 0;
	var contextPath = getContextPath();

	if(data.list.length == 0){
		searchHtml += '<p class="mypage-tit mb10">검색 결과</p>'
		searchHtml += '<div class="empty-area">'
		searchHtml += '<p><img src="'+ contextPath +'/resource/images/empty_icon.png" alt=""></p>'
		searchHtml += '<p class="mt30">검색한 상품이 존재하지 않습니다.</p></div>'
	} else {
		
	$.each(data.list,function(index, obj){
		if (rowCount === 0) {
        	searchHtml += '<div class="row">';
        };
        
	    var fileCallPath = encodeURIComponent(obj.upload_path + "/s_" + obj.uuid + "_" + obj.file_name);
	    
        if (loadCount < 8) {
	        // 상품 정보 추가
	        
	        searchHtml += '<div class="col-lg-3 pro-list mb50">'
	        searchHtml += '<a href="/proView?pro_no=' + obj.pro_no + '">'
			searchHtml += '<div class="pro-img" "data-pro_no=' + obj.pro_no + '" data-path="' + obj.upload_path + '" data-uuid="' + data.list.uuid + '" data-file_name="' + obj.file_name + '">'
	        searchHtml += '<img alt="" src="/display?file_name=' + fileCallPath + '"></div>' 
	        searchHtml += '<div class="pro-info">' 
	        searchHtml += '<p class="name">' + obj.pro_title + '</p>' 
	        searchHtml += '<p class="price">' + obj.pro_sale_price + '<span class="won">원</span></p></div></a></div>' 
			
			rowCount++;
			loadCount++;
	
	        if (rowCount === 4) {
	            // row 종료
	            searchHtml += '</div>';
	            rowCount = 0;
	        };
	        		
		} else {
			searchHtml += '<div class="col-lg-3 pro-list mb50" style="display:none;">'
	        searchHtml += '<a href="/proView?pro_no=' + obj.pro_no + '">'
			searchHtml += '<div class="pro-img" "data-pro_no=' + obj.pro_no + '" data-path="' + obj.upload_path + '" data-uuid="' + data.list.uuid + '" data-file_name="' + obj.file_name + '">'
	        searchHtml += '<img alt="" src="/display?file_name=' + fileCallPath + '"></div>' 
	        searchHtml += '<div class="pro-info">' 
	        searchHtml += '<p class="name">' + obj.pro_title + '</p>' 
	        searchHtml += '<p class="price">' + obj.pro_sale_price + '<span class="won">원</span></p></div></a></div>'
	        
	        rowCount++;
	        loadCount++;
	        if (rowCount === 4) {
	            // row 종료
	            searchHtml += '</div>';
	            rowCount = 0;
	        };
	  
		};
		
			
		})
        
    
    
    if (rowCount < 4) {
    	searchHtml += '</div>';
    };
	
	
	}
	if (loadCount > 4){	
		searchHtml += '</div><div class="more-btn"><button id="load" onclick="moreInfo()">더 보기</button></div>'
	};
    $(".search-result").html(searchHtml);    
};

// 더보기 버튼 
function moreInfo(e){
	$("div:hidden").slice(0,20).show();
	if ($("div:hidden").length == 0) {
		$("#load").fadeOut(100);
	};
    
};