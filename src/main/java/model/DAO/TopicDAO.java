package model.DAO;

import model.BEAN.TopicBEAN;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.sql.Timestamp;
import java.util.Date;

public class TopicDAO {
    public Connection connectDb() throws Exception{
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/deli_forum", "root", "teamctg123");
    }
    public TopicBEAN getTopicById(int topicId) throws Exception{
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("select * from topic " +
                " inner join user on topic.from_user=user.username " +
                " where topic.id= "+topicId);
        ResultSet rs = preparedStatement.executeQuery();
        while (rs.next()){
            int topic_id = rs.getInt("topic.id");
            String from_user = rs.getString("from_user");
            int topic_type_id = rs.getInt("topic_type_id");
            //
            Timestamp create_time =rs.getTimestamp("create_time");
            Timestamp edit_time = rs.getTimestamp("edit_time");

            //
            String topic_name = rs.getString("topic_name");
            String from_location = rs.getString("from_location");
            String to_location = rs.getString("to_location");
            //
            Timestamp deli_datetime=rs.getTimestamp("deli_datetime");
            //
            String avatar = rs.getString("avatar");
            String name = rs.getString("name");
            String description = rs.getString("description");
            //
            TopicBEAN topic = new TopicBEAN(topic_id,from_user,topic_type_id,create_time,edit_time,topic_name,from_location,to_location,deli_datetime,avatar,name,description);
            return topic;
        }
        return null;
    }
    // Get List Topic in Home Page
    public ArrayList<TopicBEAN> getTopicHomeReceive() throws Exception{
        try {
            ArrayList<TopicBEAN> list = new ArrayList<>();
            Connection conn = connectDb();
            PreparedStatement preparedStatement = conn.prepareStatement("select * from topic " +
                    "inner join topic_type on topic.topic_type_id=topic_type.id " +
                    "inner join user on topic.from_user=user.username " +
                    "where topic.topic_type_id=1 " +
                    "order by topic.create_time DESC " +
                    "limit 3");
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()){
                int topic_id = rs.getInt("topic.id");
                String from_user = rs.getString("from_user");
                int topic_type_id = rs.getInt("topic_type_id");
                //
                Timestamp create_time =rs.getTimestamp("create_time");
                Timestamp edit_time = rs.getTimestamp("edit_time");
                //
                String topic_name = rs.getString("topic_name");
                String from_location = rs.getString("from_location");
                String to_location = rs.getString("to_location");
                //
                Timestamp deli_datetime=rs.getTimestamp("deli_datetime");
                //
                String avatar = rs.getString("avatar");
                String name = rs.getString("name");
                String description = rs.getString("description");
                //
                TopicBEAN topic = new TopicBEAN(topic_id,from_user,topic_type_id,create_time,edit_time,topic_name,from_location,to_location,deli_datetime,avatar,name,description);
                list.add(topic);
            }
            return list;
        }catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }
    public ArrayList<TopicBEAN> getTopicHomeSend() throws Exception{
        try {
            ArrayList<TopicBEAN> list = new ArrayList<>();
            Connection conn = connectDb();
            PreparedStatement preparedStatement = conn.prepareStatement("select * from topic " +
                    "inner join topic_type on topic.topic_type_id=topic_type.id " +
                    "inner join user on topic.from_user=user.username " +
                    "where topic.topic_type_id=2 " +
                    "order by topic.create_time DESC " +
                    "limit 3");
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()){
                int topic_id = rs.getInt("topic.id");
                String from_user = rs.getString("from_user");
                int topic_type_id = rs.getInt("topic_type_id");
                //
                Timestamp create_time =rs.getTimestamp("create_time");
                Timestamp edit_time = rs.getTimestamp("edit_time");

                //
                String topic_name = rs.getString("topic_name");
                String from_location = rs.getString("from_location");
                String to_location = rs.getString("to_location");
                //
                Timestamp deli_datetime=rs.getTimestamp("deli_datetime");
                //
                String avatar = rs.getString("avatar");
                String name = rs.getString("name");
                String description = rs.getString("description");
                //
                TopicBEAN topic = new TopicBEAN(topic_id,from_user,topic_type_id,create_time,edit_time,topic_name,from_location,to_location,deli_datetime,avatar,name,description);
                list.add(topic);
            }
            return list;
        }catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    // Get All Topic in Topic receive/send page
    public ArrayList<TopicBEAN> getAllTopicReceive() throws Exception{
        ArrayList<TopicBEAN> list = new ArrayList<>();
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("select * from topic " +
                "inner join topic_type on topic.topic_type_id=topic_type.id " +
                "inner join user on topic.from_user=user.username " +
                "where topic.topic_type_id=1 " +
                "order by topic.create_time DESC ");
        ResultSet rs = preparedStatement.executeQuery();
        while (rs.next()){
            int topic_id = rs.getInt("topic.id");
            String from_user = rs.getString("from_user");
            int topic_type_id = rs.getInt("topic_type_id");
            //
            Timestamp create_time =rs.getTimestamp("create_time");
            Timestamp edit_time = rs.getTimestamp("edit_time");

            //
            String topic_name = rs.getString("topic_name");
            String from_location = rs.getString("from_location");
            String to_location = rs.getString("to_location");
            //
            Timestamp deli_datetime=rs.getTimestamp("deli_datetime");
            //
            String avatar = rs.getString("avatar");
            String name = rs.getString("name");
            String description = rs.getString("description");
            //
            TopicBEAN topic = new TopicBEAN(topic_id,from_user,topic_type_id,create_time,edit_time,topic_name,from_location,to_location,deli_datetime,avatar,name,description);
            list.add(topic);
        }
        return list;
    }
    public ArrayList<TopicBEAN> getAllTopicSend() throws Exception{
        ArrayList<TopicBEAN> list = new ArrayList<>();
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("select * from topic " +
                "inner join topic_type on topic.topic_type_id=topic_type.id " +
                "inner join user on topic.from_user=user.username " +
                "where topic.topic_type_id=2 " +
                "order by topic.create_time DESC ");
        ResultSet rs = preparedStatement.executeQuery();
        while (rs.next()){
            int topic_id = rs.getInt("topic.id");
            String from_user = rs.getString("from_user");
            int topic_type_id = rs.getInt("topic_type_id");
            //
            Timestamp create_time =rs.getTimestamp("create_time");
            Timestamp edit_time = rs.getTimestamp("edit_time");


            //
            String topic_name = rs.getString("topic_name");
            String from_location = rs.getString("from_location");
            String to_location = rs.getString("to_location");
            //
            Timestamp deli_datetime=rs.getTimestamp("deli_datetime");
            //
            String avatar = rs.getString("avatar");
            String name = rs.getString("name");
            String description = rs.getString("description");
            //
            TopicBEAN topic = new TopicBEAN(topic_id,from_user,topic_type_id,create_time,edit_time,topic_name,from_location,to_location,deli_datetime,avatar,name,description);
            list.add(topic);
        }
        return list;
    }
    public TopicBEAN addTopic(TopicBEAN topicBEAN){
        try {
            // Thêm mới topic
            Connection conn = connectDb();
            PreparedStatement preparedStatement = conn.prepareStatement(" insert into topic(from_user,topic_type_id,create_time,topic_name,from_location,to_location,deli_datetime) " +
                    "values (?,?,?,?,?,?,?)");


            preparedStatement.setString(1,topicBEAN.getFrom_user());
            preparedStatement.setInt(2, topicBEAN.getTopic_type_id());
            preparedStatement.setTimestamp(3,topicBEAN.getCreate_time());
            preparedStatement.setString(4,topicBEAN.getTopic_name());
            preparedStatement.setString(5,topicBEAN.getFrom_location());
            preparedStatement.setString(6,topicBEAN.getTo_location());
            preparedStatement.setTimestamp(7,topicBEAN.getDeli_datetime());

            int rowsAffected = preparedStatement.executeUpdate();


            // Lấy topic mới thêm đó ra
            PreparedStatement preparedStatement2 = conn.prepareStatement("select id,create_time from topic " +
                    "order by topic.create_time DESC " +
                    "limit 1");
            ResultSet rs = preparedStatement2.executeQuery();
//            while (rs.next()) {
//
//                int newID= rs.getInt(1);
//                return newID;
//            }
            while (rs.next()){
               TopicBEAN topic = new TopicBEAN();
               topic.setId(rs.getInt("id"));
               topic.setCreate_time(rs.getTimestamp("create_time"));

                return topic;
            }
            //

//            int newId = -1;
//            ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
//            if (generatedKeys.next()) {
//                newId = generatedKeys.getInt(1);
//                System.out.println("ID mới: " + newId);
//            } else {
//                System.out.println("Không có ID mới.");
//            }
            return null;

        }catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
