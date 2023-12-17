package model.BO;

import model.BEAN.TopicBEAN;
import model.DAO.TopicDAO;

import java.util.ArrayList;

public class TopicBO{
    TopicDAO topicDAO = new TopicDAO();
    public TopicBEAN getTopicById(int topicId) throws Exception {
        return topicDAO.getTopicById(topicId);
    }
    public ArrayList<TopicBEAN> getTopicHomeReceive() throws Exception{
        return topicDAO.getTopicHomeReceive();
    }
    public ArrayList<TopicBEAN> getTopicHomeSend() throws Exception{
        return topicDAO.getTopicHomeSend();
    }
    // Topic Profile
    public int getTopicPageNumberByUsername(String username) {
        return topicDAO.getTopicPageNumberByUsername(username);
    }
    public ArrayList<TopicBEAN> getAllTopicByUsername(String username,int pageIndex) throws Exception{
        return topicDAO.getAllTopicByUsername(username,pageIndex);
    }
    // Topic Receive/Send
    public int getTopicPageNumberByTopicTypeId(int topic_type_id) throws Exception{
        return topicDAO.getTopicPageNumberByTopicTypeId(topic_type_id);
    }
    public ArrayList<TopicBEAN> getAllTopicReceiveByPage(int pageIndex) throws Exception {
        return topicDAO.getAllTopicReceiveByPage(pageIndex);
    }
    public ArrayList<TopicBEAN> getAllTopicSendByPage(int pageIndex) throws Exception {
        return topicDAO.getAllTopicSendByPage(pageIndex);
    }
    //
    public TopicBEAN addTopic(TopicBEAN topicBEAN) throws Exception {
        return topicDAO.addTopic(topicBEAN);
    }
    public void updateTopic(TopicBEAN topicBEAN) throws Exception {
        topicDAO.updateTopic(topicBEAN);
    }
    public void deleteTopicById(int topicId) throws Exception {
        topicDAO.deleteTopicById(topicId);
    }
    //Search
    public int getTopicPageNumberBySearch(String txtSearch) throws Exception{
        return topicDAO.getTopicPageNumberBySearch(txtSearch);
    }
    public ArrayList<TopicBEAN> searchTopic(String txtSearch,int pageIndex) throws Exception {
        return topicDAO.searchTopic(txtSearch,pageIndex);
    }
    //
    public ArrayList<TopicBEAN> getAllTopicByUsername(String username) throws Exception{
        return topicDAO.getAllTopicByUsername(username);
    }
}
