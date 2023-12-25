package model.DAO;

import model.BEAN.NotifyBEAN;

import java.sql.*;
import java.util.ArrayList;

public class NotifyDAO {
    public Connection connectDb() throws Exception{
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/deli_forum", "root", "teamctg123");
    }
    public ArrayList<NotifyBEAN> getAllNotifyRoleUser(String username){
        try {
            Connection conn = connectDb();
            PreparedStatement preparedStatement = conn.prepareStatement("select * from notify " +
                    "inner join user " +
                    "on notify.from_user = user.username " +
                    "where notify_type_id = 4 and notify.to_user= ? " +
                    "order by create_time DESC");
            preparedStatement.setString(1,username);
            ResultSet rs = preparedStatement.executeQuery();
            ArrayList<NotifyBEAN> list = new ArrayList<>();
            while (rs.next()){
                NotifyBEAN notifyBEAN = new NotifyBEAN();
                notifyBEAN.setId(rs.getInt("id"));
                notifyBEAN.setFrom_user(rs.getString("from_user"));
                notifyBEAN.setTo_user(rs.getString("to_user"));
                notifyBEAN.setTo_post_id(rs.getInt("to_post_id"));
                notifyBEAN.setTo_topic_id(rs.getInt("to_topic_id"));
                notifyBEAN.setIs_read(rs.getBoolean("is_read"));
                notifyBEAN.setCreate_time(rs.getTimestamp("create_time"));
                notifyBEAN.setContext(rs.getString("context"));
                notifyBEAN.setNotify_type_id(rs.getInt("notify_type_id"));
                notifyBEAN.setAvatar(rs.getString("avatar"));
                list.add(notifyBEAN);
            }
            rs.close();
            preparedStatement.close();
            conn.close();
            return list;
        }catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public ArrayList<NotifyBEAN> getAllNotifyRoleAdmin(String username){
        try {
            Connection conn = connectDb();
            PreparedStatement preparedStatement = conn.prepareStatement("select * from notify " +
                    "inner join user " +
                    "on notify.from_user = user.username " +
                    "where notify_type_id < 4 " +
                    "or (notify_type_id = 4 and to_user= ? ) " +
                    "order by create_time DESC");
            preparedStatement.setString(1,username);
            ResultSet rs = preparedStatement.executeQuery();
            ArrayList<NotifyBEAN> list = new ArrayList<>();
            while (rs.next()){
                NotifyBEAN notifyBEAN = new NotifyBEAN();
                notifyBEAN.setId(rs.getInt("id"));
                notifyBEAN.setFrom_user(rs.getString("from_user"));
                notifyBEAN.setTo_user(rs.getString("to_user"));
                notifyBEAN.setTo_post_id(rs.getInt("to_post_id"));
                notifyBEAN.setTo_topic_id(rs.getInt("to_topic_id"));
                notifyBEAN.setIs_read(rs.getBoolean("is_read"));
                notifyBEAN.setCreate_time(rs.getTimestamp("create_time"));
                notifyBEAN.setContext(rs.getString("context"));
                notifyBEAN.setNotify_type_id(rs.getInt("notify_type_id"));
                notifyBEAN.setAvatar(rs.getString("avatar"));
                list.add(notifyBEAN);
            }
            rs.close();
            preparedStatement.close();
            conn.close();
            return list;
        }catch (Exception e) {
            e.printStackTrace();
            return null;
        }
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

            preparedStatement.close();
            conn.close();

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    //set is read notify
    public void setIsReadNotify(ArrayList<Integer> notifyIdList){
        try {
            Connection conn = connectDb();
            for(var notifyId: notifyIdList){
                PreparedStatement preparedStatement = conn.prepareStatement("update notify " +
                        " set is_read = ? " +
                        " where id = ? ");
                preparedStatement.setBoolean(1,true);
                preparedStatement.setInt(2,notifyId);
                preparedStatement.executeUpdate();
            }

            conn.close();

        }catch (Exception e){
            e.printStackTrace();
        }
    }

}
