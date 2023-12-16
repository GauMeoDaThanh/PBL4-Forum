<%@ page import="model.BEAN.UserBEAN" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Chat</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Saira:wght@500;600;700&display=swap"
          rel="stylesheet">

    <!-- Icon Font Stylesheet -->

    <link rel="stylesheet" href="../assets/library/fontawesome-free-6.4.2-web/css/all.css">
    <link rel="stylesheet" href="../assets/library/bootstrap-icons-1.11.1/bootstrap-icons.css">
    <!-- Libraries Stylesheet -->

    <link rel="stylesheet" href="../assets/lib/animate/animate.min.css">
    <link rel="stylesheet" href="../assets/lib/owlcarousel/assets/owl.carousel.min.css">

    <link rel="stylesheet" href="../assets/css/bootstrap.min.css">
    <!-- style.css -->
    <link rel="stylesheet" href="../assets/css/style.css">
</head>

<body>

<jsp:include page="header.jsp"/>
<%
    UserBEAN user = (UserBEAN) session.getAttribute("user");
    String avatar = (String) request.getAttribute("userAvatar");
%>
<main class="content" style="margin-top: 150px; margin-bottom: 150px;">
    <div class="container p-0">
        <h1 class="h3 mb-3">Chat</h1>

        <div class="card">
            <div class="d-flex">
                <!-- Sidebar(bên trái) -->
                <div class="nav flex-column nav-pills me-3 py-2"
                     style="min-width: 25%; max-height: 694px;overflow-y: scroll; flex-wrap: nowrap;" id="v-pills-tab"
                     role="tablist" aria-orientation="vertical">
                    <c:if test="${not empty requestScope.chatNameList}">
                        <c:forEach var="entry" items="${requestScope.chatNameList}">
                            <a href="${pageContext.request.contextPath}/Chat/Info?user=${entry.key}" class="nav-link">
                                <div class="d-flex align-items-center position-relative">
                                    <c:choose>
                                        <c:when test="${empty entry.value}">
                                            <img src="${pageContext.request.contextPath}/image/29.jpg"
                                                 class="rounded-circle mx-2" width="40px" height="40px" alt="">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/image/${entry.value}"
                                                 class="rounded-circle mx-2" width="40px" height="40px" alt="">
                                        </c:otherwise>
                                    </c:choose>
                                    <span><c:out value="${entry.key}"/></span>
                                </div>
                            </a>
                        </c:forEach>
                    </c:if>
                </div>
                <!-- Tin nhắn (bên phải) -->

                <!-- Người 1 -->
                <div class="tab-content flex-grow-1" id="v-pills-tabContent">
                    <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel"
                         aria-labelledby="v-pills-home-tab">
                        <div class="d-flex justify-content-between p-3" style="border-bottom: 1px solid #ccc;">
                            <div class="d-flex align-items-center">
                                <img src="${pageContext.request.contextPath}/image/<%= avatar==null || avatar.equals("") ? "29.jpg" : avatar%>"
                                     class="rounded-circle mx-2" width="40" height="40" alt="">
                                <span><strong><a
                                        href="${pageContext.request.contextPath}/Profile/Info?username=${requestScope.username}">${requestScope.username}</a></strong></span>
                            </div>
                            <div class="">
                                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modal-order">
                                    Điền đơn
                                </button>
                            </div>
                        </div>

                        <div class="position-relative" style="background-color: #E5F2FF; height: 550px">
                            <div class="chat-messages p-4" id="chat-message" style="height: 550px">
                                <c:if test="${not empty requestScope.messages}">
                                    <c:forEach var="mess" items="${requestScope.messages}">
                                        <c:choose>
                                            <c:when test="${mess.fromUser eq sessionScope.user.username && !mess.form}">
                                                <div class="chat-message-right mb-4" >
                                                    <div>
                                                        <img src="${pageContext.request.contextPath}/image/<%=user.getAvatar()==null  || user.getAvatar().equals("") ? "29.jpg" : user.getAvatar()%>"
                                                             class="rounded-circle mr-1" alt="Chris Wood" width="40" height="40">
                                                    </div>
                                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 mr-3">
                                                        <div class="font-weight-bold mb-1 text-end"><strong>Bạn</strong></div>
                                                        <c:choose>
                                                            <c:when test="${not empty mess.message}">
                                                                <c:out value="${mess.message}"/>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img id="image"
                                                                     src="${pageContext.request.contextPath}/image/${mess.picture}"
                                                                     class="" style="height: 200px;"
                                                                     alt="example placeholder">
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div class="text-muted small text-nowrap mt-2 mx-2"> <c:out value="${mess.sendTime}"/></div>
                                                </div>
                                            </c:when>
                                            <c:when test="${mess.fromUser eq requestScope.username && !mess.form}">
                                                <div class="chat-message-left pb-4">
                                                    <div>
                                                        <img src="${pageContext.request.contextPath}/image/<%= avatar==null || avatar.equals("") ? "29.jpg" : avatar%>"
                                                             class="rounded-circle mr-1" alt="Sharon Lessman" width="40" height="40">
                                                    </div>
                                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 ml-3">
                                                        <div class="font-weight-bold mb-1"><strong><c:out value="${mess.fromUser}"/></strong></div>
                                                        <c:choose>
                                                            <c:when test="${not empty mess.message}">
                                                                <c:out value="${mess.message}"/>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img id="image"
                                                                     src="${pageContext.request.contextPath}/image/${mess.picture}"
                                                                     class="" style="height: 200px;"
                                                                     alt="example placeholder">
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div class="text-muted small text-nowrap mt-2 mx-2"> <c:out value="${mess.sendTime}"/></div>
                                                </div>
                                            </c:when>
                                            <c:when test="${mess.fromUser eq sessionScope.user.username && mess.form}">
                                                <div class="chat-message-right mb-4">
                                                    <div>
                                                        <img src="${pageContext.request.contextPath}/image/<%=user.getAvatar()==null  || user.getAvatar().equals("") ? "29.jpg" : user.getAvatar()%>"
                                                             class="rounded-circle mr-1" alt="Chris Wood" width="40" height="40">
                                                    </div>
                                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 mr-3">
                                                        <div class="font-weight-bold mb-1 text-end"><strong>Bạn</strong></div>
                                                        <span class="bg-primary text-white">Đơn yêu cầu vận chuyển<br></span>
                                                        <c:set var="deliInfo" value="${fn:split(mess.message, '@@')}" />
                                                        <div>
                                                            <strong>Tên hàng hóa: </strong>${deliInfo[0]}<br>
                                                            <strong>Người nhận: </strong>${deliInfo[1]}<br>
                                                            <strong>Số điện thoại: </strong>${deliInfo[2]}<br>
                                                            <strong>Địa chỉ đến: </strong>${deliInfo[3]}<br>
                                                            <strong>Ghi chú: </strong>${deliInfo[4]}<br>
                                                        </div>
                                                        <c:if test="${mess.formState}">
                                                            <span class="bg-primary text-white">Đơn đã được nhận<br></span>
                                                        </c:if>
                                                    </div>
                                                    <div class="text-muted small text-nowrap mt-2 mx-2"><c:out value="${mess.sendTime}"/></div>
                                                </div>
                                            </c:when>
                                            <c:when test="${mess.fromUser eq requestScope.username && mess.form}">
                                                <div class="chat-message-left pb-4">
                                                    <div>
                                                        <img src="${pageContext.request.contextPath}/image/<%= avatar==null || avatar.equals("") ? "29.jpg" : avatar%>"
                                                             class="rounded-circle mr-1" alt="Sharon Lessman" width="40" height="40">
                                                    </div>
                                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 mr-3">
                                                        <div class="font-weight-bold mb-1"><strong><c:out value="${mess.fromUser}"/></strong></div>
                                                        <span class="bg-success text-white">Đơn yêu cầu nhận vận chuyển<br></span>
                                                        <c:set var="deliInfo" value="${fn:split(mess.message, '@@')}" />
                                                        <div>
                                                            <strong>Tên hàng hóa: </strong>${deliInfo[0]}<br>
                                                            <strong>Người nhận: </strong>${deliInfo[1]}<br>
                                                            <strong>Số điện thoại: </strong>${deliInfo[2]}<br>
                                                            <strong>Địa chỉ đến: </strong>${deliInfo[3]}<br>
                                                            <strong>Ghi chú: </strong>${deliInfo[4]}<br>
                                                        </div>
                                                        <div style="float: right;">
