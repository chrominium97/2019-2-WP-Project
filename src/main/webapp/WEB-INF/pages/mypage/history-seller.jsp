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
                    if(!$(this).val()) return;

                    const fileSize = this.files[0].size;
                    const fr = new FileReader();

                    if(fileSize > 200000){
                        alert('이미지 파일 크기는 200KB를 넘을 수 없습니다.');
                        $(this).val('');
                        return;
                    }

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
                    <article class="col-lg-12 ftco-animate">
                        <table class="table">
                            <tr>
                                <th>분류</th>
                                <th>이름</th>
                                <th>유형</th>
                                <th>가격</th>
                                <th>기한</th>
                                <th>상태</th>
                                <th>찜 현황</th>
                                <th>입찰(경매)</th>
                                <th>비고</th>
                            </tr>
                            <c:forEach items="${products}" var="product">
                                <tr>
                                    <td>${product.category.name}</td>
                                    <td>${product.name}</td>
                                    <td>${product.type.name}</td>
                                    <td>${product.finalPrice}</td>
                                    <td><fmt:formatDate value="${product.expireDate}" pattern="yyyy-MM-dd"/></td>
                                    <td>${product.status.name}</td>
                                    <td><p>${product.wishlists.size()}</p></td>
                                    <td>
                                        <c:forEach items="${product.bids}" var="bid">
                                            <p>${bid.user.name}: ${bid.price} <fmt:formatDate value="${bid.date}" pattern="yyyy-MM-dd HH:mm"/></p>
                                        </c:forEach>
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-secondary btn-modify"
                                                data-toggle="modal"
                                                data-target="#modal-product-modify" data-product-id="${product.id}">수정
                                        </button>
                                        <button type="button" class="btn btn-sm btn-danger btn-delete"
                                                data-product-id="${product.id}">삭제
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </article>

                    <!-- Selling Information -->
                    <aside class="col-lg-12 sidebar">
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
        <div id="modal-product-modify" class="modal fade" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <form id="form-modify-product" class="modal-content" action="#">
                    <div class="modal-header">
                        <h5 class="modal-title">상품 정보 편집</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="id" value=""/>
                        <div class="form-group">
                            <label>상품명</label>
                            <input type="text" id="name" name="name" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>카테고리</label>
                            <div class="form-group">
                                <c:forEach items="${categories}" var="category">
                                    <div class="custom-control custom-radio">
                                        <input type="radio" class="custom-control-input" name="category"
                                               value="${category}" id="radio-${category}" required>
                                        <label class="custom-control-label"
                                               for="radio-${category}">${category.name}</label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>거래 장소</label>
                            <input type="text" name="tradingPlace" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>거래 유형</label>
                            <input type="text" class="form-control-plaintext" readonly>
                            <small>거래 유형은 변경할 수 없습니다.</small>
                        </div>
                        <div class="form-group">
                            <label>판매 금액 (시작 금액)</label>
                            <input type="number" name="price" class="form-control">
                            <small>거래유형이 경매인 경우, 입찰이 들어왔다면 이 항목을 편집해도 현재 가격에는 변화가 없습니다.</small>
                        </div>
                        <div class="form-group">
                            <label>판매 기한</label>
                            <input type="datetime-local" name="expireDate" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>상품 설명</label>
                            <textarea name="description" class="form-control" required minlength="100"></textarea>
                        </div>
                        <div class="form-group">
                            <label>상품 이미지</label>
                            <input type="file" id="file" class="form-control-file">
                            <input type="hidden" id="file_base64" name="image">
                            <img id="preview" src="">
                        </div>
                    </div>
                    <div class="modal-footer text-right">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-primary">확인</button>
                    </div>
                </form>
            </div>
        </div>
    </jsp:body>
</t:layout>
