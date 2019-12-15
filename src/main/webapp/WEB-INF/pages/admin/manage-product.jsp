<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:layout>
    <jsp:body>
        <!-- Header Section -->
        <header class="hero-wrap hero-wrap-2"
                style="background-image: url('static/images/bg_1.jpg');"
                data-stellar-background-ratio="0.5">
            <div class="overlay"></div>
            <div class="container">
                <div class="row no-gutters slider-text align-items-end justify-content-start">
                    <div class="col-md-12 ftco-animate text-center mb-5">
                        <p class="breadcrumbs mb-0">
                            <span class="mr-3"><a href="index.jsp">홈 <i class="ion-ios-arrow-forward"></i></a></span>
                            <span>관리자 페이지</span></p>
                        <h1 class="mb-3 bread">사용자 목록</h1>
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
                        <div class="row">
                            <c:forEach items="${users}" var="user">
                                <div class="col-md-12 ftco-animate">
                                    ${user.name}
                                </div>
                            </c:forEach>
                        </div>
                    </article>

                    <!-- Function List -->
                    <aside class="col-lg-4 sidebar">
                        <div class="categories">
                            <h3 class="heading-3">관리자 페이지</h3>
                            <li><a href="admin/manage-user">사용자 관리</a></li>
                            <li><a href="admin/manage-product">등록 상품 관리</a></li>
                        </div>
                    </aside>

                </div>
            </div>
        </section>
    </jsp:body>
</t:layout>