package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.BEAN.DeliDetailBEAN;
import model.BEAN.DeliveryBEAN;
import model.BEAN.NotifyBEAN;
import model.BEAN.UserBEAN;
import model.BO.DeliveryBO;
import model.BO.NotifyBO;

import java.io.EOFException;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/Deli/*")
public class DeliveryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            HttpSession session = req.getSession(false);
            UserBEAN user = (UserBEAN) session.getAttribute("user");
            // Notify
            NotifyBO notifyBO = new NotifyBO();
            ArrayList<NotifyBEAN> listNotify = new ArrayList<>();
            if(user.getRole().equals("admin")){
                listNotify = notifyBO.getAllNotifyRoleAdmin(user.getUsername());
            } else{
                listNotify = notifyBO.getAllNotifyRoleUser(user.getUsername());
            }
            req.setAttribute("listNotify",listNotify);

            String action = req.getPathInfo().substring(1);
            DeliveryBO deliveryBO = new DeliveryBO();
            List<DeliveryBEAN> deliveryBEANS;
            switch (action) {
                case "Send":
                    deliveryBEANS = deliveryBO.getAllSendDeli(user.getUsername());
                    req.setAttribute("deliSendList", deliveryBEANS);
                    req.getRequestDispatcher("../view/order_send.jsp").forward(req, resp);
                    break;
                case "Receive":
                    deliveryBEANS = deliveryBO.getAllReceiveDeli(user.getUsername());
                    req.setAttribute("deliReceiveList", deliveryBEANS);
                    req.getRequestDispatcher("../view/order_receive.jsp").forward(req, resp);
                    break;
                case "Info":
                    int deliId = Integer.parseInt(req.getParameter("id"));
                    if (deliveryBO.validateTheDeliInfoAccess(deliId, user.getUsername())){
                        DeliveryBEAN deliveryBEAN = deliveryBO.getDeliInfo(deliId);
                        List<DeliDetailBEAN> deliDetailBEANS = deliveryBO.getDeliDetail(deliId);
                        req.setAttribute("deliDetail", deliDetailBEANS);
                        req.setAttribute("deliInfo", deliveryBEAN);
                        req.getRequestDispatcher("../view/order_detail.jsp").forward(req, resp);
                    }else{
                        throw new Exception();
                    }
            }
        }catch (Exception e){
            req.getRequestDispatcher("../view/page_error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            HttpSession session = req.getSession(false);
            UserBEAN user = (UserBEAN) session.getAttribute("user");
            DeliveryBO deliveryBO = new DeliveryBO();
            String deliState = req.getParameter("mode");
            DeliDetailBEAN deliDetailBEAN;
            int deliId = Integer.parseInt(req.getParameter("deliId"));
            String state;
            if (deliveryBO.validateTheDeliInfoAccess(deliId, user.getUsername())) {
                if (deliState.equals("start")) {
                    state = "Bắt đầu gửi (" + req.getParameter("start-deli") + ")";
                    deliDetailBEAN = new DeliDetailBEAN(0, deliId, state, new Timestamp(new Date().getTime()));
                } else if (deliState.equals("end")) {
                    state = "Phát thành công";
                    deliDetailBEAN = new DeliDetailBEAN(0, deliId, state, new Timestamp(new Date().getTime()));
                    deliveryBO.endDeli(deliId);
                } else {
                    state = "Đã đến địa điểm (" + req.getParameter("update-deli") + ")";
                    deliDetailBEAN = new DeliDetailBEAN(0, deliId, state, new Timestamp(new Date().getTime()));
                }
                deliveryBO.addDeliDetail(deliDetailBEAN);
                resp.sendRedirect(req.getContextPath() + "/Deli/Info?id=" + deliId);

            }else{
                throw new Exception();
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
