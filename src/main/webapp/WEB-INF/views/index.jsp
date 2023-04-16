<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<c:import url="inc/headerScript.jsp"/>
<c:import url="inc/header.jsp"/>

<link rel="stylesheet" href="${contextPath}/resource/css/pages/main.css">
<link rel="stylesheet" href="${contextPath}/resource/css/pages/main_media.css">
<script src="${contextPath}/resource/js/jquery/gsap.min.js"></script>
<script src="${contextPath}/resource/js/jquery/ScrollTrigger.min.js"></script>
<script src="${contextPath}/resource/js/pages/main.js"></script>


<!-- #container -->
<em class="fullbg"></em>
<em class="scroll"><b class="icon"></b><b class="arrow">scroll down</b></em>

<div class="main">
  <div class="section-group-1 section-group section-group-horizontal-left">
    <section class="main_greetings_wrap section sec_active">
      <h2 class="sec_tit">Welcome, let me introduce Lee Jimin's portfolio.</h2>
      <div class="circle">
        <div class="con">
          <em class="leaf_img"><img src="resource/images/main/leaf_bg.png" alt="나뭇잎 이미지"></em>
          <div class="txt">web publisher / ui & markup developer / marketer /</div>
          <div class="img"></div>
        </div>
      </div>
      <script>
        $(document).ready(function(){
          let circleText = document.querySelector('.circle .txt');
          let circleTextHtml = circleText.innerText.split('');
          circleText.innerText= null;

          const circleRotate = 360 / circleTextHtml.length;
          //console.log(circleTextHtml.length);

          circleTextHtml.forEach(function(char,i){
            //텍스트 나눠 넣어주기
            const charElement =document.createElement('span');
            charElement.innerText = char;
            circleText.appendChild(charElement);

            // 텍스트 기울기
            charElement.style.transform = "rotate("+ i * circleRotate+"deg)";

          });
        });

      </script>

    </section>
    <section class="main_introduction_wrap section">
      <ul class="Introduction">
        <li>
          <h3 class="tit">UI Development <em class="wave_line"></em></h3>
          <div  class="con">
            <p>HTML ,CSS,JS를 이해하며 다룹니다. 유지보수를 고려한 컴포넌트 단위 마크업 작성이 가능하며, 퍼블리싱 가이드 제작, 마크업 고도화 작업경험이 있습니다.
            </p>
          </div>
        </li>
        <li>
          <h3 class="tit">Markup <em class="wave_line"></em></h3>
          <div class="con">
            <p>
              웹표준을 바탕으로 시멘틱 마크업을 작성하여 크로스브라우징이 가능합니다.<br />
              웹 접근성 마크 취득한 경험이 있으며 검색엔진 최적화(SEO)가 가능합니다.
              많은 사용자가 홈페이지에 접근 할 수있도록 하며, 모두에게 동일한 내용을 전달 할 수 있도록합니다.
            </p>
          </div>
        </li>
        <li class="last">
          <h3 class="tit">Skills <em class="wave_line"></em></h3>
          <div class="con">
            <h4>UI(User Interface)</h4>
            <p>
              <em class="xi-html5">
                <b class="ally-hidden">html</b>
              </em>
              <em class="xi-css3">
                <b class="ally-hidden">css</b>
              </em>
              <em class="xi-javascript">
                <b class="ally-hidden">javascript</b>
              </em>
              <em class="xi-plus-square">
                <b class="ally-hidden">jqury</b>
              </em>

            </p>
            <p>ui animation 및 인터렉션에 관심이 많고 더 낳은 코드와 시각적인 모션을 보여주기위해 배우며 적용합니다.
            </p>
            <h4>개발환경</h4>
            <p>
              Configuration Management Tool (svn / git)
              eclipse
            </p>

            <h4>Hosting</h4>
            <p>
              빌더 쇼핑몰 활용한 작업이 가능합니다. <br />카페24 , 고도몰, 닷홈 등 운영 경험이 있습니다.
            </p>

            <h4>UX(User Experience)</h4>
            <p>
              <em class="xi-photoshop">
                <b class="ally-hidden">포토샵</b>
              </em>
              <em class="xi-illustrator">
                <b class="ally-hidden">일러스트</b>
              </em>
            </p>
            <p>
              포스터, 카드뉴스, 현수막, 명함 등 디자인 경험이 있으며, <br />웹퍼블리셔 과정을 진행하며 홈페이지 디자인도 배웠습니다.
            </p>

            <h4>Content Marketing</h4>
            <p>SNS체널 운영, 언론보도 작성 및 배포가 가능합니다.<br />
              카드뉴스 &middot; 블로그 &middot; 영상 콘텐츠 &middot; 이벤트의 기획 및 제작, 행사 모집 및 운영 경험이 있습니다.</p>
          </div>
        </li>

      </ul>
    </section>
  </div>
  <!-- end: section-group-1 -->
  <div class="section-group-2 section-group ">
    <section class="main_prosect_wrap section">
      <h2 class="sec_tit">
        <span>Recent <em class="icon_arrow"></em></span>
        <span>Project</span>
      </h2>
      <p class="img"><img src="" alt=""></p>
    </section>
    <section class="main_prosect_list section">
      <div class="prosect_wrap">
        <h2 class="sec_tit">List 06</h2>
        <p class="sec_subtxt">Pick ! <br>Web Project
          <img src="resource/images/main/emoticon_hand.png" alt="">
        </p>
        <div class="prosect_info">
          <div class="modul_tablet">
            <p class="img" style='background-image:url("https://assets.codepen.io/756881/amys-1.jpg")'></p>
          </div>
          <div class="modul_phone">
            <p class="img" style='background-image:url("https://assets.codepen.io/756881/amys-1.jpg")'></p>
          </div>
          <a class="btn_more" href="">+ More</a></p>
        </div>
        <ul  class=" wheel">

          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-1.jpg" />
          </li>
          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-2.jpg" />
          </li>
          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-3.jpg" />
          </li>
          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-4.jpg" />
          </li>
          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-5.jpg" />
          </li>
          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-6.jpg" />
          </li>



          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-1.jpg" />
          </li>
          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-2.jpg" />
          </li>
          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-3.jpg" />
          </li>
          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-4.jpg" />
          </li>
          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-5.jpg" />
          </li>
          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-6.jpg" />
          </li>


          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-1.jpg" />
          </li>
          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-2.jpg" />
          </li>
          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-3.jpg" />
          </li>
          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-4.jpg" />
          </li>
          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-5.jpg" />
          </li>
          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-6.jpg" />
          </li>

          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-1.jpg" />
          </li>
          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-2.jpg" />
          </li>
          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-3.jpg" />
          </li>
          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-4.jpg" />
          </li>
          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-5.jpg" />
          </li>
          <li class="wheel__card">
            <img src="https://assets.codepen.io/756881/amys-6.jpg" />
          </li>

        </ul>
      </div>
    </section>
  </div>
  <!-- end: section-group-2 -->
  <div class="section-group-3 section-group section-group-horizontal-right" >
    <section class="main_about_wrap section">
      <em class="line line_move"></em>
      <h2 class="sec_tit">About me</h2>
      <div class="profile_info">
        I am <em class="icon_round">Lee Jimin</em> and I am 30 years old.
        I like to show people visually and make a homepage that highlights the value of the brand.
        When I work, I am <em class="icon_round">systematic</em> and responsible.
        I study tirelessly and deal with my work patiently.
        <em class="icon_arrow"></em>
      </div>
    </section>
    <section class="main_profile_01 section " >
      <em class="line line_move"></em>
      <em class="line2 line_move"></em>
      <!--Profile-->
      <div class="profile_con">
        <ul>
          <li>
            <p class="date">2022</p>
            <h3>개발</h3>
            <p class="position"></p>
          </li>
          <li>
            <p class="date">2018~2022</p>
            <h3>오상테크놀로지</h3>
            <p class="position">UI개발팀 (대리)</p>
            <p class="subtxt">신규 홈페이지 구축 및 유지보수</p>
          </li>

        </ul>
      </div>
      <p class="profile_img"><img src="" alt=""></p>
    </section>
    <section class="main_profile_02 section " >
      <em class="line line_move"></em>
      <div class="profile_con">
        <ul>
          <li>
            <p class="date">2017</p>
            <h3>그린아트컴퓨터학원</h3>
            <p class="position">0000과정 이수</p>
          </li>
          <li>
            <p class="date">2016~2017</p>
            <h3>(주)무궁</h3>
            <p class="position">마케팅팀 (사원)</p>
            <p class="subtxt">웨딩홀사업부 6개, 드레스사업부 2개 지점<br />온라인 및 오프라인 홍보<br />행사 관리 및 지원</p>
          </li>
          <li>
            <p class="date">2012~2016</p>
            <h3>호서대학교</h3>
            <p class="position">경영학과</p>
          </li>
        </ul>
        <p class="profile_img"><img src="" alt=""></p>
      </div>

    </section>

  </div>
  <!-- end: section-group-3 -->
  <div class="section-group-4 section-group" >
    <section class="main_co_work_wrap section">
      <h2 class="sec_tit">Co-work</h2>
      <p class="sec_subtxt">나와 함께 했던 사람들의 이야기</p>
      <a href="javascript:void(0);" class="btn-green">메시지 남기기 <em class="xi-send ml5"></em></a>
      <ul class="co_work">
        <li>
          <p class="tit">이*영 대리 <span>팀</span></p>
          <p>오상테크놀로지</p>
          <div class="con">
            테스트
          </div>
        </li>
      </ul>
    </section>
    <section class="main_contact_wrap section section-10">
      <h2 class="sec_tit">inquiry</h2>
      <p class="sec_subtxt">궁금한점을 남겨주세요!</p>
      <div class="contact_wrap">
        <p></p>
        <table>
          <caption>
            <p class="ally-hidden">문의 내용 입력 테이블</p>
          </caption>
          <colgroup>
            <col style="width:20%;min-width:90px;">
            <col style="width:auto">
          </colgroup>
          <tbody>
          <tr>
            <th><label for="contact-tit">제목</label></th>
            <td><input id="contact-tit" type="text"></td>
          </tr>
          <tr>
            <th><label for="contact-con">내용</label></th>
            <td><textarea name="" id="contact-con" cols="30" rows="10"></textarea></td>
          </tr>
          <tr>
            <th><label for="contact-phone">연락처</label></th>
            <td>
              <div class="phone_con">
                <select id="contact-phone">
                  <option value="010">010</option>
                  <option value="011">011</option>
                  <option value="031">031</option>
                  <option value="031">031</option>
                </select>
                <span>-</span>
                <input  type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  maxlength="4" >
                <span>-</span>
                <input  type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  maxlength="4" >
              </div>
            </td>
          </tr>
          </tbody>
        </table>
        <a href="javascript:void(0);" class="btn-green">보내기 <em class="xi-send ml5"></em></a>
      </div>
    </section>
  </div>
  <!-- end: section-group-4 -->
