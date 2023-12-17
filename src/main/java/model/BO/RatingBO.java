package model.BO;

import model.BEAN.RatingBEAN;
import model.DAO.RatingDAO;

import java.util.ArrayList;

public class RatingBO {
    RatingDAO ratingDAO = new RatingDAO();
    public int getRatePageNumberByUsername(String username) {
        return ratingDAO.getRatePageNumberByUsername(username);
    }
    public ArrayList<RatingBEAN> getAllRatingByUsername(String username, int pageIndex) {
        return ratingDAO.getAllRatingByUsername(username,pageIndex);
    }
    public void addRate(int deliId, RatingBEAN rate) throws Exception{
        ratingDAO.addRating(deliId, rate);
    }
}
