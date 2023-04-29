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

$(function () {

    var $slide = $('#slide');
    var $nav = $('.mv-page').find('li');
    var enableNav = true; //클릭하여 내비게이션 이동 허용 여부(슬라이드 동작 중 클릭되는 것을 방지)
    var speed = 1000; //슬라이드 속도

    $slide
        .on('init reInit', function (event, slick) { //페이징이니셜
            if (!slick.$dots) 
                return;
            $("#slide_paging").html('<b class="page">' + (
                slick.currentSlide + 1
            ) + '</b> / ' + (
                slick.$dots[0].children.length
            ));
        })
        .on(
            'beforeChange',
            function (event, slick, currentSlide, nextSlide) { //슬라이드 변경 시 내비 및 페이징 변경
                //내비 변경
                if (enableNav) {
                    $nav.removeClass("on");
                    $nav
                        .eq(nextSlide)
                        .addClass("on");
                    navStatus();
                }
                //페이징 변경
                if (!slick.$dots) 
                    return;
                var i = (
                    nextSlide
                        ? nextSlide
                        : 0
                ) + 1;
                $("#slide_paging")
                    .find(".page")
                    .text(i);
            }
        );

    function navStatus() { //슬라이드 동작 중 내비클릭 방지
        enableNav = false;
        setTimeout(function () {
            enableNav = true;
        }, speed);
    }

    $nav.on("click", function () { //내비 클릭시 해당 인덱스로 이동
        if (enableNav) {
            var slideNo = $(this).index();
            $slide.slick('slickGoTo', slideNo);
            $nav.removeClass("on");
            $(this).addClass("on")
            $("#slide_paging")
                .find(".page")
                .text(slideNo + 1);
            navStatus();
        }
    });

    var $slide = $('.slide'),
        $item = $slide.find('.item'),
        $slide2 = $('.slide2');
    $slide.slick({
        //기본
        autoplay: false,
        dots: true,
        dotsClass: "slick-dots",
        swipe: true,
        draggable: true,
        slidesToShow: 1,
        slidesToScroll: 1,
        variableWidth: true,
        infinite: true, // 맨끝이미지에서 끝나지 않고 다시 맨앞으로 이동
        autoplay: true, // 기본값  false
        autoplaySpeed: 4500, // 다음이미지로 넘어갈 시간
        speed: 750, //  다음이미지로 넘겨질때 걸리는 시간
        centerMode: true,
        arrows: true, // prev, next 기능 활성화
        prevArrow: $('.prev'),
        nextArrow: $('.next'),
        pauseOnHover: true, // 마우스 호버시 슬라이드 이동 멈춤

        //추가 기능
        isRunOnLowIE: false,
        pauseOnArrowClick: true,
        pauseOnDirectionKeyPush: true,
        pauseOnSwipe: true,
        pauseOnDotsClick: true,

        responsive: [
            {/* 반응형웹*/
                breakpoint: 960,
                /*  기준화면사이즈 */
                settings: {
                    slidesToShow: 2
                }/*  사이즈에 적용될 설정 */
            }, {/* 반응형웹*/
                breakpoint: 768,
                /*  기준화면사이즈 */
                settings: {
                    slidesToShow: 1
                }/*  사이즈에 적용될 설정 */
            }
        ]
    });
    $('[data-slick-index="0"]').addClass('slick-now');
    $('[data-slick-index="-1"]').addClass('slick-isprev');
    $('[data-slick-index="1"]').addClass('slick-isnext');
    $slide.on('beforeChange', function (event, slide, currentSlide, nextSlide) {
        var count = slide.slideCount;
        var selectors = [
                nextSlide, nextSlide - count,
                nextSlide + count
            ]
                .map(function (n) {
                    return '[data-slick-index="'.concat(n, '"]');
                })
                .join(', '),
            selectorsPrev = [
                nextSlide, nextSlide - count,
                nextSlide + count
            ]
                .map(function (n) {
                    return '[data-slick-index="'.concat(n - 1, '"]');
                })
                .join(', '),
            selectorsNext = [
                nextSlide, nextSlide - count,
                nextSlide + count
            ]
                .map(function (n) {
                    return '[data-slick-index="'.concat(n + 1, '"]');
                })
                .join(', ');
        $('.slick-slide')
            .removeClass('slick-now')
            .removeClass('slick-isprev')
            .removeClass('slick-isnext');
        $(selectors).addClass('slick-now');
        $(selectorsPrev).addClass('slick-isprev');
        $(selectorsNext).addClass('slick-isnext');
    });
});

$(".slide").on('afterChange', function () {
    $(".pro-bar").addClass('pro-ani');
});
$(".slide").on('beforeChange', function () {
    $(".pro-bar").removeClass('pro-ani');
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

}