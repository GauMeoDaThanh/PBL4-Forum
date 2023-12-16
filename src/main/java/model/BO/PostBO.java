package model.BO;

import model.BEAN.PostBEAN;
import model.DAO.PostDAO;

import java.util.ArrayList;

public class PostBO {
    PostDAO postDAO = new PostDAO();
    //
    public int getPostIdNewAdd() throws Exception{
        return postDAO.getPostIdNewAdd();
    }
    // Add Notify cho tất cả những người trong topic trừ người add post mới
    public ArrayList<String> getAllUsernameInTopicExceptFromUser(int topic_id,String username) throws Exception{
        return postDAO.getAllUsernameInTopicExceptFromUser(topic_id,username);
    }
    // Go to Post when click Notify
    public int getTopicIdOfPost(int postID) {
        return postDAO.getTopicIdOfPost(postID);
    }
    public int getPostPageIndex(int topicID,int postID) throws Exception{
        return postDAO.getPostPageIndex(topicID,postID);
    }
    // get ALl Post By Page + Pagination
    public int getTopicPageNumber(int topicID) throws Exception {
        return postDAO.getTopicPageNumber(topicID);
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
