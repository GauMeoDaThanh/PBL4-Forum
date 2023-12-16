package model.DAO;

import jakarta.servlet.annotation.WebServlet;
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
    public ArrayList<TopicBEAN> getAllTopicByUsername(String username){
        try {
            ArrayList<TopicBEAN> list = new ArrayList<>();
            Connection conn = connectDb();
            PreparedStatement preparedStatement = conn.prepareStatement("select * from topic " +
                    " inner join user on topic.from_user=user.username " +
                    " where user.username = ?" +
                    " order by topic.create_time DESC ");
            preparedStatement.setString(1,username);
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
                int countPost = countPostInTopic(topic_id);
                //
                TopicBEAN topic = new TopicBEAN(topic_id,from_user,topic_type_id,create_time,edit_time,topic_name,from_location,to_location,deli_datetime,avatar,name,description,countPost);
                list.add(topic);
            }
            return list;
        }catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public int countPostInTopic(int topicId) {
        try {
            Connection conn = connectDb();
            PreparedStatement preparedStatement = conn.prepareStatement("select count(*) as number_post from post where topic_id = "+topicId);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                return rs.getInt("number_post");
            }
            return -1;
        }catch (Exception e ){
            e.printStackTrace();
            return -1;
        }
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
            int countPost = countPostInTopic(topicId);
            //
            TopicBEAN topic = new TopicBEAN(topic_id,from_user,topic_type_id,create_time,edit_time,topic_name,from_location,to_location,deli_datetime,avatar,name,description,countPost);
            return topic;
        }
        return null;
    }


    // Get ALl topic Receive/Send By Page + Pagination
    public int getTopicPageNumberByTopicTypeId(int topic_type_id) {
        try{
            Connection conn = connectDb();
            PreparedStatement preparedStatement = conn.prepareStatement(" select count(*) as listNumber from topic where topic_type_id = ?");
            preparedStatement.setInt(1,topic_type_id);

            ResultSet rs = preparedStatement.executeQuery();

            int sizePerPage = 6;
            int pageNumber=0;
            while (rs.next()){
                int listNumber=rs.getInt("listNumber");
                pageNumber = listNumber/sizePerPage;
                if(listNumber<sizePerPage){
                    ++pageNumber;
                }
                else if(listNumber%sizePerPage != 0){
                    ++pageNumber;
                }
            }

            return pageNumber;
        }catch (Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    public ArrayList<TopicBEAN> getAllTopicReceiveByPage(int pageIndex) throws Exception{
        try {
            ArrayList<TopicBEAN> list = new ArrayList<>();
            Connection conn = connectDb();
            PreparedStatement preparedStatement = conn.prepareStatement("select * from " +
                    " (select row_number() over (order by id desc) as stt ,id,from_user,topic_type_id,create_time,edit_time,topic_name,from_location,to_location,deli_datetime " +
                    " from topic " +
                    " where topic_type_id=1 " +
                    " ) as x " +
                    " inner join user on user.username = x.from_user " +
                    " where stt between ? and ? " +
                    " order by create_time DESC ");

            int sizePerPage = 6;
            preparedStatement.setInt(1,pageIndex*sizePerPage-(sizePerPage-1));
            preparedStatement.setInt(2,pageIndex*sizePerPage);

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()){
                int topic_id = rs.getInt("id");
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

                int countPost = countPostInTopic(topic_id);

                //
                TopicBEAN topic = new TopicBEAN(topic_id,from_user,topic_type_id,create_time,edit_time,topic_name,from_location,to_location,deli_datetime,avatar,name,description,countPost);
                list.add(topic);
            }
            return list;
        }catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public ArrayList<TopicBEAN> getAllTopicSendByPage(int pageIndex) throws Exception{
        try {
            ArrayList<TopicBEAN> list = new ArrayList<>();
            Connection conn = connectDb();
            PreparedStatement preparedStatement = conn.prepareStatement("select * from " +
                    " (select row_number() over (order by id desc) as stt ,id,from_user,topic_type_id,create_time,edit_time,topic_name,from_location,to_location,deli_datetime " +
                    " from topic " +
                    " where topic_type_id=2 " +
                    " ) as x " +
                    " inner join user on user.username = x.from_user " +
                    " where stt between ? and ? " +
                    " order by create_time DESC ");

            int sizePerPage = 6;
            preparedStatement.setInt(1,pageIndex*sizePerPage-(sizePerPage-1));
            preparedStatement.setInt(2,pageIndex*sizePerPage);

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()){
                int topic_id = rs.getInt("id");
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

                int countPost = countPostInTopic(topic_id);

                //
                TopicBEAN topic = new TopicBEAN(topic_id,from_user,topic_type_id,create_time,edit_time,topic_name,from_location,to_location,deli_datetime,avatar,name,description,countPost);
                list.add(topic);
            }
            return list;
        }catch (Exception e) {
            e.printStackTrace();
            return null;
        }
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
                int countPost = countPostInTopic(topic_id);
                //
                TopicBEAN topic = new TopicBEAN(topic_id,from_user,topic_type_id,create_time,edit_time,topic_name,from_location,to_location,deli_datetime,avatar,name,description,countPost);
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

                int countPost = countPostInTopic(topic_id);

                //
                TopicBEAN topic = new TopicBEAN(topic_id,from_user,topic_type_id,create_time,edit_time,topic_name,from_location,to_location,deli_datetime,avatar,name,description,countPost);
                list.add(topic);
            }
            return list;
        }catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    //
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
            while (rs.next()){
               TopicBEAN topic = new TopicBEAN();
               topic.setId(rs.getInt("id"));
               topic.setCreate_time(rs.getTimestamp("create_time"));

                return topic;
            }
            return null;

        }catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public void updateTopic(TopicBEAN topic) {
        try {
            Connection conn = connectDb();
            PreparedStatement preparedStatement  = connectDb().prepareStatement("update topic " +
                    " set topic_type_id = ?, edit_time = ?, topic_name=?, from_location = ?, to_location = ?, deli_datetime = ? " +
                    " where id = ?");

            preparedStatement.setInt(1,topic.getTopic_type_id());
            preparedStatement.setTimestamp(2,topic.getEdit_time());
            preparedStatement.setString(3,topic.getTopic_name());
            preparedStatement.setString(4,topic.getFrom_location());
            preparedStatement.setString(5,topic.getTo_location());
            preparedStatement.setTimestamp(6,topic.getDeli_datetime());
            preparedStatement.setInt(7,topic.getId());

            preparedStatement.executeUpdate();

        }catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void deleteTopicById(int topicId) {
        try{
            Connection conn = connectDb();
            PreparedStatement preparedStatement = connectDb().prepareStatement("select id from post " +
                    " where topic_id = " + topicId +
                    " order by id DESC ");
            ResultSet rs = preparedStatement.executeQuery();
            ArrayList<Integer> postIDList = new ArrayList<>();
            while (rs.next()) {
                postIDList.add(rs.getInt("id"));
            }
            for (var postID:postIDList) {
                // Xoá post_picture
                PreparedStatement preparedStatement1 = conn.prepareStatement("delete from post_picture where post_id = "+postID);
                preparedStatement1.executeUpdate();
                // Xoá post
                PreparedStatement preparedStatement2 = conn.prepareStatement("delete from post where id = "+postID);
                preparedStatement2.executeUpdate();
            }
            // Xoá topic
            PreparedStatement preparedStatement3 = conn.prepareStatement("delete from topic where id = "+topicId);
            preparedStatement3.executeUpdate();


        }catch (Exception e) {
            e.printStackTrace();
        }
    }

    //Search Topic
    public int getTopicPageNumberBySearch(String txtSearch) {
        try{
            Connection conn = connectDb();
            PreparedStatement preparedStatement = connectDb().prepareStatement("select count(*) as listNumber " +
                    " from topic " +
                    " where topic_name like ?" +
                    " or from_location like ?" +
                    " or to_location like ?");
            preparedStatement.setString(1,"%"+txtSearch+"%");
            preparedStatement.setString(2,"%"+txtSearch+"%");
            preparedStatement.setString(3,"%"+txtSearch+"%");

            ResultSet rs = preparedStatement.executeQuery();

            int sizePerPage = 6;
            int pageNumber=0;
            while (rs.next()){
                int listNumber=rs.getInt("listNumber");
                pageNumber = listNumber/sizePerPage;
                if(listNumber<sizePerPage){
                    ++pageNumber;
                }
                else if(listNumber%sizePerPage != 0){
                    ++pageNumber;
                }
            }

            return pageNumber;
        }catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    public ArrayList<TopicBEAN> searchTopic(String txtSearch,int pageIndex) {
        try {
            ArrayList<TopicBEAN> list = new ArrayList<>();
            Connection conn = connectDb();
            PreparedStatement preparedStatement = connectDb().prepareStatement("select * from " +
                    " (select row_number() over (order by id asc) as stt ,id,from_user,topic_type_id,create_time,edit_time,topic_name,from_location,to_location,deli_datetime " +
                    " from topic " +
                    " where " +
                    "   topic_name like ? " +
                    "  or from_location like ? " +
                    "  or to_location like ? " +
                    " ) as x " +
                    " inner join user on user.username = x.from_user " +
                    " where stt between ? and ?" +
                    " order by create_time DESC");


            int sizePerPage = 6;

            preparedStatement.setString(1,"%"+txtSearch+"%");
            preparedStatement.setString(2,"%"+txtSearch+"%");
            preparedStatement.setString(3,"%"+txtSearch+"%");
            preparedStatement.setInt(4,pageIndex*sizePerPage-(sizePerPage-1));
            preparedStatement.setInt(5,pageIndex*sizePerPage);

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()){
                int topic_id = rs.getInt("id");
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

                int countPost = countPostInTopic(topic_id);

                //
                TopicBEAN topic = new TopicBEAN(topic_id,from_user,topic_type_id,create_time,edit_time,topic_name,from_location,to_location,deli_datetime,avatar,name,description,countPost);
                list.add(topic);
            }
            return list;
        }catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
