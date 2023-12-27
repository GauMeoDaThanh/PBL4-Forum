package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.BEAN.DeliveryBEAN;
import model.BEAN.RatingBEAN;
import model.BEAN.UserBEAN;
import model.BO.DeliveryBO;
import model.BO.RatingBO;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.util.Date;

@WebServlet("/Rating/*")
@MultipartConfig()
public class RatingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            HttpSession session = req.getSession(false);
            UserBEAN user = (UserBEAN) session.getAttribute("user");
            int deliId = Integer.parseInt(req.getParameter("deliId"));
            int point = Integer.parseInt(req.getParameter("rating-point"));
            String rateComment = req.getParameter("rate-comment");
            String img = "";
            Part file = req.getPart("rate-picture");
            if (!file.getSubmittedFileName().isEmpty()) {
                img = System.currentTimeMillis() + file.getSubmittedFileName();
                String uploadPath = "E:/giao_trinh/pbl4/img/" + img;
                FileOutputStream fos = new FileOutputStream(uploadPath);
                InputStream is = file.getInputStream();

                byte[] data = new byte[is.available()];
                is.read(data);
                fos.write(data);
                fos.close();
            }

            DeliveryBEAN deliInfo = new DeliveryBO().getDeliInfo(deliId);
            RatingBEAN rate;
            if (deliInfo.getUserSend().equals(user.getUsername())){
                rate = new RatingBEAN(0, user.getUsername(), deliInfo.getUserTake(), point, rateComment, img,  new Timestamp(new Date().getTime()));
            }else{
                rate = new RatingBEAN(0, user.getUsername(), deliInfo.getUserSend(), point, rateComment, img, new Timestamp(new Date().getTime()));
            }
            RatingBO ratingBO = new RatingBO();
            ratingBO.addRate(deliId, rate);
            resp.sendRedirect(req.getContextPath() + "/Deli/"+req.getPathInfo().substring(1));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
