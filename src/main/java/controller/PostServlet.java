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
        String action =req.getPathInfo().substring(1);
        switch (action) {
            case "Delete":
                try {
                    int postID = Integer.parseInt(req.getParameter("postID"));
                    PostBO postBO = new PostBO();
                    postBO.deletePost(postID);

                    int topicID = Integer.parseInt(req.getParameter("topicID"));
                    resp.sendRedirect(req.getContextPath()+"/Topic/Info?topicID="+topicID);
                }catch (Exception e) {
                    e.printStackTrace();
                }
                break;
        }
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
//                    req.setAttribute("topicID",topic_id);
                    resp.sendRedirect( req.getContextPath()+"/Topic/Info?topicID="+topic_id);
//                    req.getRequestDispatcher("/Topic/Info?topicID="+topic_id).forward(req,resp);
//                    TopicBO topicBO = new TopicBO();
//                    TopicBEAN topicBEAN = topicBO.getTopicById(topic_id);
//
//                    ArrayList<PostBEAN> list = postBO.getAllPostInTopic(topic_id);
//
//                    req.setAttribute("topic",topicBEAN);
//                    req.setAttribute("listPost",list);
//                    req.getRequestDispatcher("../view/post.jsp").forward(req,resp);
                }catch (Exception e) {
                    e.printStackTrace();
                }
                break;
        }
    }
}
