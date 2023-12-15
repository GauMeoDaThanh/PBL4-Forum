package model.DAO;

import model.BEAN.NotifyBEAN;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Types;

public class NotifyDAO {
    public Connection connectDb() throws Exception{
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/deli_forum", "root", "teamctg123");
    }
    public void addNotify(NotifyBEAN notifyBEAN){
        try {
            Connection conn = connectDb();
            PreparedStatement preparedStatement = conn.prepareStatement("insert into notify(from_user, to_user, to_post_id, to_topic_id, is_read, create_time,context,notify_type_id) " +
                    " values (?,?,?,?,?,?,?,?) ");
            preparedStatement.setString(1, notifyBEAN.getFrom_user());
            preparedStatement.setString(2, notifyBEAN.getTo_user());
            preparedStatement.setObject(3,notifyBEAN.getTo_post_id(), Types.INTEGER);
            preparedStatement.setObject(4,notifyBEAN.getTo_topic_id(),Types.INTEGER);
            preparedStatement.setBoolean(5,notifyBEAN.isIs_read());
            preparedStatement.setTimestamp(6, notifyBEAN.getCreate_time());
            preparedStatement.setString(7, notifyBEAN.getContext());
            preparedStatement.setInt(8,notifyBEAN.getNotify_type_id());

            preparedStatement.executeUpdate();

        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