</div>



<script>
  /* section 1  round hover */
  const circleWrap = document.querySelector('.main_greetings_wrap');
  const circleMove = document.querySelector('.con');
  const circleImg = document.querySelector('.img');
  const mouseCoords = circleWrap.getBoundingClientRect();

  circleWrap.addEventListener('mousemove', function(e) {
    const mouseX = e.pageX - circleWrap.offsetLeft;
    const mouseY = e.pageY - circleWrap.offsetTop;

    TweenMax.to(circleMove, 0.5, {
      x: (mouseX - mouseCoords.width / 2) / mouseCoords.width * 50,
      y: (mouseY - mouseCoords.height / 2) / mouseCoords.width * 50,
      ease:"easeOutCirc",
    })
  });

  circleWrap.addEventListener('mousemove', function(e) {
    const mouseX = e.pageX - circleWrap.offsetLeft;
    const mouseY = e.pageY - circleWrap.offsetTop;

    TweenMax.to(circleImg, 0.3, {
      x: (mouseX - mouseCoords.width / 2) / mouseCoords.width * 25,
      y: (mouseY - mouseCoords.height / 2) / mouseCoords.width * 25,
      ease:"easeOutCirc",
    })
  });

  circleWrap.addEventListener('mouseenter', function(e) {
    TweenMax.to(circleMove, 0.3, {
      scale: 0.9
    })
  });

  circleWrap.addEventListener('mouseleave', function(e) {
    TweenMax.to(circleMove, 0.3, {
      x: 0,
      y: 0,
      scale: 1
    })
    TweenMax.to(circleImg, 0.3, {
      x: 0,
      y: 0,
      scale: 1
    })

  });
