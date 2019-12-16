<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:layout>
    <jsp:body>
        <div class="hero-wrap img vh-100" style="background-image: url(${cp}/static/images/bg_1.jpg);">
            <div class="overlay"></div>
            <div class="container">
                <div class="row d-md-flex no-gutters slider-text align-items-center justify-content-center">
                    <div class="col-md-10 align-items-center ftco-animate">
                        <div class="text text-center pt-5 mt-md-5">
                            <p class="mb-4">세상에 필요 없는 물건은 없습니다.</p>
                            <h1 class="mb-5">SKKU Flea Market</h1>
                            <div class="ftco-search my-md-5">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="tab-content p-4">
                                            <div class="tab-pane fade show active">
                                                <form action="${cp}/product/list" class="search-job m-0">
                                                    <input type="hidden" name="keywordType" value="productName"/>
                                                    <div class="row no-gutters">
                                                        <div class="col-md-10 mr-md-2">
                                                            <div class="form-group">
                                                                <div class="form-field">
                                                                    <div class="icon"><span
                                                                            class="icon-tag"></span></div>
                                                                    <input type="text" name="keyword"
                                                                           class="form-control"
                                                                           placeholder="검색어를 입력하세요">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md">
                                                            <div class="form-group">
                                                                <div class="form-field">
                                                                    <button type="submit"
                                                                            class="form-control btn btn-primary">검색
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:layout>
