package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.BEAN.UserBEAN;
import model.BO.ProfileBO;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

@WebServlet("/Profile/*")
@MultipartConfig()
public class ProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //Return to homepage if no user found
        HttpSession session = req.getSession(false);
        try{
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
            }
        } catch (Exception e) {
           resp.sendRedirect("../../Forum");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //Return to homepage if no user found
        HttpSession session = req.getSession(false);
        ProfileBO profileBO = new ProfileBO();
        try{
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
                    System.out.println(img);
                    if (user.getAvatar() == null || !file.getSubmittedFileName().equals("")){
                        img = file.getSubmittedFileName().equals("") ?  "" : System.currentTimeMillis() + file.getSubmittedFileName();
                        System.out.println(img);
                        if (!img.equals("")){
                            uploadPath = "E:/giao_trinh/pbl4/img/" + img;
                            FileOutputStream fos = new FileOutputStream(uploadPath);
                            InputStream is = file.getInputStream();

                            byte[] data = new byte[is.available()];
                            is.read(data);
                            fos.write(data);
                            fos.close();
                        }
                    }
                    UserBEAN userBean = new UserBEAN(username, name, email, role, img, description);
                    profileBO.updateProfile(userBean);
                    session.setAttribute("user", userBean);
                    resp.sendRedirect("../Home/");
                    break;
                case "UpdatePassword":
                    UserBEAN userBEAN = (UserBEAN) session.getAttribute("user");
                    username = userBEAN.getUsername();
                    if (!profileBO.updatePassword(username, req.getParameter("password"), req.getParameter("new_password"))) {
                        boolean ajax = "XMLHttpRequest".equals(req.getHeader("X-Requested-With"));
                        if (ajax){
                            resp.getWriter().write("wrong password");
                        }
                    }
                    break;
            };
        } catch (Exception e) {
           resp.sendRedirect("../../Forum");
        }
    }
}
