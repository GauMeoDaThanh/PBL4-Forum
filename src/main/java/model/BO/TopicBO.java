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
    public ArrayList<TopicBEAN> getAllTopicReceive() throws Exception {
        return topicDAO.getAllTopicReceive();
    }
    public ArrayList<TopicBEAN> getAllTopicSend() throws Exception {
        return topicDAO.getAllTopicSend();
    }
    public TopicBEAN addTopic(TopicBEAN topicBEAN) throws Exception {
        return topicDAO.addTopic(topicBEAN);
    }
}
