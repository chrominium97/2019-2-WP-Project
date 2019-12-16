<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<t:layout>
    <jsp:attribute name="js">
        <script>
            const expireDate = new Date('<fmt:formatDate value="${product.expireDate}" pattern="YYYY-MM-dd HH:mm:ss"/>').getTime(); // 종료날짜

            $(document).ready(() => {
                setInterval(setRemainTime, 1000);

                $('#form-bid').submit(e => {
                    e.preventDefault();

                    $.post('${cp}/product/bid', {productId: '${product.id}', price: $('#price-bid').val()}, result => {
                        if (result.success) {
                            alert("입찰에 성공했습니다.");
                            location.reload();
                        } else {
                            alert('입찰에 실패했습니다. ' + result.message);
                        }
                    });
                });
            });

            function buy() {
                $.post('${cp}/product/buy', {productId: '${product.id}'}, result => {
                    if (result.success) {
                        alert(result.message);
                        location.reload();
                    } else
                        alert(result.message);
                });
            }

            function wishlist() {
                $.post('${cp}/product/wishlist', {productId: '${product.id}'}, result => {
                    if (result.success) {
                        alert(result.message);
                        location.reload();
                    } else
                        alert(result.message);
                });
            }

            function setRemainTime() {
                const remainDate = expireDate - new Date().getTime();

                const days = Math.floor(remainDate / (1000 * 60 * 60 * 24));
                const hours = Math.floor((remainDate % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                const miniutes = Math.floor((remainDate % (1000 * 60 * 60)) / (1000 * 60));
                const seconds = Math.floor((remainDate % (1000 * 60)) / 1000);

                const t = days + "일 " + hours + "시간 " + miniutes + "분 " + seconds + "초";
                $('#remain-time').text(t);
            }
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
                            <span>구매자 페이지</span></p>
                        <h1 class="mb-3 bread">물품 상세</h1>
                    </div>
                </div>
            </div>
        </header>

        <!-- Article Section -->
        <section class="ftco-section">
            <div class="container">
                <div class="row">
                    <!-- Item Description -->
                    <article class="col-lg-8 ftco-animate">
                        <header>
                            <small>상품명</small>
                            <h2 class="mb-3">${product.name}</h2>
                        </header>
                        <section class="d-flex">
                            <div class="mr-4">
                                <small>카테고리</small>
                                <p>${product.category.name}</p>
                            </div>
                            <div class="mr-4">
                                <small>등록일</small>
                                <p><fmt:formatDate value="${product.registerDate}" pattern="YYYY-MM-dd"/></p>
                            </div>
                            <div>
                                <small>거래 장소</small>
                                <p>${product.tradingPlace}</p>
                            </div>
                        </section>
                        <section>
                            <small>상품 설명</small>
                            <p>${product.description}</p>
                        </section>
                        <section>
                            <small>상품 이미지</small>
                            <div>
                                <c:choose>
                                    <c:when test="${product.image != null}">
                                        <img src="${product.image}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${cp}/static/images/product.png" class="p-3"/>
                                    </c:otherwise>
                                </c:choose>`
                            </div>
                        </section>
                    </article>

                    <!-- Selling Information -->
                    <aside class="col-lg-4 sidebar">
                        <c:choose>
                            <c:when test="${product.status == 'SOLD'}">
                                <div class="sidebar-box ftco-animate p-4 bg-light">
                                    <h3>판매완료</h3>
                                    <p>이 상품은 판매되었습니다.</p>
                                    <div>
                                        <small>낙찰 가격</small>
                                        <h1 class="text-right"><fmt:formatNumber type="number" pattern="#,##0"
                                                                                 value="${product.finalPrice}"/>원</h1>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <form class="sidebar-box ftco-animate p-4 bg-light" action="#">
                                    <h3 class="heading-3">${product.type.name} 거래</h3>
                                    <c:choose>
                                        <c:when test="${product.type eq 'AUCTION'}">
                                            <p>정해진 기간 내에 가장 높은 가격으로 입찰한 사람에게 판매됩니다.</p>
                                            <div class="mb-4">
                                                <small>남은 시간</small>
                                                <h3 id="remain-time" class="text-right"></h3>
                                            </div>
                                            <div class="mb-4">
                                                <small>현재 가격</small>
                                                <h1 class="text-right"><fmt:formatNumber type="number" pattern="#,##0"
                                                                                         value="${product.finalPrice}"/>원</h1>
                                            </div>
                                            <div class="categories mb-4">
                                                <small>입찰 목록 (최신순)</small>
                                                <c:forEach items="${bids}" var="bid">
                                                    <li class="d-flex justify-content-between">
                                                        <div>${bid.user.name}</div>
                                                        <div><fmt:formatNumber type="number" pattern="#,##0"
                                                                               value="${bid.price}"/>원
                                                        </div>
                                                    </li>
                                                </c:forEach>
                                            </div>
                                            <div class="text-right">
                                                <button type="button" class="btn btn-secondary" onclick="wishlist()">
                                                    <span class="icon-star"></span> 찜하기
                                                </button>
                                                <button type="button" class="btn btn-primary" data-toggle="modal"
                                                        data-target="#modal-bid">
                                                    입찰
                                                </button>
                                            </div>
                                        </c:when>
                                        <c:when test="${product.type eq 'FIXED'}">
                                            <p>판매자가 정한 가격으로 거래합니다.</p>
                                            <div class="mb-4">
                                                <small>판매 기한</small>
                                                <h3 class="text-right"><fmt:formatDate value="${product.expireDate}"
                                                                                       pattern="yyyy-MM-dd HH:mm"/></h3>
                                            </div>
                                            <div class="mb-4">
                                                <small>가격</small>
                                                <h1 class="text-right"><fmt:formatNumber type="number" pattern="#,##0"
                                                                                         value="${product.finalPrice}"/>원</h1>
                                            </div>
                                            <div class="text-right">
                                                <button type="button" class="btn btn-secondary" onclick="wishlist()">
                                                    <span class="icon-star"></span> 찜하기
                                                </button>
                                                <button type="button" class="btn btn-primary" onclick="buy()">구매
                                                </button>
                                            </div>
                                        </c:when>
                                        <c:when test="${product.type eq 'OFFER'}">
                                            <p>판매자에게 직접 연락을 하여 가격을 정합니다..</p>
                                            <div class="mb-4">
                                                <small>판매 기한</small>
                                                <h3 class="text-right"><fmt:formatDate value="${product.expireDate}"
                                                                                       pattern="yyyy-MM-dd HH:mm"/></h3>
                                            </div>
                                            <div class="mb-4">
                                                <small>희망 가격</small>
                                                <h1 class="text-right"><fmt:formatNumber type="number" pattern="#,##0"
                                                                                         value="${product.finalPrice}"/>원</h1>
                                            </div>
                                            <div class="text-right">
                                                <button type="button" class="btn btn-secondary" onclick="wishlist()">
                                                    <span class="icon-star"></span> 찜하기
                                                </button>
                                            </div>
                                        </c:when>
                                    </c:choose>
                                </form>

                            </c:otherwise>
                        </c:choose>
                        <div class="sidebar-box ftco-animate p-4">
                            <h3 class="heading-3">판매자 정보</h3>
                            <div>
                                <small>이름</small>
                                <p>${product.seller.name}</p>
                            </div>
                            <div>
                                <small>연락처</small>
                                <p>${product.seller.phoneNumber}</p>
                            </div>
                        </div>
                    </aside>
                </div>
            </div>
        </section>
        <c:if test="${product.type eq 'AUCTION'}">
            <div id="modal-bid" class="modal fade" tabindex="-1" role="dialog">
                <div class="modal-dialog modal-dialog-centered modal-sm" role="document">
                    <form id="form-bid" class="modal-content" action="#">
                        <div class="modal-header">
                            <h5 class="modal-title">입찰하기</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>얼마에 입찰하시겠습니까?</p>
                            <input id="price-bid" type="number" class="form-control" value="${product.finalPrice + 500}"
                                   step="500" min="${product.finalPrice + 500}"/>
                        </div>
                        <div class="modal-footer text-right">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                            <button type="submit" class="btn btn-primary">확인</button>
                        </div>
                    </form>
                </div>
            </div>
        </c:if>
    </jsp:body>
</t:layout>