<%@ page import="edu.skku.wp.model.Product" %>
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
            $(document).ready(() => {
                $('.btn-modify').on('click', function () {
                    const id = $(this).data('user-id');
                    $.get('${cp}/admin/manage-user/get', {id}, (result) => {
                        $.each(result,function(key,value) {
                            $('#form-modify-user').find("input[name='"+key+"']").val(value);
                        });
                    });
                });

                $('#form-modify-user').on('submit', function(e) {
                    e.preventDefault();
                    $.post('${cp}/admin/manage-user/edit', $(this).serialize(), (result) => {
                        if(result.success) {
                            alert(result.message);
                            location.reload();
                        } else {
                            alert(result.message);
                        }
                    });
                });

                $('.btn-delete').on('click', function () {
                    if(!confirm("정말 제거하시겠습니까?"))
                        return;
                    const id = $(this).data('user-id');
                    $.post('${cp}/admin/manage-user/delete', {id}, (result) => {
                        if(result.success) {
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
                            <span class="mr-3"><a href="index.jsp">홈 <i class="ion-ios-arrow-forward"></i></a></span>
                            <span>관리자 페이지</span></p>
                        <h1 class="mb-3 bread">사용자 관리</h1>
                    </div>
                </div>
            </div>
        </header>

        <!-- Article Section -->
        <section class="ftco-section">
            <div class="container">
                <div class="row">
                    <!-- User List -->
                    <article class="col-lg-9 pr-lg-4">
                        <table class="table">
                            <tr>
                                <th>아이디</th>
                                <th>패스워드<small>(암호화)</small></th>
                                <th>이름</th>
                                <th>전화번호</th>
                                <th>유저타입</th>
                                <th>비고</th>
                            </tr>
                            <c:forEach items="${users}" var="user">
                                <tr>
                                    <td>${user.id}</td>
                                    <td>${user.password}</td>
                                    <td>${user.name}</td>
                                    <td>${user.phoneNumber}</td>
                                    <td>${user.type.name}</td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-secondary btn-modify"
                                                data-toggle="modal"
                                                data-target="#modal-user-modify" data-user-id="${user.id}">수정
                                        </button>
                                        <button type="button" class="btn btn-sm btn-danger btn-delete" data-user-id="${user.id}">삭제</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </article>

                    <!-- Function List -->
                    <aside class="col-lg-3 sidebar">
                        <div class="sidebar-box ftco-animate p-4 bg-light">
                            <h3 class="heading-3">관리자 메뉴</h3>
                            <div class="categories">
                                <li active><a href="${cp}/admin/manage-user"><i class="icon-users"></i> 사용자 관리</a></li>
                                <li><a href="${cp}/admin/manage-product"><i class="icon-gift"></i> 등록 상품 관리</a></li>
                            </div>
                        </div>
                    </aside>
                </div>
            </div>
        </section>
        <div id="modal-user-modify" class="modal fade" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <form id="form-modify-user" class="modal-content" action="#">
                    <div class="modal-header">
                        <h5 class="modal-title">사용자 정보 편집</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>유저 ID</label>
                            <input type="text" name="id" class="form-control" value="" readonly>
                            <small>아이디는 변경할 수 없습니다.</small>
                        </div>
                        <div class="form-group">
                            <label>패스워드</label>
                            <input type="text" name="password" class="form-control" value="">
                            <small>변경 시 자동으로 암호화되어 저장됩니다.</small>
                        </div>
                        <div class="form-group">
                            <label>이름</label>
                            <input type="text" name="name" class="form-control" value="">
                        </div>
                        <div class="form-group">
                            <label>전화번호</label>
                            <input type="text" name="phoneNumber" class="form-control" value="">
                        </div>
                        <div class="form-group">
                            <label>유저타입</label>
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
                    <div class="modal-footer text-right">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-primary">확인</button>
                    </div>
                </form>
            </div>
        </div>
    </jsp:body>
</t:layout>