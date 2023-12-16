<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Order</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Saira:wght@500;600;700&display=swap"
          rel="stylesheet">
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
                <small class="me-3 text-white-50"><a href="#"><i class="fas fa-map-marker-alt me-2 text-secondary"></i></a>54
                    Nguyễn Lương Bằng, Đà Nẵng</small>
                <small class="me-3 text-white-50"><a href="#"><i class="fas fa-envelope me-2 text-secondary"></i></a>PBL4@gmail.com</small>
            </div>
            <div id="note" class="text-secondary d-none d-xl-flex"><small>Đến với chúng tôi, mọi thứ rất dễ dàng</small>
            </div>
            <div class="top-link">
                <a href="" class="bg-light nav-fill btn btn-sm-square rounded-circle"><i
                        class="fab fa-facebook-f text-primary"></i></a>
                <a href="" class="bg-light nav-fill btn btn-sm-square rounded-circle"><i
                        class="fab fa-twitter text-primary"></i></a>
                <a href="" class="bg-light nav-fill btn btn-sm-square rounded-circle"><i
                        class="fab fa-instagram text-primary"></i></a>
                <a href="" class="bg-light nav-fill btn btn-sm-square rounded-circle me-0"><i
                        class="fab fa-linkedin-in text-primary"></i></a>
            </div>
        </div>
    </div>
</div>
<!-- Topbar End -->

