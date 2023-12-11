package model.BEAN;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class DeliDetailBEAN {
    private int id;
    private int deli_id;
    private String deliState;
    private String deliTime;

    public DeliDetailBEAN(int id, int deli_id, String deliState, Timestamp deliTime) {
        this.id = id;
        this.deli_id = deli_id;
        this.deliState = deliState;
        this.deliTime = new SimpleDateFormat("dd/MM/yyyy HH:mm").format(deliTime);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getDeli_id() {
        return deli_id;
    }

    public void setDeli_id(int deli_id) {
        this.deli_id = deli_id;
    }

    public String getDeliState() {
        return deliState;
    }

    public void setDeliState(String deliState) {
        this.deliState = deliState;
    }

    public String getDeliTime() {
        return deliTime;
    }

    public void setDeliTime(Timestamp deliTime) {
        this.deliTime = new SimpleDateFormat("dd/MM/yyyy HH:mm").format(deliTime);
    }
}
