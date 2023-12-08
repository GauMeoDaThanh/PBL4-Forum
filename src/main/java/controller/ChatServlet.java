package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.BEAN.MessageBEAN;
import model.BEAN.ProfileBEAN;
import model.BEAN.UserBEAN;
import model.BO.ChatBO;
import model.BO.ProfileBO;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@WebServlet("/Chat/*")
@MultipartConfig()
public class ChatServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            HttpSession session = req.getSession(false);
            UserBEAN user = (UserBEAN) session.getAttribute("user");
            ChatBO chatBO = new ChatBO();
            String action = req.getPathInfo().substring(1);
            List<MessageBEAN> messages = new ArrayList<>();
            if (action.equals("Info")) {
                ProfileBO profileBO = new ProfileBO();
                ProfileBEAN profileBEAN = profileBO.getUserInfo(req.getParameter("user"));
//                //Get username and avatar
                req.setAttribute("userAvatar", profileBEAN.getAvatar());
                req.setAttribute("username", profileBEAN.getUsername());
//
                messages = chatBO.getMessage(user.getUsername(), req.getParameter("user"));
                Map<String, String> chatNameList = chatBO.getChatNameList(user.getUsername());
                req.setAttribute("chatNameList", chatNameList);
                req.setAttribute("messages", messages);
                req.getRequestDispatcher("../view/chat.jsp").forward(req, resp);
            } else {

            }
        } catch (Exception e) {
            resp.sendRedirect("../../Forum");
            System.out.println(e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getPathInfo().substring(1);
            HttpSession session = req.getSession(false);
            UserBEAN self = (UserBEAN) session.getAttribute("user");
            ProfileBEAN user = new ProfileBO().getUserInfo(req.getParameter("user"));
            ChatBO chatBO = new ChatBO();
            switch (action){
                case "CreateForm":

                    break;
                case "Info":
                    String message = req.getParameter("text") == null ? "" : req.getParameter("text").trim();
                    String toUser = req.getParameter("user");
                    Part file = req.getPart("message-picture");
                    if (!file.getSubmittedFileName().equals("")) {
                        String img = System.currentTimeMillis() + file.getSubmittedFileName();
                        MessageBEAN messageBEAN = new MessageBEAN(0, self.getUsername(), toUser, "", img, new Timestamp(new Date().getTime()), false);
                        chatBO.addMessage(messageBEAN);
                        String uploadPath = "E:/giao_trinh/pbl4/img/" + img;
                        FileOutputStream fos = new FileOutputStream(uploadPath);
                        InputStream is = file.getInputStream();

                        byte[] data = new byte[is.available()];
                        is.read(data);
                        fos.write(data);
                        fos.close();
                    }
                    if (!message.equals("")) {
                        MessageBEAN messageBEAN = new MessageBEAN(0, self.getUsername(), toUser, message, null, new Timestamp(new Date().getTime()), false);
                        chatBO.addMessage(messageBEAN);
                    }
                    break;
            }

            System.out.println("da vao day");
            List<MessageBEAN> messages = chatBO.getMessage(self.getUsername(), req.getParameter("user"));
            for (MessageBEAN message : messages) {
                if (message.getFromUser().equals(self.getUsername()) && !message.isForm()) {
                    resp.getWriter().println(" <div class=\"chat-message-right mb-4\" >\n" +
                            "                                                    <div>\n" +
                            "                                                        <img src=\""+req.getContextPath() + "/image/" + self.getAvatar() +"\"\n" +
                            "                                                             class=\"rounded-circle mr-1\" alt=\"Chris Wood\" width=\"40\" height=\"40\">\n" +
                            "                                                    </div>\n" +
                            "                                                    <div class=\"flex-shrink-1 bg-light rounded py-2 px-3 mr-3\">\n" +
                            "                                                        <div class=\"font-weight-bold mb-1 text-end\"><strong>Bạn</strong></div>");
                    if (message.getMessage() != null) {
                        resp.getWriter().println(message.getMessage());
                    } else {
                        resp.getWriter().println(" <img id=\"image\"\n" +
                                "                                                                     src=\""+ req.getContextPath() + "/image/" + message.getPicture() +"\"\n" +
                                "                                                                     class=\"\" style=\"height: 200px;\"\n" +
                                "                                                                     alt=\"example placeholder\">");
                    }
                    resp.getWriter().println(" </div>\n" +
                            "                                                    <div class=\"text-muted small text-nowrap mt-2 mx-2\"> "+ message.getSendTime()+"</div>\n" +
                            "                                                </div>");
                } else if (message.getFromUser().equals(user.getUsername()) && !message.isForm()) {
                    resp.getWriter().println(" <div class=\"chat-message-left pb-4\">\n" +
                            "                                                    <div>\n" +
                            "                                                        <img src=\""+ req.getContextPath() + "/image/" + user.getAvatar() +"\"\n" +
                            "                                                             class=\"rounded-circle mr-1\" alt=\"Sharon Lessman\" width=\"40\" height=\"40\">\n" +
                            "                                                    </div>\n" +
                            "                                                    <div class=\"flex-shrink-1 bg-light rounded py-2 px-3 ml-3\">\n" +
                            "                                                        <div class=\"font-weight-bold mb-1\"><strong>"+user.getUsername()+"</strong></div>");
                    if (message.getMessage() != null){
                        resp.getWriter().println(message.getMessage());
                    }else{
                        resp.getWriter().println(" <img id=\"image\"\n" +
                                "                                                                     src=\""+ req.getContextPath() + "/image/" + message.getPicture() +"\"\n" +
                                "                                                                     class=\"\" style=\"height: 200px;\"\n" +
                                "                                                                     alt=\"example placeholder\">");
                    }
                    resp.getWriter().println("</div>\n" +
                            "                                                    <div class=\"text-muted small text-nowrap mt-2 mx-2\"> "+message.getSendTime()+"</div>\n" +
                            "                                                </div>");
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
