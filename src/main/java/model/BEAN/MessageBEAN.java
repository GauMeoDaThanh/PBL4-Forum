package model.BEAN;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class MessageBEAN {
    private int id;
    private String fromUser;
    private String toUser;
    private String message;
    private String picture;

    private String sendTime;
    private boolean form;
    private boolean formState;

    public MessageBEAN(int id, String fromUser, String toUser, String message, String picture, Timestamp sendTime, boolean form, boolean formState) {
        this.id = id;
        this.fromUser = fromUser;
        this.toUser = toUser;
        this.message = message;
        this.picture = picture;
        this.sendTime = new SimpleDateFormat("dd/MM/yyyy HH:mm").format(sendTime);
        this.form = form;
        this.formState = formState;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFromUser() {
        return fromUser;
    }

    public void setFromUser(String fromUser) {
        this.fromUser = fromUser;
    }

    public String getToUser() {
        return toUser;
    }

    public void setToUser(String toUser) {
        this.toUser = toUser;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public String getSendTime() {
        return sendTime;
    }

    public void setSendTime(Timestamp sendTime) {
        this.sendTime = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss").format(sendTime);
    }

    public boolean isForm() {
        return form;
    }

    public void setForm(boolean form) {
        this.form = form;
    }

    public void setSendTime(String sendTime) {
        this.sendTime = sendTime;
    }

    public boolean isFormState() {
        return formState;
    }

    public void setFormState(boolean formState) {
        this.formState = formState;
    }
}
