<%@ page import="edu.skku.wp.model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    pageContext.setAttribute("categories", Product.Category.values());

    String[] paramCategories = request.getParameterValues("category");
    if (paramCategories != null)
        pageContext.setAttribute("paramCategories", String.join(",", request.getParameterValues("category")));
%>
<t:layout>
    <jsp:attribute name="css">
        <style>
            .product-thumbnail {
                width: 8rem;
            }

            .product-thumbnail img {
                max-width: 8rem;
            }

            .product-desc-price {
                color: #206dfb;
                font-weight: bold;
                font-size: 1.2rem;
            }

            .search-form .form-group input {
                padding-right: 0;
            }

            .search-form .form-group select {
                font-size: 14px;
                height: 48px !important;
            }

            .btn-wishlist > button {
                width: 40px;
                height: 40px;
                border-radius: 50%;
            }

        </style>
    </jsp:attribute>
    <jsp:attribute name="js">
        <script>
            function wishlist(productId) {
                $.post('${cp}/product/wishlist', {productId}, result => {
                    if (result.success) {
                        alert(result.message);
                        location.reload();
                    } else
                        alert(result.message);
                });
            }
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
                            <span class="mr-3"><a href="index">홈 <i class="ion-ios-arrow-forward"></i></a></span>
                            <span>구매자 페이지</span></p>
                        <h1 class="mb-3 bread">상품 목록</h1>
                    </div>
                </div>
            </div>
        </header>

        <!-- Article Section -->
        <section class="ftco-section">
            <div class="container">
                <div class="row">
                    <!-- Product List -->
                    <article class="col-lg-8 pr-lg-4">
                        <div class="row">
                            <c:if test="${fn:length(products) eq 0}">
                                <div class="col-md-12 p-4">
                                    <h3 class="heading-3">검색 결과가 없습니다.</h3>
                                </div>
                            </c:if>
                            <!-- List Start -->
                            <c:forEach items="${products}" var="product">
                                <div class="col-md-12 ftco-animate">
                                    <div class="job-post-item p-4 d-block d-lg-flex align-items-center">
                                        <!-- Product Information -->
                                        <div class="product-thumbnail mr-4">
                                            <c:choose>
                                                <c:when test="${fn:length(product.image) > 0}">
                                                    <img src="${product.image}"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${cp}/static/images/product.png" class="p-3"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="mb-4 mb-md-0">
                                            <div class="job-post-item-header align-items-center">
                                                <span class="product-desc-price">
                                                    <fmt:formatNumber type="number" pattern="#,##0"
                                                                      value="${product.finalPrice}"/>원
                                                </span>
                                                <h2 class="mr-3 text-black"><a
                                                        href="${cp}/product/detail?id=${product.id}">${product.name}</a>
                                                </h2>
                                            </div>
                                            <div class="job-post-item-body d-block d-md-flex">
                                                <div class="mr-3">
                                                    <span class="icon-tag"></span>
                                                    <a href="#">${product.category.name}</a>
                                                </div>
                                                <div class="mr-3">
                                                    <span class="icon-user"></span>
                                                    <a href="#">${product.seller.name}</a>
                                                </div>
                                                <div>
                                                    <span class="icon-location_city"></span>
                                                    <span>${product.tradingPlace}</span>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Add to Wishlist -->
                                        <div class="ml-auto d-flex align-items-center md-md-0">
                                            <div class="btn-wishlist">
                                                <button class="icon text-center d-flex justify-content-center align-items-center icon mr-2"
                                                        onclick="wishlist('${product.id}')">
                                                    <span class="icon-star"></span>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <!-- List End -->
                        </div>
                    </article>

                    <!-- Search Parameters -->
                    <aside class="col-lg-4 sidebar">
                        <form class="sidebar-box ftco-animate search-form p-4 clearfix" action="#" method="get">
                            <h3 class="heading-3">검색 옵션</h3>

                            <!-- Search Item Name -->
                            <div class="form-group">
                                <label>상품 이름</label>
                                <input type="text" class="form-control" name="productName" placeholder="키워드 입력..."
                                       value="${param.productName}">
                            </div>

                            <!-- Search Keyword -->
                            <div class="form-group">
                                <label>기타 검색어</label>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <select class="form-control" name="keywordType">
                                            <option value="sellerName"
                                                    <c:if test="${param.keywordType eq 'sellerName'}">selected</c:if>>
                                                판매자이름
                                            </option>
                                            <option value="tradingPlace"
                                                    <c:if test="${param.keywordType eq 'tradingPlace'}">selected</c:if>>
                                                거래장소
                                            </option>
                                        </select>
                                    </div>
                                    <input type="text" name="keyword" class="form-control" placeholder="키워드 입력..."
                                           value="${param.keyword}">
                                </div>
                            </div>

                            <!-- Price Range -->
                            <div class="form-group">
                                <label>희망 가격<small>(원)</small></label>
                                <div class="input-group mb-3">
                                    <input type="number" class="form-control" step="500" min="0" name="minPrice"
                                           value="${param.minPrice}"/>
                                    <div class="input-group-prepend input-group-append">
                                        <span class="input-group-text">~</span>
                                    </div>
                                    <input type="number" class="form-control" step="500" name="maxPrice"
                                           value="${param.maxPrice}"/>
                                </div>
                            </div>

                            <!-- Category List -->
                            <div class="form-group">
                                <label>카테고리</label>
                                <c:forEach items="${categories}" var="category">
                                    <div class="custom-control custom-checkbox">
                                        <input type="checkbox" class="custom-control-input" name="category"
                                               value="${category}" id="check-${category}"
                                               <c:if test="${fn:contains(paramCategories, category)}">checked</c:if>>
                                        <label class="custom-control-label"
                                               for="check-${category}">${category.name}</label>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Etc Filter -->
                            <div class="form-group">
                                <label>기타</label>
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" name="excludeExpired"
                                           id="exclude-expired"
                                           <c:if test="${param.excludeExpired != null}">checked</c:if>>
                                    <label class="custom-control-label" for="exclude-expired">기한 종료 상품 제외</label>
                                </div>
                            </div>

                            <div class="text-right">
                                <button class="btn btn-primary" type="submit">
                                    <span class="icon-search"></span> 검색
                                </button>
                            </div>
                        </form>
                    </aside>

                </div>
            </div>
        </section>
    </jsp:body>
</t:layout>