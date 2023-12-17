package model.DAO;

import model.BEAN.RatingBEAN;
import model.BO.RatingBO;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;

public class RatingDAO {
    private Connection connectDb() throws Exception{
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/deli_forum", "root", "teamctg123");
    }
    public int getRatePageNumberByUsername(String username){
        try{
            Connection conn = connectDb();
            PreparedStatement preparedStatement = conn.prepareStatement("select count(*) as listNumber from rate where to_user = ? ");
            preparedStatement.setString(1,username);
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
            return -1;
        }
    }
    public ArrayList<RatingBEAN> getAllRatingByUsername(String username,int pageIndex){
        try{
            Connection conn  = connectDb();
            PreparedStatement preparedStatement=conn.prepareStatement("select * from " +
                    "(select row_number() over (order by id desc) as stt ,id,from_user,to_user,point,note,picture,rate_time,delivery_id " +
                    "from rate " +
                    "where to_user=? " +
                    ") as x " +
                    "inner join delivery on delivery.id = x.delivery_id " +
                    "inner join user on user.username = from_user " +
                    "where stt between ? and ? " +
                    "order by rate_time DESC ");
            int sizePerPage = 6;
            preparedStatement.setString(1,username);
            preparedStatement.setInt(2,pageIndex*sizePerPage-(sizePerPage-1));
            preparedStatement.setInt(3,pageIndex*sizePerPage);
            ResultSet rs = preparedStatement.executeQuery();
            ArrayList<RatingBEAN> list = new ArrayList<>();
            while (rs.next()){
                int id = rs.getInt("id");
                String fromUser = rs.getString("from_user");
                String toUser = rs.getString("to_user");
                int point = rs.getInt("point");
                String note = rs.getString("note");
                String picture = rs.getString("picture");
                Timestamp rate_time = rs.getTimestamp("rate_time");
                String user_take = rs.getString("user_take");
                String avatar = rs.getString("avatar");
                RatingBEAN ratingBEAN = new RatingBEAN(id, fromUser, toUser, point, note, picture, rate_time,user_take,avatar);
                list.add(ratingBEAN);
            }
            return list;
        }catch (Exception e) {
            e.printStackTrace();
            return null;
        }
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
