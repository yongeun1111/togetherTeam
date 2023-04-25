$(document).ready(function(){
	
	// 섬네일 이미지
	$(".pro-img").each(function(i, obj){
		
		const bobj = $(obj);
		
		const upload_path = bobj.data("path");
		const uuid = bobj.data("uuid");
		const file_name = bobj.data("file_name");
		
		// console.log("path : " + upload_path + ", uuid : " + uuid + ", file_name : " + file_name);
		
		const fileCallPath = encodeURIComponent(upload_path + "/s_" + uuid + "_" + file_name);
		$(this).find("img").attr('src', '/display?file_name=' + fileCallPath);
		
	})
	
});