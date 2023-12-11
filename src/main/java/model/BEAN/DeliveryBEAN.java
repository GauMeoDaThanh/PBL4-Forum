package model.BEAN;

import java.util.List;

public class DeliveryBEAN {
    private int id;
    private String userSend;
    private String userTake;
    private String goodsName;
    private String contactNumber;
    private String receiveName;
    private String toAddress;
    private String note;
    private boolean end;
    private String lastDeliState;

    public DeliveryBEAN(int id, String userSend, String userTake, String goodsName, String contactNumber, String receiveName, String toAddress, String note, boolean end) {
        this.id = id;
        this.userSend = userSend;
        this.userTake = userTake;
        this.goodsName = goodsName;
        this.contactNumber = contactNumber;
        this.receiveName = receiveName;
        this.note = note;
        this.toAddress = toAddress;
        this.end = end;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserSend() {
        return userSend;
    }

    public void setUserSend(String userSend) {
        this.userSend = userSend;
    }

    public String getUserTake() {
        return userTake;
    }

    public void setUserTake(String userTake) {
        this.userTake = userTake;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getReceiveName() {
        return receiveName;
    }

    public void setReceiveName(String receiveName) {
        this.receiveName = receiveName;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public boolean isEnd() {
        return end;
    }

    public void setEnd(boolean end) {
        this.end = end;
    }

    public String getToAddress() {
        return toAddress;
    }

    public void setToAddress(String toAddress) {
        this.toAddress = toAddress;
    }

    public String getLastDeliState() {
        return lastDeliState;
    }

    public void setLastDeliState(String lastDeliState) {
        this.lastDeliState = lastDeliState;
    }
}
