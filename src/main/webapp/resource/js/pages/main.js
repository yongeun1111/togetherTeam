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
