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
        //

        String action=req.getPathInfo().substring(1);
        switch (action) {
            case "Receive":
                try{
                    TopicBO topicBO = new TopicBO();

                    int pageNumber = topicBO.getTopicPageNumberByTopicTypeId(1);
                    int pageIndex = Integer.parseInt(req.getParameter("pageIndex"));
                    ArrayList<TopicBEAN> list = topicBO.getAllTopicReceiveByPage(pageIndex);

                    req.setAttribute("pageNumber",pageNumber);
                    req.setAttribute("pageIndex",pageIndex);
                    req.setAttribute("listTopic",list);

                    req.getRequestDispatcher("../view/topic_receive.jsp").forward(req,resp);
                }catch (Exception e) {
                    throw new RuntimeException(e);
                }
                break;
            case "Send":
                try{
                    TopicBO topicBO = new TopicBO();

                    int pageNumber = topicBO.getTopicPageNumberByTopicTypeId(2);
                    int pageIndex = Integer.parseInt(req.getParameter("pageIndex"));
                    ArrayList<TopicBEAN> list = topicBO.getAllTopicSendByPage(pageIndex);

                    req.setAttribute("pageNumber",pageNumber);
                    req.setAttribute("pageIndex",pageIndex);
                    req.setAttribute("listTopic",list);

                    req.getRequestDispatcher("../view/topic_send.jsp").forward(req,resp);
                }catch (Exception e) {
                    throw new RuntimeException(e);
                }
                break;
            case "Info":
                try {
                    TopicBO topicBO = new TopicBO();
                    PostBO postBO = new PostBO();

                    //
                    int topicID = Integer.parseInt(req.getParameter("topicID"));
                    if (!topicBO.isTopicExisted(topicID)) throw new Exception();
                    int pageIndex = Integer.parseInt(req.getParameter("pageIndex"));
                    int pageNumber = postBO.getTopicPageNumber(topicID);

                    TopicBEAN topicBEAN = topicBO.getTopicById(topicID);
                    ArrayList<PostBEAN> list = postBO.getAllPostInTopicByPage(topicID,pageIndex);
                    req.setAttribute("pageIndex",pageIndex);
                    req.setAttribute("pageNumber",pageNumber);
                    req.setAttribute("topic",topicBEAN);
                    req.setAttribute("listPost",list);
                    req.getRequestDispatcher("../view/post.jsp").forward(req,resp);
                } catch (Exception e) {
                    req.getRequestDispatcher("../view/page_error.jsp").forward(req, resp);
                }
                break;
            case "Search":
                try {
                    TopicBO topicBO = new TopicBO();

                    String txtSearch = req.getParameter("txtSearch");
                    int pageIndex = Integer.parseInt(req.getParameter("pageIndex"));
                    int pageNumber = topicBO.getTopicPageNumberBySearch(txtSearch);

                    ArrayList<TopicBEAN> list = topicBO.searchTopic(txtSearch,pageIndex);
                    req.setAttribute("txtSearch",txtSearch);
                    req.setAttribute("pageIndex",pageIndex);
                    req.setAttribute("pageNumber",pageNumber);
                    req.setAttribute("listSearch",list);
                    req.getRequestDispatcher("../view/search_topic.jsp").forward(req,resp);
                    break;
                }catch (Exception e) {
                    throw new RuntimeException(e);
                }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo().substring(1);
        TopicBO topicBO;
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
                    topicBO  = new TopicBO();

                    // Thêm topic mới và Lấy topic mới thêm đó ra
                    TopicBEAN newTopic = topicBO.addTopic(topicBEAN);
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
                    String contentPost = req.getParameter("new_topic_content");
                    Timestamp createTimePost = newTopic.getCreate_time();

                    PostBEAN postBEAN = new PostBEAN(from_user, newTopic.getId(), contentPost,createTimePost,imageList,null);
                    PostBO postBO = new PostBO();
                    postBO.addPost(postBEAN);
                    if(topicTypeId==1) {
                        resp.sendRedirect(req.getContextPath()+"/Topic/Receive?pageIndex=1");
                    } else {
                        resp.sendRedirect(req.getContextPath()+"/Topic/Send?pageIndex=1");
                    }
                }catch (Exception e) {
                    throw new RuntimeException(e);
                }
                break;
            case "Update":
                try {
                    topicBO = new TopicBO();

                    int topicId = Integer.parseInt(req.getParameter("topicId"));

                    if (!topicBO.isTopicExisted(topicId)) throw new Exception();

                    String topicName = req.getParameter("update_topic_name");
                    int topicTypeId = Integer.parseInt(req.getParameter("update_topic_type_id"));
                    String topicFromLocation = req.getParameter("update_topic_from_location");
                    String topicToLocation = req.getParameter("update_topic_to_location");
                    //
                    String datetime= req.getParameter("update_topic_deli_datetime");
                    LocalDateTime localDateTime = LocalDateTime.parse(datetime, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
                    Timestamp topicDeliDatetime = Timestamp.valueOf(localDateTime);
                    //
                    Timestamp editTime = Timestamp.valueOf(LocalDateTime.now());

                    TopicBEAN topic = new TopicBEAN();
                    topic.setId(topicId);
                    topic.setTopic_name(topicName);
                    topic.setTopic_type_id(topicTypeId);
                    topic.setFrom_location(topicFromLocation);
                    topic.setTo_location(topicToLocation);
                    topic.setDeli_datetime(topicDeliDatetime);
                    topic.setEdit_time(editTime);

                    topicBO.updateTopic(topic);
                    resp.sendRedirect(req.getContextPath()+"/Topic/Info?topicID="+topicId+"&pageIndex=1");
                }catch (Exception e) {
                    req.getRequestDispatcher("../view/page_error.jsp").forward(req, resp);
                }
                break;
            case "Delete":
                try {
                    topicBO = new TopicBO();
                    int topicID = Integer.parseInt(req.getParameter("delete-topicId"));

                    if (!topicBO.isTopicExisted(topicID)) throw new Exception();

                    int topidTypeId = Integer.parseInt(req.getParameter("topicTypeId"));

                    topicBO.deleteTopicById(topicID);

                    if(topidTypeId==1) {
                        resp.sendRedirect(req.getContextPath()+"/Topic/Receive?pageIndex=1");
                    } else {
                        resp.sendRedirect(req.getContextPath()+"/Topic/Send?pageIndex=1");
                    }
                }catch (Exception e) {
                    req.getRequestDispatcher("../view/page_error.jsp").forward(req, resp);
                }
                break;
        }
    }
}
