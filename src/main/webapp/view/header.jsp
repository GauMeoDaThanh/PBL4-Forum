<%@ page import="model.BEAN.UserBEAN" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.BEAN.NotifyBEAN" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page isELIgnored="false" %>
<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 03/12/2023
  Time: 8:10 CH
  To change this template use File | Settings | File Templates.
--%>
<%
    UserBEAN user = (UserBEAN) session.getAttribute("user");
    ArrayList<NotifyBEAN> list = (ArrayList<NotifyBEAN>) request.getAttribute("listNotify");
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Topbar Start -->
<div class="fixed-top bg-dark py-2 d-none d-md-flex">
    <div class="container">
        <div class="d-flex justify-content-between topbar">
            <div class="top-info">
                <small class="me-3 text-white-50"><a href="#"><i class="fas fa-map-marker-alt me-2 text-secondary"></i></a>ĐHBK Đà Nẵng</small>
                <small class="me-3 text-white-50"><a href="#"><i class="fas fa-envelope me-2 text-secondary"></i></a>PBL4@gmail.com</small>
            </div>
            <div id="note" class="text-secondary d-none d-xl-flex"><small>Đến với chúng tôi, mọi thứ rất dễ dàng</small></div>
            <div class="top-link">
                <a href="" class="bg-light nav-fill btn btn-sm-square rounded-circle"><i class="fab fa-facebook-f text-primary"></i></a>
                <a href="" class="bg-light nav-fill btn btn-sm-square rounded-circle"><i class="fab fa-twitter text-primary"></i></a>
                <a href="" class="bg-light nav-fill btn btn-sm-square rounded-circle"><i class="fab fa-instagram text-primary"></i></a>
                <a href="" class="bg-light nav-fill btn btn-sm-square rounded-circle me-0"><i class="fab fa-linkedin-in text-primary"></i></a>
            </div>
        </div>
    </div>
