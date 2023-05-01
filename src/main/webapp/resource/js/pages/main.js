$(document).ready(function () {

    // 섬네일 이미지
    $(".pro-img").each(function (i, obj) {

        const bobj = $(obj);

        const upload_path = bobj.data("path");
        const uuid = bobj.data("uuid");
        const file_name = bobj.data("file_name");

        // console.log("path : " + upload_path + ", uuid : " + uuid + ", file_name : " +
        // file_name);

        const fileCallPath = encodeURIComponent(
            upload_path + "/s_" + uuid + "_" + file_name
        );
        $(this)
            .find("img")
            .attr('src', '/display?file_name=' + fileCallPath);

    })
    
    // 프로필 이미지 등록
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
			url: '/uploadProfileImage',
	    	processData : false,
	    	contentType : false,
	    	data : formData,
	    	type : 'POST',
	    	dataType : 'json',
	    	success : showUploadImage,
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
	//이미지 삽입
	$(".image_wrap, .pro-img, .represent, .meminfo-img").each(function(i, obj){
		
		const bobj = $(obj);
		
		const upload_path = bobj.data("path");
		const uuid = bobj.data("uuid");
		const file_name = bobj.data("file_name");
	
		const fileCallPath = encodeURIComponent(upload_path + "/s_" + uuid + "_" + file_name);
		console.log(fileCallPath)
		$(this).find("img").attr('src', '/display?file_name=' + fileCallPath);
		
	})

});

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
function showUploadImage(data){
	
	console.log(data)
	// 전달받은 데이터 검증
	if(data == null){return}
	
	let uploadResult = $("#uploadResult");
	let str = "";	
	// replace(/\\/g, '/') : \를 /로 변경
	let fileCallPath = encodeURIComponent(data.mem_upload_path.replace(/\\/g, '/') + "/s_" + data.mem_uuid + "_" + data.mem_file_name);
	
	str += "<div id='result_card'>";
	str += "<img src='/display?file_name=" + fileCallPath +"'>";
	str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
	str += "<input type='hidden' name='mem_file_name' value='"+ data.mem_file_name +"'>";
	str += "<input type='hidden' name='mem_uuid' value='"+ data.mem_uuid +"'>";
	str += "<input type='hidden' name='mem_upload_path' value='"+ data.mem_upload_path +"'>";
	str += "</div>";
	
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

};


