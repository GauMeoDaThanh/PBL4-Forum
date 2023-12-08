package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.BEAN.ProfileBEAN;
import model.BEAN.UserBEAN;
import model.BO.AuthenticateBO;
import model.BO.ProfileBO;

import java.io.EOFException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

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
                    System.out.println(req.getParameter("username"));
                    String username = req.getParameter("username");
                    AuthenticateBO authenticateBO = new AuthenticateBO();
                    if (session.getAttribute("user") == null) throw new Exception();
                    ProfileBEAN userInfo = profileBO.getUserInfo(username);
                    if (userInfo != null) {
                        req.setAttribute("userInfo", userInfo);
                        req.getRequestDispatcher("../view/profile.jsp").forward(req, resp);
                    } else {
                        resp.getWriter().write("User not found");
                    }
                    break;
            }
        } catch (Exception e) {
            //Return to homepage if no user found
            resp.sendRedirect("../../Forum");
            System.out.println(e.getMessage());
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
