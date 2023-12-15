package model.BO;

import model.BEAN.NotifyBEAN;
import model.DAO.NotifyDAO;

public class NotifyBO {
    NotifyDAO notifyDAO = new NotifyDAO();
    public void addNotify(NotifyBEAN notifyBEAN) throws Exception{
        notifyDAO.addNotify(notifyBEAN);
    }
}
