<%@ page import="edu.skku.wp.model.Product" %>
<%@ page import="edu.skku.wp.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    pageContext.setAttribute("categories", Product.Category.values());
    pageContext.setAttribute("types", Product.Type.values());
%>
<t:layout>
    <jsp:attribute name="css">
        <style>
            #preview {
                max-width: 500px;
            }
        </style>
    </jsp:attribute>
    <jsp:attribute name="js">
        <script>
            $(document).ready(() => {
                $('#file').on('change', function(){
                    var fr = new FileReader();

                    fr.addEventListener('load', function(e) {
                        $('#file_base64').val(e.target.result);
                        $('#preview').attr('src', e.target.result);
                    });

                    fr.readAsDataURL(this.files[0]);
                });
            });
        </script>
        <c:if test="${message ne null}">
            <script>
               alert("${message}");
               location.href = "/mypage/history/seller";
            </script>
        </c:if>

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
                            <span>판매자 페이지</span></p>
                        <h1 class="mb-3 bread">상품 등록</h1>
                    </div>
                </div>
            </div>
        </header>

        <!-- Article Section -->
        <section class="ftco-section">
            <div class="container">
                <!-- Item Description -->
                <article class="ftco-animate">
                    <form action="${cp}/product/register" method="post">
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
                            <div class="form-group">
                                <c:forEach items="${types}" var="type">
                                    <div class="custom-control custom-radio">
                                        <input type="radio" class="custom-control-input" name="type"
                                               value="${type}" id="radio-${type}" required>
                                        <label class="custom-control-label"
                                               for="radio-${type}">${type.name}</label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>판매 금액 (시작 금액)</label>
                            <input type="number" name="price" class="form-control" step="500" min="0">
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
                        <div class="form-group text-center">
                            <button class="btn btn-lg btn-primary px-3 py-2">
                                등록
                            </button>
                        </div>
                    </form>
                </article>
            </div>
        </section>
    </jsp:body>
</t:layout>