<!-- Navbar Start -->
<jsp:include page="header.jsp"/>
<!-- Navbar End -->
<div class="container" style="min-height: 100vh; margin-top: 180px;">
    <div class="row">
        <div class="col-12">
            <c:choose>
                <c:when test="${requestScope.deliInfo.userSend eq sessionScope.user.username}">
                    <a href="${pageContext.request.contextPath}/Deli/Send">
                        <button class="btn btn-primary">Quay lại</button>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/Deli/Receive">
                        <button class="btn btn-primary">Quay lại</button>
                    </a>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
    <div class="row text-center">
        <h1>Chi tiết đơn vận</h1>
    </div>
    <div class="row">
        <div class="rounded p-4 text-dark" style="min-height: 100px; background-color: #DFEBFF;">
            <div class="row">
                <div class="col-3" style="font-size: larger;">
                    <span><strong>Mã số đơn: </strong></span>
                    <span>${requestScope.deliInfo.id}</span>
                </div>
                <c:choose>
                    <c:when test="${requestScope.deliInfo.userSend eq sessionScope.user.username}">
                        <div class="col-4" style="font-size: larger;">
                            <span><strong>Tài khoản nhận vận chuyển: </strong></span>
                            <span><a
                                    href="${pageContext.request.contextPath}/Profile/Info?username=${requestScope.deliInfo.userTake}">${requestScope.deliInfo.userTake}</a></span>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="col-4" style="font-size: larger;">
                            <span><strong>Tài khoản gửi vận chuyển: </strong></span>
                            <span><a
                                    href="${pageContext.request.contextPath}/Profile/Info?username=${requestScope.deliInfo.userSend}">${requestScope.deliInfo.userSend}</a></span>
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="col-5" style="font-size: larger;">
                    <span><strong>Người nhận hàng: </strong></span>
                    <span>${requestScope.deliInfo.receiveName}</span>
                </div>
            </div>
            <div class="row py-3">
                <div class="col-3" style="font-size: larger;">
                    <span><strong>Tên hàng hóa: </strong></span>
                    <span>${requestScope.deliInfo.goodsName}</span>
                </div>
                <div class="col-4" style="font-size: larger;">
                    <span><strong>Số điện thoại liên hệ: </strong></span>
                    <span>${requestScope.deliInfo.contactNumber}</span>
                </div>
                <div class="col-5" style="font-size: larger;">
                    <span><strong>Địa chỉ: </strong></span>
                    <span>${requestScope.deliInfo.toAddress}</span>
                </div>
            </div>


        </div>

        <div class="row my-3">
            <div class="col-10">
                <h3>Ghi chú</h3>
            </div>

            <textarea class="form-control text-dark my-2" style="background-color: #EBECED; font-size: larger;" disabled
                      id="message-text" placeholder="Ghi chú trống..." rows="3">${requestScope.deliInfo.note}</textarea>
        </div>

        <div class="row my-3">
            <div class="col-12 p-2" style="border-bottom: 1px solid #000;">
                <c:set var="isStart" value="false"/>
                <c:forEach var="deliDetail" items="${requestScope.deliDetail}">
                    <c:if test="${fn:containsIgnoreCase(deliDetail.deliState, 'bắt đầu gửi')}">
                        <c:set var="isStart" value="true"/>
                    </c:if>
                </c:forEach>
                <h3 style="display: inline-block;">Thông tin trạng thái</h3>
                <c:if test="${requestScope.deliInfo.userTake eq sessionScope.user.username && !fn:containsIgnoreCase(requestScope.deliInfo.lastDeliState, 'phát thành công')}">
                    <div style="float: right;">
                        <c:choose>
                            <c:when test="${requestScope.deliInfo.end}">
                                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal-send" disabled>Bắt đầu gửi</button>
                                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal-success" disabled>
                                    Phát thành công
                                </button>
                                <button class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#exampleModal" disabled>Cập
                                    nhật
                                </button>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${isStart}">
                                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal-send" disabled>Bắt đầu gửi</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal-send">Bắt đầu gửi</button>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${!isStart}">
                                        <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal-success" disabled>Phát thành công</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal-success">Phát thành công</button>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${!isStart}">
                                        <button class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#exampleModal" disabled>Cập nhật</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#exampleModal">Cập nhật</button>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>

                <div class="modal fade" id="exampleModal-send" tabindex="-1" aria-labelledby="exampleModalLabel-send"
                     aria-hidden="true">
                    <div class="modal-dialog" style="min-width: 1200px; ">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel-send">Bắt đầu gửi</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="${pageContext.request.contextPath}/Deli/?mode=start&deliId=${requestScope.deliInfo.id}" id="start-form" method="post">
                                    <div class="mb-3">
                                        <div class="rating-box">
                                            <h4 class="text-center">Địa chỉ hàng bắt đầu đi</h4>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="start-deli" class="col-form-label">Nhập địa chỉ hàng bắt đầu
                                            đi</label>
                                        <textarea class="form-control" name="start-deli" id="start-deli"
                                                  placeholder="Nhập địa chỉ hàng bắt đầu đi..." rows="5"
                                                  required></textarea>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="reset" class="btn btn-primary" data-bs-dismiss="modal"
                                                style="width: 80px;">Huỷ
                                        </button>
                                        <button type="submit" class="btn btn-success" style="width: 100px;">OK</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="exampleModal-success" tabindex="-1"
                     aria-labelledby="exampleModalLabel-success" aria-hidden="true">
                    <div class="modal-dialog" style="min-width: 1200px; ">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel-success">Xác nhận phát thành công</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="${pageContext.request.contextPath}/Deli/?mode=end&deliId=${requestScope.deliInfo.id}" method="post">
                                    <div class="mb-3">
                                        <div class="rating-box">
                                            <h4 class="text-center">Chắc chắn thành công? Thao tác này không thể chỉnh
                                                sửa được</h4>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="reset" class="btn btn-primary" data-bs-dismiss="modal"
                                                style="width: 80px;">Huỷ
                                        </button>
                                        <button type="submit" class="btn btn-success" style="width: 100px;">Xác nhận
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog" style="min-width: 1200px; ">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Cập nhật trạng thái</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="${pageContext.request.contextPath}/Deli/?mode=update&&deliId=${requestScope.deliInfo.id}"
                                      method="post">
                                    <div class="mb-3">
                                        <div class="rating-box">
                                            <h4 class="text-center">Cập nhật địa điểm hàng đến</h4>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="update-deli" class="col-form-label">Nhập địa chỉ hàng đã đến</label>
                                        <textarea class="form-control" name="update-deli" id="update-deli"
                                                  placeholder="Nhập địa chỉ..." rows="5" required></textarea>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="reset" class="btn btn-primary" data-bs-dismiss="modal"
                                                style="width: 80px;">Huỷ
                                        </button>
                                        <button type="submit" class="btn btn-success" style="width: 100px;">OK</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
            <div id="deli-state">
            <c:if test="${not empty requestScope.deliDetail}">
                <ul class="list-group mt-3">
                    <c:forEach var="deliDetail" items="${requestScope.deliDetail}">
                        <c:choose>
                            <c:when test="${fn:containsIgnoreCase(deliDetail.deliState, 'bắt đầu gửi')}">
                                <li class="list-group-item list-group-item-info"><c:out
                                        value="${deliDetail.deliTime} ${deliDetail.deliState}"/></li>
                            </c:when>
                            <c:when test="${fn:containsIgnoreCase(deliDetail.deliState, 'phát thành công')}">
                                <li class="list-group-item list-group-item-secondary"><c:out
                                        value="${deliDetail.deliTime} ${deliDetail.deliState}"/></li>
                            </c:when>
                            <c:otherwise>
                                <li class="list-group-item list-group-item-primary"><c:out
                                        value="${deliDetail.deliTime} ${deliDetail.deliState}"/></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </ul>
            </c:if>
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
                    <h1 class="text-white fw-bold d-block">Trans<span class="text-secondary">Port</span></h1>
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
                    <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Về chúng
                        tôi</a>
                    <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Liên
                        lạc</a>
                    <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Dịch vụ</a>
                    <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Dự án</a>
                    <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Khác</a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <a href="#" class="h3 text-secondary">Help Link</a>
                <div class="mt-4 d-flex flex-column help-link">
                    <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Điều khoản
                        sử dụng</a>
                    <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Chính sách
                        riêng tư</a>
                    <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Trợ
                        giúp</a>
                    <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Hỏi đáp</a>
                    <a href="" class="mb-2 text-white"><i class="fas fa-angle-right text-secondary me-2"></i>Tính năng
                        mới</a>
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
                        class="fas fa-copyright text-secondary me-2"></i>Transport</a>, Mọi bản quyền liên hệ chúng tôi.</span>
            </div>
            <div class="col-md-6 text-center text-md-end">
                <span class="text-light">Thiết kế bởi<a href="" class="text-secondary"> Nguyễn Đông và Văn Đạt</a>  Đóng góp bởi <a
                        href="">Bootstrap</a></span>
            </div>
        </div>
    </div>
</div>
<!-- Footer End -->


<!-- Back to Top -->
<a href="#" class="btn btn-secondary btn-square rounded-circle back-to-top"><i
        class="fa fa-arrow-up text-white"></i></a>


<!-- JavaScript Libraries -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="../assets/library/bootstrap-5.2.3-dist/js/bootstrap.bundle.min.js"></script>
<script src="../assets/lib/wow/wow.min.js"></script>
<script src="../assets/lib/easing/easing.min.js"></script>
<script src="../assets/lib/waypoints/waypoints.min.js"></script>
<script src="../assets/lib/owlcarousel/owl.carousel.min.js"></script>


<!-- Province API -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.26.1/axios.min.js" integrity="sha512-bPh3uwgU5qEMipS/VOmRqynnMXGGSRv+72H/N260MQeXZIK4PG48401Bsby9Nq5P5fz7hy5UGNmC/W1Z51h2GQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- Template Javascript -->
<script src="../assets/js/main.js"></script>
</body>

</html>