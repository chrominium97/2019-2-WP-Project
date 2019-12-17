<%@ page import="edu.skku.wp.model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<t:layout>
    <jsp:attribute name="js">
        <script>
            $(document).ready(() => {
                $('.btn-delete').on('click', function () {
                    if (!confirm("정말 제거하시겠습니까?"))
                        return;
                    const id = $(this).data('wishlist-id');
                    $.post('${cp}/mypage/wishlist/delete', {id}, (result) => {
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
        <header class="hero-wrap hero-wrap-2" style="background-image: url('${cp}/static/images/bg_1.jpg');"
                data-stellar-background-ratio="0.5">
            <div class="overlay"></div>
            <div class="container">
                <div class="row no-gutters slider-text align-items-end justify-content-start">
                    <div class="col-md-12 ftco-animate text-center mb-5">
                        <p class="breadcrumbs mb-0">
                            <span class="mr-3"><a href="index.jsp">홈 <i class="ion-ios-arrow-forward"></i></a></span>
                            <span>마이페이지</span></p>
                        <h1 class="mb-3 bread">찜 목록</h1>
                    </div>
                </div>
            </div>
        </header>

        <!-- Article Section -->
        <section class="ftco-section">
            <div class="container">
                <div class="row">
                    <!-- Item Description -->
                    <article class="col-lg-9 ftco-animate">
                        <table class="table">
                            <tr>
                                <th>분류</th>
                                <th>이름</th>
                                <th>판매자</th>
                                <th>유형</th>
                                <th>현재가격</th>
                                <th>판매기한</th>
                                <th>비고</th>
                            </tr>
                            <c:forEach items="${wishlists}" var="wishlist">
                                <tr>
                                    <td>${wishlist.product.category.name}</td>
                                    <td>${wishlist.product.name}</td>
                                    <td>${wishlist.product.seller.name}</td>
                                    <td>${wishlist.product.type.name}</td>
                                    <td>${wishlist.product.finalPrice}</td>
                                    <td><fmt:formatDate value="${wishlist.product.expireDate}" pattern="yyyy-MM-dd"/></td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-danger btn-delete"
                                                data-wishlist-id="${wishlist.id}">삭제
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </article>

                    <!-- Selling Information -->
                    <aside class="col-lg-3 sidebar">
                        <div class="sidebar-box ftco-animate p-4 bg-light">
                            <h3 class="heading-3">마이페이지 메뉴</h3>
                            <div class="categories">
                                <li><a href="${cp}/mypage/profile"><i class="icon-user-circle-o"></i> 프로필 관리</a></li>
                                <c:if test="${permission eq 'BUYER' or permission eq 'ADMIN'}">
                                    <li><a href="${cp}/mypage/history/buyer"><i class="icon-gift"></i> 거래 정보 관리
                                        (구매자)</a>
                                    </li>
                                </c:if>
                                <c:if test="${permission eq 'SELLER' or permission eq 'ADMIN'}">
                                    <li><a href="${cp}/mypage/history/seller"><i class="icon-gift"></i> 거래 정보 관리
                                        (판매자)</a>
                                    </li>
                                    <li><a href="${cp}/mypage/wishlist"><i class="icon-star"></i> 찜 목록 관리</a>
                                    </li>
                                </c:if>
                                <li><a href="${cp}/mypage/wishlist"><i class="icon-star"></i> 찜 목록 관리</a>
                            </div>
                        </div>
                    </aside>
                </div>
            </div>
        </section>
    </jsp:body>
</t:layout>
