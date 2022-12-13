<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Cheongju Riding Course</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js"
	crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic"
	rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Black+Han+Sans&family=Cute+Font&family=Do+Hyeon&family=Dokdo&family=East+Sea+Dokdo&family=Gaegu&family=Gamja+Flower&family=Gothic+A1&family=Gugi&family=Hi+Melody&family=Jua&family=Kirang+Haerang&family=Nanum+Brush+Script&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Nanum+Pen+Script&family=Noto+Sans+KR&family=Noto+Serif+KR&family=Poor+Story&family=Single+Day&family=Song+Myung&family=Stylish&family=Sunflower:wght@300&family=Yeon+Sung&display=swap"
	rel="stylesheet">

<style>
/* Create two equal columns that floats next to each other */
.map {
	float: left;
	width: 60%;
	padding: 15px;
}

.mapside {
	float: right;
	width: 40%;
	padding: 15px;
}

/* Clear floats after the columns */
.row:after {
	content: "";
	display: table;
	clear: both;
}

/*div변경과 관련된
   코드입니다. 색 등의 디자인은 보이기 위해서 표시해놨으니 스타일 추가 및 변경이 가능합니다.*/
.main
   input[type=radio] {
	display: none;
}

#tab-1:checked ~ .tab
   label:nth-child(1), #tab-2:checked ~ .tab
   label:nth-child(2), #tab-3:checked ~ .tab
   label:nth-child(3), #tab-4:checked ~ .tab
   label:nth-child(4) {
	background-color: #FFC107;
	border-radius: 15px 15px 0px 0px;
	box-shadow: none;
}

.content>div {
	display: none;
}

#tab-1:checked ~ .content div:nth-child(1), #tab-2:checked ~ .content div:nth-child(2),
	#tab-3:checked ~ .content div:nth-child(3), #tab-4:checked ~ .content div:nth-child(4)
	{
	display: block;
}

.main {
	margin: 0 auto;
	main-width: 1380px;
	max-width: 100%;
}

.tab {
	overflow: hidden;
}

.tab label {
	cursor: pointer;
	float: left;
	width: 25%;
	font-family: 'Do Hyeon', sans-serif;
	font-size: 21px;
	text-align: center;
	padding: 15px 0;
	letter-spacing: 2px;
	user-select: none;
	-webkit-user-select: none;
	font-size: 21px;
}

.content {
	background-color: #FFC107;
	min-height: 390px;
	border-radius: 0px 0px 15px 15px;
}

.content>div {
	padding: 30px;
	line-height: 1.5;
	font-family: 'Do Hyeon', sans-serif;
	font-size: 17px;
}

#button1 {
	background-color: #FDF4E3;
	color: black;
	padding: 8px;
	font-family: 'Do Hyeon', sans-serif;
	font-size: 15px;
	border: 3px solid #2C3E50;
	border-radius: 10px;
}

/* Style The Dropdown Button */
.dropbtn {
	background-color: #fdf4e3;
	color: black;
	padding: 16px;
	font-family: 'Do Hyeon', sans-serif;
	font-size: 18px;
	border: 3px solid #2C3E50;
	border-radius: 10px;
	cursor: pointer;
	border-radius: 10px;
}

/* The container <div> - needed to position the dropdown content */
.dropdown {
	position: relative;
	display: inline-block;
}

