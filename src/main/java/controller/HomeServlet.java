package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.BEAN.TopicBEAN;
import model.BEAN.UserBEAN;
import model.BO.TopicBO;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/Home/*")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        try {
            UserBEAN user = (UserBEAN) session.getAttribute("user");
            TopicBO topicBO = new TopicBO();


            ArrayList<TopicBEAN> listReceive =  topicBO.getTopicHomeReceive();
            ArrayList<TopicBEAN> listSend = topicBO.getTopicHomeSend();

            req.setAttribute("listTopicReceive",listReceive);
            req.setAttribute("listTopicSend",listSend);

            req.getRequestDispatcher("../view/home.jsp").forward(req, resp);
        } catch (Exception e) {
//            resp.sendRedirect("../../Forum");
        }
    }
}
