package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.BEAN.PostBEAN;
import model.BEAN.UserBEAN;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;

@WebServlet("/Post/*")
public class PostServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo().substring(1);
        switch (action) {
            case "add":
                try {
//                    HttpSession session  = req.getSession();
//                    UserBEAN user = (UserBEAN) session.getAttribute("user");
//                    String img="";
//                    String uploadPath = null;
//                    Part file = req.getPart("avatar");
//                    if (!file.getSubmittedFileName().equals("")) {
//                        img = System.currentTimeMillis() + file.getSubmittedFileName();
//                        uploadPath = "E:/giao_trinh/pbl4/img/" + img;
//                        FileOutputStream fos = new FileOutputStream(uploadPath);
//                        InputStream is = file.getInputStream();
//
//                        byte[] data = new byte[is.available()];
//                        is.read(data);
//                        fos.write(data);
//                        fos.close();
//                    }
//                    DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
//
//                    String from_user = user.getUsername();
//                    int topicId = Integer.parseInt(req.getParameter("newTopicID"));
//                    String content = req.getParameter("content");
//                    String createTime =  dateFormat.format(Timestamp.valueOf(LocalDateTime.now()));
//                    String editTime = null;

                }catch (Exception e) {
                    e.printStackTrace();
                }
                break;
        }
    }
}
