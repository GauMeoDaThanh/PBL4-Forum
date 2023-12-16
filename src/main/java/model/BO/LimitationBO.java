package model.BO;

import model.BEAN.LimitationBEAN;
import model.DAO.LimitationDAO;

import java.util.ArrayList;

public class LimitationBO {
    LimitationDAO limitationDAO = new LimitationDAO();
    public int UpdateLimitation(String idLimit, String Date, String userName) throws Exception {

        return limitationDAO.UpdateLimitationDAO(idLimit,userName,Date);

    }

    public ArrayList<LimitationBEAN> GetAllTypeLimitation() throws Exception {
        return limitationDAO.GetAllTypeLimitation();
    }

}