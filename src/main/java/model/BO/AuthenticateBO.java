package model.BO;

import model.BEAN.UserBEAN;
import model.DAO.AuthenticateDAO;
import org.mindrot.jbcrypt.BCrypt;

public class AuthenticateBO {
    AuthenticateDAO authenticateDAO = new AuthenticateDAO();

    public boolean verify(String username, String password) throws Exception {
        return authenticateDAO.isExistedUser(username, password);
    }
    public UserBEAN getUserDetail(String username) throws Exception {
        return authenticateDAO.getUserDetail(username);
    }
    public void signUp(String username, String password) throws Exception {
//        String hashPass = BCrypt.hashpw(password, BCrypt.gensalt());
        authenticateDAO.signUp(username, BCrypt.hashpw(password, BCrypt.gensalt()));
    }
}
