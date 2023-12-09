<%@ page import="model.BEAN.UserBEAN" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.BEAN.TopicBEAN" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<%
    UserBEAN user = (UserBEAN) session.getAttribute("user");
    ArrayList<TopicBEAN> listReceive = (ArrayList<TopicBEAN>) request.getAttribute("listTopicReceive");
    ArrayList<TopicBEAN> listSend = (ArrayList<TopicBEAN>) request.getAttribute("listTopicSend");

%>
    <head>
        <meta charset="utf-8">
        <title>Trang chủ</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Saira:wght@500;600;700&display=swap" rel="stylesheet"> 

        <!-- Icon Font Stylesheet -->

        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/library/fontawesome-free-6.4.2-web/css/all.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/library/bootstrap-icons-1.11.1/bootstrap-icons.css">
        <!-- Libraries Stylesheet -->

        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/lib/animate/animate.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/lib/owlcarousel/assets/owl.carousel.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
        <!-- style.css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    </head>

    <body>
        <!-- Topbar Start -->
        <div class="fixed-top container-fluid bg-dark py-2 d-none d-md-flex">
            <div class="container">
                <div class="d-flex justify-content-between topbar">
                    <div class="top-info">
                        <small class="me-3 text-white-50"><a href="#"><i class="fas fa-map-marker-alt me-2 text-secondary"></i></a>54 Nguyễn Lương Bằng, Đà Nẵng</small>
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
        <jsp:include page="header.jsp"/>
        <!-- Topbar End -->
        <main class="content" style="margin-top: 150px; margin-bottom: 150px;">
            <!-- Bài nhận vận chuyển -->
            <div class="container">
                <div class="row border-top">
                    <a href="/Topic/receive">
                        <h4 class="p-2 bg-primary text-secondary border-top" style="display: block;">BÀI NHẬN VẬN CHUYỂN</h4>
                    </a>
                </div>
                <%
                    for (TopicBEAN topic:listReceive) {
                        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                        String createTime = dateFormat.format(topic.getCreate_time());
//                        String editTime = dateFormat.format(topic.getEdit_time());
                        String deliDateTime = dateFormat.format(topic.getDeli_datetime());
                %>
                <div class="row">
                    <div class="inner-main-bodycollapse forum-content show">
                        <div class="card mb-2" style="background-color: #E5F2FF;">
                            <div class="card-body">
                                <div class="media forum-item d-flex">
                                    <a href="#" data-toggle="collapse" data-target=".forum-content"><img src="${pageContext.request.contextPath}/image/<%=topic.getAvatar()==null  || topic.getAvatar().equals("") ? "29.jpg" : topic.getAvatar()%>" class="mr-3 rounded-circle" width="70" height="70" alt="User" /></a>
                                    <div class="media-body mx-2" style="min-width: 60%; max-width: 60%;">
                                        <h4><a href="/Topic/Info?topicID=<%=topic.getId()%>" data-toggle="collapse" data-target=".forum-content" class="text-body"><strong><%=topic.getTopic_name()%></strong></a></h4>
                                        <p class="text-muted"><a href="/Profile/Info?username=<%=topic.getFrom_user()%>" class="text-primary"><%=topic.getFrom_user()%></a> at <span class="text-dark font-weight-bold"><%=createTime%></span></p>
                                    </div>
                                    <div class="media-body mx-4" style="width: 20%;">
                                        <div class="content__topic-item-right-item">
                                            <i class="bi bi-geo-alt-fill" style="color: red; font-size: larger;"></i>
                                            <label for="" class="text-dark"><%=topic.getFrom_location()+" đến "+ topic.getTo_location()%></label>
                                        </div>
                                        <div class="content__topic-item-right-item py-3">
                                            <i class="content__topic-item-icon color--green fa-solid fa-calendar-days" style="color: green"></i>
                                            <label for="" class="text-dark"><%=deliDateTime%></label>
                                        </div>
                                    </div>
                                    <div class="text-muted small text-center align-self-center">
                                        <!-- <span class="d-none d-sm-inline-block mx-1"><i class="far fa-eye"></i> 19</span> -->
                                        <span><i class="far fa-comment mx-1"></i> 3</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>

            </div>
            <!-- Bài gửi vận chuyển -->
            <div class="container py-5">
                <div class="row border-top">
                    <a href="/Topic/send">
                        <h4 class="p-2 bg-primary text-secondary border-top" style="display: block;">BÀI GỬI VẬN CHUYỂN</h4>
                    </a>
                </div>
                <%
                    for (TopicBEAN topic:listSend) {
                        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                        String createTime = dateFormat.format(topic.getCreate_time());
//                        String editTime = dateFormat.format(topic.getEdit_time());
                        String deliDateTime = dateFormat.format(topic.getDeli_datetime());
                %>
                <div class="row">
                    <div class="inner-main-bodycollapse forum-content show">
                        <div class="card mb-2" style="background-color: #E5F2FF;">
                            <div class="card-body">
                                <div class="media forum-item d-flex">
                                    <a href="profile.jsp" data-toggle="collapse" data-target=".forum-content"><img src="${pageContext.request.contextPath}/image/<%=topic.getAvatar()==null  || topic.getAvatar().equals("") ? "29.jpg" : topic.getAvatar()%>" class="mr-3 rounded-circle" width="70" height="70" alt="User" /></a>
                                    <div class="media-body mx-2" style="min-width: 60%; max-width: 60%;">
                                        <h4><a href="/Topic/Info?topicID=<%=topic.getId()%>" data-toggle="collapse" data-target=".forum-content" class="text-body"><strong><%=topic.getTopic_name()%></strong></a></h4>
                                        <p class="text-muted"><a href="/Profile/Info?username=<%=topic.getFrom_user()%>" class="text-primary"><%=topic.getFrom_user()%></a> at <span class="text-dark font-weight-bold"><%=createTime%></span></p>
                                    </div>
                                    <div class="media-body mx-4" style="width: 20%;">
                                        <div class="content__topic-item-right-item">
                                            <i class="bi bi-geo-alt-fill" style="color: red; font-size: larger;"></i>
                                            <label for="" class="text-dark"><%=topic.getFrom_location()+" đến "+ topic.getTo_location()%></label>
                                        </div>
                                        <div class="content__topic-item-right-item py-3">
                                            <i class="content__topic-item-icon color--green fa-solid fa-calendar-days" style="color: green"></i>
                                            <label for="" class="text-dark"><%=deliDateTime%></label>
                                        </div>
                                    </div>
                                    <div class="text-muted small text-center align-self-center">
                                        <!-- <span class="d-none d-sm-inline-block mx-1"><i class="far fa-eye"></i> 19</span> -->
                                        <span><i class="far fa-comment mx-1"></i> 3</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </main>
        <!-- Footer Start -->
         <div class="container-fluid footer bg-dark wow fadeIn" data-wow-delay=".3s">
            <div class="container pt-5 pb-4">
                <div class="row g-5">
                    <div class="col-lg-3 col-md-6">
                        <a href="../index.jsp">
                            <h1 class="text-white fw-bold d-block">Trans<span class="text-secondary">Port</span> </h1>
                        </a>
                        <p class="mt-4 text-light">Chúng tôi tạo ra diễn đàn này giúp mọi người kết nối và dễ dàng vận chuyển.</p>
                        <div class="d-flex hightech-link">
                            <a href="" class="btn-light nav-fill btn btn-square rounded-circle me-2"><i class="fab fa-facebook-f text-primary"></i></a>
                            <a href="" class="btn-light nav-fill btn btn-square rounded-circle me-2"><i class="fab fa-twitter text-primary"></i></a>
                            <a href="" class="btn-light nav-fill btn btn-square rounded-circle me-2"><i class="fab fa-instagram text-primary"></i></a>
                            <a href="" class="btn-light nav-fill btn btn-square rounded-circle me-0"><i class="fab fa-linkedin-in text-primary"></i></a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <a href="#" class="h3 text-secondary">Short Link</a>
                        <div class="mt-4 d-flex flex-column short-link">
                            <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Về chúng tôi</a>
                            <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Liên lạc</a>
                            <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Dịch vụ</a>
                            <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Dự án</a>
                            <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Khác</a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <a href="#" class="h3 text-secondary">Help Link</a>
                        <div class="mt-4 d-flex flex-column help-link">
                            <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Điều khoản sử dụng</a>
                            <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Chính sách riêng tư</a>
                            <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Trợ giúp</a>
                            <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Hỏi đáp</a>
                            <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Tính năng mới</a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <a href="#" class="h3 text-secondary">Liên lạc với chúng tôi</a>
                        <div class="text-white mt-4 d-flex flex-column contact-link">
                            <a href="#" class="pb-3 text-light border-bottom border-primary"><i class="fas fa-map-marker-alt text-secondary me-2"></i>54 Nguyễn Lương Bằng</a>
                            <a href="#" class="py-3 text-light border-bottom border-primary"><i class="fas fa-phone-alt text-secondary me-2"></i>0966535573</a>
                            <a href="#" class="py-3 text-light border-bottom border-primary"><i class="fas fa-envelope text-secondary me-2"></i>PBL4@gmail.com</a>
                        </div>
                    </div>
                </div>
                <hr class="text-light mt-5 mb-4">
                <div class="row">
                    <div class="col-md-6 text-center text-md-start">
                        <span class="text-light"><a href="#" class="text-secondary"><i class="fas fa-copyright text-secondary me-2"></i>Transport</a>, Mọi bản quyền liên hệ chúng tôi.</span>
                    </div>
                    <div class="col-md-6 text-center text-md-end">
                        <span class="text-light">Thiết kế bởi<a href="" class="text-secondary"> Nguyễn Đông và Văn Đạt</a>  Đóng góp bởi <a href="">Bootstrap</a></span>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-secondary btn-square rounded-circle back-to-top"><i class="fa fa-arrow-up text-white"></i></a>

        
        <!-- JavaScript Libraries -->
        <script src="${pageContext.request.contextPath}/assets/library/bootstrap-5.2.3-dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/lib/wow/wow.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/lib/easing/easing.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/lib/waypoints/waypoints.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Template Javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
    </body>

</html>