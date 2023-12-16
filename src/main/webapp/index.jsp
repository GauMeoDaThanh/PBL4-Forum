<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Forum</title>
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

        <!-- Customized Bootstrap Stylesheet -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
        <!-- Template Stylesheet -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    </head>

    <body>
        <!-- Spinner Start -->
        <div id="spinner" class="show position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-grow text-primary" role="status"></div>
        </div>
        <!-- Spinner End -->

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
                    <a href="" class="navbar-brand">
                        <h1 class="text-white fw-bold d-block">Trans<span class="text-secondary">Port</span> </h1>
                    </a>
                    <button type="button" class="navbar-toggler me-0" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse bg-transparent" id="navbarCollapse">
                        <div class="navbar-nav ms-auto mx-xl-auto p-0"></div>
                    </div>
                    <div class="">
                        <button class="btn btn-secondary rounded-pill px-5 py-3 text-white" data-bs-toggle="modal" data-bs-target="#LoginRegisterModal">Đăng nhập</button>
                    </div>
                </nav>
            </div>
        </div>
        <!-- modal -->
        <div class="container">
            <div class="modal fade" id="LoginRegisterModal" tabindex="-1" aria-labelledby="LoginLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="LoginLabel" style="display: block;">Đăng nhập</h5>
                            <h5 class="modal-title" id="RegisterLabel" style="display: none;">Đăng ký</h5>
                            <button type="reset" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="authenticate/login" id="form-login" style="display: block;" method="post">
                                <div class="mb-3">
                                    <label for="recipient-name" class="col-form-label">Tên đăng nhập</label>
                                    <input type="text" class="form-control" id="recipient-name" placeholder="Nhập tên đăng nhập..." name="username" required>
                                </div>

                                <div class="mb-3">
                                    <label for="recipient-name" class="col-form-label">Mật khẩu</label>
                                    <input type="password" class="form-control" id="recipient-name" placeholder="Nhập mật khẩu..." name="password" required>
                                </div>

                                <div class="mb-3">
                                    <label for="recipient-name" class="col-form-label">Chưa có tài khoản</label>
                                    <button href="#" class="btn btn-link" id="register-tab" onclick="ClickRegisterTab()" type="reset">Đăng ký</button>
                                </div>

                                <div class="modal-footer">
                                    <button type="reset" class="btn btn-primary" data-bs-dismiss="modal" style="width: 120px;">Huỷ</button>
                                    <button type="submit" class="btn btn-success"  style="width: 120px;">Đăng nhập</button>
                                </div>
                            </form>
                            <form method="post" action="authenticate/register" id="form-register" style="display: none;" oninput="password2.setCustomValidity(password2.value != password.value ? 'Mật khẩu không giống' : '')">
                                <div class="mb-3">
                                    <label for="recipient-name" class="col-form-label">Tên đăng nhập</label>
                                    <input type="text" class="form-control" id="recipient-name" placeholder="Nhập tên đăng nhập..." name="username" required>
                                </div>

                                <div class="mb-3">
                                    <label for="recipient-name" class="col-form-label" >Mật khẩu</label>
                                    <input type="password" class="form-control" id="password" placeholder="Nhập mật khẩu..." name="password" required>
                                </div>

                                <div class="mb-3">
                                    <label for="recipient-name" class="col-form-label">Nhập lại mật khẩu</label>
                                    <input type="password" class="form-control" name="password2" placeholder="Nhập lại mật khẩu..." required>
                                </div>

                                <div class="mb-3">
                                    <p id="error" style="color: red"></p>
                                    <label for="recipient-name" class="col-form-label">Đã có tài khoản</label>
                                    <button href="#" class="btn btn-link" id="login-tab" onclick="ClickLoginTab()" type="reset">Đăng nhập</button>
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal" style="width: 120px;">Huỷ</button>
                                    <button type="submit" class="btn btn-success"  style="width: 120px;" id="register-btn">Đăng ký</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <!-- Navbar End -->

        <!-- Carousel Start -->
        <div class="container-fluid px-0">
            <div id="carouselId" class="carousel slide" data-bs-ride="carousel">
                <ol class="carousel-indicators">
                    <li data-bs-target="#carouselId" data-bs-slide-to="0" class="active" aria-current="true" aria-label="First slide"></li>
                    <li data-bs-target="#carouselId" data-bs-slide-to="1" aria-label="Second slide"></li>
                </ol>
                <div class="carousel-inner" role="listbox">
                    <div class="carousel-item active">
                        <img src="${pageContext.request.contextPath}/assets/img/carousel-1.jpg" class="img-fluid" alt="First slide" style="width: 100%; height: 20%;">
                        <div class="carousel-caption">
                            <div class="container carousel-content">
                                <h6 class="text-secondary h4 animated fadeInUp">Diễn đàn vận chuyển</h6>
                                <h1 class="text-white display-1 mb-4 animated fadeInRight">Transport Forum</h1>
                                <p class="mb-4 text-white fs-5 animated fadeInDown">Chúng tôi làm diễn đàn này đem đến giải pháp cho mọi người trong việc vận chuyển hàng hoá.</p>
                            </div>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <img src="${pageContext.request.contextPath}/assets/img/carousel-2.jpg" class="img-fluid" alt="Second slide" style="width: 100%; height: 20%;">
                        <div class="carousel-caption">
                            <div class="container carousel-content">
                                <h6 class="text-secondary h4 animated fadeInUp">Cam kết đảm bảo chất lượng</h6>
                                <h1 class="text-white display-1 mb-4 animated fadeInRight">Transport Forum</h1>
                                <p class="mb-4 text-white fs-5 animated fadeInDown">Chúng tôi sẵn lòng lắng nghe ý kiến của mọi người. Làm mọi thứ tốt nhất có thể, đem đến trải nghiệm tốt nhất cho người dùng</p>
                            </div>
                        </div>
                    </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselId" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselId" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </div>
        <!-- Carousel End -->

        




        <!-- Footer Start -->
        <div class="container-fluid footer bg-dark wow fadeIn" data-wow-delay=".3s">
            <div class="container pt-5 pb-4">
                <div class="row g-5">
                    <div class="col-lg-3 col-md-6">
                        <a href="index.jsp">
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/library/bootstrap-5.2.3-dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/lib/wow/wow.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/lib/easing/easing.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/lib/waypoints/waypoints.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Province API -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.26.1/axios.min.js" integrity="sha512-bPh3uwgU5qEMipS/VOmRqynnMXGGSRv+72H/N260MQeXZIK4PG48401Bsby9Nq5P5fz7hy5UGNmC/W1Z51h2GQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <!-- Template Javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
        <script >
            $(document).on("submit", "#form-register", function (event){
                const $form = $(this);
                $.post($form.attr("action"), $form.serialize(), function (response){
                    if (response === "trung tai khoan") {
                        alert("Tên tài khoản đã tồn tại, vui lòng chọn tên khác");
                        location.reload();
                    }else {
                        window.location.assign("Profile/Register")
                    }
                });
                event.preventDefault();
            });
            const urlParams = new URLSearchParams(window.location.search);
            const alertParam = urlParams.get('alert');

            if (alertParam === '1') {

                alert('Sai tài khoản hoặc mật khẩu');
                window.location.assign("/Forum");
            }
            ////////
            else if(alertParam==="BanAccount"){
                alert('Tài khoản đã bị chặn đăng nhập, liên hệ admin để được hỗ trợ!');
                window.location.assign("/Forum");
            }
        </script>


    </body>

</html>