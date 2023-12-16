package model.BEAN;

import java.lang.reflect.Constructor;

public class LimitationBEAN {

    private String idLimitation;
    private String typeLimitation;

    public LimitationBEAN(String idLimitation, String typeLimitation){
        this.idLimitation = idLimitation;
        this.typeLimitation = typeLimitation;
    }

    public String getIdLimitation() {
        return idLimitation;
    }

    public String getTypeLimitation() {
        return typeLimitation;
    }

    public void setIdLimitation(String idLimitation) {
        this.idLimitation = idLimitation;
    }

    public void setTypeLimitation(String typeLimitation) {
        this.typeLimitation = typeLimitation;
    }
}