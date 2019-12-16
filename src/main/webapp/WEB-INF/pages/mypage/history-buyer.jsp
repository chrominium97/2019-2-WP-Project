<%@ page import="edu.skku.wp.model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    pageContext.setAttribute("categories", Product.Category.values());
%>
<t:layout>
    <jsp:attribute name="js">
        <script>
            $(document).ready(() => {
                $('.btn-modify').on('click', function () {
                    const id = $(this).data('product-id');
                    $.get('${cp}/mypage/history/seller/get', {id}, (result) => {
                        $.each(result, function (key, value) {
                            $('#form-modify-product').find("[name='" + key + "']:not([type='radio'])").val(value);
                        });

                        $.each($('#form-modify-product [type="radio"]'), function(key, el) {
                            if(result.category == el.value) $(el).attr('checked', true);
                        });
                    });
                });

                $('#file').on('change', function(){
                    var fr = new FileReader();

                    fr.addEventListener('load', function(e) {
                        $('#file_base64').val(e.target.result);
                        $('#preview').attr('src', e.target.result);
                    });

                    fr.readAsDataURL(this.files[0]);
                });

                $('#form-modify-product').on('submit', function (e) {
                    e.preventDefault();
                    $.post('${cp}/mypage/history/seller/edit', $(this).serialize(), (result) => {
                        if (result.success) {
                            alert(result.message);
                            location.reload();
                        } else {
                            alert(result.message);
                        }
                    });
                });

                $('.btn-delete').on('click', function () {
                    if (!confirm("정말 제거하시겠습니까?"))
                        return;
                    const id = $(this).data('product-id');
                    $.post('${cp}/mypage/history/seller/delete', {id}, (result) => {
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
                        <h1 class="mb-3 bread">상품 거래 히스토리</h1>
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
                        <h3>구매 완료</h3>
                        <table class="table">
                            <tr>
                                <th>분류</th>
                                <th>이름</th>
                                <th>판매자</th>
                                <th>유형</th>
                                <th>기한</th>
                                <th>가격</th>
                            </tr>
                            <c:forEach items="${products}" var="product">
                                <tr>
                                    <td>${product.category.name}</td>
                                    <td>${product.name}</td>
                                    <td>${product.seller.name}</td>
                                    <td>${product.type.name}</td>
                                    <td><fmt:formatDate value="${product.expireDate}" pattern="yyyy-MM-dd"/></td>
                                    <td>${product.finalPrice}</td>
                                </tr>
                            </c:forEach>
                            <tr>
                                <th colspan="5">가격 합계</th>
                                <th>${totalPrice}</th>
                            </tr>
                        </table>
                        <h3>경매 진행 중</h3>
                        <table class="table">
                            <tr>
                                <th>분류</th>
                                <th>이름</th>
                                <th>판매자</th>
                                <th>기한</th>
                                <th>입찰가</th>
                            </tr>
                            <c:forEach items="${bids}" var="bid">
                                <tr>
                                    <td>${bid.product.category.name}</td>
                                    <td>${bid.product.name}</td>
                                    <td>${bid.product.seller.name}</td>
                                    <td><fmt:formatDate value="${bid.product.expireDate}" pattern="yyyy-MM-dd"/></td>
                                    <td>${bid.price}</td>
                                </tr>
                            </c:forEach>
                            <tr>
                                <th colspan="4">가격 합계</th>
                                <th>${pendingPrice}</th>
                            </tr>
                        </table>
                        <p class="text-right">전체 합계 (진행중 경매 포함): ${totalPrice} (${totalPrice + pendingPrice})</p>
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
