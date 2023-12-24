<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.BEAN.TopicBEAN" %>
<%@ page import="model.BEAN.UserBEAN" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.BEAN.PostBEAN" %>
<%@ page import="java.util.Objects" %>
<!DOCTYPE html>
<html lang="en">
<%
    UserBEAN user = (UserBEAN) session.getAttribute("user");
    // Go to Post when click post in notify
    int postID = -1;
    if(request.getAttribute("postID") != null){
        String data = request.getAttribute("postID").toString();
        if(data!=null && !data.isEmpty()){
            postID = Integer.parseInt(data);
        }
    }

    //
    int pageIndex = (int) request.getAttribute("pageIndex");
    int pageNumber = (int) request.getAttribute("pageNumber");
    TopicBEAN topic = (TopicBEAN) request.getAttribute("topic");
    ArrayList<PostBEAN> listPost = (ArrayList<PostBEAN>) request.getAttribute("listPost");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
%>
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

<body onload="goToPost(<%=postID%>)">
<!-- Navbar Start -->
<jsp:include page="header.jsp"/>
<!-- Navbar End -->
<main class="content" style="margin-top: 150px; margin-bottom: 150px;">
    <div class="container">
        <div class="mb-3">
            <h1 class="h3 mb-3 text-body"><%=topic.getTopic_name()%></h1>
            <div class="d-flex align-items-center">
                <div class="mx-2 d-flex align-items-center">
                    <i class="bi bi-person" style="font-size: larger;"></i>
                    <a href="${pageContext.request.contextPath}/Profile/Info?username=<%=topic.getFrom_user()%>" class="mx-1"><%=topic.getFrom_user()%></a>
                </div>
                <div class="mx-2 d-flex align-items-center">
                    <i class="fa-solid fa-clock" style="color: orange; font-size: large;"></i>
                    <span class="mx-1 text-dark"><strong>Bài đăng lúc: </strong><%=dateFormat.format(topic.getCreate_time())%></span>
                </div>
                <%
                    if(topic.getEdit_time()!=null) {

                %>
                <div class="mx-2 d-flex align-items-center">
                    <i class="bi bi-pen" style="color: blue; font-size: large;"></i>
                    <span class="mx-1 text-dark"><strong>Chỉnh sửa lúc: </strong><%=dateFormat.format(topic.getEdit_time())%></span>
                </div>
                <%
                    }
                %>
                <div class="mx-2 d-flex align-items-center">
                    <i class="bi bi-geo-alt-fill" style="color: red; font-size: large;"></i>
                    <span class="mx-1 text-dark" ><%=topic.getFrom_location()+" đến "+topic.getTo_location()%></span>
                </div>
                <div class="mx-2 d-flex align-items-center">
                    <i class="fa-solid fa-calendar-days" style="color: green; font-size: large;"></i>
                    <span class="mx-1 text-dark"><%=dateFormat.format(topic.getDeli_datetime())%></span>
                </div>
            </div>
        </div>
        <div class="mb-5">
            <%
                if(user.getRole().equals("admin") || user.getUsername().equals(topic.getFrom_user())){
            %>
            <button class="btn btn-danger mx-2 p-2" style="width: 120px;" data-bs-toggle="modal" data-bs-target="#confirm-delete-topic-modal">
                <i class="bi bi-trash" ></i>
                Xoá
            </button>
            <%
                }
            %>
            <%
                if(!user.getUsername().equals(topic.getFrom_user()) && !user.getRole().equals("admin")) {
            %>
            <button class="btn btn-primary mx-2 p-2" style="width: 120px;" data-bs-toggle="modal" data-bs-target="#report-topic-modal">
                <i class="bi bi-flag" ></i>
                Báo cáo
            </button>
            <%
                }
            %>
            <%
                if(user.getUsername().equals(topic.getFrom_user())){
            %>
            <button class="btn btn-success mx-2 p-2" style="width: 120px;" data-bs-toggle="modal" data-bs-target="#update-topic-modal"  onclick="getProvinceOption('select-from-location','<%=topic.getFrom_location()%>','select-to-location','<%=topic.getTo_location()%>')">
                <i class="bi bi-pen"></i>
                Chỉnh sửa
            </button>
            <%
                }
            %>
            <div class="modal fade" id="confirm-delete-topic-modal" tabindex="-1"  aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" style="min-width: 800px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="confirm-delete-topic-modalLabel">Xác nhận xoá Topic</h5>
                            <button type="reset" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <h4 class="text-center">Bạn có chắc chẵn muốn xoá Topic này.<br>Thao tác này không thể quay lại</h4>
                            <form action="${pageContext.request.contextPath}/Topic/Delete" method="post">
                                <div class="modal-footer">
                                    <input name="delete-topicId" value="<%=topic.getId()%>" type="text" style="display: none;">
                                    <input name="topicTypeId" value="<%=topic.getTopic_type_id()%>" type="text" style="display: none;">
                                    <button type="reset" class="btn btn-primary" data-bs-dismiss="modal" style="width: 80px;">Huỷ</button>
                                    <button type="submit" class="btn btn-success" style="width: 100px;">Xác nhận</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="report-topic-modal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog" style="min-width: 800px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="report-topic-modalLabel">Báo cáo Topic</h5>
                            <button type="reset" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="${pageContext.request.contextPath}/Notify/Add" method="post">
                                <div class="mb-3 d-none">
                                    <input name="from-username" value="<%=user.getUsername()%>" type="hidden">
                                    <input name="to-username" value="<%=topic.getFrom_user()%>" type="hidden">
                                    <input name="topicId" value="<%=topic.getId()%>" type="hidden">
                                    <input name="notify-type-id" value="2" type="hidden">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Chọn lý do báo cáo</label>
                                    <div class="form-check">
                                        <input name="select-report-reason" id="selected1-1" class="form-check-input" type="checkbox" value="Ngôn từ mất kiểm soát">
                                        <label class="form-check-label" for="selected1-1">Ngôn từ mất kiểm soát</label>
                                    </div>
                                    <div class="form-check">
                                        <input name="select-report-reason" id="selected1-2" class="form-check-input" type="checkbox" value="Lừa đảo">
                                        <label class="form-check-label" for="selected1-2">Lừa đảo</label>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="other-reason1" class="form-label">Lý do khác</label>
                                    <textarea name="report-other-reason" id="other-reason1" class="form-control" rows="10" placeholder="Nhập lý do khác"></textarea>
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
            <div class="modal fade" id="update-topic-modal" tabindex="-1"  aria-hidden="true">
                <div class="modal-dialog" style="min-width: 700px;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="update-topic-modalLabel">Chỉnh sửa Topic</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="${pageContext.request.contextPath}/Topic/Update" method="post">
                                <div class="mb-3 d-none">
                                    <input name="topicId" value="<%=topic.getId()%>" type="text">
                                </div>
                                <div class="mb-3">
                                    <label for="update_topic_name" class="col-form-label">Tên Topic</label>
                                    <input name="update_topic_name" value="<%=topic.getTopic_name()%>" type="text" class="form-control" id="update_topic_name" placeholder="Nhập tên Topic" required>
                                </div>
                                <div class="mb-3">
                                    <label for="select-topic-type-id" class="col-form-label">Chọn thể loại bài đăng</label>
                                    <select name="update_topic_type_id" id="select-topic-type-id" class="form-select">
                                        <%
                                            if(topic.getTopic_type_id()==1) {
                                        %>
                                        <option value="1" selected>Bài nhận vận chuyển</option>
                                        <option value="2">Bài gửi vận chuyển</option>
                                        <%
                                            }
                                            else{
                                        %>
                                        <option value="1">Bài nhận vận chuyển</option>
                                        <option value="2" selected>Bài gửi vận chuyển</option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="select-from-location" class="col-form-label">Địa điểm đi</label>
                                    <select name="update_topic_from_location" id="select-from-location" class="form-select"></select>
                                </div>
                                <div class="mb-3">
                                    <label for="select-to-location" class="col-form-label">Địa điểm đến</label>
                                    <select name="update_topic_to_location" id="select-to-location" class="form-select" ></select>
                                </div>
                                <div class="mb-3">
                                    <label for="select-datetime" class="my-2" style="display:block;">Thời gian chuyển</label>
                                    <input name="update_topic_deli_datetime"  type="datetime-local" id="select-datetime" value="<%=topic.getDeli_datetime()%>" class="form-control" required>
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
    </div>
<%--    Post Section--%>
    <div class="container">
        <%
            for (PostBEAN post:listPost) {
        %>
        <div class="row rounded border mt-3" id="<%=post.getId()%>" style="">
            <div class="col-2 p-2 text-center" style="background-color: #ccc; border-right: 1px solid #d3d5d7;">
                <img src="${pageContext.request.contextPath}/image/<%=post.getAvatar()==null  || post.getAvatar().equals("") ? "29.jpg" : post.getAvatar()%>"  class="rounded-circle mr-1 avatar-hover" alt="Vanessa Tucker" width="100" height="100">
                <div>
                    <a id="post-owner-<%=post.getId()%>" class="text-primary my-2" href="${pageContext.request.contextPath}/Profile/Info?username=<%=post.getFrom_user()%>" style="font-weight: 700; font-size: larger;"><%=post.getFrom_user()%></a>
                    <p class="text-success p-2"><%=post.getDescription()%></p>
                </div>
            </div>
            <div class="col-10 p-3" style="background-color: #E5F2FF; min-height: 100%;">
                <div class="d-flex align-items-center py-2 my-1" style="border-bottom: 1px solid #ccc;">
                    <span class="mx-1 text-dark" style="margin-right: 30px;"><%=dateFormat.format(post.getCreate_time())%></span>
                    <span class="mx-1"><%=post.getEdit_time()==null?"":"Chỉnh sửa lúc: "+dateFormat.format(post.getEdit_time())%></span>
                </div>
                <%
                    if(post.getDelete_time()==null){

                %>
                <%
                        if(post.getPost_id()!=null) {
                            if(post.getDeleteTimeOfPostReply()==null){

                %>
                                    <div style="background-color: #ccc;" class="p-3 rounded">
                                        <span class="text-dark"><strong>Trả lời <a href="${pageContext.request.contextPath}/Profile/Info?username=<%=post.getFrom_user()%>"><%=post.getTo_username()%></a>:</strong></span><br>
                                        <%=post.getContentOfPostReply()%>
                                        <br><br>
                                        <%
                                                        for (String imageName2 : post.getImageListOfPostReply()){
                                        %>
                                        <img src="${pageContext.request.contextPath}/image/<%=imageName2%>" class="mx-2" height="160" alt="image">
                                        <%

                                                        }
                                        %>
                                    </div>
                <%
                            }
                            else if(post.getDeleteTimeOfPostReply()!=null){
                %>
                                <div style="background-color: #ccc;" class="p-3 rounded">
                                    <span class="text-dark"><strong>Trả lời <a href="${pageContext.request.contextPath}/Profile/Info?username=<%=post.getFrom_user()%>"><%=post.getTo_username()%></a>:</strong></span><br>
                                    <h6 style="color: #dc3545;" class="p-4">Bài viết đã bị xoá lúc <%=dateFormat.format(post.getDeleteTimeOfPostReply())%></h6>
                                </div>
                <%
                            }
                        }
                %>
                <div id="post-content-<%=post.getId()%>" class="text-dark">
                    <%=post.getContent()%>
                    <br><br>
                    <%

                            for(String imageName:post.getImageList()) {

                    %>
                    <img src="${pageContext.request.contextPath}/image/<%=imageName%>" class="mx-2" height="160" alt="image">
                    <%
                            }
                    %>
                </div>
                <div class="mt-3 py-2" style="border-top: 1px solid #ccc;">
                    <button class="icon-hover btn" onclick="replyPost('post-owner-<%=post.getId()%>','post-content-<%=post.getId()%>','<%=post.getId()%>','owner-post-to','content-post-to','id-post-to','block-reply')">
                        <i class="bi bi-reply"></i>
                        Trả lời
                    </button>
                    <%
                        if(!post.getFrom_user().equals(user.getUsername())) {
                    %>

                    <%
                            if(!user.getRole().equals("admin")){
                    %>
                    <button class="icon-hover btn" data-bs-toggle="modal" data-bs-target="#report-post-modal-<%=post.getId()%>">
                        <i class="bi bi-flag" ></i>
                        Báo cáo
                    </button>
                    <div class="modal fade" id="report-post-modal-<%=post.getId()%>" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog" style="min-width: 800px;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="report-post-modalLabel">Báo cáo bài viết</h5>
                                    <button type="reset" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form action="${pageContext.request.contextPath}/Notify/Add" method="post">
                                        <div class="mb-3 d-none">
                                            <input name="from-username" value="<%=user.getUsername()%>" type="hidden">
                                            <input name="to-username" value="<%=topic.getFrom_user()%>" type="hidden">
                                            <input name="topicId" value="<%=topic.getId()%>" type="hidden">
                                            <input name="postId" value="<%=post.getId()%>" type="hidden">
                                            <input name="notify-type-id" value="3" type="hidden">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Chọn lý do báo cáo</label>
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
                                            <textarea name="report-other-reason" id="other-reason" class="form-control" rows="10" placeholder="Nhập lý do khác"></textarea>
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
                    <%
                            }
                            else{

                    %>
                    <button type="submit" class="icon-hover btn btn-link" style="color: #dc3545;" data-bs-toggle="modal" data-bs-target="#confirm-delete-post-modal1-<%=post.getId()%>">
                        <i class="bi bi-trash" ></i>
                        Xoá bài viết
                    </button>
                    <div class="modal fade" id="confirm-delete-post-modal1-<%=post.getId()%>" tabindex="-1"  aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered" style="min-width: 800px;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Xác nhận xoá bài viết</h5>
                                    <button type="reset" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <h4 class="text-center">Bạn có chắc chẵn muốn xoá viết này.<br>Thao tác này không thể quay lại</h4>
                                    <form action="${pageContext.request.contextPath}/Post/Delete" method="post">
                                        <input name="topicId" value="<%=topic.getId()%>" type="hidden">
                                        <input name="delete-postId" value="<%=post.getId()%>" type="hidden">
                                        <div class="modal-footer">
                                            <button type="reset" class="btn btn-primary" data-bs-dismiss="modal" style="width: 80px;">Huỷ</button>
                                            <button type="submit" class="btn btn-success" style="width: 100px;">Xác nhận</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                            }
                    %>
                    <%
                        }
                        else {
                    %>
                    <button class="icon-hover btn" data-bs-toggle="modal" data-bs-target="#update-post-modal-<%=post.getId()%>">
                        <i class="bi bi-pen"></i>
                        Chỉnh sửa
                    </button>
                    <div class="modal fade" id="update-post-modal-<%=post.getId()%>" tabindex="-1"  aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered" style="min-width: 1200px;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="update-post-modalLabel">Chỉnh sửa bài viết</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form action="${pageContext.request.contextPath}/Post/Update" method="post" enctype="multipart/form-data">
                                        <div class="mb-3" style="display: none;">
                                            <input name="update-topic-id" value="<%=topic.getId()%>" type="text">
                                            <input name="update-post-id" value="<%=post.getId()%>" type="text">
                                        </div>
                                        <div class="mb-3">

                                            <label for="formFileMultiple-<%=post.getId()%>" class="form-label">Đính kèm ảnh</label>
                                            <input name="update-post-image" id="formFileMultiple-<%=post.getId()%>" class="form-control" type="file" accept=".jpg,.png" multiple onchange="uploadImages(<%=post.getId()%>)">
                                            <div id="view-image-container-<%=post.getId()%>" class="d-flex"></div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="message-text" class="col-form-label">Nội dung chính</label>
                                            <textarea name="update-post-content" class="form-control" id="message-text" placeholder="Nhập nội dung chính" rows="10"><%=post.getContent()%></textarea>
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
                    <button type="submit" class="icon-hover btn btn-link" style="color: #dc3545;" data-bs-toggle="modal" data-bs-target="#confirm-delete-post-modal-<%=post.getId()%>">
                        <i class="bi bi-trash" ></i>
                        Xoá bài viết
                    </button>
                    <div class="modal fade" id="confirm-delete-post-modal-<%=post.getId()%>" tabindex="-1"  aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered" style="min-width: 800px;">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Xác nhận xoá bài viết</h5>
                                    <button type="reset" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <h4 class="text-center">Bạn có chắc chẵn muốn xoá viết này.<br>Thao tác này không thể quay lại</h4>
                                    <form action="${pageContext.request.contextPath}/Post/Delete" method="post">
                                        <input name="topicId" value="<%=topic.getId()%>" type="text" style="display: none;">
                                        <input name="delete-postId" value="<%=post.getId()%>" type="text" style="display: none;">
                                        <div class="modal-footer">
                                            <button type="reset" class="btn btn-primary" data-bs-dismiss="modal" style="width: 80px;">Huỷ</button>
                                            <button type="submit" class="btn btn-success" style="width: 100px;">Xác nhận</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%
                            }
                    %>
                </div>
                    <%
                        }
                        else {

                    %>
                    <!--Post bi xoa start-->
                    <%
                        if(post.getPost_id()!=null) {
                    %>
                                     <div style="background-color: #ccc;" class="p-3 rounded">
                                    <span class="text-dark"><strong>Trả lời <a href="${pageContext.request.contextPath}/Profile/Info?username=<%=post.getFrom_user()%>"><%=post.getTo_username()%></a>:</strong></span><br>
                    <%
                                    if(post.getDeleteTimeOfPostReply()==null){
                    %>
                                        <%=post.getContentOfPostReply()%>
                                        <br><br>
                    <%
                                        for (String imageName2 : post.getImageListOfPostReply()){
                    %>
                                    <img src="${pageContext.request.contextPath}/image/<%=imageName2%>" class="mx-2" height="160" alt="image">

                    <%
                                        }
                    %>
                    <%
                                    } else{
                    %>
                                    <h6 style="color: #dc3545;" class="p-4">Bài viết đã bị xoá lúc <%=dateFormat.format(post.getDeleteTimeOfPostReply())%></h6>
                    <%
                                    }
                    %>
                                </div>
                    <%
                        }
                    %>

                     <div id="post-content-<%=post.getId()%>" class="text-dark">
                        <h6 style="color: #dc3545;" class="p-4">Bài viết đã bị xoá lúc <%=dateFormat.format(post.getDelete_time())%></h6>
                     </div>

                    <!--Post bi xoa end-->
                <%
                    }
                %>
            </div>

        </div>

        <%
            }
        %>
    </div>
<%--    Pagination section--%>
    <div class="container">
        <div class="row m-4">
            <nav aria-label="Page navigation example">
                <ul class="pagination justify-content-center" id="pagination">
                    <%
                        if(pageIndex==1 || pageNumber==1){

                    %>
                    <li class="page-item disabled" id="previousPage">
                        <a class="page-link" href="#" tabindex="-1">Trước</a>
                    </li>
                    <%
                    } else{
                    %>
                    <li class="page-item" id="previousPage">
                        <a class="page-link" href="${pageContext.request.contextPath}/Topic/Info?topicID=<%=topic.getId()%>&pageIndex=<%=pageIndex-1%>" tabindex="-1">Trước</a>
                    </li>
                    <%
                        }
                    %>
                    <%--                            --%>

                    <%
                        for(int i=1;i<=pageNumber;i++) {
                            if(pageIndex==i){
                    %>
                    <li class="page-item active"><a class="page-link" href="${pageContext.request.contextPath}/Topic/Info?topicID=<%=topic.getId()%>&pageIndex=<%=i%>"><%=i%></a></li>
                    <%
                    }
                    else{

                    %>
                    <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/Topic/Info?topicID=<%=topic.getId()%>&pageIndex=<%=i%>"><%=i%></a></li>
                    <%
                        }
                    %>
                    <%
                        }
                    %>
                    <%--                            --%>
                    <%
                        if(pageIndex==pageNumber || pageNumber==1) {
                    %>
                    <li class="page-item disabled" id="nextPage">
                        <a class="page-link" href="#">Sau</a>
                    </li>
                    <%
                    } else{
                    %>
                    <li class="page-item" id="nextPage">
                        <a class="page-link" href="${pageContext.request.contextPath}/Topic/Info?topicID=<%=topic.getId()%>&pageIndex=<%=pageIndex+1%>">Sau</a>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </nav>
        </div>
    </div>
<%--    Comment section--%>
    <div class="container">
        <div class="row rounded border mt-3" id="element-focus-reply">
            <div class="col-2 p-2 text-center" style="background-color: #ccc; border-right: 1px solid #d3d5d7;">
                <img src="${pageContext.request.contextPath}/image/<%=user.getAvatar()==null  || user.getAvatar().equals("") ? "29.jpg" : user.getAvatar()%>"  class="rounded-circle mr-1 avatar-hover" alt="Vanessa Tucker" width="100" height="100">
                <div>
                    <a class="text-primary my-2" href="${pageContext.request.contextPath}/Profile/Info?username=<%=user.getUsername()%>" style="font-weight: 700; font-size: larger;"><%=user.getUsername()%></a>
                    <p class="text-success p-2"><%=user.getDescription()%></p>
                </div>
            </div>

            <div class="col-10 p-3" style="background-color: #E5F2FF;">
                <form action="${pageContext.request.contextPath}/Post/Add" method="post" enctype="multipart/form-data">
                    <div id="block-reply" style="background-color: #ccc; display: none;" class="p-3 rounded">
                        <strong><span class="text-dark text-bold" >Trả lời </span><span id="owner-post-to" class="text-dark text-bold"></span>:</strong><br>
                        <div id="content-post-to"></div>
                        <input name="topicID" value="<%=topic.getId()%>" style="display:none;">
                        <input name="idPostTo" type="text" id="id-post-to" style="display: none;">
                    </div>

                    <div class="mt-3">
                        <label for="attachFile" class="text-dark" ><strong>Đính kèm ảnh</strong></label>
                        <input name="attachFile" type="file" id="attachFile" class="form-control my-2" accept=".jpg,.png" multiple>
                        <textarea name="post-content-text" class="form-control" placeholder="Nhập nội dung" rows="10" required></textarea>
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
<!-- Province API -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.26.1/axios.min.js" integrity="sha512-bPh3uwgU5qEMipS/VOmRqynnMXGGSRv+72H/N260MQeXZIK4PG48401Bsby9Nq5P5fz7hy5UGNmC/W1Z51h2GQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- Template Javascript -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>

</html>