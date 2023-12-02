package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.BEAN.UserBEAN;
import model.BO.AuthenticateBO;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;

@WebServlet("/authenticate/*")
public class AuthenticateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
//                resp.getWriter().println(role);
                        HttpSession session = req.getSession();
                        session.setAttribute("user", user);
                        resp.sendRedirect("../Topic/");
                    }else{
                        resp.getWriter().println("cut roi");
                    }
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
                break;
            case "register":
                try{
                    String username = req.getParameter("username");
                    String password = req.getParameter("password");
//                    authenticateBO.signUp(username, password);
//                    resp.sendRedirect("../../Forum?alert=success");
                    resp.sendRedirect(BCrypt.hashpw("1", BCrypt.gensalt()));
                }catch(Exception e){
                    throw new RuntimeException(e);
                }
                break;
        }


    }
}
