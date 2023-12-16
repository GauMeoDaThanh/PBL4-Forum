package model.BEAN;

public class ProfileBEAN {
    private String username;
    private String name;
    private String email;
    private String description;
    private int receiveDeli;
    private double star;
    private String avatar;

    public ProfileBEAN(String username, String name, String email, String description, int receiveDeli, double star, String avatar) {
        this.username = username;
        this.name = name;
        this.email = email;
        this.description = description;
        this.receiveDeli = receiveDeli;
        this.star = star;
        this.avatar = avatar;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getReceiveDeli() {
        return receiveDeli;
    }

    public void setReceiveDeli(int receiveDeli) {
        this.receiveDeli = receiveDeli;
    }

    public double getStar() {
        return Math.round((star*100)/100);
    }

    public void setStar(double star) {
        this.star = star;
    }
}
