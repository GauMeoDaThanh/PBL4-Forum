package model.BO;

import model.BEAN.PostBEAN;
import model.DAO.PostDAO;

import java.util.ArrayList;

public class PostBO {
    PostDAO postDAO = new PostDAO();
    // get ALl Post By Page + Pagination
    public int getPostPageNumber(int topicID) throws Exception {
        return postDAO.getPostPageNumber(topicID);
    }
    public ArrayList<PostBEAN> getAllPostInTopicByPage(int topicId,int pageIndex) throws Exception {
        return postDAO.getAllPostInTopicByPage(topicId,pageIndex);
    }

    //
    public void addPost(PostBEAN postBEAN) throws Exception{
        postDAO.addPost(postBEAN);
    }
    public void deletePost(int postID) throws Exception {
        postDAO.deletePostById(postID);
    }
    public void updatePost(PostBEAN postBEAN) throws Exception{
        postDAO.updatePost(postBEAN);
    }

}
