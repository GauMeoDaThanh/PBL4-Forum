package model.BEAN;

import java.sql.Timestamp;

public class NotifyBEAN {
    private int id;
    private String from_user;
    private String to_user;
    private Integer to_post_id;
    private Integer to_topic_id;
    private boolean is_read;
    private Timestamp create_time;
    private String context;
    private int notify_type_id;
    //
    private String avatar;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFrom_user() {
        return from_user;
    }

    public void setFrom_user(String from_user) {
        this.from_user = from_user;
    }

    public String getTo_user() {
        return to_user;
    }

    public void setTo_user(String to_user) {
        this.to_user = to_user;
    }

    public Integer getTo_post_id() {
        return to_post_id;
    }

    public void setTo_post_id(Integer to_post_id) {
        this.to_post_id = to_post_id;
    }

    public Integer getTo_topic_id() {
        return to_topic_id;
    }

    public void setTo_topic_id(Integer to_topic_id) {
        this.to_topic_id = to_topic_id;
    }

    public boolean isIs_read() {
        return is_read;
    }

    public void setIs_read(boolean is_read) {
        this.is_read = is_read;
    }

    public Timestamp getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Timestamp create_time) {
        this.create_time = create_time;
    }

    public String getContext() {
        return context;
    }

    public void setContext(String context) {
        this.context = context;
    }

    public int getNotify_type_id() {
        return notify_type_id;
    }

    public void setNotify_type_id(int notify_type_id) {
        this.notify_type_id = notify_type_id;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
}