<%--                                                            <c:set value="${mess.id}" var="deliInfoId"/>--%>
                                                            <c:choose>
                                                                <c:when test="${mess.formState}">
                                                                    <span class="bg-success text-white">Đã nhận đơn này<br></span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <a href="#" class="btn btn-success" onclick="acceptDeli(${mess.id})">Nhận đơn</a>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                    <div class="text-muted small text-nowrap mt-2 mx-2"><c:out value="${mess.sendTime}"/></div>
                                                </div>
                                            </c:when>
                                        </c:choose>
                                    </c:forEach>
                                </c:if>

<%--                                <div class="chat-message-right mb-4">--%>
<%--                                    <div>--%>
<%--                                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png"--%>
<%--                                             class="rounded-circle mr-1" alt="Chris Wood" width="40" height="40">--%>
<%--                                    </div>--%>
<%--                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 mr-3">--%>
<%--                                        <div class="font-weight-bold mb-1">Bạn</div>--%>
<%--                                        Cum ea graeci tractatos.--%>
<%--                                    </div>--%>
<%--                                    <div class="text-muted small text-nowrap mt-2 mx-2"> 2:20</div>--%>
<%--                                </div>--%>

<%--                                <div class="chat-message-left pb-4">--%>
<%--                                    <div>--%>
<%--                                        <img src="https://bootdey.com/img/Content/avatar/avatar3.png"--%>
<%--                                             class="rounded-circle mr-1" alt="Sharon Lessman" width="40" height="40">--%>
<%--                                        <div class="text-muted small text-nowrap mt-2">2:36 am</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 ml-3">--%>
<%--                                        <div class="font-weight-bold mb-1">Sharon Lessman</div>--%>
<%--                                        Sed pulvinar, massa vitae interdum pulvinar, risus lectus porttitor magna, vitae--%>
<%--                                        commodo lectus mauris et velit.--%>
<%--                                        Proin ultricies placerat imperdiet. Morbi varius quam ac venenatis tempus.--%>
<%--                                    </div>--%>
<%--                                </div>--%>

