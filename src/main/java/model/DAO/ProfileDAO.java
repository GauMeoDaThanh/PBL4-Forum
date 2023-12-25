package model.DAO;

import model.BEAN.ProfileBEAN;
import model.BEAN.UserBEAN;
import model.BO.ProfileBO;

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

        preparedStatement.close();
        conn.close();
    }

    public String getPassword(String username) throws Exception{
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("Select password from user where username = ?");
        preparedStatement.setString(1, username);
        ResultSet rs = preparedStatement.executeQuery();
        rs.next();
        String password = rs.getString("password");

        rs.close();
        preparedStatement.close();
        conn.close();
        return password;
    }
    public void updatePassword(String username, String password) throws Exception {
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("UPDATE user set password = ? where username = ?");
        preparedStatement.setString(1, password);
        preparedStatement.setString(2, username);
        preparedStatement.executeUpdate();
        preparedStatement.close();
        conn.close();
    }

    public boolean isValidUser(String username) throws Exception{
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("select * from user where username = ?");
        preparedStatement.setString(1, username);
        ResultSet rs = preparedStatement.executeQuery();
        return rs.next();
    }
    public ProfileBEAN getUser(String username) throws Exception {
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("select count(delivery.id) as num_deli, avg(rate.point) as point, user.username," +
                " user.name, user.email, user.description, user.avatar from user left join delivery on user.username = delivery.user_take left join rate on user.username = rate.to_user " +
                "where user.username = ?");
        preparedStatement.setString(1, username);
        ResultSet rs = preparedStatement.executeQuery();
        rs.next();
        return new ProfileBEAN(rs.getString("username"), rs.getString("name"),
                rs.getString("email"), rs.getString("description"),
                rs.getInt("num_deli"), rs.getDouble("point"), rs.getString("avatar"));
    }
}
