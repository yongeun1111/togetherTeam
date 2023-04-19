$(document).ready(function(){
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
	
	
	
});

// 취소 버튼 처리
$(function(){
	$("#cancelBtn").click(function(){
		alert("회원정보 변경이 취소되었습니다.");
	})
})
