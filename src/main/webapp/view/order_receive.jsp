<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
        <jsp:include page="header.jsp"/>
        <!-- Navbar End -->
        <div class="container py-5 my-5" style="min-height: 100vh;">
            <div class="container py-5">
                <div class="row my-4">

                    <h5 class="text-center">ĐƠN NHẬN VẬN CHUYỂN</h5>
                    <div class="col-12 py-2">
                        <c:choose>
                            <c:when test="${not empty requestScope.deliReceiveList}">
                                <table class="table table-bordered">
                                    <thead>
                                    <tr>
                                        <th scope="col" style="max-width: 6%; width: 6%;"  class="text-center">Mã đơn</th>
                                        <th scope="col" style="max-width: 16%; width: 16%;" class="text-center">Tài khoản nhờ gửi</th>
                                        <th scope="col" style="max-width: 16%; width: 16%;" class="text-center">Tên hàng hóa</th>
                                        <th scope="col" style="max-width: 14%; width: 14%;" class="text-center">Người nhận</th>
                                        <th scope="col" style="max-width: 12%; width: 12%;" class="text-center">Số điện thoại</th>
                                        <th scope="col" style="max-width: 15%; width: 15%;" class="text-center">Địa chỉ đến</th>
                                        <th scope="col" style="max-width: 12%; width: 12%;" class="text-center">Trạng thái</th>
                                        <th scope="col" style="max-width: 10%; width: 10%;" class="text-center">Chi tiết</th>
                                        <th scope="col" style="max-width: 12%; width: 12%;" class="text-center">Đánh giá</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="deliInfo" items="${requestScope.deliReceiveList}">
                                        <tr>
                                            <th class="text-center"><c:out value="${deliInfo.id}"/></th>
                                            <td class="text-center"><a href="${pageContext.request.contextPath}/Profile/Info?username=${deliInfo.userSend}" >${deliInfo.userSend}</a></td>
                                            <td class="text-center"><c:out value="${deliInfo.goodsName}"/></td>
                                            <td class="text-center"><c:out value="${deliInfo.receiveName}"/></td>
                                            <td class="text-center"><c:out value="${deliInfo.contactNumber}"/></td>
                                            <td><c:out value="${deliInfo.toAddress}"/> </td>
                                            <c:choose>
                                                <c:when test="${fn:containsIgnoreCase(deliInfo.lastDeliState, 'bắt đầu gửi')}">
                                                    <td class="text-center text-info">Bắt đầu gửi</td>
                                                </c:when>
                                                <c:when test="${deliInfo.end}">
                                                    <td class="text-center text-success">Phát thành công</td>
                                                </c:when>
                                                <c:when test="${empty deliInfo.lastDeliState}">
                                                    <td class="text-center text-dark">Chưa vận chuyển</td>
                                                </c:when>
                                                <c:otherwise>
                                                    <td class="text-center text-secondary">Đang chuyển</td>
                                                </c:otherwise>
                                            </c:choose>
                                            <td class="text-center"><a href="${pageContext.request.contextPath}/Deli/Info?id=${deliInfo.id}"><button type="button" class="btn btn-primary">Chi tiết</button></a></td>
                                            <c:choose>
                                                <c:when test="${deliInfo.rated}">
                                                    <td class="text-center"><button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#exampleModal" disabled>Đã đánh giá</button></td>
                                                </c:when>
                                                <c:when test="${deliInfo.end}">
                                                    <td class="text-center"><button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal" data-id="${deliInfo.id}" id="rating-btn">Đánh giá</button></td>
                                                </c:when>
                                                <c:otherwise>
                                                    <td class="text-center"><button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#exampleModal" disabled>Đánh giá</button></td>
                                                </c:otherwise>
                                            </c:choose>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <p class="text-center font-weight-bold text-danger h5">Chưa có đơn hàng nào</p>
                            </c:otherwise>
                        </c:choose>
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
                            <form action="${pageContext.request.contextPath}/Rating/Receive" method="post" enctype="multipart/form-data">
                                <div class="mb-3">
                                    <div class="rating-box">
                                        <h4 class="text-center">Đánh giá sao cho người này</h4>
                                        <div class="stars my-2 text-center">
                                            <i class="fa-solid fa-star star-1 active" onclick="onStarClick()"></i>
                                            <i class="fa-solid fa-star star-2 active" onclick="onStarClick()"></i>
                                            <i class="fa-solid fa-star star-3 active" onclick="onStarClick()"></i>
                                            <i class="fa-solid fa-star star-4 active" onclick="onStarClick()"></i>
                                            <i class="fa-solid fa-star star-5 active" onclick="onStarClick()"></i>
                                        </div>
                                        <h4 class="text-center rating-label my-2">Rất tốt</h4>
                                        <h6 class="text-center rating-number d-none">5</h6>
                                        <input type="text" value="5" name="rating-point" id="rating" hidden>
                                        <input type="text" id="deli-id" name="deliId" value="" hidden>
                                      </div>
                                </div>
                                <div class="mb-3">
                                    <label for="message-text" class="col-form-label">Đính kèm ảnh</label>
                                    <input type="file" class="form-control" accept=".jpg,.png" name="rate-picture">
                                </div>
                                <div class="mb-3">
                                    <label for="message-text" class="col-form-label">Nhận xét</label>
                                    <textarea class="form-control" id="message-text" placeholder="Nhập nhận xét..." rows="5" name="rate-comment"></textarea>
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
    <script>
        $(document).on("click", "#rating-btn", function (){
            var deliId = $(this).data('id');
            $("#deli-id").val(deliId);
        });
    </script>
    </body>

</html>