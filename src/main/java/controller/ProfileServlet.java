package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.BEAN.UserBEAN;
import model.BO.ProfileBo;
import model.DAO.ProfileDAO;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Path;
import java.util.Collection;
import java.util.Date;

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
            }
        } catch (Exception e) {
           resp.sendRedirect("../../Forum");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //Return to homepage if no user found
        HttpSession session = req.getSession(false);
        try{
            UserBEAN user = (UserBEAN) session.getAttribute("user");
            String action = req.getPathInfo().substring(1);
            switch (action) {
                case "RegisterUpdate":
                    String name = req.getParameter("name");
                    String email = req.getParameter("email");
                    String description = req.getParameter("description");
                    String username = user.getUsername();
                    String role = user.getRole();
                    String uploadPath = null;

                    //save avatar to assets/img folder
                    Part file = req.getPart("avatar");
                    String img = file.getSubmittedFileName().equals("") ?  "" : System.currentTimeMillis() + file.getSubmittedFileName();
                    System.out.println(img);
                    if (!img.equals("")){
                        uploadPath = "E:/Code file/Workspace Intelj/Java/PBL4-DeliveryForum/src/main/webapp/assets/img/" + img;
                        FileOutputStream fos = new FileOutputStream(uploadPath);
                        InputStream is = file.getInputStream();

                        byte[] data = new byte[is.available()];
                        is.read(data);
                        fos.write(data);
                        fos.close();
                    }

                    UserBEAN userBean = new UserBEAN(username, name, email, role, img, description);
                    ProfileBo profileBO = new ProfileBo();
                    profileBO.updateProfile(userBean);
                    resp.getWriter().println("xog");
            };
        } catch (Exception e) {
            resp.sendRedirect("../../Forum");
        }
    }
}
