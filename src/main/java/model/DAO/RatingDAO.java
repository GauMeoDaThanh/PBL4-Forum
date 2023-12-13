package model.DAO;

import model.BEAN.RatingBEAN;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.util.Date;

public class RatingDAO {
    private Connection connectDb() throws Exception{
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/deli_forum", "root", "teamctg123");
    }
    public void addRating(int deliId, RatingBEAN rate) throws Exception{
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("insert into rate (from_user, to_user, point, note, picture, rate_time, delivery_id) values (?, ?, ?, ?, ?, ?, ?)");
        preparedStatement.setString(1, rate.getFromUser());
        preparedStatement.setString(2, rate.getToUser());
        preparedStatement.setInt(3, rate.getPoint());
        preparedStatement.setString(4, rate.getNote());
        preparedStatement.setString(5, rate.getPicture());
        preparedStatement.setTimestamp(6,  new Timestamp(new Date().getTime()));
        preparedStatement.setInt(7,  deliId);
        preparedStatement.executeUpdate();
        conn.close();
        preparedStatement.close();
    }
}
