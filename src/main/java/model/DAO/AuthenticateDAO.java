package model.DAO;

import model.BEAN.UserBEAN;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;

public class AuthenticateDAO {
    public Connection connectDb() throws Exception{
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/deli_forum", "root", "teamctg123");
    }

    public boolean verifyUser(String username, String password) throws Exception{
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("select count(*) as count, password from user where username = ?");
        preparedStatement.setString(1, username);
        ResultSet rs = preparedStatement.executeQuery();
        rs.next();
        if (rs.getInt("count") > 0){
            return BCrypt.checkpw(password, rs.getString("password"));
        }
        return false;
    }
    public boolean isExistedUsername(String username) throws Exception{
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("select count(*) as count from user where username = ?");
        preparedStatement.setString(1, username);
        ResultSet rs = preparedStatement.executeQuery();
        rs.next();
        if (rs.getInt("count") > 0) {
            conn.close();
            return true;
        }
        rs.close();
        preparedStatement.close();
        conn.close();
        return false;
    }
    public UserBEAN getUserDetail(String username) throws Exception {
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("select username, password, name, email, role_type, avatar, limit_id, limit_started, description from user join role on user.role_id = role.id \n" +
                "where username = ?");
        preparedStatement.setString(1, username);
        ResultSet rs = preparedStatement.executeQuery();
        rs.next();

        return new UserBEAN(rs.getString("username"), rs.getString("name"),
                rs.getString("email"), rs.getString("role_type"), rs.getString("avatar"), rs.getString("description"));
    }
    public void signUp(String username, String password) throws Exception {
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("insert into user (username, password, role_id) values (?, ?, 2)");
        preparedStatement.setString(1, username);
        preparedStatement.setString(2, password);
        preparedStatement.executeUpdate();

        preparedStatement.close();
        conn.close();
    }

    /////////////////////////////Xử phạt
    public UserBEAN CheckPunishedByUserName(String UserName) throws Exception {
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("select username, name, email, role_id, avatar, limit_id, limit_started, description from user where username=?");
        preparedStatement.setString(1,UserName);

        ResultSet rs = preparedStatement.executeQuery();
        while (rs.next()) {
            String userName = rs.getString("username");
            String name = rs.getString("name");
            String email = rs.getString("email");
            String role = rs.getString("role_id");
            String avatar = rs.getString("avatar");
            String limit_id = rs.getString("limit_id");
            String limit_started = rs.getString("limit_started");
            String description = rs.getString("description");
            UserBEAN user = new UserBEAN(userName, name, email, role, avatar, description);
            user.setLimitId(limit_id);
            user.setLimitStart(limit_started);

            return user;
        }
        return null;


    }

    public void StopPunished (String UserName) throws Exception {
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("update user set limit_id=null,limit_started=null where username=?");
        preparedStatement.setString(1,UserName);
        preparedStatement.executeUpdate();

        preparedStatement.close();
        conn.close();
    }
}
