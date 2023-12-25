package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.BEAN.NotifyBEAN;
import model.BEAN.PostBEAN;
import model.BEAN.TopicBEAN;
import model.BEAN.UserBEAN;
import model.BO.NotifyBO;
import model.BO.PostBO;
import model.BO.TopicBO;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;

@WebServlet("/Post/*")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2 MB
        maxFileSize = 1024 * 1024 * 10,        // 10 MB
        maxRequestSize = 1024 * 1024 * 50      // 50 MB
)
public class PostServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserBEAN user = (UserBEAN) session.getAttribute("user");
        // Notify
        NotifyBO notifyBO = new NotifyBO();
        ArrayList<NotifyBEAN> listNotify = new ArrayList<>();
        if(user.getRole().equals("admin")){
            listNotify = notifyBO.getAllNotifyRoleAdmin(user.getUsername());
        } else{
            listNotify = notifyBO.getAllNotifyRoleUser(user.getUsername());
        }
        req.setAttribute("listNotify",listNotify);
        String action = req.getPathInfo().substring(1);
        switch (action){
            case "Info":
                try{
                    PostBO postBO = new PostBO();
                    int postID = Integer.parseInt(req.getParameter("postID"));
                    int topicID = postBO.getTopicIdOfPost(postID);

                    int pageNumber = postBO.getTopicPageNumber(topicID);
                    int pageIndex = postBO.getPostPageIndex(topicID,postID);
                    //

                    TopicBO topicBO = new TopicBO();
                    TopicBEAN topicBEAN = topicBO.getTopicById(topicID);
                    ArrayList<PostBEAN> list = postBO.getAllPostInTopicByPage(topicID,pageIndex);

                    req.setAttribute("postID",postID);
                    req.setAttribute("pageIndex",pageIndex);
                    req.setAttribute("pageNumber",pageNumber);
                    req.setAttribute("topic",topicBEAN);
                    req.setAttribute("listPost",list);
                    req.getRequestDispatcher("../view/post.jsp").forward(req,resp);
                }catch (Exception e){
                    e.printStackTrace();
                }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserBEAN user = (UserBEAN) session.getAttribute("user");
        String action = req.getPathInfo().substring(1);
        switch (action) {
            case "Add":
                try {
                    String from_user = user.getUsername();
                    int topic_id = Integer.parseInt(req.getParameter("topicID"));
                    String content = req.getParameter("post-content-text");
                    Timestamp createTime = Timestamp.valueOf(LocalDateTime.now());
                    Integer post_id= null;
                    if(!req.getParameter("idPostTo").equals("")) {
                        post_id = Integer.valueOf(req.getParameter("idPostTo"));
                    }

                    // Thêm post và image của post
                    Collection<Part> fileParts = req.getParts();
                    ArrayList<String> imageList = new ArrayList<>();
                    for(Part file:fileParts) {
                        String originalFileName = file.getSubmittedFileName();
                        if(originalFileName!=null && !originalFileName.isEmpty()) {
                            String img = System.currentTimeMillis() + originalFileName;
                            String uploadPath="E:/giao_trinh/pbl4/img/" + img;
                            FileOutputStream fos = new FileOutputStream(uploadPath);
                            InputStream is = file.getInputStream();

                            byte[] data = new byte[is.available()];
                            is.read(data);
                            fos.write(data);
                            fos.close();

                            imageList.add(img);
                        }
                    }

                    PostBEAN postBEAN = new PostBEAN(from_user, topic_id, content,createTime,imageList,post_id);
                    PostBO postBO = new PostBO();
                    postBO.addPost(postBEAN);

                    // Lấy id của post mới thêm
                    int newId = postBO.getPostIdNewAdd();

                    // Add Notify cho tất cả những người trong topic trừ người add post mới
                    ArrayList<String> listUsername = postBO.getAllUsernameInTopicExceptFromUser(topic_id,from_user);

                    if(listUsername.isEmpty()){
                        // Nếu không người nào khác trong topic thì Load lại trang topic sau khi thêm post
                        int topicPageNumber = postBO.getTopicPageNumber(topic_id);
//                        resp.sendRedirect( req.getContextPath()+"/Topic/Info?topicID="+topic_id+"&pageIndex="+topicPageNumber);
                        resp.sendRedirect(req.getContextPath()+"/Post/Info?postID="+newId);
//                        href="${pageContext.request.contextPath}/Post/Info?postID=<%=notify.getTo_post_id()%>"
                    }
                    else {
                        ArrayList<NotifyBEAN> listNotify2 = new ArrayList<>();
                        for (String username : listUsername){
                            NotifyBEAN notify = new NotifyBEAN();
                            notify.setFrom_user(from_user);
                            notify.setTo_user(username);
                            notify.setTo_post_id(newId);
                            notify.setIs_read(false);
                            notify.setCreate_time(Timestamp.valueOf(LocalDateTime.now()));
                            notify.setContext(content);
                            notify.setNotify_type_id(4);
                            listNotify2.add(notify);
                        }
                        req.setAttribute("listNotify",listNotify2);
//                        req.setAttribute("topicId",topic_id);
                        req.setAttribute("postID",newId);
                        req.getRequestDispatcher("/Notify/AddNotifyNewPost").forward(req,resp);
                    }


                }catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            case "Update":
                try {
                    int topicId = Integer.parseInt(req.getParameter("update-topic-id"));
                    int postId = Integer.parseInt(req.getParameter("update-post-id"));
                    String content = req.getParameter("update-post-content");
                    Timestamp editTime = Timestamp.valueOf(LocalDateTime.now());


                    Collection<Part> fileParts = req.getParts();
                    ArrayList<String> imageList = new ArrayList<>();
                    for(Part file:fileParts) {
                        String originalFileName = file.getSubmittedFileName();
                        if(originalFileName!=null && !originalFileName.isEmpty()) {
                            String img = System.currentTimeMillis() + originalFileName;
                            String uploadPath="E:/giao_trinh/pbl4/img/" + img;
                            FileOutputStream fos = new FileOutputStream(uploadPath);
                            InputStream is = file.getInputStream();

                            byte[] data = new byte[is.available()];
                            is.read(data);
                            fos.write(data);
                            fos.close();

                            imageList.add(img);
                        }
                    }

                    PostBEAN post = new PostBEAN();
                    post.setId(postId);
                    post.setContent(content);
                    post.setEdit_time(editTime);
                    post.setImageList(imageList);

                    PostBO postBO = new PostBO();
                    postBO.updatePost(post);
                    resp.sendRedirect( req.getContextPath()+"/Topic/Info?topicID="+topicId+"&pageIndex=1");

                }catch (Exception e){
                    e.printStackTrace();
                }
                break;
            case "Delete":
                try {
                    int postID = Integer.parseInt(req.getParameter("delete-postId"));
                    PostBO postBO = new PostBO();
                    postBO.deletePost(postID);

                    int topicID = Integer.parseInt(req.getParameter("topicId"));
                    resp.sendRedirect(req.getContextPath()+"/Topic/Info?topicID="+topicID+"&pageIndex=1");
                }catch (Exception e) {
                    e.printStackTrace();
                }
                break;
        }
    }
}
