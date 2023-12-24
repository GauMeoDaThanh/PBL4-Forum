package model.BO;

import model.BEAN.NotifyBEAN;
import model.DAO.NotifyDAO;

import java.util.ArrayList;

public class NotifyBO {
    NotifyDAO notifyDAO = new NotifyDAO();
    public void addNotify(NotifyBEAN notifyBEAN) throws Exception{
        notifyDAO.addNotify(notifyBEAN);
    }
    public ArrayList<NotifyBEAN> getAllNotifyRoleUser(String username){
        return notifyDAO.getAllNotifyRoleUser(username);
    }
    public ArrayList<NotifyBEAN> getAllNotifyRoleAdmin(String username){
        return notifyDAO.getAllNotifyRoleAdmin(username);
    }
    public void setIsReadNotify(ArrayList<Integer> notifyIdList) {
        notifyDAO.setIsReadNotify(notifyIdList);
    }
}
