package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.BEAN.PostBEAN;
import model.BEAN.TopicBEAN;
import model.BEAN.UserBEAN;
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

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo().substring(1);
        switch (action) {
            case "Add":
                try {
                    HttpSession session = req.getSession();
                    UserBEAN user = (UserBEAN) session.getAttribute("user");
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

                    // Load lại trang post sau khi thêm
                    resp.sendRedirect( req.getContextPath()+"/Topic/Info?topicID="+topic_id+"&pageIndex=1");

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
                    System.out.println(postID);
                    PostBO postBO = new PostBO();
                    postBO.deletePost(postID);

                    int topicID = Integer.parseInt(req.getParameter("topicId"));
                    System.out.println(topicID);
                    resp.sendRedirect(req.getContextPath()+"/Topic/Info?topicID="+topicID+"&pageIndex=1");
                }catch (Exception e) {
                    e.printStackTrace();
                }
                break;
        }
    }
}
