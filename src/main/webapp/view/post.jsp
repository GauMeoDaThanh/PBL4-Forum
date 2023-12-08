<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Post</title>
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
<!-- Topbar End -->

<!-- Navbar Start -->
<jsp:include page="header.jsp"/>
<!-- Navbar End -->
<main class="content" style="margin-top: 150px; margin-bottom: 150px;">
    <div class="container">
        <div class="mb-3">
            <h1 class="h3 mb-3 text-body">Nhận vận chuyển nội thành Đà Nẵng</h1>
            <div class="d-flex align-items-center">
                <div class="mx-2 d-flex align-items-center">
                    <i class="bi bi-person" style="font-size: larger;"></i>
                    <a href="" class="mx-1">Leo Messi</a>
                </div>
                <div class="mx-2 d-flex align-items-center">
                    <i class="bi bi-geo-alt-fill" style="color: red; font-size: large;"></i>
                    <span class="mx-1">Hà Nội đến Hồ Chí Minh</span>
                </div>
                <div class="mx-2 d-flex align-items-center">
                    <i class="fa-solid fa-calendar-days" style="color: green; font-size: large;"></i>
                    <span class="mx-1">05/10/2023 16:00</span>
                </div>
            </div>
        </div>

    </div>
    <div class="modal fade" id="confirm-delete" tabindex="-1" aria-labelledby="confirm-delete-modalLabel" aria-hidden="true">
        <div class="modal-dialog" style="min-width: 700px; ">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirm-delete-modalLabel">Xác nhận xoá bài viết</h5>
                    <button type="reset" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <h4 class="text-center">Bạn có chắc chẵn muốn xoá bài viết này. Thao tác này không thể quay lại</h4>
                    <form>
                        <div class="modal-footer">
                            <button type="reset" class="btn btn-primary" data-bs-dismiss="modal" style="width: 80px;">Huỷ</button>
                            <button type="button" class="btn btn-success" style="width: 100px;">Xác nhận</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row rounded border mt-3" id="id-post-1" style="min-height: 200px;">
            <div class="col-2 p-2 text-center" style="background-color: #E5F2FF; border-right: 1px solid #d3d5d7;">
                <img src="../assets/img/101.jpg"  class="rounded-circle mr-1 avatar-hover" alt="Vanessa Tucker" width="100" height="100">
                <div>
                    <a id="post-owner-1" class="text-primary my-2" href="" style="font-weight: 700; font-size: larger;">Leo Messi</a>
                    <p class="text-success p-2">Tôi là nhà vô địch thế giới.Tôi là nhà vô địch thế giới.</p>
                </div>
            </div>
            <div class="col-10 p-3" style="background-color: #E5F2FF; min-height: 100%;">
                <div class="m-1 d-flex align-items-center">
                    <i class="fa-solid fa-calendar-days" style="color: green; font-size: large;"></i>
                    <span class="mx-1">05/10/2023 16:00</span>
                </div>
                <p id="post-content-1" style="min-height: 50%;">Diễn đàn VOZ vừa được cập nhật lên phiên bản hơi mới, với những thay đổi tập trung chính về hiệu năng và nâng cao trải nghiệm. Một vài ví dụ:
                    Nhanh cực, nếu thấy chậm thì refresh lại thử xem sao.
                    Mã xác thực 2 lớp không phải nhập lại nếu bạn vào VOZ thường xuyên, ít vào thì chịu.
                    Thông báo có thể đánh dấu đã đọc từng cái một, có thể tinh chỉnh tự động đánh dấu, tổng hợp... abcxyz... ai rảnh thì mò thử.
                    Nhanh cực, nếu thấy chậm thì refresh lại thử xem sao.
                    Mã xác thực 2 lớp không phải nhập lại nếu bạn vào VOZ thường xuyên, ít vào thì chịu.
                    Thông báo có thể đánh dấu đã đọc từng cái một, có thể tinh chỉnh tự động đánh dấu, tổng hợp... abcxyz... ai rảnh thì mò thử.
                    Nhanh cực, nếu thấy chậm thì refresh lại thử xem sao.
                    Mã xác thực 2 lớp không phải nhập lại nếu bạn vào VOZ thường xuyên, ít vào thì chịu.
                    Thông báo có thể đánh dấu đã đọc từng cái một, có thể tinh chỉnh tự động đánh dấu, tổng hợp... abcxyz... ai rảnh thì mò thử.
                    <br><br>
                    <img src="../assets/img/about-2.jpg" width="160" height="160" alt="image">
                </p>
                <div class="mt-3 py-2" style="border-top: 1px solid #ccc;">
                    <button class="icon-hover btn" style="display: none;">
                        <i class="bi bi-heart" ></i>
                        Thích
                    </button>
                    <button class="icon-hover btn" style="display: none;">
                        <i class="bi bi-emoji-angry"></i>
                        Phẫn nộ
                    </button>
                    <button class="icon-hover btn" onclick="replyPost('post-owner-1','post-content-1','id-post-1','owner-post-to','content-post-to','id-post-to','block-reply')">
                        <i class="bi bi-reply"></i>
                        Trả lời
                    </button>
                    <button class="icon-hover btn">
                        <i class="bi bi-flag" ></i>
                        Báo cáo
                    </button>
                    <button class="icon-hover btn btn-link" style="color: #dc3545;" data-bs-toggle="modal" data-bs-target="#confirm-delete">
                        <i class="bi bi-trash" ></i>
                        Xoá bài viết
                    </button>
                </div>

            </div>
        </div>
        <div class="row rounded border mt-3" id="id-post-2" style="min-height: 200px;">
            <div class="col-2 p-2 text-center" style="background-color: #E5F2FF; border-right: 1px solid #d3d5d7;">
                <img src="../assets/img/101.jpg"  class="rounded-circle mr-1 avatar-hover" alt="Vanessa Tucker" width="100" height="100">
                <div>
                    <a id="post-owner-2" class="text-primary my-2" href="" style="font-weight: 700; font-size: larger;">Nguyễn Lam</a>
                    <p class="text-success p-2">Tôi là lam</p>
                </div>
            </div>
            <div class="col-10 p-3" style="background-color: #E5F2FF; min-height: 100%;">
                <div class="m-1 d-flex align-items-center">
                    <i class="fa-solid fa-calendar-days" style="color: green; font-size: large;"></i>
                    <span class="mx-1">05/10/2023 16:00</span>
                </div>
                <p id="post-content-2" style="min-height: 50%;">Hello

                    <br><br>
                    <img src="../assets/img/about-1.jpg" width="160" height="160" alt="image">
                </p>
                <div class="mt-3 py-2" style="border-top: 1px solid #ccc;">
                    <button class="icon-hover btn" style="display: none;">
                        <i class="bi bi-heart" ></i>
                        Thích
                    </button>
                    <button class="icon-hover btn" style="display: none;">
                        <i class="bi bi-emoji-angry"></i>
                        Phẫn nộ
                    </button>
                    <button class="icon-hover btn" onclick="replyPost('post-owner-2','post-content-2','id-post-2','owner-post-to','content-post-to','id-post-to','block-reply')">
                        <i class="bi bi-reply"></i>
                        Trả lời
                    </button>
                    <button class="icon-hover btn">
                        <i class="bi bi-flag" ></i>
                        Báo cáo
                    </button>
                    <button class="icon-hover btn btn-link" style="color: #dc3545;" data-bs-toggle="modal" data-bs-target="#confirm-delete">
                        <i class="bi bi-trash" ></i>
                        Xoá bài viết
                    </button>
                </div>

            </div>
        </div>
        <nav aria-label="Page navigation example" class="my-5">
            <ul class="pagination justify-content-center">
                <li class="page-item disabled">
                    <a class="page-link" href="#" tabindex="-1">Previous</a>
                </li>
                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                    <a class="page-link" href="#">Next</a>
                </li>
            </ul>
        </nav>
        <div class="row rounded border mt-3">
            <div class="col-2 p-2 text-center" style="background-color: #E5F2FF; border-right: 1px solid #d3d5d7;">
                <img src="../assets/img/about-2.jpg"  class="rounded-circle mr-1 avatar-hover" alt="Vanessa Tucker" width="100" height="100">
                <div>
                    <a class="text-primary my-2" href="" style="font-weight: 700; font-size: larger;">Nguyen Dong</a>
                    <p class="text-success p-2">Toi la nguyen dong</p>
                </div>
            </div>

            <div class="col-10 p-3" style="background-color: #E5F2FF;">
                <form action="/Post/add" method="post">
                    <div id="block-reply" style="background-color: #ccc; display: none;" class="p-3 rounded">
                        <span>Trả lời </span><span id="owner-post-to"></span>:<br>
                        <p id="content-post-to"></p>
                        <input name="idPostTo" type="text" id="id-post-to" style="display: none;">
                    </div>

                    <div class="mt-3">
                        <label for="attachFile" class="">Đính kèm ảnh</label>
                        <input name="attachFile" type="file" id="attachFile" class="form-control my-2" accept=".jpg,.png" multiple>
                        <textarea name="post-content-text" class="form-control" id="message-text" placeholder="Nhập nội dung" rows="10"></textarea>
                    </div>
                    <div class="mt-3 py-2" style="text-align: right; border-top: 1px solid #ccc;">
                        <button type="reset" class="btn btn-primary mx-3" style="width: 120px;" onclick="resetReply('owner-post-to','content-post-to','id-post-to','block-reply')">
                            <i class="bi bi-bootstrap-reboot"></i>
                            Reset
                        </button>
                        <button class="btn btn-success" style="width: 120px;">
                            <i class="bi bi-send"></i>
                            Gửi
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>
<!-- Footer Start -->
<div class="container-fluid footer bg-dark wow fadeIn" data-wow-delay=".3s">
    <div class="container pt-5 pb-4">
        <div class="row g-5">
            <div class="col-lg-3 col-md-6">
                <a href="index.html">
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

<script>
    window.addEventListener("load", function() {
        // Wait for the entire page, including images and other resources, to be fully loaded
        var elementToFocus = document.getElementById("element-focus");

        // Check if the element exists
        if (elementToFocus) {
            // Scroll to the element with smooth behavior
            elementToFocus.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
    });
</script>

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