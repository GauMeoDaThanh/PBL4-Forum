package model.DAO;

import model.BEAN.DeliDetailBEAN;
import model.BEAN.DeliveryBEAN;

import javax.xml.transform.Result;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DeliveryDAO {
    public Connection connectDb() throws Exception{
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/deli_forum", "root", "teamctg123");
    }
    public void addDeliForm(String user1, String user2, DeliveryBEAN deliInfo) throws Exception {
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("insert into delivery (user_send, user_take, goods_name, contact_number, receive_name, note, to_address) values (?, ?, ?, ?, ?, ?, ?)");
        preparedStatement.setString(1, deliInfo.getUserSend());
        preparedStatement.setString(2, deliInfo.getUserTake());
        preparedStatement.setString(3, deliInfo.getGoodsName());
        preparedStatement.setString(4, deliInfo.getContactNumber());
        preparedStatement.setString(5, deliInfo.getReceiveName());
        preparedStatement.setString(6, deliInfo.getNote());
        preparedStatement.setString(7, deliInfo.getToAddress());
        preparedStatement.executeUpdate();
        conn.close();
    }

    public void addDeliDetail(DeliDetailBEAN deliDetailBEAN) throws Exception{
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("insert into delivery_detail (delivery_id, deli_state, deli_time) values (?, ?, ?);");
        preparedStatement.setInt(1, deliDetailBEAN.getDeli_id());
        preparedStatement.setString(2, deliDetailBEAN.getDeliState());
        preparedStatement.setTimestamp(3,  new Timestamp(new Date().getTime()));
        preparedStatement.executeUpdate();
        conn.close();
        preparedStatement.close();
    }
    public DeliveryBEAN getDeliInfo(int deliId) throws Exception{
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("select * from delivery where id = ?");
        preparedStatement.setInt(1, deliId);
        ResultSet rs = preparedStatement.executeQuery();
        if (rs.next()) {
            DeliveryBEAN deliveryBEAN = new DeliveryBEAN(rs.getInt("id"), rs.getString("user_send"), rs.getString("user_take"), rs.getString("goods_name"), rs.getString("contact_number"),
                    rs.getString("receive_name"), rs.getString("to_address"), rs.getString("note"), rs.getBoolean("is_end"));
            conn.close();
            preparedStatement.close();
            rs.close();
            return deliveryBEAN;
        }
        conn.close();
        preparedStatement.close();
        rs.close();
        return null;
    }
    public List<DeliDetailBEAN> getDeliDetail(int deliId) throws Exception {
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("select * from delivery_detail where delivery_id = ? order by id desc");
        preparedStatement.setInt(1, deliId);
        ResultSet rs = preparedStatement.executeQuery();
        List<DeliDetailBEAN> deliDetailBEANS = new ArrayList<>();
        while (rs.next()) {
            DeliDetailBEAN deliDetailBEAN = new DeliDetailBEAN(rs.getInt("id"), rs.getInt("delivery_id"), rs.getString("deli_state"), rs.getTimestamp("deli_time"));
            deliDetailBEANS.add(deliDetailBEAN);
        }
        conn.close();
        preparedStatement.close();
        rs.close();
        return deliDetailBEANS;
    }

    public List<DeliveryBEAN> getAllSendDeli(String username) throws Exception {
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("select * from delivery where user_send = ? order by id desc");
        preparedStatement.setString(1, username);
        ResultSet rs = preparedStatement.executeQuery();
        List<DeliveryBEAN> deliveryBEANS = new ArrayList<>();
        while (rs.next()) {
            DeliveryBEAN deliveryBEAN = new DeliveryBEAN(rs.getInt("id"), rs.getString("user_send"), rs.getString("user_take"), rs.getString("goods_name"), rs.getString("contact_number"),
                    rs.getString("receive_name"), rs.getString("to_address"), rs.getString("note"), rs.getBoolean("is_end"));
            deliveryBEAN.setLastDeliState(getLastDeliState(rs.getInt("id")));
            deliveryBEANS.add(deliveryBEAN);
        }
        conn.close();
        preparedStatement.close();
        rs.close();
        return deliveryBEANS;
    }

    public List<DeliveryBEAN> getAllReceiveDeli(String username) throws Exception {
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("select * from delivery where user_take = ? order by id desc");
        preparedStatement.setString(1, username);
        ResultSet rs = preparedStatement.executeQuery();
        List<DeliveryBEAN> deliveryBEANS = new ArrayList<>();
        while(rs.next()){
            DeliveryBEAN deliveryBEAN = new DeliveryBEAN(rs.getInt("id"), rs.getString("user_send"), rs.getString("user_take"), rs.getString("goods_name"), rs.getString("contact_number"),
                    rs.getString("receive_name"), rs.getString("to_address"), rs.getString("note"), rs.getBoolean("is_end"));
            deliveryBEAN.setLastDeliState(getLastDeliState(rs.getInt("id")));
            deliveryBEANS.add(deliveryBEAN);
        }
        conn.close();
        preparedStatement.close();
        rs.close();
        return deliveryBEANS;
    }
    public String getLastDeliState(int deliId) throws Exception {
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("select * from delivery_detail where delivery_id = ? order by id desc limit 1");
        preparedStatement.setInt(1, deliId);
        ResultSet rs = preparedStatement.executeQuery();
        if (rs.next()) {
            String lastDeliState = rs.getString("deli_state");
            conn.close();
            return lastDeliState;
        }
        conn.close();
        preparedStatement.close();
        rs.close();
        return null;
    }
    public List<String> getDeliUser(int deliId) throws Exception{
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("select user_take, user_send from delivery where id = ?");
        preparedStatement.setInt(1, deliId);
        ResultSet rs = preparedStatement.executeQuery();
        List<String> userInfoDeli = new ArrayList<>();
        if (rs.next()) {
            userInfoDeli.add(rs.getString("user_take"));
            userInfoDeli.add(rs.getString("user_send"));
            conn.close();
            return userInfoDeli;
        }
        conn.close();
        preparedStatement.close();
        rs.close();
        return null;
    }
    public void endDeli(int deliId) throws Exception {
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("update delivery set is_end = 1 where id = ?");
        preparedStatement.setInt(1, deliId);
        preparedStatement.executeUpdate();
        conn.close();
        preparedStatement.close();
    }
}
