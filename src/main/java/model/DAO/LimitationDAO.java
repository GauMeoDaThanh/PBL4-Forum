package model.DAO;

import model.BEAN.LimitationBEAN;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Locale;

public class LimitationDAO {

    public Connection connectDb() throws Exception{
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/deli_forum", "root", "teamctg123");
    }
    public int UpdateLimitationDAO(String idLimit, String userName, String Date) throws Exception {
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("update user set limit_id= ?,limit_started=? where username=?");
        preparedStatement.setString(1,idLimit);
        preparedStatement.setString(2,Date);
        preparedStatement.setString(3,userName);
//        System.out.println(preparedStatement);

        int result =  preparedStatement.executeUpdate();

        conn.close();
        preparedStatement.close();
        return result;


    }

    public ArrayList<LimitationBEAN> GetAllTypeLimitation() throws Exception {
        Connection conn = connectDb();
        PreparedStatement preparedStatement = conn.prepareStatement("select * from limitation");
        ArrayList<LimitationBEAN> li = new ArrayList<>();
        ResultSet rs = preparedStatement.executeQuery();
        while (rs.next()){
            String idLimitation = rs.getString(1);
            String typeLimitation = rs.getString(2);
            LimitationBEAN limitation= new LimitationBEAN(idLimitation,typeLimitation);
            li.add(limitation);
        }
        conn.close();
        preparedStatement.close();
        rs.close();
        return  li;
    }



}