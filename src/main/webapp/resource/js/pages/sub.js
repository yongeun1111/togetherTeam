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
			console.log(query)
			$.ajax({
				url : "/searchProduct",
				type : "post",
				data : {"query" : query},
				dataType : "json",
				success : searchProduct,
				error : function(){ alert("error") }
			});
	});
	
	/* 이미지 업로드 */
	$("input[type='file']").on("change", function(e){
		
		/* 이미지 존재시 삭제 */
		if($(".imgDeleteBtn").length > 0){
			deleteFile();
		}
		
		let formData = new FormData();
		let fileInput = $('input[name="uploadFile"]');
		let fileList = fileInput[0].files;
		// let fileObj = fileList[0];
		
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
				targetDiv.remove();
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
		clickSearch.addEventListener("keyup", function enterSend(event){
			if (event.keyCode === null){
				event.preventDeault();
			}
			if (event.keyCode === 13){
				$("#search").click();
				$("#searchProduct").val("");
			}
		});	
	
	
	
	
});


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
		searchHtml += '<div class="empty-area">'
		searchHtml += '<p><img src="'+ contextPath +'/resource/images/empty_icon.png" alt=""></p>'
		searchHtml += '<p class="mt30">검색한 상품이 존재하지 않습니다.</p></div>'
	} else {
		
	$.each(data.list,function(index, obj){
		if (rowCount === 0) {
        	searchHtml += '<div class="row">';
        };
        
	    var fileCallPath = encodeURIComponent(obj.upload_path + "/s_" + obj.uuid + "_" + obj.file_name);
	    
        if (loadCount < 4) {
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
		searchHtml += '</div><button id="load" onclick="moreInfo()">더 보기</button>'
	};
    $(".search-result").html(searchHtml);    
};

// 더보기 버튼 
function moreInfo(e){
	$("div:hidden").slice(0,10).show();
	if ($("div:hidden").length == 0) {
		$("#load").fadeOut(100);
	};
    
};