package model.DAO;

import com.mysql.cj.jdbc.ConnectionImpl;
import model.BEAN.PostBEAN;
import model.BEAN.TopicBEAN;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;

public class PostDAO {
    public Connection connectDb() throws Exception{
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/deli_forum", "root", "teamctg123");
    }
    public PostBEAN getPostById(int postId) {
        try {
            Connection conn = connectDb();
            PreparedStatement preparedStatement = conn.prepareStatement("select * from post " +
                    " inner join user on post.from_user = user.username " +
                    " where post.id = " + postId);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()){
                int ID = rs.getInt("post.id");
                String fromUser=rs.getString("post.from_user");
                int topicID=rs.getInt("post.topic_id");
                String content = rs.getString("post.content");
                Timestamp createTime = rs.getTimestamp("post.create_time");
                Timestamp editTime=rs.getTimestamp("post.edit_time");
                Timestamp deleteTime = rs.getTimestamp("delete_time");

                Integer postID;
                if(rs.getObject("post.post_id") == null) {
                    postID = null;
                } else {
                    postID = rs.getInt("post.post_id");
                }

                String avatar=rs.getString("user.avatar");
                String name = rs.getString("user.name");
                String description = rs.getString("user.description");
                ArrayList<String> imageList = getAllPictureInPost(ID);
                PostBEAN postBEAN = new PostBEAN(ID,fromUser,topicID,content,createTime,editTime,postID,avatar,name,description,imageList,deleteTime);
                return postBEAN;
            }
            return null;
        }catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public ArrayList<String> getAllPictureInPost(int postId) throws Exception {
        ArrayList<String> imageList = new ArrayList<>();
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("select * from post_picture " +
                " where post_picture.post_id = "+postId);
        ResultSet rs = preparedStatement.executeQuery();
        while (rs.next()){
            String img = rs.getString("picture");
            imageList.add(img);
        }
        return imageList;
    }

