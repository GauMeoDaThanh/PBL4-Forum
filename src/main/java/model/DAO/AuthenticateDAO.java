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
        PreparedStatement statement = connectDb().prepareStatement("select count(*) as count from user where username = ?");
        statement.setString(1, username);
        ResultSet rs = statement.executeQuery();
        rs.next();
        if (rs.getInt("count") > 0) {
            return true;
        }
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
    }
}
