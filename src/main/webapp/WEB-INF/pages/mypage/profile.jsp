<%@ page import="edu.skku.wp.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    pageContext.setAttribute("types", User.Type.values());
%>
<t:layout>
    <jsp:attribute name="js">
        <script>
            $(document).ready(function () {
                $('#form-modify-user').on('submit', function (e) {
                    e.preventDefault();
                    $.post('${cp}/mypage/profile/edit', $(this).serialize(), (result) => {
                        if (result.success) {
                            alert(result.message);
                            location.reload();
                        } else {
                            alert(result.message);
                        }
                    });
                });
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <!-- Header Section -->
        <header class="hero-wrap hero-wrap-2"
                style="background-image: url('${cp}/static/images/bg_1.jpg');"
                data-stellar-background-ratio="0.5">
            <div class="overlay"></div>
            <div class="container">
                <div class="row no-gutters slider-text align-items-end justify-content-start">
                    <div class="col-md-12 ftco-animate text-center mb-5">
                        <p class="breadcrumbs mb-0">
                            <span class="mr-3"><a href="${cp}/index">홈 <i class="ion-ios-arrow-forward"></i></a></span>
                            <span>마이페이지</span></p>
                        <h1 class="mb-3 bread">프로필 관리</h1>
                    </div>
                </div>
            </div>
        </header>

        <!-- Article Section -->
        <section class="ftco-section">
            <div class="container">
                <div class="row">
                    <!-- User List -->
                    <article class="col-lg-8 pr-lg-4">
                        <form id="form-modify-user" action="#" method="post">
                            <div class="form-group form-control-inline">
                                <label>유저 ID</label>
                                <input type="text" name="id" class="form-control-plaintext" value="${user.id}" readonly>
                                <small>아이디는 변경할 수 없습니다.</small>
                            </div>
                            <div class="form-group">
                                <label>패스워드</label>
                                <input type="password" name="password" class="form-control" value="" placeholder="변경 안 함">
                                <small>변경 시 자동으로 암호화되어 저장됩니다.</small>
                            </div>
                            <div class="form-group">
                                <label>이름</label>
                                <input type="text" name="name" class="form-control" value="${user.name}">
                            </div>
                            <div class="form-group">
                                <label>전화번호</label>
                                <input type="text" name="phoneNumber" class="form-control" value="${user.phoneNumber}">
                            </div>
                            <div class="form-group">
                                <label>유저타입</label>
                                <input type="hidden" value="${user.type}">
                                <input type="text" class="form-control-plaintext" value="${user.type.name}">
                                <small>유저타입은 변경할 수 없습니다.</small>
                            </div>
                            <button type="submit" class="btn btn-primary px-3 py-2">수정</button>
                        </form>
                    </article>

                    <!-- Function List -->
                    <aside class="col-lg-4 sidebar">
                        <div class="sidebar-box ftco-animate p-4 bg-light">
                            <h3 class="heading-3">마이페이지 메뉴</h3>
                            <div class="categories">
                                <li><a href="${cp}/mypage/profile"><i class="icon-user-circle-o"></i> 프로필 관리</a></li>
                                <c:if test="${permission eq 'BUYER' or permission eq 'ADMIN'}">
                                    <li><a href="${cp}/mypage/history/buyer"><i class="icon-gift"></i> 거래 정보 관리
                                        (구매자)</a>
                                    </li>
                                    <li><a href="${cp}/mypage/wishlist"><i class="icon-star"></i> 찜 목록 관리</a>
                                    </li>
                                </c:if>
                                <c:if test="${permission eq 'SELLER' or permission eq 'ADMIN'}">
                                    <li><a href="${cp}/mypage/history/seller"><i class="icon-gift"></i> 거래 정보 관리
                                        (판매자)</a>
                                    </li>
                                </c:if>
                            </div>
                        </div>
                    </aside>
                </div>
            </div>
        </section>
    </jsp:body>
</t:layout>