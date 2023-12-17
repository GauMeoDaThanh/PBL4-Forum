package model.BEAN;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class RatingBEAN {
    private int id;
    private String fromUser;
    private String toUser;
    private int point;
    private String note;
    private String picture;
    private String time;
    private String user_take;
    private String avatar;
    public RatingBEAN(int id, String fromUser, String toUser, int point, String note, String picture, Timestamp time) {
        this.id = id;
        this.fromUser = fromUser;
        this.toUser = toUser;
        this.point = point;
        this.note = note;
        this.picture = picture;
        this.time = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(time);
    }

    public RatingBEAN(int id, String fromUser, String toUser, int point, String note, String picture, Timestamp time, String user_take, String avatar) {
        this.id = id;
        this.fromUser = fromUser;
        this.toUser = toUser;
        this.point = point;
        this.note = note;
        this.picture = picture;
        this.time = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(time);
        this.user_take = user_take;
        this.avatar = avatar;
    }

    public int getId() {
        return id;
    }

    public String getFromUser() {
        return fromUser;
    }

    public String getToUser() {
        return toUser;
    }

    public int getPoint() {
        return point;
    }

    public String getNote() {
        return note;
    }

    public String getPicture() {
        return picture;
    }
    public String getTime(){
        return time;
    }

    public String getUser_take() {
        return user_take;
    }

    public void setUser_take(String user_take) {
        this.user_take = user_take;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
}
