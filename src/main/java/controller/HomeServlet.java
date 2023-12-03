package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.BEAN.UserBEAN;

import java.io.IOException;

@WebServlet("/Home/*")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        try {
            UserBEAN user = (UserBEAN) session.getAttribute("user");
//            System.out.println(user.getAvatar());
            req.getRequestDispatcher("../view/home.jsp").forward(req, resp);
        } catch (Exception e) {
            resp.sendRedirect("../../Forum");
        }
    }
}
