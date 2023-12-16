package model.BO;

import model.BEAN.UserBEAN;
import model.DAO.AuthenticateDAO;
import org.mindrot.jbcrypt.BCrypt;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class AuthenticateBO {
    AuthenticateDAO authenticateDAO = new AuthenticateDAO();

    public boolean verify(String username, String password) throws Exception {
        return authenticateDAO.verifyUser(username, password);
    }
    public UserBEAN getUserDetail(String username) throws Exception {
        return authenticateDAO.getUserDetail(username);
    }
    public void signUp(String username, String password) throws Exception {
        authenticateDAO.signUp(username, BCrypt.hashpw(password, BCrypt.gensalt()));
    }

    public boolean isExistedUsername(String username) throws Exception{
        return authenticateDAO.isExistedUsername(username);
    }
    /////////////////// Xử phạt
    public boolean CheckPunished(String UserName) throws Exception {
        boolean Check = true;
        UserBEAN user = authenticateDAO.CheckPunishedByUserName(UserName);
        String limit_id = user.getLimitId();
        String limit_started = user.getLimitStart();

        if(limit_id == null || limit_started == null){

            return true;
        }
        switch (limit_id){
            case "1":

                LocalDateTime DateTime = GetLocalDateTime(limit_started);
                LocalDateTime LimitDateTime = DateTime.plusDays(7);
                LocalDateTime CurentDateTime = LocalDateTime.now();
                Check = CurrentLimit(UserName,CurentDateTime,LimitDateTime);


                break;
            case "2":
                Check =false;
                break;
            case "3":
                DateTime = GetLocalDateTime(limit_started);
                LimitDateTime = DateTime.plusDays(1);
                CurentDateTime = LocalDateTime.now();
                Check = CurrentLimit(UserName,CurentDateTime,LimitDateTime);

                break;
        }


        return Check;
    }
    public boolean CurrentLimit(String UserName, LocalDateTime CurrentDateTime, LocalDateTime LimitDateTime) throws Exception {
        if (CurrentDateTime.isBefore(LimitDateTime)) {

            return false;
        } else if (CurrentDateTime.isAfter(LimitDateTime)) {
            authenticateDAO.StopPunished(UserName);
            return  true;
        } else {
            authenticateDAO.StopPunished(UserName);
            return true;
        }
    }

    public LocalDateTime GetLocalDateTime(String st){

        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        LocalDateTime localDateTime = LocalDateTime.parse(st, dateTimeFormatter);
        return localDateTime;
    }
}
