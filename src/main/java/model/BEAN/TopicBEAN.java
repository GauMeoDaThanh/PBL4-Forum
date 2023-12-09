package model.BEAN;

import java.sql.Timestamp;

public class TopicBEAN {
    private int id;
    private String from_user;
    private int topic_type_id;
    private Timestamp create_time;
    private Timestamp edit_time;
    private String topic_name;
    private String from_location;
    private String to_location;
    private Timestamp deli_datetime;
    private String avatar;
    private String name;
    private String description;
//    private int countPost;

    public TopicBEAN() {

    }
    // Thêm topic
    public TopicBEAN(String from_user, int topic_type_id, Timestamp create_time, String topic_name, String from_location, String to_location, Timestamp deli_datetime) {
        this.from_user = from_user;
        this.topic_type_id = topic_type_id;
        this.create_time = create_time;
        this.topic_name = topic_name;
        this.from_location = from_location;
        this.to_location = to_location;
        this.deli_datetime = deli_datetime;
    }
    // Lấy topic ra

    public TopicBEAN(int id, String from_user, int topic_type_id, Timestamp create_time, Timestamp edit_time, String topic_name, String from_location, String to_location, Timestamp deli_datetime, String avatar, String name, String description) {
        this.id = id;
        this.from_user = from_user;
        this.topic_type_id = topic_type_id;
        this.create_time = create_time;
        this.edit_time = edit_time;
        this.topic_name = topic_name;
        this.from_location = from_location;
        this.to_location = to_location;
        this.deli_datetime = deli_datetime;
        this.avatar = avatar;
        this.name = name;
        this.description = description;
    }

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

    public int getTopic_type_id() {
        return topic_type_id;
    }

    public void setTopic_type_id(int topic_type_id) {
        this.topic_type_id = topic_type_id;
    }

    public Timestamp getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Timestamp create_time) {
        this.create_time = create_time;
    }

    public Timestamp getEdit_time() {
        return edit_time;
    }

    public void setEdit_time(Timestamp edit_time) {
        this.edit_time = edit_time;
    }

    public String getTopic_name() {
        return topic_name;
    }

    public void setTopic_name(String topic_name) {
        this.topic_name = topic_name;
    }

    public String getFrom_location() {
        return from_location;
    }

    public void setFrom_location(String from_location) {
        this.from_location = from_location;
    }

    public String getTo_location() {
        return to_location;
    }

    public void setTo_location(String to_location) {
        this.to_location = to_location;
    }

    public Timestamp getDeli_datetime() {
        return deli_datetime;
    }

    public void setDeli_datetime(Timestamp deli_datetime) {
        this.deli_datetime = deli_datetime;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
