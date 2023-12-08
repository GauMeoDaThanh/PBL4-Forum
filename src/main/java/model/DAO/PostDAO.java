package model.DAO;

import com.mysql.cj.jdbc.ConnectionImpl;
import model.BEAN.PostBEAN;

import java.sql.*;

public class PostDAO {
    public Connection connectDb() throws Exception{
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/deli_forum", "root", "teamctg123");
    }
    public void addPost(PostBEAN postBEAN) throws Exception {
        try{
            Connection conn = connectDb();
            PreparedStatement preparedStatement = conn.prepareStatement("insert into post(from_user, topic_id, content, create_time) " +
                    "values (?,?,?,?)");
            preparedStatement.setString(1,postBEAN.getFrom_user());
            preparedStatement.setInt(2, postBEAN.getTopic_id());
            preparedStatement.setString(3,postBEAN.getContent());
            preparedStatement.setTimestamp(4,postBEAN.getCreate_time());
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
}
