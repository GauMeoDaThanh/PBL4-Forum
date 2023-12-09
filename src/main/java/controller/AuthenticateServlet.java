package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.BEAN.UserBEAN;
import model.BO.AuthenticateBO;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;

@WebServlet("/authenticate/*")
public class AuthenticateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo().substring(1);
        switch (action) {
            case "logout":
                HttpSession session = req.getSession(false);
                session.removeAttribute("user");
                resp.sendRedirect("../index.jsp");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo().substring(1);
        AuthenticateBO authenticateBO = new AuthenticateBO();
        switch (action){
            case "login":
                try {
                    String username = req.getParameter("username");
                    String password = req.getParameter("password");
                    if (authenticateBO.verify(username, password)) {
                        UserBEAN user = authenticateBO.getUserDetail(username);
                        HttpSession session = req.getSession();
                        session.setAttribute("user", user);
                        if (user.getName() == null) {
                            resp.sendRedirect("../Profile/Register");
                        }else{
                            resp.sendRedirect("../Home/");
                        }

                    }else{
                        resp.sendRedirect("../../Forum?alert=1");
                    }
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
                break;
            case "register":
                try{
                    String username = req.getParameter("username");
                    String password = req.getParameter("password");
                    if (!authenticateBO.isExistedUsername(username)){
                        authenticateBO.signUp(username, password);
                        UserBEAN userBEAN = authenticateBO.getUserDetail(username);
                        HttpSession session = req.getSession();
                        session.setAttribute("user", userBEAN);
                    }else {
                        boolean ajax = "XMLHttpRequest".equals(req.getHeader("X-Requested-With"));
                        if (ajax) {
                            resp.getWriter().write("trung tai khoan");
                        }
                    }
                }catch(Exception e){
                    throw new RuntimeException(e);
                }
                break;
        }


    }
}
