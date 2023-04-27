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



// 메인비주얼 동그라미 애니메이션

//범위 랜덤 함수(소수점 2자리까지)
function random(min, max) { //min~max 범위
	//toFixed()를 통해 반환된 문자 데이터를,
	//parseFloat()을 통해 소수점을 가지는 숫자 데이터로 변환
	return parseFloat((Math.random() * (max - min) + min).toFixed(2))
}

function floatingCircle(item, delayAfter, size) {
	gsap.to(
		item, //선택자
		random(1.5, 2.5), //1.5~2.5초 사이의 랜덤한 애니메이션 동작 시간
		{
			delay: random(0, delayAfter), //몇초 뒤에 애니메이션을 실행, 지연 시간 설정
			y: size, //transform: translateY(수치)와 같음. 수직으로 움직이는 크기
			repeat: -1, //몇 번 반복하는지를 설정, -1은 무한 반복.
			yoyo: true, //한번 재생된 애니메이션을 다시 뒤로 재생-위아래 움직임
			ease: Power1.easeInOut //easing 함수 적용
		}
	);
}

floatingCircle('.c1', .5, 30)
floatingCircle('.c2', 1, 20)
floatingCircle('.c3', 1.5, 10)