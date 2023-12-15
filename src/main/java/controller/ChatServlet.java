package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.BEAN.MessageBEAN;
import model.BEAN.ProfileBEAN;
import model.BEAN.UserBEAN;
import model.BO.ChatBO;
import model.BO.DeliveryBO;
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
            ProfileBO profileBO = new ProfileBO();
            ProfileBEAN profileBEAN;
            switch (action){
                case "Info":
                    profileBEAN = profileBO.getUserInfo(req.getParameter("user"));
//                //Get username and avatar
                    req.setAttribute("userAvatar", profileBEAN.getAvatar());
                    req.setAttribute("username", profileBEAN.getUsername());
                    messages = chatBO.getMessage(user.getUsername(), req.getParameter("user"));
                    break;
                case "View":
                    String lastChatUser = chatBO.getLastChatUser(user.getUsername());
                    if (lastChatUser != null) {
                        profileBEAN = profileBO.getUserInfo(chatBO.getLastChatUser(user.getUsername()));
                        req.setAttribute("userAvatar", profileBEAN.getAvatar());
                        req.setAttribute("username", profileBEAN.getUsername());
                        messages = chatBO.getMessage(user.getUsername(), profileBEAN.getUsername());
                    }
                    break;
            }
            Map<String, String> chatNameList = chatBO.getChatNameList(user.getUsername());
            req.setAttribute("chatNameList", chatNameList);
            req.setAttribute("messages", messages);
            req.getRequestDispatcher("../view/chat.jsp").forward(req, resp);
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
            ProfileBEAN user = req.getParameter("user") != null ? new ProfileBO().getUserInfo(req.getParameter("user")) : null;
            ChatBO chatBO = new ChatBO();
            switch (action){
                case "CreateForm":
                    String goodsName = req.getParameter("goods-name");
                    String receiver = req.getParameter("receiver");
                    String phoneNumber = req.getParameter("phone_number");
                    String address = req.getParameter("address");
                    String deliNote = req.getParameter("deli-note");
                    String formInfo = goodsName + "@@" + receiver + "@@" + phoneNumber + "@@" + address + "@@" + deliNote + "@@";
                    chatBO.addMessage(new MessageBEAN(0, self.getUsername(), user.getUsername(), formInfo, null, new Timestamp(new Date().getTime()), true, false));
                    break;
                case "ChangeState":
                    int idMessage = Integer.parseInt(req.getParameter("id"));
                    chatBO.changeDeliFormState(idMessage);
                    DeliveryBO deliveryBO = new DeliveryBO();
                    deliveryBO.addDeliForm(user.getUsername(), self.getUsername(), idMessage);
                    break;
                case "Info":
                    String message = req.getParameter("text") == null ? "" : req.getParameter("text").trim();
                    String toUser = req.getParameter("user");
                    Part file = req.getPart("message-picture");
                    if (!file.getSubmittedFileName().equals("")) {
                        String img = System.currentTimeMillis() + file.getSubmittedFileName();
                        MessageBEAN messageBEAN = new MessageBEAN(0, self.getUsername(), toUser, "", img, new Timestamp(new Date().getTime()), false, false);
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
                        MessageBEAN messageBEAN = new MessageBEAN(0, self.getUsername(), toUser, message, null, new Timestamp(new Date().getTime()), false, false);
                        chatBO.addMessage(messageBEAN);
                    }
                    break;
                case "UpdateChatList":
                    System.out.println("da lay duoc chat list");
                    Map<String, String> chatNameList = chatBO.getChatNameList(self.getUsername());
                    if (chatNameList != null) {
                        for (Map.Entry<String, String> entry : chatNameList.entrySet()) {
                            resp.getWriter().println(" <a href=\""+req.getContextPath()+"/Chat/Info?user="+entry.getKey()+"\" class=\"nav-link\">\n" +
                                    "                                <div class=\"d-flex align-items-center position-relative\">");
                            if (entry.getValue().equals("")){
                                resp.getWriter().println(" <img src=\""+req.getContextPath()+"/image/29.jpg\"\n" +
                                        "                                                 class=\"rounded-circle mx-2\" width=\"40px\" height=\"40px\" alt=\"\">");
                            }else{
                                resp.getWriter().println("<img src=\""+req.getContextPath()+"/image/"+entry.getValue()+"\"\n" +
                                        "                                                 class=\"rounded-circle mx-2\" width=\"40px\" height=\"40px\" alt=\"\">");
                            }
                            resp.getWriter().println(" <span>"+entry.getKey()+"</span></div>\n" +
                                    "                            </a>");
                        }
                    }
                    return;
            }

            System.out.println("da vao day");
            List<MessageBEAN> messages = chatBO.getMessage(self.getUsername(), user.getUsername());
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
                } else if (message.getFromUser().equals(self.getUsername()) && message.isForm()){
                    String[] deliInfo = message.getMessage().split("@@");
                    resp.getWriter().println("<div class=\"chat-message-right mb-4\">\n" +
                            "                                                    <div>\n" +
                            "                                                        <img src=\""+ req.getContextPath() + "/image/" + self.getAvatar() +"\"\n" +
                            "                                                             class=\"rounded-circle mr-1\" alt=\"Chris Wood\" width=\"40\" height=\"40\">\n" +
                            "                                                    </div>\n" +
                            "                                                    <div class=\"flex-shrink-1 bg-light rounded py-2 px-3 mr-3\">\n" +
                            "                                                        <div class=\"font-weight-bold mb-1 text-end\"><strong>Bạn</strong></div>\n" +
                            "                                                        <span class=\"bg-primary text-white\">Đơn yêu cầu vận chuyển<br></span>\n" +
                            "                                                        <div>\n" +
                            "                                                            <strong>Tên hàng hóa: </strong>"+  deliInfo[0] +"<br>\n" +
                            "                                                            <strong>Người nhận: </strong>"+  deliInfo[1] +"<br>\n" +
                            "                                                            <strong>Số điện thoại: </strong>"+  deliInfo[2] +"<br>\n" +
                            "                                                            <strong>Địa chỉ đến: </strong>"+  deliInfo[3] +"<br>\n" +
                            "                                                            <strong>Ghi chú: </strong>"+  deliInfo[4] +"<br>\n" +
                            "                                                        </div>\n");
                    if (message.isFormState()){
                        resp.getWriter().println("  <span class=\"bg-primary text-white\">Đơn đã được nhận<br></span>");
                    }
                    resp.getWriter().println(" </div>\n" +
                            "                                                    <div class=\"text-muted small text-nowrap mt-2 mx-2\">"+message.getSendTime()+"</div>\n" +
                            "                                                </div>");
                } else if (message.getFromUser().equals(user.getUsername()) && message.isForm()) {
                    String[] deliInfo = message.getMessage().split("@@");
                    resp.getWriter().println("<div class=\"chat-message-left pb-4\">\n" +
                            "                                                    <div>\n" +
                            "                                                        <img src=\""+ req.getContextPath() + "/image/" + user.getAvatar() +"\"\n" +
                            "                                                             class=\"rounded-circle mr-1\" alt=\"Sharon Lessman\" width=\"40\" height=\"40\">\n" +
                            "                                                    </div>\n" +
                            "                                                    <div class=\"flex-shrink-1 bg-light rounded py-2 px-3 mr-3\">\n" +
                            "                                                        <div class=\"font-weight-bold mb-1\"><strong>"+user.getUsername()+"</strong></div>" +
                            "                                                        <span class=\"bg-success text-white\">Đơn yêu cầu nhận vận chuyển<br></span>\n" +
                            "                                                        <div>\n" +
                            "                                                            <strong>Tên hàng hóa: </strong>"+  deliInfo[0] +"<br>\n" +
                            "                                                            <strong>Người nhận: </strong>"+  deliInfo[1] +"<br>\n" +
                            "                                                            <strong>Số điện thoại: </strong>"+  deliInfo[2] +"<br>\n" +
                            "                                                            <strong>Địa chỉ đến: </strong>"+  deliInfo[3] +"<br>\n" +
                            "                                                            <strong>Ghi chú: </strong>"+  deliInfo[4] +"<br>\n" +
                            "                                                        </div>\n" +
                            "                                                        <div style=\"float: right;\">\n");
                    if (message.isFormState()){
                        resp.getWriter().println("                                                                    <span class=\"bg-success text-white\">Đã nhận đơn này<br></span>\n");
                    }else{
                        resp.getWriter().println("                                                                    <a href=\"#\" class=\"btn btn-success\" onclick=\"acceptDeli("+message.getId()+")\">Nhận đơn</a>\n");
                    }
                    resp.getWriter().println("</div>\n" +
                            "                                                    </div>\n" +
                            "                                                    <div class=\"text-muted small text-nowrap mt-2 mx-2\">"+message.getSendTime()+"</div>\n" +
                            "                                                </div>");
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());

        }
    }
}
