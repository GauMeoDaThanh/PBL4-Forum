<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Trang nhận</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Saira:wght@500;600;700&display=swap" rel="stylesheet"> 

        <!-- Icon Font Stylesheet -->

        <link rel="stylesheet" href="${pageContext.request.contextPath}
/assets/library/fontawesome-free-6.4.2-web/css/all.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}
/assets/library/bootstrap-icons-1.11.1/bootstrap-icons.css">
        <!-- Libraries Stylesheet -->

        <link rel="stylesheet" href="${pageContext.request.contextPath}
/assets/lib/animate/animate.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}
/assets/lib/owlcarousel/assets/owl.carousel.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}
/assets/css/bootstrap.min.css">
        <!-- style.css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}
/assets/css/style.css">
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
        <!-- Topbar End -->

        <!-- Navbar Start -->
        <div class="fixed-top my-5 container-fluid bg-primary">
            <div class="container">
                <nav class="navbar navbar-dark navbar-expand-lg py-0">
                    <a href="home.jsp" class="navbar-brand">
                        <h1 class="text-white fw-bold d-block">Trans<span class="text-secondary">Port</span> </h1>
                    </a>
                    <button type="button" class="navbar-toggler me-0" data-bs-toggle="collapse"
                        data-bs-target="#navbarCollapse">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse bg-transparent" id="navbarCollapse">
                        <div class="navbar-nav ms-auto mx-xl-auto p-0">
                            <a href="./order_receive.jsp" class="nav-item nav-link">Đơn nhận</a>
                            <a href="order_send.jsp" class="nav-item nav-link">Đơn gửi</a>
                            <a href="chat.jsp" class="nav-item nav-link">Chat</a>
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
                                <img src="${pageContext.request.contextPath}
/assets/img/101.jpg" alt="mdo" width="40" height="40" class="rounded-circle">
                                <span class="text-white mx-2">Nguyễn Đông Tuấn</span>
                            </div>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                                <li><a class="dropdown-item" href="profile.jsp">Trang cá nhân</a></li>
                                <li><a class="dropdown-item" href="change_profile.jsp">Chỉnh sửa thông tin</a></li>
                                <li><a class="dropdown-item" href="change_password.jsp">Đổi mật khẩu</a></li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <li><a class="dropdown-item" href="../index.jsp">Đăng xuất</a></li>
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
        <div class="container py-5 my-5" style="min-height: 100vh;">
            <div class="container py-5">
                <div class="row my-4">

                    <h5 class="text-center">ĐƠN NHẬN VẬN CHUYỂN</h5>
                    <div class="col-12 py-2">
                      <table class="table table-bordered">
                        <thead>
                          <tr>
                            <th scope="col" style="max-width: 8%; width: 8%;"  class="text-center">Mã đơn</th>
                            <th scope="col" style="max-width: 20%; width: 20%;" class="text-center">Thông tin người gửi</th>
                            <th scope="col" style="max-width: 10%; width: 10%;"  class="text-center">Số điện thoại</th>
                            <th scope="col" style="max-width: 30%; width: 30%;" class="text-center">Địa chỉ</th>
                            <th scope="col" style="max-width: 10%; width: 10%;" class="text-center">Trạng thái</th>
                            <th scope="col" style="max-width: 10%; width: 10%;" class="text-center">Chi tiết</th>
                            <th scope="col" style="max-width: 12%; width: 12%;" class="text-center">Đánh giá</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <th class="text-center">D001</th>
                            <td><a href=""><img src="${pageContext.request.contextPath}
/assets/img/101.jpg" alt="mdo" width="35" height="35" class="rounded-circle" style="margin-right: 3px;">Recoon</a></td>
                            <td class="text-center">0987822857</td>
                            <td>K356 Ngũ Hành Sơn, phường Mỹ An, quận Ngũ Hành Sơn, thành phố Đà Nẵng.</td>
                            <td class="text-center">Đang chuyển</td>
                            <td class="text-center"><a href="order_detail.jsp"><button type="button" class="btn btn-primary">Chi tiết</button></a></td>
                            <td class="text-center"><button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal">Đánh giá</button></td>
                          </tr>
                          <tr>
                            <th class="text-center">D001</th>
                            <td><a href=""><img src="../assets/img/101.jpg" alt="mdo" width="35" height="35" class="rounded-circle" style="margin-right: 3px;">Recoon</a></td>
                            <td class="text-center">0987822857</td>
                            <td>K356 Ngũ Hành Sơn, phường Mỹ An, quận Ngũ Hành Sơn, thành phố Đà Nẵng.</td>
                            <td class="text-center">Đang chuyển</td>
                            <td class="text-center"><a href="order_detail.jsp"><button type="button" class="btn btn-primary">Chi tiết</button></a></td>
                            <td class="text-center"><button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal">Đánh giá</button></td>
                          </tr>
                          <tr>
                            <th class="text-center">D001</th>
                            <td><a href=""><img src="../assets/img/101.jpg" alt="mdo" width="35" height="35" class="rounded-circle" style="margin-right: 3px;">Recoon</a></td>
                            <td class="text-center">0987822857</td>
                            <td>K356 Ngũ Hành Sơn, phường Mỹ An, quận Ngũ Hành Sơn, thành phố Đà Nẵng.</td>
                            <td class="text-center">Đang chuyển</td>
                            <td class="text-center"><a href="order_detail.jsp"><button type="button" class="btn btn-primary">Chi tiết</button></a></td>
                            <td class="text-center"><button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal">Đánh giá</button></td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                  </div>
            </div>
        </div>
        <div class="container">
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog"  style="min-width: 1200px; ">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Đánh giá</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form>
                                <div class="mb-3">
                                    <div class="rating-box">
                                        <h4 class="text-center">Đánh giá sao cho người này</h4>
                                        <div class="stars my-2 text-center">
                                            <i class="fa-solid fa-star star-1 active" onclick="onStarClick()"></i>
                                            <i class="fa-solid fa-star star-2" onclick="onStarClick()"></i>
                                            <i class="fa-solid fa-star star-3" onclick="onStarClick()"></i>
                                            <i class="fa-solid fa-star star-4" onclick="onStarClick()"></i>
                                            <i class="fa-solid fa-star star-5" onclick="onStarClick()"></i>
                                        </div>
                                        <h4 class="text-center rating-label my-2">Rất tệ</h4>
                                        <h6 class="text-center rating-number d-none">1</h6>
                                      </div>
                                </div>
                                <div class="mb-3">
                                    <label for="message-text" class="col-form-label">Nhận xét</label>
                                    <textarea class="form-control" id="message-text" placeholder="Nhập nhận xét..." rows="5"></textarea>
                                </div>
                                
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal" style="width: 80px;">Huỷ</button>
                                    <button type="button" class="btn btn-success" style="width: 100px;">OK</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
              </div>
        </div>
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
        <script src="${pageContext.request.contextPath}
/assets/library/bootstrap-5.2.3-dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}
/assets/lib/wow/wow.min.js"></script>
        <script src="${pageContext.request.contextPath}
/assets/lib/easing/easing.min.js"></script>
        <script src="${pageContext.request.contextPath}
/assets/lib/waypoints/waypoints.min.js"></script>
        <script src="${pageContext.request.contextPath}
/assets/lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Template Javascript -->
        <script src="${pageContext.request.contextPath}
/assets/js/main.js"></script>
    </body>

</html>