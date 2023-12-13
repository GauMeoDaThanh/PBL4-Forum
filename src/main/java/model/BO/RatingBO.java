package model.BO;

import model.BEAN.RatingBEAN;
import model.DAO.RatingDAO;

public class RatingBO {
    RatingDAO ratingDAO = new RatingDAO();

    public void addRate(int deliId, RatingBEAN rate) throws Exception{
        ratingDAO.addRating(deliId, rate);
    }
}
