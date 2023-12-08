<%@ page import="model.BEAN.UserBEAN" %>
<%@page isELIgnored="false" %>
<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 03/12/2023
  Time: 8:10 CH
  To change this template use File | Settings | File Templates.
--%>
<%
    UserBEAN user = (UserBEAN) session.getAttribute("user"); %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Navbar Start -->
<div class="fixed-top my-5 container-fluid bg-primary">
    <div class="container">
        <nav class="navbar navbar-dark navbar-expand-lg py-0">
            <a href="./home.jsp" class="navbar-brand">
                <h1 class="text-white fw-bold d-block">Trans<span class="text-secondary">Port</span> </h1>
            </a>
            <button type="button" class="navbar-toggler me-0" data-bs-toggle="collapse"
                    data-bs-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse bg-transparent" id="navbarCollapse">
                <div class="navbar-nav ms-auto mx-xl-auto p-0">
                    <a href="#" class="nav-item nav-link">Đơn nhận</a>
                    <a href="#" class="nav-item nav-link">Đơn gửi</a>
                    <a href="#" class="nav-item nav-link">Chat</a>
                </div>
            </div>
            <div class="d-none d-xl-flex flex-shirink-0 align-items-center">
                <form class="input-group" style="width: auto;">
                    <div class="form-outline">
                        <input type="text" id="form1" class="form-control" placeholder="Tìm kiếm bài viết..." />
                    </div>
                    <button type="button" class="btn btn-primary">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
                <div class="btn-group">
                    <div id="dropdownMenuButton1" class="btn text-white d-flex align-items-center"
                         style="font-size: 16px;" data-bs-toggle="dropdown" data-bs-display="static">
                        <img src="${pageContext.request.contextPath}/image/<%=user.getAvatar()==null  || user.getAvatar().equals("") ? "29.jpg" : user.getAvatar()%>" alt="mdo" width="40" height="40" class="rounded-circle">
                        <span class="text-white mx-2"><%=user.getUsername()%></span>
                    </div>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                        <li><a class="dropdown-item" href="../Profile/Info?username=<%=user.getUsername()%>">Trang cá nhân</a></li>
                        <li><a class="dropdown-item" href="../Profile/Update">Chỉnh sửa thông tin</a></li>
                        <li><a class="dropdown-item" href="../Profile/UpdatePassword">Đổi mật khẩu</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li><a class="dropdown-item" href="../authenticate/logout">Đăng xuất</a></li>
                    </ul>
                </div>
                <!--  -->
                <!--  -->
                <div class="header__notification" onclick="clickOnBell()">
                    <i class="header__notification-icon bi bi-bell"></i>
                    <!-- <span class="header__notification-number">99+</span> -->
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                    99+
                                    <span class="visually-hidden">unread messages</span>
                                  </span>
                    <div class="header__popup">
                        <h3 class="header__popup-heading">
                            Thông báo
                        </h3>
                        <ul class="header__popup-list">
                            <a class="header__popup-item" href="">
                                <img class="header__popup-item-avatar rounded-circle" src="../assets/img/29.jpg"></img>
                                <label class="header__popup-item-content">
                                    Người dùng Chihuahua vừa đăng bài viết mới.Vào share cho mình với. Share đi mình cho 50k. Nhanh nha bạn ơi
                                </label>
                            </a>
                            <a class="header__popup-item" href="">
                                <img class="header__popup-item-avatar rounded-circle" src="../assets/img/29.jpg"></img>
                                <label class="header__popup-item-content">
                                    Người dùng Chihuahua vừa đăng bài viết mới.Vào share cho mình với. Share đi mình cho 50k. Nhanh nha bạn ơi
                                </label>
                            </a>
                            <a class="header__popup-item" href="">
                                <img class="header__popup-item-avatar rounded-circle" src="../assets/img/29.jpg"></img>
                                <label class="header__popup-item-content">
                                    Share đi mình cho 50k. Nhanh nha bạn ơi.Người dùng Chihuahua vừa đăng bài viết mới.Vào share cho mình với. Share đi mình cho 50k. Nhanh nha bạn ơi.
                                </label>
                            </a>
                            <a class="header__popup-item" href="">
                                <img class="header__popup-item-avatar rounded-circle" src="../assets/img/29.jpg"></img>
                                <label class="header__popup-item-content">
                                    Share đi mình cho 50k. Nhanh nha bạn ơi.Người dùng Chihuahua vừa đăng bài viết mới.Vào share cho mình với. Share đi mình cho 50k. Nhanh nha bạn ơi.
                                </label>
                            </a>
                            <a class="header__popup-item" href="">
                                <img class="header__popup-item-avatar rounded-circle" src="../assets/img/29.jpg"></img>
                                <label class="header__popup-item-content">
                                    Share đi mình cho 50k. Nhanh nha bạn ơi.Người dùng Chihuahua vừa đăng bài viết mới.Vào share cho mình với. Share đi mình cho 50k. Nhanh nha bạn ơi.
                                </label>
                            </a>
                            <a class="header__popup-item" href="">
                                <img class="header__popup-item-avatar rounded-circle" src="../assets/img/29.jpg"></img>
                                <label class="header__popup-item-content">
                                    Share đi mình cho 50k. Nhanh nha bạn ơi.Người dùng Chihuahua vừa đăng bài viết mới.Vào share cho mình với. Share đi mình cho 50k. Nhanh nha bạn ơi.
                                </label>
                            </a>
                            <a class="header__popup-item" href="">
                                <img class="header__popup-item-avatar rounded-circle" src="../assets/img/29.jpg"></img>
                                <label class="header__popup-item-content">
                                    Share đi mình cho 50k. Nhanh nha bạn ơi.Người dùng Chihuahua vừa đăng bài viết mới.Vào share cho mình với. Share đi mình cho 50k. Nhanh nha bạn ơi.
                                </label>
                            </a>
                            <a class="header__popup-item" href="">
                                <img class="header__popup-item-avatar rounded-circle" src="../assets/img/29.jpg"></img>
                                <label class="header__popup-item-content">
                                    Share đi mình cho 50k. Nhanh nha bạn ơi.Người dùng Chihuahua vừa đăng bài viết mới.Vào share cho mình với. Share đi mình cho 50k. Nhanh nha bạn ơi.
                                </label>
                            </a>
                            <a class="header__popup-item" href="">
                                <img class="header__popup-item-avatar rounded-circle" src="../assets/img/29.jpg"></img>
                                <label class="header__popup-item-content">
                                    Share đi mình cho 50k. Nhanh nha bạn ơi.Người dùng Chihuahua vừa đăng bài viết mới.Vào share cho mình với. Share đi mình cho 50k. Nhanh nha bạn ơi.
                                </label>
                            </a>
                        </ul>
                        <h3 class="header__popup-bottom">
                            Xem tất cả
                        </h3>
                    </div>
                </div>

            </div>
        </nav>
    </div>
</div>
<!-- Navbar End -->