/* Dropdown Content (Hidden by Default) */
.dropdown-content {
	display: none;
	position: absolute;
	background-color: white;
	border-radius: 10px;
	width: 115px;
	font-family: 'Do Hyeon', sans-serif;
	font-size: 17px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

/* Links inside the dropdown */
.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

/* Change color of dropdown links on hover */
.dropdown-content a:hover {
	background-color: #BCECF6;
	border-radius: 10px;
}

/* Show the dropdown menu on hover */
.dropdown:hover .dropdown-content {
	display: block;
}

/* Change the background color of the dropdown button when the dropdown content is shown */
.dropdown:hover .dropbtn {
	background-color: #BCECF6;
}
</style>

<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4fe8c6488c405b06e0e67f6a99cfc617"></script>


<script>
	function hInfo1() {
		document.getElementById("img1").src = "assets/코스 정보/코스1.jpg";

		roadviewClient.getNearestPanoId(position1, 50, function(panoId) {
			roadview.setPanoId(panoId, position1); //panoId와 중심좌표를 통해 로드뷰 실행
		});

	}
	function hInfo2() {
		document.getElementById("img1").src = "assets/코스 정보/코스2.jpg";

		roadviewClient.getNearestPanoId(position2, 50, function(panoId) {
			roadview.setPanoId(panoId, position2); //panoId와 중심좌표를 통해 로드뷰 실행
		});

	}
	function hInfo3() {
		document.getElementById("img1").src = "assets/코스 정보/코스3.jpg";

		roadviewClient.getNearestPanoId(position3, 50, function(panoId) {
			roadview.setPanoId(panoId, position3); //panoId와 중심좌표를 통해 로드뷰 실행
		});

	}
	function hInfo4() {
		document.getElementById("img1").src = "assets/코스 정보/코스4.jpg";

		roadviewClient.getNearestPanoId(position4, 50, function(panoId) {
			roadview.setPanoId(panoId, position4); //panoId와 중심좌표를 통해 로드뷰 실행
		});

	}
	function hInfo5() {
		document.getElementById("img1").src = "assets/코스 정보/코스5.jpg";

		roadviewClient.getNearestPanoId(position5, 50, function(panoId) {
			roadview.setPanoId(panoId, position5); //panoId와 중심좌표를 통해 로드뷰 실행
		});

	}
	function hInfo6() {
		document.getElementById("img1").src = "assets/코스 정보/코스6.jpg";

		roadviewClient.getNearestPanoId(position6, 50, function(panoId) {
			roadview.setPanoId(panoId, position6); //panoId와 중심좌표를 통해 로드뷰 실행
		});

	}
	function hInfo7() {
		document.getElementById("img1").src = "assets/코스 정보/코스7.jpg";

		roadviewClient.getNearestPanoId(position7, 50, function(panoId) {
			roadview.setPanoId(panoId, position7); //panoId와 중심좌표를 통해 로드뷰 실행
		});

	}
	function hInfo8() {
		document.getElementById("img1").src = "assets/코스 정보/코스8.jpg";

		roadviewClient.getNearestPanoId(position8, 50, function(panoId) {
			roadview.setPanoId(panoId, position8); //panoId와 중심좌표를 통해 로드뷰 실행
		});

	}
	function hInfo9() {
		document.getElementById("img1").src = "assets/코스 정보/코스9.jpg";

		roadviewClient.getNearestPanoId(position1, 50, function(panoId) {
			roadview.setPanoId(panoId, position9); //panoId와 중심좌표를 통해 로드뷰 실행
		});

	}
</script>


</head>
<body id="page-top" style="background-color: #BCECF6">
	<!-- Navigation-->
	<nav
		class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top"
		id="mainNav">
	<div class="container">

		<a class="navbar-brand" href="#page-top">Windbreaker</a>
		<button
			class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded"
			type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarResponsive" aria-controls="navbarResponsive"
			aria-expanded="false" aria-label="Toggle navigation">
			Menu <i class="fas fa-bars"></i>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav ms-auto">
				<li class="nav-item mx-0 mx-lg-1"><a
					class="nav-link py-3 px-0 px-lg-3 rounded" href="#portfolio">Riding
						Course</a></li>
				<li class="nav-item mx-0 mx-lg-1"><a
					class="nav-link py-3 px-0 px-lg-3 rounded" href="#about">About
						Course </a></li>
				<li class="nav-item mx-0 mx-lg-1"><a
					class="nav-link py-3 px-0 px-lg-3 rounded" href="#contact">Our
						Team</a></li>
			</ul>
		</div>
	</div>
	</nav>
	<!-- Masthead-->
	<header class="masthead bg-warning text-white text-center">
	<div class="container d-flex align-items-center flex-column">
		<!-- Masthead Avatar Image-->
		<img class="masthead-avatar mb-5" src="assets/img/bike.svg" alt="..." />
		<!-- Masthead Heading-->
		<h1 class="masthead-heading text-uppercase mb-0">WindBreaker</h1>
		<!-- Icon Divider-->
		<div class="divider-custom divider-light">
			<div class="divider-custom-line"></div>
			<div class="divider-custom-icon">
				<i class="fas fa-star"></i>
			</div>
			<div class="divider-custom-line"></div>
		</div>
		<!-- Masthead Subheading-->
		<p class="masthead-subheading font-weight-light mb-0">Cheongjusi
			Riding Course</p>

	</div>

	</header>
	<!-- Portfolio Section-->
	<section class="page-section portfolio" id="portfolio">
	<div class="container">
		<!-- Portfolio Section Heading-->
		<h2
			class="page-section-heading text-center text-uppercase text-secondary mb-0">Riding
			Course</h2>
		<!-- Icon Divider-->
		<div class="divider-custom">
			<div class="divider-custom-line"></div>
			<div class="divider-custom-icon">
				<i class="fas fa-star"></i>
			</div>
			<div class="divider-custom-line"></div>
		</div>


		<div class="row">
			<div class="map">
				<div id="map"
					style="width: 100%; height: 450px; margin: 0 auto; border: 4px solid #FFC107"></div>

			</div>

			<script>
				var container = document.getElementById('map');
				var options = {
					center : new kakao.maps.LatLng(36.629226755812056,
							127.46077301185697),
					level : 7
				};

				var map = new kakao.maps.Map(container, options);

				var h1path = [
						new kakao.maps.LatLng(36.62560943971661,
								127.43152088005203),
						new kakao.maps.LatLng(36.62540270181606,
								127.4307539122943),
						new kakao.maps.LatLng(36.62861909113492,
								127.42843513904427),
						new kakao.maps.LatLng(36.632574864938896,
								127.43223056470742),
						new kakao.maps.LatLng(36.63311877299577,
								127.43382129022103),
						new kakao.maps.LatLng(36.632749735068685,
								127.43617278941053),
						new kakao.maps.LatLng(36.63277771334297,
								127.44081299888433),
						new kakao.maps.LatLng(36.633782301852165,
								127.44449726723042),
						new kakao.maps.LatLng(36.63451577129949,
								127.45312210392713),
						new kakao.maps.LatLng(36.63488521715975,
								127.46017956917748),
						new kakao.maps.LatLng(36.63543710772401,
								127.46885947813018),
						new kakao.maps.LatLng(36.6353953049239,
								127.47486353508042),
						new kakao.maps.LatLng(36.63600830381946,
								127.47930627178538),
						new kakao.maps.LatLng(36.636513760180996,
								127.48467086852625),
						new kakao.maps.LatLng(36.64373535919031,
								127.48379356111457),
						new kakao.maps.LatLng(36.648548436265216,
								127.48130746626869),
						new kakao.maps.LatLng(36.65498559707476,
								127.47604629548721),
						new kakao.maps.LatLng(36.657189244830256,
								127.47481839859189),
						new kakao.maps.LatLng(36.6589723695219,
								127.47791071129257),
						new kakao.maps.LatLng(36.65002840811796,
								127.48577882124543),
						new kakao.maps.LatLng(36.647591045388765,
								127.48793859999451),
						new kakao.maps.LatLng(36.646472150548036,
								127.48940208046572),
						new kakao.maps.LatLng(36.64479554713093,
								127.4895256636504),
						new kakao.maps.LatLng(36.642496756448374,
								127.48974873944528), ]

				var h2path = [
						new kakao.maps.LatLng(36.62584214936984,
								127.431958191396),
						new kakao.maps.LatLng(36.62621686344876,
								127.43299442337087),
						new kakao.maps.LatLng(36.62898578935837,
								127.44092556560354),
						new kakao.maps.LatLng(36.632757417651675,
								127.4408184737015),
						new kakao.maps.LatLng(36.63377554352094,
								127.44449722841162),
						new kakao.maps.LatLng(36.63415216074888,
								127.44740087232165),
						new kakao.maps.LatLng(36.63415216074888,
								127.44740087232165),
						new kakao.maps.LatLng(36.63491463275042,
								127.46014620066413),
						new kakao.maps.LatLng(36.63674612746366,
								127.45957565840169),
						new kakao.maps.LatLng(36.637845997273665,
								127.45944801223281),
						new kakao.maps.LatLng(36.638913077327416,
								127.45964443797037),
						new kakao.maps.LatLng(36.63978958567092,
								127.46018637402548),
						new kakao.maps.LatLng(36.643069924805296,
								127.46245353403819),
						new kakao.maps.LatLng(36.64338690906443,
								127.45383941116957),
						new kakao.maps.LatLng(36.64932482571461,
								127.45397490093839),
						new kakao.maps.LatLng(36.649256307991365,
								127.46703649941878),
						new kakao.maps.LatLng(36.65059214210661,
								127.46935114434137),
						new kakao.maps.LatLng(36.651175699973834,
								127.46990267702282),
						new kakao.maps.LatLng(36.65552793480257,
								127.47223305321903),
						new kakao.maps.LatLng(36.65628126706628,
								127.47314357663456),
						new kakao.maps.LatLng(36.65896546539665,
								127.47794701861783),
						new kakao.maps.LatLng(36.66406370661632,
								127.48681496657045),
						new kakao.maps.LatLng(36.66428616814185,
								127.487504268526),
						new kakao.maps.LatLng(36.66459698945888,
								127.49081152200017),
						new kakao.maps.LatLng(36.6645060486177,
								127.4931934370975), ]

				var h3path = [
						new kakao.maps.LatLng(36.66449704919819,
								127.49319058332632),
						new kakao.maps.LatLng(36.663821617892445,
								127.4930911988284),
						new kakao.maps.LatLng(36.66309843069635,
								127.49255528851204),
						new kakao.maps.LatLng(36.66088462830651,
								127.49074600920318),
						new kakao.maps.LatLng(36.66056561291922,
								127.49053147218977),
						new kakao.maps.LatLng(36.660241608102304,
								127.49043434566069),
						new kakao.maps.LatLng(36.659196676318956,
								127.49034383236685),
						new kakao.maps.LatLng(36.65890434789572,
								127.49021335546183),
						new kakao.maps.LatLng(36.65732157638392,
								127.48833553013772),
						new kakao.maps.LatLng(36.65500478165436,
								127.48855576339372),
						new kakao.maps.LatLng(36.651615214973724,
								127.4888810395455),
						new kakao.maps.LatLng(36.65156735187567,
								127.48846694597093),
						new kakao.maps.LatLng(36.650055190361705,
								127.48584049774487),
						new kakao.maps.LatLng(36.64757822170455,
								127.48334791182364),
						new kakao.maps.LatLng(36.64724651410547,
								127.48292647953605),
						new kakao.maps.LatLng(36.64523636006934,
								127.47861980014282),
						new kakao.maps.LatLng(36.64303799531317,
								127.47401585909907),
						new kakao.maps.LatLng(36.64273899256922,
								127.47329277050423),
						new kakao.maps.LatLng(36.6426526322379,
								127.472347341244),
						new kakao.maps.LatLng(36.643069968213865,
								127.46244235197325), ]

				var h4path = [
						new kakao.maps.LatLng(36.66726748859071,
								127.501941580113),
						new kakao.maps.LatLng(36.66683918402912,
								127.50200591314035),
						new kakao.maps.LatLng(36.66610974218406,
								127.50189491204274),
						new kakao.maps.LatLng(36.663750418567595,
								127.50151047846794),
						new kakao.maps.LatLng(36.659867010802984,
								127.50140699330052),
						new kakao.maps.LatLng(36.65913173144176,
								127.50054100834107),
						new kakao.maps.LatLng(36.65911821677319,
								127.49946719661442),
						new kakao.maps.LatLng(36.658113865518054,
								127.49937123261932),
						new kakao.maps.LatLng(36.65754122148162,
								127.49947378592647),
						new kakao.maps.LatLng(36.65728069958832,
								127.49928196883974),
						new kakao.maps.LatLng(36.65670678299562,
								127.49861279830226),
						new kakao.maps.LatLng(36.655955050619774,
								127.49951946067377),
						new kakao.maps.LatLng(36.65543785573269,
								127.49929243767136),
						new kakao.maps.LatLng(36.6547836121813,
								127.49843822917997),
						new kakao.maps.LatLng(36.65469404023974,
								127.49830903594882),
						new kakao.maps.LatLng(36.654239405416774,
								127.49820545093758),
						new kakao.maps.LatLng(36.65388940230509,
								127.49786208788964),
						new kakao.maps.LatLng(36.65367902209409,
								127.49753081009645),
						new kakao.maps.LatLng(36.65318724462355,
								127.49768981078161),
						new kakao.maps.LatLng(36.65267821599329,
								127.49766416742158),
						new kakao.maps.LatLng(36.65225761476161,
								127.49804170436055),
						new kakao.maps.LatLng(36.651711606755306,
								127.49823949206933),
						new kakao.maps.LatLng(36.651253471359844,
								127.49789544406856),
						new kakao.maps.LatLng(36.651362538198214,
								127.49767247610988),
						new kakao.maps.LatLng(36.65142605663014,
								127.4964874321431),
						new kakao.maps.LatLng(36.65133282356466,
								127.49507212042792),
						new kakao.maps.LatLng(36.651373954053874,
								127.49493258985451),
						new kakao.maps.LatLng(36.65132260445656,
								127.494278026338),
						new kakao.maps.LatLng(36.65180675789581,
								127.49378345173052),
						new kakao.maps.LatLng(36.652038698233866,
								127.49217449328816),
						new kakao.maps.LatLng(36.65166111182889,
								127.48977321811371),
						new kakao.maps.LatLng(36.65086135887976,
								127.49032173350146),
						new kakao.maps.LatLng(36.65012585535094,
								127.4905854704636),
						new kakao.maps.LatLng(36.64915403595789,
								127.49133976311245),
						new kakao.maps.LatLng(36.64900953664825,
								127.49141712733507),
						new kakao.maps.LatLng(36.64774265698482,
								127.4916103719509),
						new kakao.maps.LatLng(36.645574927806024,
								127.49173637819261),
						new kakao.maps.LatLng(36.643186358199095,
								127.49187774743505),
						new kakao.maps.LatLng(36.64127098237944,
								127.49199416302984),
						new kakao.maps.LatLng(36.641407849373905,
								127.49376180044953),

				]

				var h5path = [
						new kakao.maps.LatLng(36.607142133473836,
								127.48171510221933),
						new kakao.maps.LatLng(36.612689010918,
								127.47374620451284),
						new kakao.maps.LatLng(36.615498190219064,
								127.47092968134318),
						new kakao.maps.LatLng(36.6226815032284,
								127.46716679600658),
						new kakao.maps.LatLng(36.62455106581086,
								127.46377946535944),
						new kakao.maps.LatLng(36.634927955040936,
								127.46019659505198),
						new kakao.maps.LatLng(36.633744275764144,
								127.44442437241395),
						new kakao.maps.LatLng(36.632725754641676,
								127.44085183586368),
						new kakao.maps.LatLng(36.62896770505515,
								127.4409422330272),
						new kakao.maps.LatLng(36.62538268944444,
								127.43068113234675),
						new kakao.maps.LatLng(36.62297076409395,
								127.4323110909853),
						new kakao.maps.LatLng(36.62615354356392,
								127.44165289496361),
						new kakao.maps.LatLng(36.62528660984308,
								127.4421510381654),
						new kakao.maps.LatLng(36.625964907981185,
								127.44391574069063) ]

				var h6path = [
						new kakao.maps.LatLng(36.607128277948455,
								127.4817988444882),
						new kakao.maps.LatLng(36.61136882073712,
								127.48495498861102),
						new kakao.maps.LatLng(36.624780163344965,
								127.48875064256735),
						new kakao.maps.LatLng(36.6290982059881,
								127.48171196178859),
						new kakao.maps.LatLng(36.631935080441814,
								127.47989598296905),
						new kakao.maps.LatLng(36.63865223584525,
								127.47896483613442),
						new kakao.maps.LatLng(36.643777725772786,
								127.47944386554717),
						new kakao.maps.LatLng(36.645047719177796,
								127.48404778600094),
						new kakao.maps.LatLng(36.64478212248232,
								127.48950321357705),
						new kakao.maps.LatLng(36.637128255600594,
								127.49030457957726)

				]

				var h7path = [
						new kakao.maps.LatLng(36.63490773408057,
								127.46018249836632),
						new kakao.maps.LatLng(36.637118212085454,
								127.45948003053614),
						new kakao.maps.LatLng(36.638694677226276,
								127.45961239087116),
						new kakao.maps.LatLng(36.64308113438284,
								127.4624675789557),
						new kakao.maps.LatLng(36.64268186275932,
								127.47236149754725),
						new kakao.maps.LatLng(36.64282177833756,
								127.47343585110028),
						new kakao.maps.LatLng(36.64524330929302,
								127.47857231695814),
						new kakao.maps.LatLng(36.64727126046049,
								127.48293502123235),
						new kakao.maps.LatLng(36.65006191442563,
								127.48584892747773),
						new kakao.maps.LatLng(36.65166708573577,
								127.48886738800432),
						new kakao.maps.LatLng(36.64249894025061,
								127.48976552661367)

				]

				var h8path = [
						new kakao.maps.LatLng(36.59627113415164,
								127.49787442119904),
						new kakao.maps.LatLng(36.59652701020777,
								127.49917802102671),
						new kakao.maps.LatLng(36.59861683451052,
								127.49937029792346),
						new kakao.maps.LatLng(36.60113181775529,
								127.49917415838497),
						new kakao.maps.LatLng(36.60498011228039,
								127.49906483256845),
						new kakao.maps.LatLng(36.60597193950334,
								127.49892592195408),
						new kakao.maps.LatLng(36.60972181067995,
								127.49864828359526),
						new kakao.maps.LatLng(36.611371819080226,
								127.49842417441134),
						new kakao.maps.LatLng(36.61263635911407,
								127.49771692622511),
						new kakao.maps.LatLng(36.61321726522948,
								127.49671463993242),
						new kakao.maps.LatLng(36.617290973609485,
								127.49440444639389),
						new kakao.maps.LatLng(36.61936690229319,
								127.49360164312736),
						new kakao.maps.LatLng(36.621736904994656,
								127.49359439443414),
						new kakao.maps.LatLng(36.623279092912085,
								127.49329120242896),
						new kakao.maps.LatLng(36.62432761323933,
								127.49251531158393),
						new kakao.maps.LatLng(36.62566481604203,
								127.48947173507003),
						new kakao.maps.LatLng(36.62652632494451,
								127.48814677198793),
						new kakao.maps.LatLng(36.629403111945365,
								127.48318966433703),
						new kakao.maps.LatLng(36.63092127366388,
								127.48213698922174),
						new kakao.maps.LatLng(36.63233628210068,
								127.48207871988252),
						new kakao.maps.LatLng(36.63601368970956,
								127.48410308095059),
						new kakao.maps.LatLng(36.638527682447105,
								127.48414117320847),
						new kakao.maps.LatLng(36.64152967894352,
								127.48383567814696),
						new kakao.maps.LatLng(36.64473227507005,
								127.48294992173764),
						new kakao.maps.LatLng(36.6468000153762,
								127.48192282637439),
						new kakao.maps.LatLng(36.64986319999006,
								127.47985063610525),
						new kakao.maps.LatLng(36.653254330813226,
								127.47688560580755),
						new kakao.maps.LatLng(36.65686031718475,
								127.4742571630361),
						new kakao.maps.LatLng(36.65960824724006,
								127.47211536961264),
						new kakao.maps.LatLng(36.659824645054954,
								127.47208313682547),
						new kakao.maps.LatLng(36.66012960108143,
								127.47244291212893),
						new kakao.maps.LatLng(36.66755426626042,
								127.46573203035659),
						new kakao.maps.LatLng(36.66639978648106,
								127.46368927700922),
						new kakao.maps.LatLng(36.671338829530846,
								127.45880807408965),
						new kakao.maps.LatLng(36.67356014184288,
								127.45527506669195),
						new kakao.maps.LatLng(36.67397097596238,
								127.45387913742192),
						new kakao.maps.LatLng(36.67453434373296,
								127.45265188966476),
						new kakao.maps.LatLng(36.674520059367026,
								127.45166736063845),
						new kakao.maps.LatLng(36.675665813685654,
								127.4489332317975),
						new kakao.maps.LatLng(36.676807224633905,
								127.4473400923443),
						new kakao.maps.LatLng(36.680823895305174,
								127.44314555123474),
						new kakao.maps.LatLng(36.681179608513304,
								127.44199524340954),
						new kakao.maps.LatLng(36.68122141458417,
								127.44044037086819),
						new kakao.maps.LatLng(36.68051675278279,
								127.4360283786042),
						new kakao.maps.LatLng(36.68146532786833,
								127.43537364690175), ]

				var h9path = [
						new kakao.maps.LatLng(36.61935090470267,
								127.51650985528939),
						new kakao.maps.LatLng(36.62332387246914,
								127.51881696795768),
						new kakao.maps.LatLng(36.62771623121848,
								127.51999795546062),
						new kakao.maps.LatLng(36.628794037238485,
								127.52081017318484),
						new kakao.maps.LatLng(36.63065555055123,
								127.52168359813226),
						new kakao.maps.LatLng(36.63219746100021,
								127.52145919662009),
						new kakao.maps.LatLng(36.63251801232701,
								127.52131041611189),
						new kakao.maps.LatLng(36.6337788438217,
								127.52148103337291),
						new kakao.maps.LatLng(36.63446196668148,
								127.52187697360498),
						new kakao.maps.LatLng(36.63450033568122,
								127.52237478939296),
						new kakao.maps.LatLng(36.635005544305784,
								127.5232698948781),
						new kakao.maps.LatLng(36.634943418307905,
								127.52356577446054),
						new kakao.maps.LatLng(36.63508065529186,
								127.52412016941693),
						new kakao.maps.LatLng(36.635015486846854,
								127.52459492605344),
						new kakao.maps.LatLng(36.635045917342126,
								127.52484670787098),
						new kakao.maps.LatLng(36.63523898875996,
								127.52499896307182),
						new kakao.maps.LatLng(36.63546964362227,
								127.52480206174234),
						new kakao.maps.LatLng(36.6354499229013,
								127.52467613957836),
						new kakao.maps.LatLng(36.63557908043756,
								127.52450650184579),
						new kakao.maps.LatLng(36.63559897223185,
								127.52408175052801),
						new kakao.maps.LatLng(36.63594147627488,
								127.524064503029),

				]

				// 지도에 표시할 선을 생성합니다
				var polyline = new kakao.maps.Polyline({
					strokeWeight : 5, // 선의 두께 입니다
					strokeColor : 'red', // 선의 색깔입니다
					strokeOpacity : 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
					strokeStyle : 'solid' // 선의 스타일입니다
				});

				//////////////////////////////////////////////
				var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

				var h1positions = [
						{
							title : 'CU 청주가경행복점',
							latlng : new kakao.maps.LatLng(36.631800699999644,
									127.42776759999995)
						},
						{
							title : '삼천리 사창점',
							latlng : new kakao.maps.LatLng(36.635201785454164,
									127.46854833350524)
						} ];

				var h1markers = [];

				for (var i = 0; i < h1positions.length; i++) {
					var imageSize = new kakao.maps.Size(24, 35);
					var markerImage = new kakao.maps.MarkerImage(imageSrc,
							imageSize);
					var h1marker = new kakao.maps.Marker({
						position : h1positions[i].latlng,
						title : h1positions[i].title,
						image : markerImage
					});
					h1markers.push(h1marker);
				}
				function h1Markers(map) {
					for (var i = 0; i < h1markers.length; i++) {
						h1markers[i].setMap(map);
					}
				}

				////////////////////////////
				var h2positions = [
						{
							title : 'GS25',
							latlng : new kakao.maps.LatLng(36.63501609592116,
									127.45954022598029)
						},
						{
							title : 'CU',
							latlng : new kakao.maps.LatLng(36.641035602223624,
									127.46129801100648)
						}, ];

				var h2markers = [];

				for (var i = 0; i < h2positions.length; i++) {
					var imageSize = new kakao.maps.Size(24, 35);
					var markerImage = new kakao.maps.MarkerImage(imageSrc,
							imageSize);
					var h2marker = new kakao.maps.Marker({
						position : h2positions[i].latlng,
						title : h2positions[i].title,
						image : markerImage
					});
					h2markers.push(h2marker);
				}
				function h2Markers(map) {
					for (var i = 0; i < h2markers.length; i++) {
						h2markers[i].setMap(map);
					}
				}
				////////////////////////////
				var h3positions = [
						{
							title : 'CU 청주우암월드점',
							latlng : new kakao.maps.LatLng(36.64765603252509,
									127.4819359879429)
						},
						{
							title : 'cnj바이크',
							latlng : new kakao.maps.LatLng(36.64660013515697,
									127.48009542552838)
						},
						{
							title : '아텍스자전거',
							latlng : new kakao.maps.LatLng(36.660677760707536,
									127.49021341531679)
						} ];

				var h3markers = [];

				for (var i = 0; i < h3positions.length; i++) {
					var imageSize = new kakao.maps.Size(24, 35);
					var markerImage = new kakao.maps.MarkerImage(imageSrc,
							imageSize);
					var h3marker = new kakao.maps.Marker({
						position : h3positions[i].latlng,
						title : h3positions[i].title,
						image : markerImage
					});
					h3markers.push(h3marker);
				}
				function h3Markers(map) {
					for (var i = 0; i < h3markers.length; i++) {
						h3markers[i].setMap(map);
					}
				}

				////////////////////////////
				var h4positions = [
						{
							title : '세븐일레븐 청주대중문',
							latlng : new kakao.maps.LatLng(36.65084841262592,
									127.49280381490179)
						},
						{
							title : '알톤자전거 북문점',
							latlng : new kakao.maps.LatLng(36.6428136658807,
									127.49025674361545)
						}, ];

				var h4markers = [];

				for (var i = 0; i < h4positions.length; i++) {
					var imageSize = new kakao.maps.Size(24, 35);
					var markerImage = new kakao.maps.MarkerImage(imageSrc,
							imageSize);
					var h4marker = new kakao.maps.Marker({
						position : h4positions[i].latlng,
						title : h4positions[i].title,
						image : markerImage
					});
					h4markers.push(h4marker);
				}
				function h4Markers(map) {
					for (var i = 0; i < h4markers.length; i++) {
						h4markers[i].setMap(map);
					}
				}

				////////////////////////////
				var h5positions = [
						{
							title : 'gs25 사창사거리점',
							latlng : new kakao.maps.LatLng(36.63507475640046,
									127.45951765293752)
						},
						{
							title : '알톤자전거',
							latlng : new kakao.maps.LatLng(36.60773811269995,
									127.48141031744922)
						}, ];

				var h5markers = [];

				for (var i = 0; i < h5positions.length; i++) {
					var imageSize = new kakao.maps.Size(24, 35);
					var markerImage = new kakao.maps.MarkerImage(imageSrc,
							imageSize);
					var h5marker = new kakao.maps.Marker({
						position : h5positions[i].latlng,
						title : h5positions[i].title,
						image : markerImage
					});
					h5markers.push(h5marker);
				}
				function h5Markers(map) {
					for (var i = 0; i < h5markers.length; i++) {
						h5markers[i].setMap(map);
					}
				}

				////////////////////////////
				var h6positions = [
						{
							title : '세븐일레븐 청주교대점',
							latlng : new kakao.maps.LatLng(36.61723186212638,
									127.48687529641548)
						},
						{
							title : '알톤자전거',
							latlng : new kakao.maps.LatLng(36.60773811269995,
									127.48141031744922)
						},
						{
							title : '한성상사',
							latlng : new kakao.maps.LatLng(36.61254019356228,
									127.48475776777245)
						},
						{
							title : '더바이크샵',
							latlng : new kakao.maps.LatLng(36.644517346572684,
									127.48704697461201)
						} ];

				var h6markers = [];

				for (var i = 0; i < h6positions.length; i++) {
					var imageSize = new kakao.maps.Size(24, 35);
					var markerImage = new kakao.maps.MarkerImage(imageSrc,
							imageSize);
					var h6marker = new kakao.maps.Marker({
						position : h6positions[i].latlng,
						title : h6positions[i].title,
						image : markerImage
					});
					h6markers.push(h6marker);
				}
				function h6Markers(map) {
					for (var i = 0; i < h6markers.length; i++) {
						h6markers[i].setMap(map);
					}
				}

				////////////////////////////
				var h7positions = [
						{
							title : 'gs25봉명리치점',
							latlng : new kakao.maps.LatLng(36.642457701430466,
									127.46393599338346)
						},
						{
							title : 'cnj바이크',
							latlng : new kakao.maps.LatLng(36.64660013515697,
									127.48009542552838)
						}, ];

				var h7markers = [];

				for (var i = 0; i < h7positions.length; i++) {
					var imageSize = new kakao.maps.Size(24, 35);
					var markerImage = new kakao.maps.MarkerImage(imageSrc,
							imageSize);
					var h7marker = new kakao.maps.Marker({
						position : h7positions[i].latlng,
						title : h7positions[i].title,
						image : markerImage
					});
					h7markers.push(h7marker);
				}
				function h7Markers(map) {
					for (var i = 0; i < h7markers.length; i++) {
						h7markers[i].setMap(map);
					}
				}

				////////////////////////////
				var h8positions = [
						{
							title : 'CU 청주 송절점',
							latlng : new kakao.maps.LatLng(36.66555014749169,
									127.46435195896785)
						},
						{
							title : '소울바이크',
							latlng : new kakao.maps.LatLng(36.65741168549743,
									127.47156398766785)
						} ];

				var h8markers = [];

				for (var i = 0; i < h8positions.length; i++) {
					var imageSize = new kakao.maps.Size(24, 35);
					var markerImage = new kakao.maps.MarkerImage(imageSrc,
							imageSize);
					var h8marker = new kakao.maps.Marker({
						position : h8positions[i].latlng,
						title : h8positions[i].title,
						image : markerImage
					});
					h8markers.push(h8marker);
				}
				function h8Markers(map) {
					for (var i = 0; i < h8markers.length; i++) {
						h8markers[i].setMap(map);
					}
				}

				////////////////////////////
				var h9positions = [
						{
							title : '동부 LPG주유소점',
							latlng : new kakao.maps.LatLng(36.62884778386025,
									127.5204712145237)
						},
						{
							title : '순치명 석조여래입상',
							latlng : new kakao.maps.LatLng(36.632530024001944,
									127.52165430577752)
						}, ];

				var h9markers = [];

				for (var i = 0; i < h9positions.length; i++) {
					var imageSize = new kakao.maps.Size(24, 35);
					var markerImage = new kakao.maps.MarkerImage(imageSrc,
							imageSize);
					var h9marker = new kakao.maps.Marker({
						position : h9positions[i].latlng,
						title : h9positions[i].title,
						image : markerImage
					});
					h9markers.push(h9marker);
				}
				function h9Markers(map) {
					for (var i = 0; i < h9markers.length; i++) {
						h9markers[i].setMap(map);
					}
				}

				////////////////////////////

				function h1see() {
					polyline.setPath(h1path);
					polyline.setMap(map);
				}

				function h1rest() {
					h1Markers(map);
				}

				function h1hide() {
					polyline.setPath(h1path);
					polyline.setMap(null);
					h1Markers(null);
				}

				function h2see() {
					polyline.setPath(h2path);
					polyline.setMap(map);
				}

				function h2rest() {
					h2Markers(map)
				}

				function h2hide() {
					polyline.setPath(h2path);
					polyline.setMap(null);
					h2Markers(null);
				}

				function h3see() {
					polyline.setPath(h3path);
					polyline.setMap(map);
				}

				function h3rest() {
					h3Markers(map)
				}

				function h3hide() {
					polyline.setPath(h3path);
					polyline.setMap(null);
					h3Markers(null);
				}

				function h4see() {
					polyline.setPath(h4path);
					polyline.setMap(map);
				}

				function h4rest() {
					h4Markers(map)
				}

				function h4hide() {
					polyline.setPath(h4path);
					polyline.setMap(null);
					h4Markers(null);
				}

				function h5see() {
					polyline.setPath(h5path);
					polyline.setMap(map);
				}

				function h5rest() {
					h5Markers(map)
				}

				function h5hide() {
					polyline.setPath(h5path);
					polyline.setMap(null);
					h5Markers(null);
				}

				function h6see() {
					polyline.setPath(h6path);
					polyline.setMap(map);
				}

				function h6rest() {
					h6Markers(map)
				}

				function h6hide() {
					polyline.setPath(h6path);
					polyline.setMap(null);
					h6Markers(null);
				}

				function h7see() {
					polyline.setPath(h7path);
					polyline.setMap(map);
				}

				function h7rest() {
					h7Markers(map)
				}

				function h7hide() {
					polyline.setPath(h7path);
					polyline.setMap(null);
					h7Markers(null);
				}

				function h8see() {
					polyline.setPath(h8path);
					polyline.setMap(map);
				}

				function h8rest() {
					h8Markers(map)
				}

				function h8hide() {
					polyline.setPath(h8path);
					polyline.setMap(null);
					h8Markers(null);
				}

				function h9see() {
					polyline.setPath(h9path);
					polyline.setMap(map);
				}

				function h9rest() {
					h9Markers(map)
				}

				function h9hide() {
					polyline.setPath(h9path);
					polyline.setMap(null);
					h9Markers(null);
				}
			</script>

			<div class="mapside">
				<div class="main">
					<input type="radio" id="tab-1" name="show" checked /> <input
						type="radio" id="tab-2" name="show" /> <input type="radio"
						id="tab-3" name="show" /> <input type="radio" id="tab-4"
						name="show" />
					<div class="tab">
						<label for="tab-1">흥덕구 코스</label> <label for="tab-2">청원구
							코스</label> <label for="tab-3">서원구 코스</label> <label for="tab-4">상당구
							코스</label>
					</div>
					<div class="content">
						<div class="content-dis">

							<div>1. 청주시외버스터미널 → 터미널사거리(우회전) → 복대사거리 → 산업단지육거리 → 충대사거리 →
								사창사거리 → 사직사거리 → 청주대교사거리(좌회전) → 제2운천교사거리(우회전) → 방아다리사거리 → 청주시청</div>
							<button id="button1" onclick="h1see()">경로 표시</button>
							<button id="button1" onclick="h1rest()">휴게시설 표시</button>
							<button id="button1" onclick="h1hide()">초기화</button>
							<div>
								<br> <br>
							</div>

							<div>2. 청주시외버스터미널 → 터미널사거리(우회전) → 복대사거리 → 산업단지육거리 → 충대사거리 →
								사창사거리(좌회전) → 봉정사거리 → 시영아파트사거리 → 내덕사거리(우회전) → 율량교사거리</div>
							<button id="button1" onclick="h2see()">경로 표시</button>
							<button id="button1" onclick="h2rest()">휴게시설 표시</button>
							<button id="button1" onclick="h2hide()">초기화</button>

						</div>
						<div class="content-dis">
							<div>1. 율량교사거리 → 내덕칠거리 → 청주대사거리(우회전) → 우암사거리 → 흥덕사거리 →
								봉명사거리</div>
							<button id="button1" onclick="h3see()">경로 표시</button>
							<button id="button1" onclick="h3rest()">휴게시설 표시</button>
							<button id="button1" onclick="h3hide()">초기화</button>
							<div>
								<br> <br>
							</div>
							<div>2. 청주중앙초등학교 → 대성로 → 우암순환로(우회전) → 삼일공원</div>
							<button id="button1" onclick="h4see()">경로 표시</button>
							<button id="button1" onclick="h4rest()">휴게시설 표시</button>
							<button id="button1" onclick="h4hide()">초기화</button>
						</div>

						<div class="content-dis">
							<div>1. 분평사거리 → 산남사거리 → 개신오거리 → 사창사거리(좌회전) → 산업단지육거리 →
								복대사거리 → 터미널사거리(좌회전) → 시외버스터미널 방향(좌회전) →복대2동사무소</div>
							<button id="button1" onclick="h5see()">경로 표시</button>
							<button id="button1" onclick="h5rest()">휴게시설 표시</button>
							<button id="button1" onclick="h5hide()">초기화</button>
							<div>
								<br>
							</div>
							<div>2. 분평사거리 → 모충사거리(좌회전) → 사직사거리 → 삼원맨션사거리(우회전) →
								방아다리사거리(우회전) → 상당사거리</div>
							<button id="button1" onclick="h6see()">경로 표시</button>
							<button id="button1" onclick="h6rest()">휴게시설 표시</button>
							<button id="button1" onclick="h6hide()">초기화</button>
							<div>
								<br>
							</div>
							<div>3. 사창사거리 → 봉명사거리(우회전) → 흥덕사거리 → 우암사거리 → 청주대사거리(우회전) →
								청주시청</div>
							<button id="button1" onclick="h7see()">경로 표시</button>
							<button id="button1" onclick="h7rest()">휴게시설 표시</button>
							<button id="button1" onclick="h7hide()">초기화</button>
						</div>

						<div class="content-dis">
							<div>1. 장평교 → 방서교 → 수영교 → 청남교 → 모충대교 → 청주대교 → 흥덕대교 → 제2운천교
								→ 송천교 → 미호천</div>

							<button id="button1" onclick="h8see()">경로 표시</button>
							<button id="button1" onclick="h8rest()">휴게시설 표시</button>
							<button id="button1" onclick="h8hide()">초기화</button>
							<div>
								<br> <br>
							</div>
							<div>2. 용암지하차도 → 동부우회도로 → E1 LPG 충전소(우회전) → 순치명석불 → 이정골마을회관
								→ 용정저수지</div>

							<button id="button1" onclick="h9see()">경로 표시</button>
							<button id="button1" onclick="h9rest()">휴게시설 표시</button>
							<button id="button1" onclick="h9hide()">초기화</button>

						</div>
						<div></div>
					</div>
				</div>
			</div>
	</section>



	<!-- About Section-->
	<section class="page-section bg-warning text-white mb-0" id="about">
	<div class="container">
		<!-- About Section Heading-->
		<h2 class="page-section-heading text-center text-uppercase text-white">About
			Course</h2>
		<!-- Icon Divider-->
		<div class="divider-custom divider-light">
			<div class="divider-custom-line"></div>
			<div class="divider-custom-icon">
				<i class="fas fa-star"></i>
			</div>
			<div class="divider-custom-line"></div>
		</div>
		<!-- About Section Content-->
		<div class="row" style="width: 100%; min-height: 450px">
			<div class="mapside">
				<div class="dropdown">
					<button class="dropbtn">흥덕구 코스</button>
					<div class="dropdown-content">
						<a onclick="hInfo1()" style="color: black;">코스 1</a> <a
							onclick="hInfo2()" style="color: black;">코스 2</a>
					</div>
				</div>
				<div class="dropdown">
					<button class="dropbtn">청원구 코스</button>
					<div class="dropdown-content">
						<a onclick="hInfo3()" style="color: black;">코스 1</a> <a
							onclick="hInfo4()" style="color: black;">코스 2</a> <a
							onclick="hInfo5()" style="color: black;">코스 3</a>
					</div>
				</div>
				<div class="dropdown">
					<button class="dropbtn">서원구 코스</button>
					<div class="dropdown-content">
						<a onclick="hInfo6()" style="color: black;">코스 1</a> <a
							onclick="hInfo7()" style="color: black;">코스 2</a>
					</div>
				</div>
				<div class="dropdown">
					<button class="dropbtn">상당구 코스</button>
					<div class="dropdown-content">
						<a onclick="hInfo8()" style="color: black;">코스 1</a> <a
							onclick="hInfo9()" style="color: black;">코스 2</a>
					</div>
				</div>

				<img id="img1"
					style="width: 465px; height: 180px; margin-top: 40%; box-shadow: 0px 0px 2px 2px rgb(0, 0, 0)"
					src="assets/코스 정보/INFO.jpg" />
			</div>
			<div class="map">
				<div id="roadview"
					style="width: 775px; height: 445px; box-shadow: 0px 0px 2px 2px rgb(0, 0, 0)"></div>
				<script>
					var roadviewContainer = document.getElementById('roadview'); //로드뷰를 표시할 div
					var roadview = new kakao.maps.Roadview(roadviewContainer); //로드뷰 객체
					var roadviewClient = new kakao.maps.RoadviewClient(); //좌표로부터 로드뷰 파노ID를 가져올 로드뷰 helper객체

					var position0 = new kakao.maps.LatLng(36.62891233294496,
							127.45800862172902);
					var position1 = new kakao.maps.LatLng(36.62560943971661,
							127.43152088005203);
					var position2 = new kakao.maps.LatLng(36.62584214936984,
							127.431958191396);
					var position3 = new kakao.maps.LatLng(36.66449704919819,
							127.49319058332632);
					var position4 = new kakao.maps.LatLng(36.66726748859071,
							127.501941580113);
					var position5 = new kakao.maps.LatLng(36.607123975729,
							127.48074852067237);
					var position6 = new kakao.maps.LatLng(36.607150918665766,
							127.48177104249034);
					var position7 = new kakao.maps.LatLng(36.63490773408057,
							127.46018249836632);
					var position8 = new kakao.maps.LatLng(36.59627113415164,
							127.49787442119904);
					var position9 = new kakao.maps.LatLng(36.61935090470267,
							127.51650985528939);
					// 특정 위치의 좌표와 가까운 로드뷰의 panoId를 추출하여 로드뷰를 띄운다.
					roadviewClient.getNearestPanoId(position0, 50, function(
							panoId) {
						roadview.setPanoId(panoId, position0); //panoId와 중심좌표를 통해 로드뷰 실행
					});
				</script>
			</div>
		</div>
	</div>

	</section>
	<!-- Contact Section-->
	<section class="page-section" id="contact">
	<div class="container">
		<!-- Contact Section Heading-->
		<h2
			class="page-section-heading text-center text-uppercase text-secondary mb-0">Our
			Team</h2>
		<!-- Icon Divider-->
		<div class="divider-custom">
			<div class="divider-custom-line"></div>
			<div class="divider-custom-icon">
				<i class="fas fa-star"></i>
			</div>
			<div class="divider-custom-line"></div>
		</div>
		<!-- Contact Section Form-->
		<img id="img2"
			style="width: 1000px; height: 470px; margin-left: 145px; box-shadow: 0px 0px 2px 2px rgb(0, 0, 0)"
			src="assets/img/team.png" />
	</div>
	</section>
	<!-- Footer-->
	<footer class="footer text-center">
	<div class="container">
		<div class="row">
			<!-- Footer Location-->
			<div class="col-lg-4 mb-5 mb-lg-0">
				<h4 class="text-uppercase mb-4">Team</h4>
				<p class="lead mb-0">
					JinYeong Kim <br /> MinWoo Cho <br /> DongHyeon Lee
				</p>
			</div>
			<!-- Footer Social Icons-->
			<div class="col-lg-4 mb-5 mb-lg-0">
				<h4 class="text-uppercase mb-4">Class</h4>
				<p class="lead mb-0">
					OpenSource Gaebal <br /> Prof. Kang <br /> -Java Web Project-
				</p>

			</div>
			<!-- Footer About Text-->
			<div class="col-lg-4">
				<h4 class="text-uppercase mb-4">Github URL</h4>
				<p class="lead mb-0">
					This is our <a
						href="https://github.com/OS-Project-OPAYA/windbreaker"> Github
						repository</a> .
				</p>
			</div>
		</div>
	</div>
	</footer>
	<!-- Copyright Section-->
	<div class="copyright py-4 text-center text-white">
		<div class="container">
			<small>Copyright &copy; Windbreaker</small>
		</div>
	</div>

	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>

</body>
</html>