</div>
<!-- Topbar End -->
<!-- Navbar Start -->
<div class="fixed-top my-5 bg-primary">
    <div class="container">
        <nav class="navbar navbar-dark navbar-expand-lg py-0">
            <a href="${pageContext.request.contextPath}/Home/" class="navbar-brand">
                <h1 class="text-white fw-bold d-block">Trans<span class="text-secondary">Port</span> </h1>
            </a>
            <button type="button" class="navbar-toggler me-0" data-bs-toggle="collapse"
                    data-bs-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse bg-transparent" id="navbarCollapse">
                <div class="navbar-nav ms-auto mx-xl-auto p-0">
                    <a href="${pageContext.request.contextPath}/Deli/Receive" class="nav-item nav-link">Đơn nhận</a>
                    <a href="${pageContext.request.contextPath}/Deli/Send" class="nav-item nav-link">Đơn gửi</a>
                    <a href="${pageContext.request.contextPath}/Chat/View" class="nav-item nav-link">Chat</a>
                </div>
            </div>
            <div class="d-flex align-items-center">
                <form action="${pageContext.request.contextPath}/Topic/Search" method="get" class="input-group" style="width: auto;">
                    <div class="form-outline">
                        <input name="txtSearch" type="text" id="form1" class="form-control" placeholder="Tìm kiếm topic" required/>
                        <input name="pageIndex" value="1" type="hidden">
                    </div>
                    <button type="submit" class="btn btn-primary">
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
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"><%=list.size()%>
                                    <span class="visually-hidden">unread messages</span>
                                  </span>
                    <div class="header__popup">
                        <h3 class="header__popup-heading">
                            Thông báo
                        </h3>
                        <ul class="header__popup-list">
                            <%
                                DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                                for(NotifyBEAN notify : list){
                            %>
                            <div class="row">
                                <div class="col-12">
                                    <div class="card mb-2" >
                                        <div class="card-body">
                                            <div class="d-flex">
                                                <a href=""><img src="${pageContext.request.contextPath}/image/<%=notify.getAvatar()==null  || notify.getAvatar().equals("") ? "29.jpg" : notify.getAvatar()%>" class="mr-3 rounded-circle" width="70" height="70" alt="User" /></a>
                                                <div class="media-body mx-2">
                                                    <%
                                                        if(notify.getNotify_type_id()==1){
                                                    %>
                                                    <span class="text-white rounded p-1 my-2 bg-danger"  style="font-size: 1rem;">Báo cáo trang cá nhân</span>
                                                    <h4 class="header__popup-item-content mt-1">
                                                        <a href="${pageContext.request.contextPath}/Profile/Info?username=<%=notify.getTo_user()%>" class="text-body" style="font-size: 18px;"><strong><%=notify.getContext()%></strong></a>
                                                    </h4>
                                                    <p class="text-muted">
                                                        <a href="${pageContext.request.contextPath}/Profile/Info?username=<%=notify.getFrom_user()%>" class="text-primary" style="font-size: 1rem;"><%=notify.getFrom_user()%></a>
                                                        báo cáo
                                                        <a href="${pageContext.request.contextPath}/Profile/Info?username=<%=notify.getTo_user()%>"><%=notify.getTo_user()%></a>
                                                        at
                                                        <span class="text-dark font-weight-bold"><%=dateFormat.format(notify.getCreate_time())%></span>
                                                    </p>
                                                    <%
                                                        }
                                                        else if(notify.getNotify_type_id()==2){
                                                    %>
                                                    <span class="text-white rounded p-1 my-2 bg-warning"  style="font-size: 1rem;">Báo cáo Topic</span>
                                                    <h4 class="header__popup-item-content mt-1">
                                                        <a href="${pageContext.request.contextPath}/Topic/Info?topicID=<%=notify.getTo_topic_id()%>&pageIndex=1" class="text-body" style="font-size: 18px;"><strong><%=notify.getContext()%></strong></a>
                                                    </h4>
                                                    <p class="text-muted">
                                                        <a href="${pageContext.request.contextPath}/Profile/Info?username=<%=notify.getFrom_user()%>" class="text-primary" style="font-size: 1rem;"><%=notify.getFrom_user()%></a>
                                                        báo cáo Topic của
                                                        <a href="${pageContext.request.contextPath}/Profile/Info?username=<%=notify.getTo_user()%>"><%=notify.getTo_user()%></a>
                                                        at
                                                        <span class="text-dark font-weight-bold"><%=dateFormat.format(notify.getCreate_time())%></span>
                                                    </p>
                                                    <%
                                                        }
                                                        else if(notify.getNotify_type_id()==3){
                                                    %>
                                                    <span class="text-white rounded p-1 my-2 bg-primary"  style="font-size: 1rem;">Báo cáo Post</span>
                                                    <h4 class="header__popup-item-content mt-1">
                                                        <a href="${pageContext.request.contextPath}/Post/Info?postID=<%=notify.getTo_post_id()%>" class="text-body" style="font-size: 18px;"><strong><%=notify.getContext()%></strong></a>
                                                    </h4>
                                                    <p class="text-muted">
                                                        <a href="${pageContext.request.contextPath}/Profile/Info?username=<%=notify.getFrom_user()%>" class="text-primary" style="font-size: 1rem;"><%=notify.getFrom_user()%></a>
                                                        báo cáo Post của
                                                        <a href="${pageContext.request.contextPath}/Profile/Info?username=<%=notify.getTo_user()%>"><%=notify.getTo_user()%></a>
                                                        at
                                                        <span class="text-dark font-weight-bold"><%=dateFormat.format(notify.getCreate_time())%></span>
                                                    </p>
                                                    <%
                                                        }
                                                        else if(notify.getNotify_type_id()==4){
                                                    %>
                                                    <span class="text-white rounded p-1 my-2 bg-success"  style="font-size: 1rem;">Bài Post mới</span>
                                                    <h4 class="header__popup-item-content mt-1">
                                                        <a href="${pageContext.request.contextPath}/Post/Info?postID=<%=notify.getTo_post_id()%>" class="text-body" style="font-size: 18px;"><strong><%=notify.getContext()%></strong></a>
                                                    </h4>
                                                    <p class="text-muted">
                                                        <a href="${pageContext.request.contextPath}/Profile/Info?username=<%=notify.getFrom_user()%>" class="text-primary" style="font-size: 1rem;"><%=notify.getFrom_user()%></a>
                                                        đăng Post mới at
                                                        <span class="text-dark font-weight-bold"><%=dateFormat.format(notify.getCreate_time())%></span>
                                                    </p>
                                                   <%
                                                       }
                                                   %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            %>
<%--                            <div class="row">--%>
<%--                                <div class="col-12">--%>
<%--                                    <div class="card mb-2" >--%>
<%--                                        <div class="card-body">--%>
<%--                                            <div class="d-flex">--%>
<%--                                                <a href=""><img src="../assets/img/101.jpg" class="mr-3 rounded-circle" width="70" height="70" alt="User" /></a>--%>
<%--                                                <div class="media-body mx-2">--%>
<%--                                                    <span class="text-white rounded p-1 my-2 bg-warning"  style="font-size: 1rem;">Báo cáo Topic</span>--%>
<%--                                                    <h4 class="header__popup-item-content mt-1"><a href="" class="text-body" style="font-size: 18px;"><strong>Ngôn từ mất kiểm soát, lừa đảo, scam.Ngôn từ mất kiểm soát, lừa đảo, scam.Ngôn từ mất kiểm soát, lừa đảo, scam.Ngôn từ mất kiểm soát, lừa đảo, scam</strong></a></h4>--%>
<%--                                                    <p class="text-muted">--%>
<%--                                                        <a href="" class="text-primary" style="font-size: 1rem;">Nguyen Dong</a> báo cáo Topic của <a href="">Van Dat</a>  at <span class="text-dark font-weight-bold">16:00:00</span></p>--%>
<%--                                                </div>--%>
<%--                                            </div>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <div class="row">--%>
<%--                                <div class="col-12">--%>
<%--                                    <div class="card mb-2" style="background-color: #E5F2FF;">--%>
<%--                                        <div class="card-body">--%>
<%--                                            <div class="d-flex">--%>
<%--                                                <a href=""><img src="../assets/img/101.jpg" class="mr-3 rounded-circle" width="70" height="70" alt="User" /></a>--%>
<%--                                                <div class="media-body mx-2">--%>
<%--                                                    <span class="text-white rounded p-1 my-2 bg-primary"  style="font-size: 1rem;">Báo cáo Post</span>--%>
<%--                                                    <h4 class="header__popup-item-content mt-1"><a href="" class="text-body" style="font-size: 18px;"><strong>Ngôn từ mất kiểm soát, lừa đảo, scam.Ngôn từ mất kiểm soát, lừa đảo, scam.Ngôn từ mất kiểm soát, lừa đảo, scam.Ngôn từ mất kiểm soát, lừa đảo, scam</strong></a></h4>--%>
<%--                                                    <p class="text-muted">--%>
<%--                                                        <a href="" class="text-primary" style="font-size: 1rem;">Nguyen Dong</a> báo cáo Post của <a href="">Van Dat</a>  at <span class="text-dark font-weight-bold">16:00:00</span></p>--%>
<%--                                                </div>--%>
<%--                                            </div>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <div class="row">--%>
<%--                                <div class="col-12">--%>
<%--                                    <div class="card mb-2" style="background-color: #E5F2FF;">--%>
<%--                                        <div class="card-body">--%>
<%--                                            <div class="d-flex">--%>
<%--                                                <a href=""><img src="../assets/img/101.jpg" class="mr-3 rounded-circle" width="70" height="70" alt="User" /></a>--%>
<%--                                                <div class="media-body mx-2">--%>
<%--                                                    <span class="text-white rounded p-1 my-2 bg-success"  style="font-size: 1rem;">Bài Post mới</span>--%>
<%--                                                    <h4 class="header__popup-item-content mt-1"><a href="" class="text-body" style="font-size: 18px;"><strong>Ngôn từ mất kiểm soát, lừa đảo, scam.Ngôn từ mất kiểm soát, lừa đảo, scam.Ngôn từ mất kiểm soát, lừa đảo, scam.Ngôn từ mất kiểm soát, lừa đảo, scam</strong></a></h4>--%>
<%--                                                    <p class="text-muted">--%>
<%--                                                        <a href="" class="text-primary" style="font-size: 1rem;">Nguyen Dong</a> đăng Post mới at <span class="text-dark font-weight-bold">16:00:00</span></p>--%>
<%--                                                </div>--%>
<%--                                            </div>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
                        </ul>
                        <a class="header__popup-bottom">
                            Xem tất cả
                        </a>
                    </div>
                </div>

            </div>
        </nav>
    </div>
</div>
<!-- Navbar End -->
