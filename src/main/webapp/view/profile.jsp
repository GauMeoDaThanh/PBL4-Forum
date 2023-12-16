<%@ page import="model.BEAN.ProfileBEAN" %>
<%@ page import="model.BEAN.UserBEAN" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.BEAN.TopicBEAN" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.SortedMap" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<%
    UserBEAN user = (UserBEAN) session.getAttribute("user");
    ArrayList<TopicBEAN> listTopic = (ArrayList<TopicBEAN>) request.getAttribute("listTopic");
%>

<head>
    <meta charset="utf-8">
    <title>Trang cá nhân</title>
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

    <jsp:include page="header.jsp"/>
    <%
        ProfileBEAN profileBEAN = (ProfileBEAN) request.getAttribute("userInfo");
    %>

    <main class="content" style="margin-top: 150px; margin-bottom: 150px;">
        <div class="container">
            <div class="row">
                <div class="d-flex">
                    <div class="w-100 d-flex" style="background-color: #E5F2FF;">
                        <img src="${pageContext.request.contextPath}/image/<%=profileBEAN.getAvatar()==null  || profileBEAN.getAvatar().equals("") ? "29.jpg" : profileBEAN.getAvatar()%>" alt="" width="350" height="350" class="rounded-circle">

                        <div class="p-4">
                            <div>
                                <h3><%=profileBEAN.getUsername()%></h3>
                                <span style="font-size: large;"><%=profileBEAN.getDescription()%></span><br><br>
                                <span style="font-size: large;"><strong>Tên: </strong><%=profileBEAN.getName()%></span><br>
                                <span style="font-size: large;"><strong>Email: </strong><%=profileBEAN.getEmail()%></span><br>
                                <span style="font-size: large;"><strong>Số lượng đơn đã nhận: </strong><%=profileBEAN.getReceiveDeli()%></span><br>
                                <span style="font-size: large;"><strong>Số sao đánh giá trung bình: </strong><%=profileBEAN.getStar()%><i
                                        class="fas fa-star" style="color: rgb(255, 213, 0);"></i></span>
                            </div>
                            <div class="my-4">
                                <c:choose>
                                    <c:when test="${sessionScope.user.username == requestScope.userInfo.username }">
                                    </c:when>
                                    <c:when test="${sessionScope.user.role == 'admin'}">
                                        <a class="btn btn-success mx-4" style="width: 100px;" href="../Chat/Info?user=${requestScope.userInfo.username}">Chat</a>
                                        <button onclick="LoadSelect()" class="btn btn-danger mx-4" data-bs-toggle="modal" data-bs-target="#modal-ban"
                                                style="width: 100px;">Xử phạt</button>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="btn btn-success mx-4" style="width: 100px;" href="../Chat/Info?user=${requestScope.userInfo.username}">Chat</a>
                                        <button class="btn btn-primary mx-4" data-bs-toggle="modal"
                                                data-bs-target="#modal-report" style="width: 100px;">Báo cáo</button>
                                    </c:otherwise>
                                </c:choose>
                                <div class="modal fade" id="modal-report" aria-labelledby="modal-report-label"
                                    aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" style="min-width: 800px;">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="report-topic-modalLabel">Báo cáo <%=user.getUsername()%></h5>
                                                <button type="reset" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="${pageContext.request.contextPath}/Notify/Add" method="post">
                                                    <div class="mb-3 d-none">
                                                        <input name="from-username" value="<%=user.getUsername()%>" type="hidden">
                                                        <input name="to-username" value="${requestScope.userInfo.username}" type="hidden">
                                                        <input name="notify-type-id" value="1" type="hidden">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="" class="form-label">Chọn lý do báo cáo</label>
                                                        <div class="form-check">
                                                            <input name="select-report-reason" id="selected-1" class="form-check-input" type="checkbox" value="Ngôn từ mất kiểm soát">
                                                            <label class="form-check-label" for="selected-1">Ngôn từ mất kiểm soát</label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input name="select-report-reason" id="selected-2" class="form-check-input" type="checkbox" value="Lừa đảo">
                                                            <label class="form-check-label" for="selected-2">Lừa đảo</label>
                                                        </div>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="other-reason" class="form-label">Lý do khác</label>
                                                        <textarea name="report-other-reason"  id="other-reason"  class="form-control" rows="10" placeholder="Nhập lý do khác"></textarea>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="reset" class="btn btn-primary" data-bs-dismiss="modal" style="width: 80px;">Huỷ</button>
                                                        <button type="submit" class="btn btn-success" style="width: 100px;">OK</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="modal fade" id="modal-ban" aria-labelledby="modal-ban-label"
                                    aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" style="min-width: 800px;" centered>
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="modal-ban-label">Xử phạt người dùng</h5>
                                                <button type="reset" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="">
                                                    <div class="mb-3">
                                                        <label for="form-select-punish" class="mb-2">Chọn hình thức xử phạt</label>
                                                        <select name="form-select-punish" id="form-select-punish" class="form-select">


                                                        </select>
                                                    </div>
                                                    <div class="mb-3 text-center">
                                                        <button type="reset" class="btn btn-primary mx-5"
                                                            data-bs-dismiss="modal" style="width: 80px;">Huỷ</button>
                                                        <button onclick="UpdateLimitation(event)" class="btn btn-danger" type="submit" data-bs-dismiss="modal">Xử phạt</button>
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
            <div class="row p-3">
                <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                    <li class="nav-item" role="presentation" style="background-color: #E5F2FF;">
                        <button class="nav-link active" id="pills-home-tab" data-bs-toggle="pill"
                            data-bs-target="#pills-home" type="button" role="tab" aria-controls="pills-home"
                            aria-selected="true">Bài viết đã đăng</button>
                    </li>
                    <li class="nav-item" role="presentation" style="background-color: #E5F2FF;">
                        <button class="nav-link" id="pills-profile-tab" data-bs-toggle="pill"
                            data-bs-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile"
                            aria-selected="false">Đánh giá</button>
                    </li>
                </ul>
                <div class="tab-content my-3" id="pills-tabContent">
                    <div class="tab-pane fade show active" id="pills-home" role="tabpanel"  aria-labelledby="pills-home-tab">
                        <%
                            for (var topic:listTopic) {
                                DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                                String createTime = dateFormat.format(topic.getCreate_time());
                                String deliDateTime = dateFormat.format(topic.getDeli_datetime());
                        %>
                        <div class="row">
                            <div class="col-12">
                                <div class="card mb-2" style="background-color: #E5F2FF;">
                                    <div class="card-body d-flex">
                                        <div class="col-7 d-flex">
                                            <a href="${pageContext.request.contextPath}/Profile/Info?username=<%=topic.getFrom_user()%>"><img src="${pageContext.request.contextPath}/image/<%=topic.getAvatar()==null  || topic.getAvatar().equals("") ? "29.jpg" : topic.getAvatar()%>" class="mr-3 rounded-circle" width="70" height="70" alt="User" /></a>
                                            <div class="media-body mx-2">
                                                <%
                                                    if(topic.getTopic_type_id()==1) {
                                                %>
                                                <span class="text-white rounded p-1 my-2" style="background-color: #7752FE;">Bài nhận vận chuyển</span>
                                                <%
                                                } else{
                                                %>
                                                <span class="text-white rounded p-1 my-2" style="background-color: #A231FC;">Bài gửi vận chuyển</span>
                                                <%
                                                    }
                                                %>
                                                <h4><a href="${pageContext.request.contextPath}/Topic/Info?topicID=<%=topic.getId()%>" class="text-body"><strong><%=topic.getTopic_name()%></strong></a></h4>
                                                <p class="text-muted"><a href="${pageContext.request.contextPath}/Profile/Info?username=<%=topic.getFrom_user()%>" class="text-primary"><%=topic.getFrom_user()%></a> at <span class="text-dark font-weight-bold"><%=createTime%></span></p>
                                            </div>
                                        </div>
                                        <div class="mx-2 col-4 d-flex flex-column justify-content-center">
                                            <div class="py-2">
                                                <i class="bi bi-geo-alt-fill" style="color: red; font-size: larger;"></i>
                                                <label for="" class="text-dark"><%=topic.getFrom_location()+" đến "+ topic.getTo_location()%></label>
                                            </div>
                                            <div class="py-2">
                                                <i class="content__topic-item-icon color--green fa-solid fa-calendar-days" style="color: green; font-size: larger;"></i>
                                                <label for="" class="text-dark"><%=deliDateTime%></label>
                                            </div>
                                        </div>
                                        <div class="col-1 d-flex align-items-center justify-content-center">
                                            <span><i class="far fa-comment mx-1"></i><%=topic.getCountPost()%></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                        <!-- pagination -->
                        <nav aria-label="...">
                            <ul class="pagination justify-content-center">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" tabindex="-1">Previous</a>
                                </li>
                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
                                </li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#">Next</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                    <!--Đánh giá-->
                    <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
                        <div class="card mb-2" style="background-color: #E5F2FF;">
                            <div class="card-body">
                                <div class="d-flex">
                                    <a href="" data-toggle="collapse" data-target=".forum-content"><img
                                            src="../assets/img/29.jpg" class="mr-3 rounded-circle" width="70"
                                            height="70" alt="User" /></a>
                                    <div class="media-body mx-2" style="min-width: 60%; max-width: 60%;">
                                        <span class="text-white rounded p-1" style="background-color: #7752FE;">Người
                                            gửi vận chuyển</span>
                                        <span style="font-size: large;" class="mx-2"><strong>Số sao đánh giá:
                                            </strong>5.0<i class="fas fa-star"
                                                style="color: rgb(255, 213, 0);"></i></span>
                                        <h4 class="mt-2"><strong>Giao hàng nhanh uy tín</strong></h4>
                                        <p class="text-muted"><a href="javascript:void(0)">NguyenDong</a> at <span
                                                class="text-dark font-weight-bold">05/05/2023 16:00</span></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card mb-2" style="background-color: #E5F2FF;">
                            <div class="card-body">
                                <div class="d-flex">
                                    <a href="" data-toggle="collapse" data-target=".forum-content"><img
                                            src="${pageContext.request.contextPath}/assets/img/29.jpg" class="mr-3 rounded-circle" width="70"
                                            height="70" alt="User" /></a>
                                    <div class="media-body mx-2" style="min-width: 60%; max-width: 60%;">
                                        <span class="text-white rounded p-1" style="background-color: #A231FC;">Người
                                            nhận vận chuyển</span>
                                        <span style="font-size: large;" class="mx-2"><strong>Số sao đánh giá:
                                            </strong>5.0<i class="fas fa-star"
                                                style="color: rgb(255, 213, 0);"></i></span>
                                        <h4 class="mt-2"><strong>Đưa hàng nhanh. Không bùng kèo</strong></h4>
                                        <p class="text-muted"><a href="javascript:void(0)">NguyenDong</a> at <span
                                                class="text-dark font-weight-bold">05/05/2023 16:00</span></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <nav aria-label="...">
                            <ul class="pagination justify-content-center">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" tabindex="-1">Previous</a>
                                </li>
                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
                                </li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#">Next</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
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
                    <p class="mt-4 text-light">Chúng tôi tạo ra diễn đàn này giúp mọi người kết nối và dễ dàng vận
                        chuyển.</p>
                    <div class="d-flex hightech-link">
                        <a href="" class="btn-light nav-fill btn btn-square rounded-circle me-2"><i
                                class="fab fa-facebook-f text-primary"></i></a>
                        <a href="" class="btn-light nav-fill btn btn-square rounded-circle me-2"><i
                                class="fab fa-twitter text-primary"></i></a>
                        <a href="" class="btn-light nav-fill btn btn-square rounded-circle me-2"><i
                                class="fab fa-instagram text-primary"></i></a>
                        <a href="" class="btn-light nav-fill btn btn-square rounded-circle me-0"><i
                                class="fab fa-linkedin-in text-primary"></i></a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <a href="#" class="h3 text-secondary">Short Link</a>
                    <div class="mt-4 d-flex flex-column short-link">
                        <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Về
                            chúng tôi</a>
                        <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Liên
                            lạc</a>
                        <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Dịch
                            vụ</a>
                        <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Dự
                            án</a>
                        <a href="" class="mb-2 text-white"><i
                                class="fas fa-angle-right text-secondary me-2"></i>Khác</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <a href="#" class="h3 text-secondary">Help Link</a>
                    <div class="mt-4 d-flex flex-column help-link">
                        <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Điều
                            khoản sử dụng</a>
                        <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Chính
                            sách riêng tư</a>
                        <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Trợ
                            giúp</a>
                        <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Hỏi
                            đáp</a>
                        <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Tính
                            năng mới</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <a href="#" class="h3 text-secondary">Liên lạc với chúng tôi</a>
                    <div class="text-white mt-4 d-flex flex-column contact-link">
                        <a href="#" class="pb-3 text-light border-bottom border-primary"><i
                                class="fas fa-map-marker-alt text-secondary me-2"></i>54 Nguyễn Lương Bằng</a>
                        <a href="#" class="py-3 text-light border-bottom border-primary"><i
                                class="fas fa-phone-alt text-secondary me-2"></i>0966535573</a>
                        <a href="#" class="py-3 text-light border-bottom border-primary"><i
                                class="fas fa-envelope text-secondary me-2"></i>PBL4@gmail.com</a>
                    </div>
                </div>
            </div>
            <hr class="text-light mt-5 mb-4">
            <div class="row">
                <div class="col-md-6 text-center text-md-start">
                    <span class="text-light"><a href="#" class="text-secondary"><i
                                class="fas fa-copyright text-secondary me-2"></i>Transport</a>, Mọi bản quyền liên hệ
                        chúng tôi.</span>
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <span class="text-light">Thiết kế bởi<a href="" class="text-secondary"> Nguyễn Đông và Văn Đạt</a>
                        Đóng góp bởi <a href="">Bootstrap</a></span>
                </div>
            </div>
        </div>
    </div>
    <!-- Footer End -->


    <!-- Back to Top -->
    <a href="#" class="btn btn-secondary btn-square rounded-circle back-to-top"><i
            class="fa fa-arrow-up text-white"></i></a>


    <!-- JavaScript Libraries -->
    <script src="${pageContext.request.contextPath}/assets/library/bootstrap-5.2.3-dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/lib/wow/wow.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/lib/easing/easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/lib/waypoints/waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/lib/owlcarousel/owl.carousel.min.js"></script>
<%--    --%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- Province API -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.26.1/axios.min.js" integrity="sha512-bPh3uwgU5qEMipS/VOmRqynnMXGGSRv+72H/N260MQeXZIK4PG48401Bsby9Nq5P5fz7hy5UGNmC/W1Z51h2GQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>

    <script>

        function LoadSelect(){

            var select = document.getElementById("form-select-punish");
            select.innerHTML="";
            // select.innerHTML="<option value='0'>--Chọn hình thức xử phạt--</option>";
            $.ajax({
                url: "/Forum/limitation/GetTypeLimitation",
                type: "get",
                success: function (response){

                    select.innerHTML +=response;
                },
                error: function (xhr, status, error) {
                    console.error("AJAX request failed:", status, error);
                }
            });
        }

        function UpdateLimitation(event){
            event.preventDefault();
            let idLimit= document.getElementById("form-select-punish").value;

            $.ajax({

                url: "/Forum/limitation/UpdateLimitation?UserName=<%= profileBEAN.getUsername()%>&idLimit="+idLimit,
                type: "get",
                success: function (response){
                    alert(response);
                }
            });
        }

        function AddNotification(event){
            event.preventDefault();
            let selectElement = document.getElementById("form-select-report");

            let index = selectElement.selectedIndex;

            let context = selectElement.options[index].innerText;
            <%--let Name = '<%=userLogin.getName()%>';--%>
            // alert(Name);
            // alert(context);
            $.ajax({

                url: "/Forum/notification/ReportUser?toUser=<%=profileBEAN.getUsername()%>&context="+context+"&idNotify=1",
                type: "get",
                success: function (response){
                    alert(response);
                }
            });

        }
    </script>
</body>

</html>