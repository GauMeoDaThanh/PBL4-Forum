package model.BO;

import model.BEAN.MessageBEAN;
import model.BEAN.ProfileBEAN;
import model.DAO.ChatDAO;

import java.util.List;
import java.util.Map;

public class ChatBO {
    ChatDAO chatDAO = new ChatDAO();

    public List<MessageBEAN> getMessage(String user1, String user2) throws Exception {
        return chatDAO.getMessage(user1, user2);
    }
    public Map<String, String> getChatNameList(String username) throws Exception {
        return chatDAO.getChatNameList(username);
    }

    public void addMessage(MessageBEAN messageBEAN) throws Exception {
        chatDAO.addMessage(messageBEAN);
    }

    public void changeDeliFormState(int idMessage) throws Exception {
        chatDAO.changeDeliFormState(idMessage);
    }
}
