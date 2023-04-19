$(document).ready(function(){
	$(".proCategory").click(function(){
		var category = $(this).text()
		$.ajax({
			url : "${cpath}/getCategory",
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