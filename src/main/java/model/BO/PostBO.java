package model.BO;

import model.BEAN.PostBEAN;
import model.DAO.PostDAO;

import java.util.ArrayList;

public class PostBO {
    PostDAO postDAO = new PostDAO();
    public ArrayList<PostBEAN> getAllPostInTopic(int topicId) throws Exception {
        return postDAO.getAllPostInTopic(topicId);
    }
    public void addPost(PostBEAN postBEAN) throws Exception{
        postDAO.addPost(postBEAN);
    }
    public void deletePost(int postID) throws Exception {
        postDAO.deletePostById(postID);
    }

}
