package model.BEAN;

import java.sql.Timestamp;
import java.util.ArrayList;

public class PostBEAN {
    private int id;
    private String from_user;
    private int topic_id;
    private String content;
    private Timestamp create_time;
    private Timestamp edit_time;
    private Integer post_id;
    //
    private String avatar;
    private String name;
    private String description;
    private ArrayList<String> imageList;
    public PostBEAN() {

    }

    public PostBEAN(String from_user, int topic_id, String content, Timestamp create_time,ArrayList<String> imageList,Integer post_id) {
        this.from_user = from_user;
        this.topic_id = topic_id;
        this.content = content;
        this.create_time = create_time;
        this.imageList = imageList;
        this.post_id = post_id;
    }

    public PostBEAN(int id, String from_user, int topic_id, String content, Timestamp create_time, Timestamp edit_time, Integer post_id, String avatar, String name, String description, ArrayList<String> imageList) {
        this.id = id;
        this.from_user = from_user;
        this.topic_id = topic_id;
        this.content = content;
        this.create_time = create_time;
        this.edit_time = edit_time;
        this.post_id = post_id;
        this.avatar = avatar;
        this.name = name;
        this.description = description;
        this.imageList = imageList;
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

    public int getTopic_id() {
        return topic_id;
    }

    public void setTopic_id(int topic_id) {
        this.topic_id = topic_id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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

    public Integer getPost_id() {
        return post_id;
    }

    public void setPost_id(Integer post_id) {
        this.post_id = post_id;
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

    public ArrayList<String> getImageList() {
        return imageList;
    }

    public void setImageList(ArrayList<String> imageList) {
        this.imageList = imageList;
    }
}
