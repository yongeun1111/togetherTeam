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
				success : function(data){
					console.log(data)
				},
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
	$(".image_wrap").each(function(i, obj){
		
		const bobj = $(obj);
		
		const upload_path = bobj.data("path");
		const uuid = bobj.data("uuid");
		const file_name = bobj.data("file_name");

		const fileCallPath = encodeURIComponent(upload_path + "/s_" + uuid + "_" + file_name);
		console.log(fileCallPath)
		$(this).find("img").attr('src', '/display?file_name=' + fileCallPath);
		
	})
	
	
	// 상세페이지 이미지
	$(".represent").each(function(i, obj){
		
		const view_bobj = $(obj);
		
		const view_upload_path = view_bobj.data("path");
		const view_uuid = view_bobj.data("uuid");
		const view_file_name = view_bobj.data("file_name");
		
		// console.log("path : " + view_upload_path + ", uuid : " + view_uuid + ", file_name : " + view_file_name);
		
		const view_fileCallPath = encodeURIComponent(view_upload_path + "/s_" + view_uuid + "_" + view_file_name);
		$(this).find("#imgRepresent").attr('src', '/display?file_name=' + view_fileCallPath);
		
	})
	
	
	
	
	
});

// 취소 버튼 처리
$(function(){
	$("#cancelBtn").click(function(){
		alert("회원정보 변경이 취소되었습니다.");
	})
})
