package model.BO;

import model.BEAN.UserBEAN;
import model.DAO.ProfileDAO;

public class ProfileBo {

    ProfileDAO profileDAO = new ProfileDAO();

    public void updateProfile(UserBEAN userBEAN) throws Exception {
        profileDAO.updateUser(userBEAN);
    }
}
