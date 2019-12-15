<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>SKKU Flea Market</title>

    <!-- Template CSS -->

    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="static/css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="static/css/animate.css">

    <link rel="stylesheet" href="static/css/owl.carousel.min.css">
    <link rel="stylesheet" href="static/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="static/css/magnific-popup.css">

    <link rel="stylesheet" href="static/css/aos.css">

    <link rel="stylesheet" href="static/css/ionicons.min.css">

    <link rel="stylesheet" href="static/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="static/css/jquery.timepicker.css">


    <link rel="stylesheet" href="static/css/flaticon.css">
    <link rel="stylesheet" href="static/css/icomoon.css">
    <link rel="stylesheet" href="static/css/style.css">

    <!-- Page Specific CSS -->
    <style>
        .container {
            width: 400px;
            position: absolute;
            top: calc(50% - 300px);
            left: calc(50% - 200px);
        }

        .title {
            text-align: center;
            font-size: 20px;
            font-weight: 700;
        }

        .profile-img {
            width: 120px;
        }

    </style>
</head>
<body>
<div class="hero-wrap img vh-100" style="background-image: url(static/images/bg_1.jpg);">
    <div class="overlay"></div>
</div>
<div class="container bg-white p-4 ftco-animate">
    <div class="title">SKKU Flea Market</div>
    <h1 class="text-center">로그인</h1>
    <form action="login" method="post" class="p-4 bg-light rounded-lg mb-0">
        <div class="p-4 text-center">
            <img src="static/images/profile-user.png" class="profile-img"/>
        </div>
        <input type="text" name="id" class="form-control mb-2" placeholder="아이디" required>
        <input type="password" name="password" class="form-control mb-2" placeholder="비밀번호" required>
        <c:if test="${not empty errorMessage}">
            <div class="text-danger text-center">${errorMessage}</div>
        </c:if>
        <button type="submit" class="btn btn-block btn-primary py-3 px-5">로그인</button>
        <a class="btn btn-block btn-light py-3 px-5" href="register">회원가입</a>
    </form>
</div>

<!-- Template JavaScript -->

<script src="static/js/jquery.min.js"></script>
<script src="static/js/jquery-migrate-3.0.1.min.js"></script>
<script src="static/js/popper.min.js"></script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/jquery.easing.1.3.js"></script>
<script src="static/js/jquery.waypoints.min.js"></script>
<script src="static/js/jquery.stellar.min.js"></script>
<script src="static/js/owl.carousel.min.js"></script>
<script src="static/js/jquery.magnific-popup.min.js"></script>
<script src="static/js/aos.js"></script>
<script src="static/js/jquery.animateNumber.min.js"></script>
<script src="static/js/scrollax.min.js"></script>
<script src="static/js/google-map.js"></script>
<script src="static/js/main.js"></script>

</body>
</html>