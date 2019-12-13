<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:layout>
    <jsp:body>
        <div class="hero-wrap img" style="background-image: url(static/images/bg_1.jpg);">
            <div class="overlay"></div>
            <div class="container">
                <div class="row d-md-flex no-gutters slider-text align-items-center justify-content-center">
                    <div class="col-md-10 d-flex align-items-center ftco-animate">
                        <div class="text text-center pt-5 mt-md-5">
                            <p class="mb-4">Find Job, Employment, and Career Opportunities</p>
                            <h1 class="mb-5">The Eassiest Way to Get Your New Job</h1>
                            <div class="ftco-counter ftco-no-pt ftco-no-pb">
                                <div class="row">
                                    <div class="col-md-4 d-flex justify-content-center counter-wrap ftco-animate">
                                        <div class="block-18">
                                            <div class="text d-flex">
                                                <div class="icon mr-2">
                                                    <span class="flaticon-worldwide"></span>
                                                </div>
                                                <div class="desc text-left">
                                                    <strong class="number" data-number="46">0</strong>
                                                    <span>Countries</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4 d-flex justify-content-center counter-wrap ftco-animate">
                                        <div class="block-18 text-center">
                                            <div class="text d-flex">
                                                <div class="icon mr-2">
                                                    <span class="flaticon-visitor"></span>
                                                </div>
                                                <div class="desc text-left">
                                                    <strong class="number" data-number="450">0</strong>
                                                    <span>Companies</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4 d-flex justify-content-center counter-wrap ftco-animate">
                                        <div class="block-18 text-center">
                                            <div class="text d-flex">
                                                <div class="icon mr-2">
                                                    <span class="flaticon-resume"></span>
                                                </div>
                                                <div class="desc text-left">
                                                    <strong class="number" data-number="80000">0</strong>
                                                    <span>Active Employees</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="ftco-search my-md-5">
                                <div class="row">
                                    <div class="col-md-12 nav-link-wrap">
                                        <div class="nav nav-pills text-center" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                                            <a class="nav-link active mr-md-1" id="v-pills-1-tab" data-toggle="pill" href="#v-pills-1" role="tab" aria-controls="v-pills-1" aria-selected="true">Find a Job</a>

                                            <a class="nav-link" id="v-pills-2-tab" data-toggle="pill" href="#v-pills-2" role="tab" aria-controls="v-pills-2" aria-selected="false">Find a Candidate</a>

                                        </div>
                                    </div>
                                    <div class="col-md-12 tab-wrap">

                                        <div class="tab-content p-4" id="v-pills-tabContent">

                                            <div class="tab-pane fade show active" id="v-pills-1" role="tabpanel" aria-labelledby="v-pills-nextgen-tab">
                                                <form action="#" class="search-job">
                                                    <div class="row no-gutters">
                                                        <div class="col-md mr-md-2">
                                                            <div class="form-group">
                                                                <div class="form-field">
                                                                    <div class="icon"><span class="icon-briefcase"></span></div>
                                                                    <input type="text" class="form-control" placeholder="eg. Garphic. Web Developer">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md mr-md-2">
                                                            <div class="form-group">
                                                                <div class="form-field">
                                                                    <div class="select-wrap">
                                                                        <div class="icon"><span class="ion-ios-arrow-down"></span></div>
                                                                        <select name="" id="" class="form-control">
                                                                            <option value="">Category</option>
                                                                            <option value="">Full Time</option>
                                                                            <option value="">Part Time</option>
                                                                            <option value="">Freelance</option>
                                                                            <option value="">Internship</option>
                                                                            <option value="">Temporary</option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md mr-md-2">
                                                            <div class="form-group">
                                                                <div class="form-field">
                                                                    <div class="icon"><span class="icon-map-marker"></span></div>
                                                                    <input type="text" class="form-control" placeholder="Location">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md">
                                                            <div class="form-group">
                                                                <div class="form-field">
                                                                    <button type="submit" class="form-control btn btn-primary">Search</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>

                                            <div class="tab-pane fade" id="v-pills-2" role="tabpanel" aria-labelledby="v-pills-performance-tab">
                                                <form action="#" class="search-job">
                                                    <div class="row">
                                                        <div class="col-md">
                                                            <div class="form-group">
                                                                <div class="form-field">
                                                                    <div class="icon"><span class="icon-user"></span></div>
                                                                    <input type="text" class="form-control" placeholder="eg. Adam Scott">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md">
                                                            <div class="form-group">
                                                                <div class="form-field">
                                                                    <div class="select-wrap">
                                                                        <div class="icon"><span class="ion-ios-arrow-down"></span></div>
                                                                        <select name="" id="" class="form-control">
                                                                            <option value="">Category</option>
                                                                            <option value="">Full Time</option>
                                                                            <option value="">Part Time</option>
                                                                            <option value="">Freelance</option>
                                                                            <option value="">Internship</option>
                                                                            <option value="">Temporary</option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md">
                                                            <div class="form-group">
                                                                <div class="form-field">
                                                                    <div class="icon"><span class="icon-map-marker"></span></div>
                                                                    <input type="text" class="form-control" placeholder="Location">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md">
                                                            <div class="form-group">
                                                                <div class="form-field">
                                                                    <button type="submit" class="form-control btn btn-primary">Search</button>
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
