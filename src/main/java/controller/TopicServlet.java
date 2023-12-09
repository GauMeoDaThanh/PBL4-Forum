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
import java.sql.Time;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collection;

@WebServlet("/Topic/*")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2 MB
        maxFileSize = 1024 * 1024 * 10,        // 10 MB
        maxRequestSize = 1024 * 1024 * 50      // 50 MB
)
public class TopicServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action=req.getPathInfo().substring(1);
        switch (action) {
            case "receive":
                try{
                    TopicBO topicBO = new TopicBO();
                    ArrayList<TopicBEAN> list = topicBO.getAllTopicReceive();
                    req.setAttribute("listTopic",list);
                    req.getRequestDispatcher("../view/topic_receive.jsp").forward(req,resp);
                }catch (Exception e) {
                    throw new RuntimeException(e);
                }
                break;
            case "send":
                try{
                    TopicBO topicBO = new TopicBO();
                    ArrayList<TopicBEAN> list = topicBO.getAllTopicSend();
                    req.setAttribute("listTopic",list);
                    req.getRequestDispatcher("../view/topic_send.jsp").forward(req,resp);
                }catch (Exception e) {
                    throw new RuntimeException(e);
                }
                break;
            case "Info":
                try {
                    int topicID = Integer.parseInt(req.getParameter("topicID"));
                    TopicBO topicBO = new TopicBO();
                    TopicBEAN topicBEAN = topicBO.getTopicById(topicID);
                    PostBO postBO =new PostBO();
                    ArrayList<PostBEAN> list = postBO.getAllPostInTopic(topicID);
                    req.setAttribute("topic",topicBEAN);
                    req.setAttribute("listPost",list);
                    req.getRequestDispatcher("../view/post.jsp").forward(req,resp);
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }

                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo().substring(1);
        switch (action) {
            case "addNewTopic":
                try{
                    HttpSession session = req.getSession();
                    UserBEAN user  = (UserBEAN) session.getAttribute("user");

                    //
                    String from_user = user.getUsername();

                    int topicTypeId = Integer.parseInt(req.getParameter("new_topic_type_id"));
                    //
                    Timestamp createTime = Timestamp.valueOf(LocalDateTime.now());

                    String topicName = req.getParameter("new_topic_name");
                    String fromLocation = req.getParameter("new_topic_from_location");
                    String toLocation = req.getParameter("new_topic_to_location");
                    //
                    String datetime= req.getParameter("new_topic_deli_datetime");
                    LocalDateTime localDateTime = LocalDateTime.parse(datetime, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
                    Timestamp topicDeliDatetime = Timestamp.valueOf(localDateTime);
                    //

                    TopicBEAN topicBEAN = new TopicBEAN(from_user,topicTypeId,createTime,topicName,fromLocation,toLocation,topicDeliDatetime);
                    TopicBO topicBO  = new TopicBO();

                    // Thêm topic mới và Lấy topic mới thêm đó ra
                    TopicBEAN newTopic = topicBO.addTopic(topicBEAN);
                    // Thêm post và image của post
                    Collection<Part> fileParts = req.getParts();
                    ArrayList<String> imageList = new ArrayList<>();
                    for(Part file:fileParts) {
                        String originalFileName = file.getSubmittedFileName();
                        if(originalFileName!=null) {
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
                    String contentPost = req.getParameter("new_topic_content");
                    Timestamp createTimePost = newTopic.getCreate_time();

                    PostBEAN postBEAN = new PostBEAN(from_user, newTopic.getId(), contentPost,createTimePost,imageList,null);
                    PostBO postBO = new PostBO();
                    postBO.addPost(postBEAN);
                    if(topicTypeId==1) {
                        resp.sendRedirect(req.getContextPath()+"/Topic/receive");
                    } else {
                        resp.sendRedirect(req.getContextPath()+"/Topic/send");
                    }
                }catch (Exception e) {
                    throw new RuntimeException(e);
                }
                break;

        }
    }
}
