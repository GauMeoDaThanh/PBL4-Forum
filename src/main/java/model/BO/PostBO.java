package model.BO;

import model.BEAN.PostBEAN;
import model.DAO.PostDAO;

public class PostBO {
    PostDAO postDAO = new PostDAO();
    public void addPost(PostBEAN postBEAN) throws Exception{
        postDAO.addPost(postBEAN);
    }
}