<%--                                <div class="chat-message-left pb-4">--%>
<%--                                    <div>--%>
<%--                                        <img src="https://bootdey.com/img/Content/avatar/avatar3.png"--%>
<%--                                             class="rounded-circle mr-1" alt="Sharon Lessman" width="40" height="40">--%>
<%--                                        <div class="text-muted small text-nowrap mt-2">2:37 am</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 ml-3">--%>
<%--                                        <div class="font-weight-bold mb-1">Sharon Lessman</div>--%>
<%--                                        Cras pulvinar, sapien id vehicula aliquet, diam velit elementum orci.--%>
<%--                                    </div>--%>
<%--                                </div>--%>

<%--                                <div class="chat-message-right mb-4">--%>
<%--                                    <div>--%>
<%--                                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png"--%>
<%--                                             class="rounded-circle mr-1" alt="Chris Wood" width="40" height="40">--%>
<%--                                        <div class="text-muted small text-nowrap mt-2">2:38 am</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 mr-3">--%>
<%--                                        <div class="font-weight-bold mb-1">Bạn</div>--%>
<%--                                        Lorem ipsum dolor sit amet, vis erat denique in, dicunt prodesset te vix.--%>
<%--                                    </div>--%>
<%--                                </div>--%>

<%--                                <div class="chat-message-left pb-4">--%>
<%--                                    <div>--%>
<%--                                        <img src="https://bootdey.com/img/Content/avatar/avatar3.png"--%>
<%--                                             class="rounded-circle mr-1" alt="Sharon Lessman" width="40" height="40">--%>
<%--                                        <div class="text-muted small text-nowrap mt-2">2:39 am</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 ml-3">--%>
<%--                                        <div class="font-weight-bold mb-1">Sharon Lessman</div>--%>
<%--                                        Sit meis deleniti eu, pri vidit meliore docendi ut, an eum erat animal commodo.--%>
<%--                                    </div>--%>
<%--                                </div>--%>

<%--                                <div class="chat-message-right mb-4">--%>
<%--                                    <div>--%>
<%--                                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png"--%>
<%--                                             class="rounded-circle mr-1" alt="Chris Wood" width="40" height="40">--%>
<%--                                        <div class="text-muted small text-nowrap mt-2">2:40 am</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 mr-3">--%>
<%--                                        <div class="font-weight-bold mb-1">Bạn</div>--%>
<%--                                        Cum ea graeci tractatos.--%>
<%--                                    </div>--%>
<%--                                </div>--%>

<%--                                <div class="chat-message-right mb-4">--%>
<%--                                    <div>--%>
<%--                                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png"--%>
<%--                                             class="rounded-circle mr-1" alt="Chris Wood" width="40" height="40">--%>
<%--                                        <div class="text-muted small text-nowrap mt-2">2:41 am</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 mr-3">--%>
<%--                                        <div class="font-weight-bold mb-1">Bạn</div>--%>
<%--                                        Morbi finibus, lorem id placerat ullamcorper, nunc enim ultrices massa, id--%>
<%--                                        dignissim metus urna eget purus.--%>
<%--                                    </div>--%>
<%--                                </div>--%>

<%--                                <div class="chat-message-left pb-4">--%>
<%--                                    <div>--%>
<%--                                        <img src="https://bootdey.com/img/Content/avatar/avatar3.png"--%>
<%--                                             class="rounded-circle mr-1" alt="Sharon Lessman" width="40" height="40">--%>
<%--                                    </div>--%>
<%--                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 ml-3">--%>
<%--                                        <div class="font-weight-bold mb-1">Sharon Lessman</div>--%>
<%--                                        Sed pulvinar, massa vitae interdum pulvinar, risus lectus porttitor magna, vitae--%>
<%--                                        commodo lectus mauris et velit.--%>
<%--                                        Proin ultricies placerat imperdiet. Morbi varius quam ac venenatis tempus.--%>
<%--                                    </div>--%>
<%--                                    <div class="text-muted small text-nowrap mt-2 mx-2">2:44 am</div>--%>
<%--                                </div>--%>

