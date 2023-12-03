package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.BEAN.UserBEAN;

import java.io.IOException;
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
                case "Update":
                    String name = req.getParameter("name");
                    String email = req.getParameter("email");
                    String description = req.getParameter("description");
                    String img = getFileName(req.getPart("avatar")).isEmpty() ? "" : System.currentTimeMillis() + getFileName(req.getPart("avatar"));
                    String username = user.getUsername();
                    System.out.println(username + img);
            };
        } catch (Exception e) {
            resp.sendRedirect("../../Forum");
        }
    }
    private String getFileName(Part part){
        String headers = part.getHeaders("content-disposition").toString();
        for (String content : headers.split(";")){
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1, content.length()-1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
