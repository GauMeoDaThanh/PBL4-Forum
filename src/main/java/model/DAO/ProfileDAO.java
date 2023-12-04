package model.DAO;

import model.BEAN.UserBEAN;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ProfileDAO {
    public Connection connectDb() throws Exception{
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/deli_forum", "root", "teamctg123");
    }
    public void updateUser(UserBEAN userBEAN) throws Exception{
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("UPDATE user set name = ?, email = ?, avatar = ?, description = ? where username = ?");
        preparedStatement.setString(1, userBEAN.getName());
        preparedStatement.setString(2, userBEAN.getEmail());
        preparedStatement.setString(3, userBEAN.getAvatar());
        preparedStatement.setString(4, userBEAN.getDescription());
        preparedStatement.setString(5, userBEAN.getUsername());

        preparedStatement.executeUpdate();
    }

    public String getPassword(String username) throws Exception{
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("Select password from user where username = ?");
        preparedStatement.setString(1, username);
        ResultSet rs = preparedStatement.executeQuery();
        rs.next();
        return rs.getString("password");
    }
    public void updatePassword(String username, String password) throws Exception {
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("UPDATE user set password = ? where username = ?");
        preparedStatement.setString(1, password);
        preparedStatement.setString(2, username);
        preparedStatement.executeUpdate();
    }
}
