$(document).ready(function(){
	$(".proCategory").click(function(){
		var category = $(this).text()
		$.ajax({
			url : "${cpath}/getCategory",//?query=bookname
			type : "post", // get으로 갈 경우 한글 인코딩이 더 필요
			data : {"category" : category}, // query는 문자열처리를 해도 되고, 안해도 됨
			dataType : "json",
			success : function(data){
				console.log(data)
			},
			error : function(){ alert("error") }
		});
	})
})