<%--                                <div class="chat-message-right mb-4">--%>
<%--                                    <div>--%>
<%--                                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png"--%>
<%--                                             class="rounded-circle mr-1" alt="Chris Wood" width="40" height="40">--%>
<%--                                        <div class="text-muted small text-nowrap mt-2">2:43 am</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 mr-3">--%>
<%--                                        <div class="font-weight-bold mb-1">Bạn</div>--%>
<%--                                        Lorem ipsum dolor sit amet, vis erat denique in, dicunt prodesset te vix.--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                                <div class="chat-message-right mb-4">--%>
<%--                                    <div>--%>
<%--                                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png"--%>
<%--                                             class="rounded-circle mr-1" alt="Chris Wood" width="40" height="40">--%>
<%--                                    </div>--%>
<%--                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 mr-3">--%>
<%--                                        <div class="font-weight-bold mb-1">Bạn</div>--%>
<%--                                        <span class="bg-primary text-white">Đơn yêu cầu vận chuyển<br></span>--%>
<%--                                        <div>--%>
<%--                                            <strong>Người nhận: </strong>Tuấn<br>--%>
<%--                                            <strong>Số điện thoại: </strong>0966535573<br>--%>
<%--                                            <strong>Địa chỉ đi: </strong>Hải Phòng<br>--%>
<%--                                            <strong>Địa chỉ đến: </strong>Bắc Giang<br>--%>
<%--                                            <strong>Khổi lượng: </strong>250g<br>--%>
<%--                                            <strong>Thời gian đưa hàng cho người vận chuyển: </strong>30/11/2023--%>
<%--                                            16:00<br>--%>
<%--                                            <strong>Ghi chú: </strong>Cho chú iphone 14<br>--%>
<%--                                        </div>--%>
<%--                                        <a href="" class="btn btn-primary" style="float: right;">Huỷ</a>--%>
<%--                                    </div>--%>
<%--                                    <div class="text-muted small text-nowrap mt-2 mx-2">2:44 am</div>--%>
<%--                                </div>--%>

