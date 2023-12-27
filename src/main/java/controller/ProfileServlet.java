package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.BEAN.*;
import model.BO.*;

import java.io.EOFException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

@WebServlet("/Profile/*")
@MultipartConfig()
public class ProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        ProfileBO profileBO = new ProfileBO();
        try {
            String action = req.getPathInfo().substring(1);
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
            switch (action) {
                case "Register":
                    req.getRequestDispatcher("../view/register_profile.jsp").forward(req, resp);
                    break;
                case "Update":
                    req.getRequestDispatcher("../view/change_profile.jsp").forward(req, resp);
                    break;
                case "UpdatePassword":
                    req.getRequestDispatcher("../view/change_password.jsp").forward(req, resp);
                    break;
                case "Info":
                    if (session.getAttribute("user") == null) throw new Exception();
                    String username = req.getParameter("username");
                    ProfileBEAN userInfo = profileBO.getUserInfo(username);

                    TopicBO topicBO = new TopicBO();

                    int modView = 1;
                    int pageNumber = topicBO.getTopicPageNumberByUsername(username);
                    int pageIndex = 1;
                    ArrayList<TopicBEAN> listTopic = topicBO.getAllTopicByUsername(username,pageIndex);

                    if (userInfo != null) {
                        req.setAttribute("modView",modView);
                        req.setAttribute("pageNumber",pageNumber);
                        req.setAttribute("pageIndex",pageIndex);
                        req.setAttribute("userInfo", userInfo);
                        req.setAttribute("listTopic",listTopic);
                        req.setAttribute("listRate",null);
                        req.getRequestDispatcher("../view/profile.jsp").forward(req, resp);
                    } else {

                    }
                    break;
                case "InfoProfile":
                    String username2 = req.getParameter("username");
                    ProfileBEAN userInfo2 = profileBO.getUserInfo(username2);

                    TopicBO topicBO2 = new TopicBO();
                    RatingBO ratingBO2 = new RatingBO();

                    int modView2 = Integer.parseInt(req.getParameter("modView"));
                    int pageIndex2 = Integer.parseInt(req.getParameter("pageIndex"));

                    int pageNumber2;

                    ArrayList<TopicBEAN> listTopic2 = null;
                    ArrayList<RatingBEAN> listRate2 = null;
                    if(modView2 == 1){
                        pageNumber2 = topicBO2.getTopicPageNumberByUsername(username2);
                        listTopic2 = topicBO2.getAllTopicByUsername(username2,pageIndex2);
                    } else{
                        pageNumber2 = ratingBO2.getRatePageNumberByUsername(username2);
                        listRate2 = ratingBO2.getAllRatingByUsername(username2,pageIndex2);
                    }


                    if (userInfo2 != null) {
                        req.setAttribute("modView",modView2);
                        req.setAttribute("pageNumber",pageNumber2);
                        req.setAttribute("pageIndex",pageIndex2);
                        req.setAttribute("userInfo", userInfo2);
                        req.setAttribute("listTopic",listTopic2);
                        req.setAttribute("listRate",listRate2);
                        req.getRequestDispatcher("../view/profile.jsp").forward(req, resp);
                    } else {

                    }
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.getRequestDispatcher("../view/page_error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //Return to homepage if no user found
        HttpSession session = req.getSession(false);
        ProfileBO profileBO = new ProfileBO();
        try {
            UserBEAN user = (UserBEAN) session.getAttribute("user");
            String username;
            String action = req.getPathInfo().substring(1);
            switch (action) {
                case "Update":
                    String name = req.getParameter("name");
                    String email = req.getParameter("email");
                    String description = req.getParameter("description");
                    username = user.getUsername();
                    String role = user.getRole();
                    String uploadPath = null;
                    String img = user.getAvatar();
                    //save avatar to assets/img folder
                    Part file = req.getPart("avatar");
                    if (user.getAvatar() == null || !file.getSubmittedFileName().equals("")) {
                        img = file.getSubmittedFileName().equals("") ? "" : System.currentTimeMillis() + file.getSubmittedFileName();
                        if (!img.equals("")) {
                            uploadPath = "E:/giao_trinh/pbl4/img/" + img;
                            FileOutputStream fos = new FileOutputStream(uploadPath);
                            InputStream is = file.getInputStream();

                            byte[] data = new byte[is.available()];
                            is.read(data);
                            fos.write(data);
                            fos.close();
                        }
                    }
                    UserBEAN userBean = new UserBEAN(username, name, email, role, img.equals("") ? "29.jpg" : img, description);
                    profileBO.updateProfile(userBean);
                    session.setAttribute("user", userBean);
                    resp.sendRedirect("../Home/");

                    break;
                case "UpdatePassword":
                    UserBEAN userBEAN = (UserBEAN) session.getAttribute("user");
                    username = userBEAN.getUsername();
                    boolean ajax = "XMLHttpRequest".equals(req.getHeader("X-Requested-With"));
                    if (ajax) {
                        if (!profileBO.updatePassword(username, req.getParameter("password"), req.getParameter("new_password"))) {
                            resp.getWriter().write("wrong password");
                        } else {
                            resp.getWriter().write("Ok");
                        }
                    }
                    break;
            }
            ;
        } catch (Exception e) {
            resp.sendRedirect("../../Forum");
            System.out.println(e.getMessage());
        }
    }
}
