package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.BEAN.NotifyBEAN;
import model.BO.NotifyBO;
import model.BO.PostBO;
import org.json.JSONArray;

import java.io.IOException;
import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;

@WebServlet("/Notify/*")
public class NotifyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo().substring(1);
        switch (action) {
            // Add Notify Report
            case "Add": {
                try {
                    String from_user = req.getParameter("from-username");
                    String to_user = req.getParameter("to-username");
                    int notify_type_id = Integer.parseInt(req.getParameter("notify-type-id"));

                    Integer to_topic_id = null;
                    Integer to_post_id = null;
                    if (notify_type_id == 2) {
                        if (req.getParameter("topicId") != null && !req.getParameter("topicId").isEmpty()) {
                            to_topic_id = Integer.valueOf(req.getParameter("topicId"));
                        }
                    } else if (notify_type_id == 3) {
                        if (req.getParameter("postId") != null && !req.getParameter("postId").isEmpty()) {
                            to_post_id = Integer.valueOf(req.getParameter("postId"));
                        }
                    }
                    boolean is_read = true;
                    Timestamp create_time = Timestamp.valueOf(LocalDateTime.now());
                    //
                    String[] selectedReasons = req.getParameterValues("select-report-reason");
                    String otherReason = req.getParameter("report-other-reason");
                    String context="";
                    if (selectedReasons != null) {
                        int length = selectedReasons.length;
                        context += selectedReasons[0];
                        for (int i = 1; i < length; i++) {
                            context += ", " + selectedReasons[i] ;
                        }
                    }
                    if(!otherReason.equals("")){
                        if(context.equals("")){
                            context+=otherReason;
                        }else{
                            context+=", "+otherReason;
                        }
                    }

                    //
                    NotifyBEAN notify = new NotifyBEAN();
                    notify.setFrom_user(from_user);
                    notify.setTo_user(to_user);
                    notify.setTo_post_id(to_post_id);
                    notify.setTo_topic_id(to_topic_id);
                    notify.setIs_read(is_read);
                    notify.setCreate_time(create_time);
                    notify.setContext(context);
                    notify.setNotify_type_id(notify_type_id);

                    NotifyBO notifyBO = new NotifyBO();
                    notifyBO.addNotify(notify);

                    if (notify_type_id == 1) {
                        resp.sendRedirect(req.getContextPath() + "/Profile/Info?username=" + to_user);
                    } else {
                        if (req.getParameter("topicId") != null && !req.getParameter("topicId").isEmpty()) {
                            to_topic_id = Integer.valueOf(req.getParameter("topicId"));
                        }
                        resp.sendRedirect(req.getContextPath() + "/Topic/Info?topicID=" + to_topic_id + "&pageIndex=1");
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            }
            case "AddNotifyNewPost":
                try {
                    NotifyBO notifyBO = new NotifyBO();
                    ArrayList<NotifyBEAN> listNotify = (ArrayList<NotifyBEAN>) req.getAttribute("listNotify");
                    int topic_id = (int) req.getAttribute("topicId");
                    for(NotifyBEAN notify : listNotify){
                        notifyBO.addNotify(notify);
                    }

                    PostBO postBO = new PostBO();
                    int topicPageNumber = postBO.getTopicPageNumber(topic_id);
                    resp.sendRedirect(req.getContextPath() + "/Topic/Info?topicID=" + topic_id + "&pageIndex="+topicPageNumber);

                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            case "SetIsRead":
                try {
                    NotifyBO notifyBO = new NotifyBO();

                    //
                    String notifyIdJson = req.getParameter("notifyId");
                    // Parse JSON string to ArrayList
                    ArrayList<Integer> idList = new ArrayList<>();
                    if (notifyIdJson != null && !notifyIdJson.isEmpty()) {
                        JSONArray jsonArray = new JSONArray(notifyIdJson);
                        for (int i = 0; i < jsonArray.length(); i++) {
                            idList.add(jsonArray.getInt(i));
                        }
                    }
                    notifyBO.setIsReadNotify(idList);

                    // Gửi giá trị mới về trang JSP
                    resp.setContentType("text/plain");
                    resp.setCharacterEncoding("UTF-8");
                    resp.getWriter().write("successful");
                }catch (Exception e) {
                    e.printStackTrace();
                }
                break;
        }
    }
}
