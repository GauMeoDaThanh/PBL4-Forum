package model.BO;

import model.BEAN.DeliDetailBEAN;
import model.BEAN.DeliveryBEAN;
import model.DAO.ChatDAO;
import model.DAO.DeliveryDAO;

import java.util.List;

public class DeliveryBO {
    DeliveryDAO deliveryDAO = new DeliveryDAO();
    ChatDAO chatDAO = new ChatDAO();

    public void addDeliForm(String user1, String user2, int idMessage) throws Exception{
        String deliInfo = chatDAO.getDeliInfoMessage(idMessage);
        String[] deliInfos = deliInfo.split("@@");
        DeliveryBEAN deliveryBEAN = new DeliveryBEAN(0, user1, user2, deliInfos[0], deliInfos[2], deliInfos[1], deliInfos[3], deliInfos[4], false);
        deliveryDAO.addDeliForm(user1, user2, deliveryBEAN);
    }

    public void addDeliDetail(DeliDetailBEAN deliDetailBEAN) throws Exception {
        deliveryDAO.addDeliDetail(deliDetailBEAN);
    }
    public List<DeliveryBEAN> getAllSendDeli(String username) throws Exception {
        return deliveryDAO.getAllSendDeli(username);
    }
    public List<DeliveryBEAN> getAllReceiveDeli(String username) throws Exception {
        return deliveryDAO.getAllReceiveDeli(username);
    }
    public List<DeliDetailBEAN> getDeliDetail(int deliId) throws Exception {
        return deliveryDAO.getDeliDetail(deliId);
    }

    public boolean validateTheDeliInfoAccess(int deliId, String username) throws Exception{
        List<String> userInfoDeli = deliveryDAO.getDeliUser(deliId);
        for (String user : userInfoDeli) {
            if (user.equals(username)) return true;
        }
        return false;
    }

    public DeliveryBEAN getDeliInfo(int deliId) throws Exception {
        return deliveryDAO.getDeliInfo(deliId);
    }
    public void endDeli(int deliId) throws Exception{
        deliveryDAO.endDeli(deliId);
    }
}
