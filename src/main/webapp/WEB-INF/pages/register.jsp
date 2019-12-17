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
    </style>
</head>
<body>
<div class="hero-wrap img vh-100" style="background-image: url(static/images/bg_1.jpg);">
    <div class="overlay"></div>
</div>
<div class="container bg-white p-4">
    <div class="title">SKKU Flea Market</div>
    <h1 class="text-center">회원가입</h1>
    <form action="register" method="post" class="p-4 bg-light rounded-lg mb-0">
        <div class="form-group mb-2">
            <div class="input-group">
                <input type="text" name="id" class="form-control" placeholder="아이디" required>
                <div class="input-group-append">
                    <button id="check-id" type="button" class="btn btn-outline-secondary" style="height: 52px;">중복확인
                    </button>
                </div>
            </div>
            <small id="check-id-result" class="form-text text-success" style="display: none;"></small>
        </div>
        <input type="password" name="password" class="form-control mb-2" placeholder="비밀번호" required>
        <input type="text" name="name" class="form-control mb-2" placeholder="이름" required>
        <input type="text" name="phoneNumber" class="form-control mb-2" placeholder="휴대폰 번호" required>
        <label for="type">회원 종류</label>
        <div id="type" class="form-group">
            <span class="custom-control custom-control-inline custom-radio">
                <input type="radio" id="type-buyer" class="custom-control-input" name="type" value="BUYER" required>
                <label class="custom-control-label" for="type-buyer">구매자</label>
            </span>
            <span class="custom-control custom-control-inline custom-radio">
                <input type="radio" id="type-seller" class="custom-control-input" name="type" value="SELLER" required>
                <label class="custom-control-label" for="type-seller">판매자</label>
            </span>
        </div>
        <button type="submit" class="btn btn-block btn-primary py-3 px-5">가입</button>
        <a class="btn btn-block btn-light py-3 px-5" href="login">취소</a>
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

<script>
    $(document).ready(function () {
        $('#check-id').click(function () {
            $.post("register/check-id", {id: $(this).parent().prev().val()}, function (result) {
                if (result) {
                    $('#check-id-result').text('사용하실 수 있는 아이디입니다.').removeClass('text-danger').addClass('text-success').show();
                } else {
                    $('#check-id-result').text('사용하실 수 없는 아이디입니다.').removeClass('text-success').addClass('text-danger').show();
                }
            });
        });
    });
</script>

</body>
</html>