<%--                                <div class="chat-message-left pb-4">--%>
<%--                                    <div>--%>
<%--                                        <img src="https://bootdey.com/img/Content/avatar/avatar3.png"--%>
<%--                                             class="rounded-circle mr-1" alt="Sharon Lessman" width="40" height="40">--%>
<%--                                        <div class="text-muted small text-nowrap mt-2">2:44 am</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 ml-3">--%>
<%--                                        <div class="font-weight-bold mb-1">Sharon Lessman</div>--%>
<%--                                        Sit meis deleniti eu, pri vidit meliore docendi ut, an eum erat animal commodo.--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                                <div class="chat-message-left pb-4">--%>
<%--                                    <div>--%>
<%--                                        <img src="https://bootdey.com/img/Content/avatar/avatar3.png"--%>
<%--                                             class="rounded-circle mr-1" alt="Sharon Lessman" width="40" height="40">--%>
<%--                                        <div class="text-muted small text-nowrap mt-2">2:44 am</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 mr-3">--%>
<%--                                        <div class="font-weight-bold mb-1">Sharon Lessman</div>--%>
<%--                                        <span class="bg-success text-white">Đơn yêu cầu nhận vận chuyển<br></span>--%>
<%--                                        <div>--%>
<%--                                            <strong>Người nhận: </strong>Tuấn<br>--%>
<%--                                            <strong>Số điện thoại: </strong>0966535573<br>--%>
<%--                                            <strong>Địa chỉ đi: </strong>Hải Phòng<br>--%>
<%--                                            <strong>Địa chỉ đến: </strong>Bắc Giang<br>--%>
<%--                                            <strong>Khổi lượng: </strong>250g<br>--%>
<%--                                            <strong>Thời gian đưa hàng cho người vận chuyển: </strong>30/11/2023--%>
<%--                                            16:00<br>--%>
<%--                                            <strong>Ghi chú: </strong>Cho chú iphone 14<br>--%>
<%--                                        </div>--%>
<%--                                        <div style="float: right;">--%>
<%--                                            <a href="" class="btn btn-primary">Huỷ</a>--%>
<%--                                            <a href="" class="btn btn-success">Nhận đơn</a>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>

                            </div>
                        </div>

                        <div class="flex-grow-0 py-3 px-4 border-top">
                            <form action="${pageContext.request.contextPath}/Chat/Info?user=${requestScope.username}" method="post" enctype="multipart/form-data" id="send-message">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Nhập tin nhắn" id="text"
                                           name="text">
                                    <div class="d-flex">
                                        <button class="btn btn-success mx-1" type="submit">Gửi</button>
                                        <div class="d-flex justify-content-center">
                                            <label class="btn btn-primary btn-rounded">
                                                <label class="form-label text-white m-1">
                                                    <label class="bi bi-paperclip" for="customFile2" style="cursor: pointer;"></label>
                                                </label>
                                                <input type="file" class="form-control d-none" id="customFile2" accept=".jpg,.png"
                                                       onchange="displaySelectedImage(event, 'selectedAvatar2')" name="message-picture"/>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div id="displayImageChat" class="m-2 d-flex align-items-center">
                                    <img id="selectedAvatar2"
                                         src="https://mdbootstrap.com/img/Photos/Others/placeholder-avatar.jpg"
                                         class="" style="height: 100px; object-fit: cover; display: none;"
                                         alt="example placeholder"/>
                                    <button id="button-deleteImage" class="btn btn-danger mx-2"
                                            style="display: none; width: 50px; height: 50px;" type="button"><i
                                            class="bi bi-bootstrap-reboot"></i></button>
                                </div>
                            </form>

                        </div>
                    </div>
                    <!-- Ngưới 2 -->
                    <div class="tab-pane fade" id="v-pills-profile" role="tabpanel"
                         aria-labelledby="v-pills-profile-tab">
                        <div class="d-flex justify-content-between p-3" style="border-bottom: 1px solid #ccc;">
                            <div class="d-flex align-items-center">
                                <img src="../assets/img/29.jpg" class="rounded-circle mx-2" width="40" height="40"
                                     alt="">
                                <span><strong><a href="./profile.html">Phùng Ánh</a></strong></span>
                            </div>
                            <div class="">
                                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modal-order">
                                    Điền đơn
                                </button>
                            </div>
                        </div>
                        <div class="position-relative" style="background-color: #E5F2FF;">
                            <div class="chat-messages p-4">

                                <div class="chat-message-right pb-4">
                                    <div>
                                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png"
                                             class="rounded-circle mr-1" alt="Chris Wood" width="40" height="40">
                                        <div class="text-muted small text-nowrap mt-2">2:33 am</div>
                                    </div>
                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 mr-3">
                                        <div class="font-weight-bold mb-1">Bạn</div>
                                        Lorem ipsum dolor sit amet, vis erat denique in, dicunt prodesset te vix.
                                    </div>
                                </div>

                                <div class="chat-message-left pb-4">
                                    <div>
                                        <img src="https://bootdey.com/img/Content/avatar/avatar3.png"
                                             class="rounded-circle mr-1" alt="Sharon Lessman" width="40" height="40">
                                        <div class="text-muted small text-nowrap mt-2">2:34 am</div>
                                    </div>
                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 ml-3">
                                        <div class="font-weight-bold mb-1">Sharon Lessman</div>
                                        Sit meis deleniti eu, pri vidit meliore docendi ut, an eum erat animal commodo.
                                    </div>
                                </div>

                                <div class="chat-message-right mb-4">
                                    <div>
                                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png"
                                             class="rounded-circle mr-1" alt="Chris Wood" width="40" height="40">
                                        <div class="text-muted small text-nowrap mt-2">2:35 am</div>
                                    </div>
                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 mr-3">
                                        <div class="font-weight-bold mb-1">Bạn</div>
                                        Cum ea graeci tractatos.
                                    </div>
                                </div>

                                <div class="chat-message-left pb-4">
                                    <div>
                                        <img src="https://bootdey.com/img/Content/avatar/avatar3.png"
                                             class="rounded-circle mr-1" alt="Sharon Lessman" width="40" height="40">
                                        <div class="text-muted small text-nowrap mt-2">2:36 am</div>
                                    </div>
                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 ml-3">
                                        <div class="font-weight-bold mb-1">Sharon Lessman</div>
                                        Sed pulvinar, massa vitae interdum pulvinar, risus lectus porttitor magna, vitae
                                        commodo lectus mauris et velit.
                                        Proin ultricies placerat imperdiet. Morbi varius quam ac venenatis tempus.
                                    </div>
                                </div>

                                <div class="chat-message-left pb-4">
                                    <div>
                                        <img src="https://bootdey.com/img/Content/avatar/avatar3.png"
                                             class="rounded-circle mr-1" alt="Sharon Lessman" width="40" height="40">
                                        <div class="text-muted small text-nowrap mt-2">2:37 am</div>
                                    </div>
                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 ml-3">
                                        <div class="font-weight-bold mb-1">Sharon Lessman</div>
                                        Cras pulvinar, sapien id vehicula aliquet, diam velit elementum orci.
                                    </div>
                                </div>

                                <div class="chat-message-right mb-4">
                                    <div>
                                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png"
                                             class="rounded-circle mr-1" alt="Chris Wood" width="40" height="40">
                                        <div class="text-muted small text-nowrap mt-2">2:38 am</div>
                                    </div>
                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 mr-3">
                                        <div class="font-weight-bold mb-1">Bạn</div>
                                        Lorem ipsum dolor sit amet, vis erat denique in, dicunt prodesset te vix.
                                    </div>
                                </div>

                                <div class="chat-message-left pb-4">
                                    <div>
                                        <img src="https://bootdey.com/img/Content/avatar/avatar3.png"
                                             class="rounded-circle mr-1" alt="Sharon Lessman" width="40" height="40">
                                        <div class="text-muted small text-nowrap mt-2">2:39 am</div>
                                    </div>
                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 ml-3">
                                        <div class="font-weight-bold mb-1">Sharon Lessman</div>
                                        Sit meis deleniti eu, pri vidit meliore docendi ut, an eum erat animal commodo.
                                    </div>
                                </div>

                                <div class="chat-message-right mb-4">
                                    <div>
                                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png"
                                             class="rounded-circle mr-1" alt="Chris Wood" width="40" height="40">
                                        <div class="text-muted small text-nowrap mt-2">2:40 am</div>
                                    </div>
                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 mr-3">
                                        <div class="font-weight-bold mb-1">Bạn</div>
                                        Cum ea graeci tractatos.
                                    </div>
                                </div>

                                <div class="chat-message-right mb-4">
                                    <div>
                                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png"
                                             class="rounded-circle mr-1" alt="Chris Wood" width="40" height="40">
                                        <div class="text-muted small text-nowrap mt-2">2:41 am</div>
                                    </div>
                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 mr-3">
                                        <div class="font-weight-bold mb-1">Bạn</div>
                                        Morbi finibus, lorem id placerat ullamcorper, nunc enim ultrices massa, id
                                        dignissim metus urna eget purus.
                                    </div>
                                </div>

                                <div class="chat-message-left pb-4">
                                    <div>
                                        <img src="https://bootdey.com/img/Content/avatar/avatar3.png"
                                             class="rounded-circle mr-1" alt="Sharon Lessman" width="40" height="40">
                                        <div class="text-muted small text-nowrap mt-2">2:42 am</div>
                                    </div>
                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 ml-3">
                                        <div class="font-weight-bold mb-1">Sharon Lessman</div>
                                        Sed pulvinar, massa vitae interdum pulvinar, risus lectus porttitor magna, vitae
                                        commodo lectus mauris et velit.
                                        Proin ultricies placerat imperdiet. Morbi varius quam ac venenatis tempus.
                                    </div>
                                </div>

                                <div class="chat-message-right mb-4">
                                    <div>
                                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png"
                                             class="rounded-circle mr-1" alt="Chris Wood" width="40" height="40">
                                        <div class="text-muted small text-nowrap mt-2">2:43 am</div>
                                    </div>
                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 mr-3">
                                        <div class="font-weight-bold mb-1">Bạn</div>
                                        Lorem ipsum dolor sit amet, vis erat denique in, dicunt prodesset te vix.
                                    </div>
                                </div>
                                <div class="chat-message-right mb-4">
                                    <div>
                                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png"
                                             class="rounded-circle mr-1" alt="Chris Wood" width="40" height="40">
                                    </div>
                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 mr-3">
                                        <div class="font-weight-bold mb-1">Bạn</div>
                                        <span class="bg-primary text-white">Đơn yêu cầu vận chuyển<br></span>
                                        <div>
                                            <strong>Người nhận: </strong>Tuấn<br>
                                            <strong>Số điện thoại: </strong>0966535573<br>
                                            <strong>Địa chỉ đi: </strong>Hải Phòng<br>
                                            <strong>Địa chỉ đến: </strong>Bắc Giang<br>
                                            <strong>Khổi lượng: </strong>250g<br>
                                            <strong>Thời gian đưa hàng cho người vận chuyển: </strong>30/11/2023
                                            16:00<br>
                                            <strong>Ghi chú: </strong>Cho chú iphone 14<br>
                                        </div>
                                        <a href="" class="btn btn-primary" style="float: right;">Huỷ</a>
                                    </div>
                                    <div class="text-muted small text-nowrap mt-2 mx-2">2:43 am</div>
                                </div>

                                <div class="chat-message-left pb-4">
                                    <div>
                                        <img src="https://bootdey.com/img/Content/avatar/avatar3.png"
                                             class="rounded-circle mr-1" alt="Sharon Lessman" width="40" height="40">
                                    </div>
                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 ml-3">
                                        <div class="font-weight-bold mb-1">Sharon Lessman</div>
                                        Sit meis deleniti eu, pri vidit meliore docendi ut, an eum erat animal commodo.
                                    </div>
                                    <div class="text-muted small text-nowrap mt-2 mx-2">2:44 am</div>
                                </div>
                                <div class="chat-message-left pb-4">
                                    <div>
                                        <img src="https://bootdey.com/img/Content/avatar/avatar3.png"
                                             class="rounded-circle mr-1" alt="Sharon Lessman" width="40" height="40">
                                        <div class="text-muted small text-nowrap mt-2">2:44 am</div>
                                    </div>
                                    <div class="flex-shrink-1 bg-light rounded py-2 px-3 mr-3">
                                        <div class="font-weight-bold mb-1">Sharon Lessman</div>
                                        <span class="bg-success text-white">Đơn yêu cầu nhận vận chuyển<br></span>
                                        <div>
                                            <strong>Người nhận: </strong>Tuấn<br>
                                            <strong>Số điện thoại: </strong>0966535573<br>
                                            <strong>Địa chỉ đi: </strong>Hải Phòng<br>
                                            <strong>Địa chỉ đến: </strong>Bắc Giang<br>
                                            <strong>Khổi lượng: </strong>250g<br>
                                            <strong>Thời gian đưa hàng cho người vận chuyển: </strong>30/11/2023
                                            16:00<br>
                                            <strong>Ghi chú: </strong>Cho chú iphone 14<br>
                                        </div>
                                        <div style="float: right;">
                                            <a href="" class="btn btn-primary">Huỷ</a>
                                            <a href="" class="btn btn-success">Nhận đơn</a>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="flex-grow-0 py-3 px-4 border-top">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Nhập tin nhắn">
                                <button class="btn btn-primary" type="button" onclick="">Gửi</button>
                            </div>
                        </div>
                    </div>
                    <!-- Người 3 -->
                    <div class="tab-pane fade" id="v-pills-messages" role="tabpanel"
                         aria-labelledby="v-pills-profile-tab">
                        <div class="d-flex justify-content-between p-3" style="border-bottom: 1px solid #ccc;">
                            <div class="d-flex align-items-center">
                                <img src="../assets/img/29.jpg" class="rounded-circle mx-2" width="40" height="40"
                                     alt="">
                                <span><strong><a href="./profile.html">Phùng Ánh</a></strong></span>
                            </div>
                            <div class="">
                                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modal-order">
                                    Điền đơn
                                </button>
                            </div>
                        </div>
                        <div class="position-relative" style="background-color: #E5F2FF;">
                            <div class="chat-messages p-4">

                            </div>
                        </div>

                        <div class="flex-grow-0 py-3 px-4 border-top">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Nhập tin nhắn">
                                <button class="btn btn-primary">Gửi</button>
                            </div>
                        </div>
                    </div>
                    <!-- button chat -->
                    <div class="tab-pane fade" id="v-pills-messages" role="tabpanel"
                         aria-labelledby="v-pills-messages-tab">...
                    </div>
                    <div class="tab-pane fade" id="v-pills-settings" role="tabpanel"
                         aria-labelledby="v-pills-settings-tab">...
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal điền đơn -->
    <div class="container" id="delivery-form-container">
        <div class="modal fade" id="modal-order" tabindex="-1" aria-labelledby="modal-orderLabel" aria-hidden="true">
            <div class="modal-dialog" style="min-width: 1000px; ">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modal-orderLabel">Điền đơn mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form method="post" id="deli-form" oninput="phone_number.setCustomValidity(phone_number.value.length > 12 || phone_number.value.length === 0? 'Vui lòng nhập đúng định dạng số điện thoại' : '')">
                            <div class="mb-3">
                                <label for="goods-name" class="col-form-label">Nhập tên hàng hóa</label>
                                <input type="text" class="form-control" name="goods-name" id="goods-name"
                                       placeholder="Nhập tên hàng hóa" required>
                            </div>
                            <div class="mb-3">
                                <label for="receiver" class="col-form-label">Nhập tên người nhận</label>
                                <input type="text" class="form-control" name="receiver" id="receiver"
                                       placeholder="Nhập tên người nhận" required>
                            </div>
                            <div class="mb-3">
                                <label for="phone-number" class="col-form-label">Số điện thoại</label>
                                <input type="text" class="form-control" name="phone_number" id="phone-number"
                                       placeholder="Nhập số điện thoại" required>
                            </div>
                            <div class="mb-3">
                                <label for="address" class="col-form-label">Địa điểm đến</label>
                                <input type="text" class="form-control" name="address" id="address"
                                       placeholder="Nhập địa điểm đến" required>
                            </div>
                            <div class="mb-3">
                                <label for="deli-note" class="col-form-label">Nhập ghi chú</label>
                                <textarea class="form-control" name="deli-note" id="deli-note" placeholder="Nhập ghi chú..."
                                          rows="3" required></textarea>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" data-bs-dismiss="modal"
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
    <div class="container">
        <div class="modal fade" id="required-order" tabindex="-1" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog" style="min-width: 1200px; ">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Đơn chờ xác nhận</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="pills-home-tab" data-bs-toggle="pill"
                                        data-bs-target="#pills-home" type="button" role="tab" aria-controls="pills-home"
                                        aria-selected="true">Đơn yêu cầu nhận
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="pills-profile-tab" data-bs-toggle="pill"
                                        data-bs-target="#pills-profile" type="button" role="tab"
                                        aria-controls="pills-profile" aria-selected="false">Đơn yêu cầu chuyển
                                </button>
                            </li>
                        </ul>
                        <div class="tab-content" id="pills-tabContent">
                            <div class="tab-pane fade show active" id="pills-home" role="tabpanel"
                                 aria-labelledby="pills-home-tab">
                                <table class="table table-bordered">
                                    <thead>
                                    <tr>
                                        <th scope="col" style="max-width: 8%; width: 8%;" class="text-center">Mã đơn
                                            chờ
                                        </th>
                                        <th scope="col" style="max-width: 20%; width: 20%;" class="text-center">Người
                                            nhận
                                        </th>
                                        <th scope="col" style="max-width: 10%; width: 10%;" class="text-center">Số điện
                                            thoại
                                        </th>
                                        <th scope="col" style="max-width: 30%; width: 30%;" class="text-center">Địa
                                            chỉ
                                        </th>
                                        <th scope="col" style="max-width: 10%; width: 10%;" class="text-center">Trạng
                                            thái
                                        </th>
                                        <th scope="col" style="max-width: 10%; width: 10%;" class="text-center">Chi
                                            tiết
                                        </th>
                                        <th scope="col" style="max-width: 12%; width: 12%;" class="text-center">Huỷ</th>
                                        <th scope="col" style="max-width: 12%; width: 12%;" class="text-center">Chấp
                                            nhận
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <th class="text-center">D001</th>
                                        <td><img src="../assets/img/101.jpg" alt="mdo" width="35" height="35"
                                                 class="rounded-circle" style="margin-right: 3px;">Recoon
                                        </td>
                                        <td class="text-center">0987822857</td>
                                        <td>K356 Ngũ Hành Sơn, phường Mỹ An, quận Ngũ Hành Sơn, thành phố Đà Nẵng.</td>
                                        <td class="text-center">Đang chuyển</td>
                                        <td class="text-center"><a href="./order_detail.html">
                                            <button type="button" class="btn btn-primary">Chi tiết</button>
                                        </a></td>
                                        <td class="text-center">
                                            <button type="button" class="btn btn-success" data-bs-toggle="modal"
                                                    data-bs-target="#exampleModal">Đánh giá
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="text-center">D001</th>
                                        <td><img src="../assets/img/101.jpg" alt="mdo" width="35" height="35"
                                                 class="rounded-circle" style="margin-right: 3px;">Recoon
                                        </td>
                                        <td class="text-center">0987822857</td>
                                        <td>K356 Ngũ Hành Sơn, phường Mỹ An, quận Ngũ Hành Sơn, thành phố Đà Nẵng.</td>
                                        <td class="text-center">Đang chuyển</td>
                                        <td class="text-center"><a href="./order_detail.html">
                                            <button type="button" class="btn btn-primary">Chi tiết</button>
                                        </a></td>
                                        <td class="text-center">
                                            <button type="button" class="btn btn-success" data-bs-toggle="modal"
                                                    data-bs-target="#exampleModal">Đánh giá
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="text-center">D001</th>
                                        <td><img src="../assets/img/101.jpg" alt="mdo" width="35" height="35"
                                                 class="rounded-circle" style="margin-right: 3px;">Recoon
                                        </td>
                                        <td class="text-center">0987822857</td>
                                        <td>K356 Ngũ Hành Sơn, phường Mỹ An, quận Ngũ Hành Sơn, thành phố Đà Nẵng.</td>
                                        <td class="text-center">Đang chuyển</td>
                                        <td class="text-center"><a href="./order_detail.html">
                                            <button type="button" class="btn btn-primary">Chi tiết</button>
                                        </a></td>
                                        <td class="text-center">
                                            <button type="button" class="btn btn-success" data-bs-toggle="modal"
                                                    data-bs-target="#exampleModal">Đánh giá
                                            </button>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="tab-pane fade" id="pills-profile" role="tabpanel"
                                 aria-labelledby="pills-profile-tab">

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    -->
</main>
<!-- Footer Start -->
<div class="container-fluid footer bg-dark wow fadeIn" data-wow-delay=".3s">
    <div class="container pt-5 pb-4">
        <div class="row g-5">
            <div class="col-lg-3 col-md-6">
                <a href="index.html">
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
<script>
    const chatWindow = document.getElementById("chat-message");
    chatWindow.scrollTop = chatWindow.scrollHeight;

    setInterval(function (){
        getMessage();
        getChatNameList();
    }, 5000);


    $(document).on("click", "#button-deleteImage", function () {
        $("#customFile2").val('');
        $("#selectedAvatar2").slideUp();
        $("#button-deleteImage").hide();
    });

    $("#deli-form").submit(function (e){
        const $form = $(this);
        const Data = new FormData($form[0]);

        $.ajax({
            url: "/Forum/Chat/CreateForm?user=${requestScope.username}",
            type: "POST",
            data: Data,
            contentType : false,
            processData : false,
            success: function (response){
                $("#chat-message").html(response);
                $("#modal-order").modal("hide");
                $("#chat-message").scrollTop($("#chat-message")[0].scrollHeight);
            }
        });

        e.preventDefault();
    })

    $(document).on("submit", "#send-message", function (event) {
        const $form = $(this);
        const formData = new FormData($form[0]);  // Create FormData object from the form

        $.ajax({
            url: $form.attr("action"),
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            success: function (response) {
                $("#chat-message").html(response);
                $("#chat-message").scrollTop($("#chat-message")[0].scrollHeight);
                $("#text").val("");
                $("#customFile2").val('');
                $("#selectedAvatar2").slideUp();
                $("#button-deleteImage").hide();
                getChatNameList();
            }
        });
        event.preventDefault();
    });

    function getMessage() {
        $.ajax({
            url:"/Forum/Chat/?user=${requestScope.username}",
            type: "POST",
            success: function (response) {
                $("#chat-message").html(response);
                if (($("#chat-message").scrollTop()/($("#chat-message")[0].scrollHeight)*100 > 60)){
                    $("#chat-message").scrollTop($("#chat-message")[0].scrollHeight);
                }

            },
        });
    }

    function getChatNameList(){
        $.ajax({
           url:"/Forum/Chat/UpdateChatList",
           type: "POST",
            success: function (response) {
                $("#v-pills-tab").html(response);
            },
        });
    }

    function acceptDeli(id){
        $.ajax({
            url : "/Forum/Chat/ChangeState?id="+id+"&user=${requestScope.username}",
            type: "POST",
            success: function (response){
                $("#chat-message").html(response);
                $("#chat-message").scrollTop($("#chat-message")[0].scrollHeight);
                alert("Đã nhận đơn hàng");
                // alert(response);
            }
        })
    }

</script>
</body>

</html>