</script>



<script>

  /*==========================================================================
  스크롤 트리거 플러그인 활성화
  ==========================================================================*/

  gsap.registerPlugin(ScrollTrigger);


  function SectionGroup__init(){
    console.log('strat')
    let $fullBg = $('.fullbg');
    let $leafImg = $('.leaf_img');
    let $windowHeight = $(window).height();



    $('.section-group').each(function(index, node) {

      let $group = $(this);
      let $section = $group.find(' .section');
      let $con = $group.find(' > .section > .con');

      // 컨텐츠 전체 높이
      let $sectionLeng =$section.length;
      let $groupHeight =($sectionLeng * $windowHeight) + 'px';  // 그룹 높이 = 윈도우 창 높이 * 섹션 개수

      //group 1
      let $group1 = $('.section-group-1');
      let $sec01 =$('.main_greetings_wrap');
      let $sectit = $group1.find('.sec_tit');
      let $circleP = $('.circle');

      let $sec02 =$('.main_introduction_wrap');
      let $sec02Con =$('.Introduction');
      let $sec02El =$sec02Con.find('li');
      let $sec02ElLast =$sec02Con.find('.last .con');
      let $sec02ElTit =$sec02El.find('.tit');

      //group 2
      let $group2 = $('.section-group-2');
      let $sec03 =$('.main_prosect_list');
      let $sec03Con = document.querySelector(".prosect_wrap");
      let $sec03wheel = document.querySelector(".wheel");
      let $sec03images = gsap.utils.toArray(".wheel__card");


      //group 3
      let $group3 = $('.section-group-3');

      // 각 섹션 section active
      let $allSection = gsap.utils.toArray(".section-group");
      $allSection.forEach((title) => {
        gsap.to(title, {
          scrollTrigger: {
            trigger: title,
            start: "top top",
            end: "bottom 0",
            toggleClass:  "sec_active",
          }
        })
      });





      /*==================================================
      ***각섹션 별 동작******

      section group 01
      ===================================================*/

      if($group.hasClass('section-group-1')){



        //$group1.height($groupHeight);

        //section move left
        let sectionLeft = gsap.timeline({
          scrollTrigger: {
            trigger: $group1,
            start:"top top",
            end:"+=" + ($sectionLeng - 1) + "00%",
            scrub:true,
            pin :true,
            ease:'easeOutQuart',
            duration:1,

          }
        });

        sectionLeft.to($section, {
          xPercent: -100 * ($section.length - 1),
          ease:'easeOutQuart'
        },0.1).to($sectit,{
          x: '100%',	stagger:10
        },0.1).to($circleP,{
          scale:'2.5',
          x: '-200%',
          opacity:0,
          stagger:10,

        },0.1)


        // content show
        gsap.from($sec02El,{
          scrollTrigger: {
            trigger: $sec02Con,
            start:"top top",
            end:"+=100%",
            scrub:true,
            pin :false,
            duration:1,
            ease:'easeOutQuart',
            //markers:true,
            repeatDelay:1,
            //delaty:0.2,
          },
          y:'200px',
          opacity: 0,
          stagger:10

        },1);

        // last section >  right move
        let section2last = gsap.timeline({
          scrollTrigger: {
            trigger: $sec02ElLast,
            start:"top top",
            scrub:true,
            pin :false,
            duration:1,
            ease:'easeOutQuart',
            //markers:true,
            //repeatDelay:1,
            //delaty:0.2,
          }
        });
        section2last.to($sec02,{
          x:'-100vw',
          y:'0',
          marginLeft:'200px'
        },1.5).to($fullBg,{
          x:'-100vw',
          y:'0',
        },1.5).to($group2,{
          left:'0',
          marginLeft:'0',
        },1.5)

      }



      /*===================================================
      section group 02
      ===================================================*/

      if($group.hasClass('section-group-2')){

        let $group2top = $('.main_prosect_wrap');
        let group2Start = gsap.timeline({
          scrollTrigger: {
            trigger: $group2top,
            start:"top center",
            //	end:"bottom bottom",
            scrub:true,
            pin :false,
            duration:1,
            ease:'easeOutQuart',
            //markers:true,
            //repeatDelay:1,
            //delaty:0.2,
          }
        });

        group2Start.to($group2top,{
          x:'-60%'
        },1.5).to($sec03,{
          x:'0'
        },1.5).to($fullBg,{
          x:'-60%',
          y:-100 * ($section.length - 1),
        },1.5);


        //wheel position
        let $radius = $sec03wheel.offsetWidth / 2;
        let $center = $sec03wheel.offsetWidth / 2;
        let $total = $sec03images.length;
        let $totalNum = $sec03images.length / 4 ;
        let slice = (2 * Math.PI) / $total;

        // group and section height
        let $group2Height= $windowHeight * $total / 6;
        $group2.height($group2Height+  $windowHeight + "px"); //section 2 개
        $sec03.height($group2Height + "px");

        $sec03images.forEach((item, i) => {
          let angle = i * slice;
          let x = $center + $radius * Math.sin(angle);
          let y = $center - $radius * Math.cos(angle);

          gsap.set(item, {
            rotation: angle + "_rad",
            xPercent: -50,
            yPercent: -50,
            x: x,
            y: y
          });
        });
        console.log($section.length)
        //section content fixed center

        let group2Move = gsap.timeline({
          scrollTrigger: {
            trigger: $sec03,
            start:"top top",
            end:"bottom bottom",
            scrub:true,
            ease:'easeOutQuart',
            pin:true,
            //markers:true,
            //onLeave: self => section3Leave()
          }
        });
        let $pickshow =$sec03.find('.sec_subtxt');
        group2Move.from($pickshow,{
          opacity:'0'
        },0.2).to($sec03Con,{},2)





        //section content wheel move
        gsap.to($sec03wheel, {
          rotate: () => -360,
          duration: $totalNum,
          scrollTrigger: {
            trigger: $sec03,
            start:"top +=500",
            end:"bottom bottom",
            scrub:true,
            ease:'easeOutQuart',
            //markers:true,
            pin:false,
            scrub: 1,
            snap: 1 / $totalNum,
            invalidateOnRefresh: true,
            //repeatDelay:2,
            //delay:2

          }
        },1.5)




        //section content wheel action
        $('.wheel__card').on('click',function(){
          let wheelImg = $(this).find('img').attr('src');
          $('.wheel__card').removeClass('active');
          $(this).addClass('active');
          console.log(wheelImg)
          setTimeout(function(){
            $('.modul_tablet .img , .modul_phone .img').attr('style', 'background-image:url("'+ wheelImg+ '")')

          },400);


        });


      }


      /*===================================================
      section group 03
      ===================================================*/

      if($group.hasClass('section-group-3')){
        //section position
        $group3.height($groupHeight);
        $group3.find('.section').each(function(index){
          let $group03Mtop = 'margin-top:' + $windowHeight * index + 'px; height:'+$windowHeight + 'px';
          $(this).attr('style',$group03Mtop )
        });

        //section move right
        let sectionRight = gsap.timeline({
          scrollTrigger: {
            trigger: $group3,
            start:"top top",
            end:"+=" + ($section.length - 1) + "00%",
            scrub:true,
            duration:1,
            ease:"easeOutQuart",
          }
        });
        sectionRight.to($section, {
          xPercent: 100 * ($section.length - 1),

        },0.5).to($fullBg,{
          x:-100 * ($section.length - 1),
          y:'0',
        },0.5)




        ///end

      }
    });




  };






  /* END : 스크롤 트리거 플러그인 ========================================================*/


  /*===========================================================================

  /* END : 플루팅 및 리사이징 이벤트  =======================================================*/

  $(document).ready(function () {
    SectionGroup__init(); //gsap


    // 윈도우창 너비 변화시 스크롤 이벤트 리셋 필요
    //let re_size = window.outerHeight;
    //$('section').css({'height':re_size})





  });



  //기기 확인
  function isMobile(){
    var UserAgent = navigator.userAgent;

    if (UserAgent.match(/iPhone|iPad|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null || UserAgent.match(/LG|SAMSUNG|Samsung/) != null)

    {
      return true;
    }else{
      return false;
    }
  }



  $(function () {

    if (isMobile()) {
      // 모바일이면 실행될 코드 들어가는 곳

    } else {
      // 모바일이 아니면 실행될 코드 들어가는 곳
      console.log('pc')
      window.addEventListener("resize", SectionGroup__init);//gsap
    }


  });










</script>

<c:import url="inc/footer.jsp"/>
