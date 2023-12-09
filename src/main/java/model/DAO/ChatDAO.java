package model.DAO;

import model.BEAN.MessageBEAN;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ChatDAO {
    public Connection connectDb() throws Exception{
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/deli_forum", "root", "teamctg123");
    }
    public List<MessageBEAN> getMessage(String user1, String user2) throws Exception {
        List<MessageBEAN> messages = new ArrayList<>();
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("select * from message where (from_user=? or to_user=?) and (from_user=? or to_user=?)");
        preparedStatement.setString(1, user1);
        preparedStatement.setString(2, user1);
        preparedStatement.setString(3, user2);
        preparedStatement.setString(4, user2);
        ResultSet rs = preparedStatement.executeQuery();
        while (rs.next()) {
            MessageBEAN message = new MessageBEAN(rs.getInt("id"), rs.getString("from_user"),
                    rs.getString("to_user"), rs.getString("message"), rs.getString("message_picture"),
                    rs.getTimestamp("send_time"), rs.getBoolean("isForm"), rs.getBoolean("form_state"));
            messages.add(message);
        }
        conn.close();
        return messages;
    }
    public Map<String, String> getChatNameList(String username) throws Exception {
        Connection conn = connectDb();
        Map<String, String> chatNameList = new HashMap<>();
        PreparedStatement preparedStatement = conn.prepareStatement("select from_user, to_user from message where " +
                "from_user = ? or to_user= ? order by id desc");
        preparedStatement.setString(1, username);
        preparedStatement.setString(2, username);
        ResultSet rs = preparedStatement.executeQuery();
        while (rs.next()) {
            String user;
            if (rs.getString("from_user").equals(username)){
                user = rs.getString("to_user");
            }else{
                user = rs.getString("from_user");
            }
            if (!chatNameList.containsKey("user")) {
                chatNameList.put(user, getAvatar(user));
            }
        }
        conn.close();
        return chatNameList;
    }

    public void addMessage(MessageBEAN message) throws Exception {
        Connection conn = connectDb();
        PreparedStatement preparedStatement;
        if (message.getMessage().equals("")){
            preparedStatement = conn.prepareStatement("insert into message (from_user, to_user, message_picture, send_time) values ( ? , ? , ? , ?)");
            preparedStatement.setString(1, message.getFromUser());
            preparedStatement.setString(2, message.getToUser());
            preparedStatement.setString(3, message.getPicture());
            preparedStatement.setTimestamp(4, new Timestamp(new Date().getTime()));
            preparedStatement.executeUpdate();
        }else{
            preparedStatement = conn.prepareStatement("insert into message (from_user, to_user, message, send_time, isForm) values ( ? , ? , ? , ?, ?)");
            preparedStatement.setString(1, message.getFromUser());
            preparedStatement.setString(2, message.getToUser());
            preparedStatement.setString(3, message.getMessage());
            preparedStatement.setTimestamp(4, new Timestamp(new Date().getTime()));
            preparedStatement.setBoolean(5, message.isForm());
            preparedStatement.executeUpdate();
        }
        conn.close();
    }

    public void changeDeliFormState(int idMessage) throws Exception {
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("update message set form_state = 1 where id = ?");
        preparedStatement.setInt(1, idMessage);
        preparedStatement.executeUpdate();
        conn.close();
    }
    public String getLastChatUser(String username) throws Exception {
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("select * from message where from_user=? or to_user=? order by id desc limit 1");
        preparedStatement.setString(1, username);
        preparedStatement.setString(2, username);
        ResultSet rs = preparedStatement.executeQuery();
        rs.next();
        String chatWithUser;
        if (rs.getString("from_user").equals(username)){
            chatWithUser = rs.getString("to_user");
        }else {
            chatWithUser = rs.getString("from_user");
        }
        conn.close();
        return chatWithUser;
    }
    private String getAvatar(String username) throws Exception {
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("select avatar from user where username = ?");
        preparedStatement.setString(1, username);
        ResultSet rs = preparedStatement.executeQuery();
        if (rs.next()) {
            return rs.getString("avatar");
        }
        conn.close();
        return null;
    }
}
