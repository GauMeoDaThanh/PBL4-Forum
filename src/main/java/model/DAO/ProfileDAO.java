package model.DAO;

import model.BEAN.UserBEAN;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

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
}
