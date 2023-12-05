package model.BO;

import model.BEAN.ProfileBEAN;
import model.BEAN.UserBEAN;
import model.DAO.ProfileDAO;
import org.mindrot.jbcrypt.BCrypt;

public class ProfileBO {

    ProfileDAO profileDAO = new ProfileDAO();

    public void updateProfile(UserBEAN userBEAN) throws Exception {
        profileDAO.updateUser(userBEAN);
    }
    public boolean updatePassword(String username, String password, String newPassword) throws Exception{
        String hashPass = profileDAO.getPassword(username);
        if (BCrypt.checkpw(password, hashPass)) {
            profileDAO.updatePassword(username, BCrypt.hashpw(newPassword, BCrypt.gensalt()));
            return true;
        }
        return false;
    }

    public ProfileBEAN getUserInfo(String username) throws Exception{
        if (profileDAO.isValidUser(username)){
            return profileDAO.getUser(username);
        }
        return null;
    }
}