    public ArrayList<PostBEAN> getAllPostInTopic(int topicId) throws Exception {
        ArrayList<PostBEAN> list = new ArrayList<>();
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("select * from post " +
                " inner join user on post.from_user = user.username " +
                " where post.topic_id = "+topicId +
                " order by post.create_time ");
        ResultSet rs = preparedStatement.executeQuery();
        while (rs.next()){
            int ID = rs.getInt("post.id");
            String fromUser=rs.getString("post.from_user");
            int topicID=rs.getInt("post.topic_id");
            String content = rs.getString("post.content");
            Timestamp createTime = rs.getTimestamp("post.create_time");
            Timestamp editTime=rs.getTimestamp("post.edit_time");
            Timestamp deleteTime = rs.getTimestamp("post.delete_time");

            System.out.println("==================");
            System.out.println(deleteTime);

            Integer postID;
            if(rs.getObject("post.post_id") == null) {
                postID = null;
            } else {
                postID = rs.getInt("post.post_id");
            }

            String avatar=rs.getString("user.avatar");
            String name = rs.getString("user.name");
            String description = rs.getString("user.description");
            ArrayList<String> imageList = getAllPictureInPost(ID);
            PostBEAN postBEAN = new PostBEAN(ID,fromUser,topicID,content,createTime,editTime,postID,avatar,name,description,imageList,deleteTime);
            list.add(postBEAN);
        }
        return list;
    }
    public void addPost(PostBEAN postBEAN) throws Exception {
        try{
            Connection conn = connectDb();
            PreparedStatement preparedStatement = conn.prepareStatement("insert into post(from_user, topic_id, content, create_time, post_id) " +
                    "values (?,?,?,?,?)");
            preparedStatement.setString(1,postBEAN.getFrom_user());
            preparedStatement.setInt(2, postBEAN.getTopic_id());
            preparedStatement.setString(3,postBEAN.getContent());
            preparedStatement.setTimestamp(4,postBEAN.getCreate_time());
            preparedStatement.setObject(5, postBEAN.getPost_id(), Types.INTEGER);


            int rowsAffected = preparedStatement.executeUpdate();

            // Lấy id post vứa thêm đó ra và thêm image của post
            PreparedStatement preparedStatement2 = conn.prepareStatement(" select id from post " +
                    " order by create_time DESC " +
                    " limit 1");
            ResultSet rs2 = preparedStatement2.executeQuery();
            while (rs2.next()) {
                for (String img : postBEAN.getImageList()) {
                    PreparedStatement preparedStatement3 = conn.prepareStatement("insert into post_picture(post_id,picture) " +
                            " values (?,?)");
                    preparedStatement3.setInt(1,rs2.getInt("id"));
                    preparedStatement3.setString(2,img);
                    preparedStatement3.executeUpdate();
                }
            }
            //
        }catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void updatePost(PostBEAN post) {
        try {
            Connection conn = connectDb();
            PreparedStatement preparedStatement  = conn.prepareStatement("update post " +
                    " set content = ?, edit_time = ?" +
                    " where id = ?");
            preparedStatement.setString(1,post.getContent());
            preparedStatement.setTimestamp(2,post.getEdit_time());
            preparedStatement.setInt(3,post.getId());
            preparedStatement.executeUpdate();

            if(post.getImageList().size()>0){
                PreparedStatement preparedStatement1 = conn.prepareStatement("delete from post_picture " +
                        " where post_id = "+post.getId());
                preparedStatement1.executeUpdate();
            }



            for (String img : post.getImageList()) {
                PreparedStatement preparedStatement3 = conn.prepareStatement("insert into post_picture(post_id,picture) " +
                        " values (?,?)");
                preparedStatement3.setInt(1,post.getId());
                preparedStatement3.setString(2,img);
                preparedStatement3.executeUpdate();
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deletePostById(int postId) {
        try {
            Connection conn = connectDb();
            PreparedStatement preparedStatement = conn.prepareStatement("update post " +
                    " set delete_time = ? " +
                    " where id = ?");
            preparedStatement.setTimestamp(1,Timestamp.valueOf(LocalDateTime.now()));
            preparedStatement.setInt(2,postId);
            preparedStatement.executeUpdate();
        }catch (Exception e) {
            e.printStackTrace();
        }
    }
//    // Xoá các post mà khoả chính id không phải là khoá ngoại của post khác (topic_id)
//    public void deletePost_IDisNotFK(int postID) {
//        try {
//            Connection conn = connectDb();
//            PreparedStatement preparedStatement = conn.prepareStatement("delete from post_picture " +
//                    " where post_id = "+postID);
//            preparedStatement.executeUpdate();
//
//            PreparedStatement preparedStatement1 = conn.prepareStatement("delete from post " +
//                    " where id = "+postID);
//            preparedStatement1.executeUpdate();
//        }catch (Exception e) {
//            e.printStackTrace();
//        }
//    }

//    public ArrayList<PostBEAN> getAllPostByPostIDForeignKey(int fk_postID) {
//        try {
//            ArrayList<PostBEAN> list = new ArrayList<>();
//            Connection conn = connectDb();
//            PreparedStatement preparedStatement = conn.prepareStatement("select * from post " +
//                    " inner join user on post.from_user = user.username " +
//                    " where post.post_id = " + fk_postID +
//                    " order by post.create_time DESC ");
//            ResultSet rs = preparedStatement.executeQuery();
//            while (rs.next()){
//                int ID = rs.getInt("post.id");
//                String fromUser=rs.getString("post.from_user");
//                int topicID=rs.getInt("post.topic_id");
//                String content = rs.getString("post.content");
//                Timestamp createTime = rs.getTimestamp("post.create_time");
//                Timestamp editTime=rs.getTimestamp("post.edit_time");
//
//                Integer postID;
//                if(rs.getObject("post.post_id") == null) {
//                    postID = null;
//                } else {
//                    postID = rs.getInt("post.post_id");
//                }
//
//                String avatar=rs.getString("user.avatar");
//                String name = rs.getString("user.name");
//                String description = rs.getString("user.description");
//                ArrayList<String> imageList = getAllPictureInPost(ID);
//                PostBEAN postBEAN = new PostBEAN(ID,fromUser,topicID,content,createTime,editTime,postID,avatar,name,description,imageList);
//                list.add(postBEAN);
//            }
//            return list;
//        }catch (Exception e){
//            e.printStackTrace();
//            return null;
//        }
//    }
//    public void deletePostById(int postID) {
//        try{
//            PostBEAN postBEAN = getPostById(postID);
//            if(postBEAN.getPost_id()!=null) {
//                ArrayList<PostBEAN> list = getAllPostByPostIDForeignKey(postBEAN.getPost_id());
//                for(PostBEAN post : list) {
//                    deletePost_IDisNotFK(post.getId());
//                }
//            }
//            else {
//                deletePost_IDisNotFK(postID);
//            }
//        }catch (Exception e) {
//            e.printStackTrace();
//        }
//    }


}