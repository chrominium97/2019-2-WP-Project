<%@ tag import="edu.skku.wp.security.SessionAuthProvider" %>
<%@ tag import="edu.skku.wp.security.Permission" %>
<%@ tag description="Page Layout Template" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="css" fragment="true" %>
<%@ attribute name="js" fragment="true" %>
<%
    Permission permission = SessionAuthProvider.getPermission(request);
    request.setAttribute("permission", permission);
    request.setAttribute("cp", request.getContextPath());
%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <title>SKKU Flea Market</title>

    <!-- Template CSS -->

    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${cp}/static/css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="${cp}/static/css/animate.css">

    <link rel="stylesheet" href="${cp}/static/css/owl.carousel.min.css">
    <link rel="stylesheet" href="${cp}/static/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="${cp}/static/css/magnific-popup.css">

    <link rel="stylesheet" href="${cp}/static/css/aos.css">

    <link rel="stylesheet" href="${cp}/static/css/ionicons.min.css">

    <link rel="stylesheet" href="${cp}/static/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="${cp}/static/css/jquery.timepicker.css">


    <link rel="stylesheet" href="${cp}/static/css/flaticon.css">
    <link rel="stylesheet" href="${cp}/static/css/icomoon.css">
    <link rel="stylesheet" href="${cp}/static/css/style.css">
    <style>
        body {
            overflow-wrap: break-word;
        }
    </style>

    <!-- Page Specific CSS -->

    <jsp:invoke fragment="css"/>
</head>
<body>

<!-- Navigation Menu Start -->

<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
    <div class="container-fluid px-md-4	">
        <a class="navbar-brand" href="${cp}">SKKU Flea Market</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav"
                aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="oi oi-menu"></span> Menu
        </button>

        <div class="collapse navbar-collapse" id="ftco-nav">
            <ul class="navbar-nav ml-auto">
                <c:choose>
                    <c:when test="${permission eq 'ANONYMOUS'}">
                        <%-- Anonymous --%>
                        <li class="nav-item active">
                            <a href="${cp}/login" class="nav-link"><span class="icon-key"></span> 로그인</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item active">
                            <a href="${cp}/product/list" class="nav-link"><span class="icon-list"></span> 상품 목록</a>
                        </li>
                        <c:if test="${permission eq 'SELLER' or permission eq 'ADMIN'}">
                            <li class="nav-item active">
                                <a href="${cp}/product/register" class="nav-link"><span class="icon-upload"></span> 상품 등록</a>
                            </li>
                        </c:if>
                        <li class="nav-item active">
                            <a href="${cp}/mypage" class="nav-link"><span class="icon-person"></span> 마이페이지</a>
                        </li>
                        <c:if test="${permission eq 'ADMIN'}">
                            <li class="nav-item active">
                                <a href="${cp}/admin" class="nav-link"><span class="icon-gears"></span> 관리</a>
                            </li>
                        </c:if>
                        <li class="nav-item active">
                            <a href="#" onclick="this.nextElementSibling.submit()" class="nav-link"><span class="icon-power-off"></span> 로그아웃</a>
                            <form action="${cp}/logout" method="post" style="display: none"></form>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<!-- Navigation Menu End -->

<!-- Header Start -->
<!-- Header End -->

<!-- Page Body Start -->

<jsp:doBody/>

<!-- Page Body End -->

<!-- Footer Start -->
<footer class="ftco-footer ftco-section bg-light">
    <div class="container">
        <div class="row">
            <div class="col-md-12 text-center">

                <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                    Copyright &copy;<script>document.write(new Date().getFullYear());</script>
                    All rights reserved | This template is made with <i class="icon-heart text-danger"
                                                                        aria-hidden="true"></i> by <a
                            href="https://colorlib.com" target="_blank">Colorlib</a>
                    <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
            </div>
        </div>
    </div>
</footer>

<!-- Footer End -->

<!-- Template JavaScript -->

<script src="${cp}/static/js/jquery.min.js"></script>
<script src="${cp}/static/js/jquery-migrate-3.0.1.min.js"></script>
<script src="${cp}/static/js/popper.min.js"></script>
<script src="${cp}/static/js/bootstrap.min.js"></script>
<script src="${cp}/static/js/jquery.easing.1.3.js"></script>
<script src="${cp}/static/js/jquery.waypoints.min.js"></script>
<script src="${cp}/static/js/jquery.stellar.min.js"></script>
<script src="${cp}/static/js/owl.carousel.min.js"></script>
<script src="${cp}/static/js/jquery.magnific-popup.min.js"></script>
<script src="${cp}/static/js/aos.js"></script>
<script src="${cp}/static/js/jquery.animateNumber.min.js"></script>
<script src="${cp}/static/js/scrollax.min.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
<script src="${cp}/static/js/google-map.js"></script>
<script src="${cp}/static/js/main.js"></script>

<!-- Page Specific Javascript -->

<jsp:invoke fragment="js"/>
</body>
</html>