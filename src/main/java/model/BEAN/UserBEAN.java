package model.BEAN;

public class UserBEAN {
    private String username;
    private String name;
    private String email;
    private String role;
    private String avatar;
    private String description;
    private String limitId;
    private String limitStart;

    public UserBEAN(String username, String name, String email, String role,
                    String avatar, String description) {
        this.username = username;
        this.name = name;
        this.email = email;
        this.role = role;
        this.avatar = avatar;
        this.description = description;
        this.limitId = "";
        this.limitStart = "";
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

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLimitId() {
        return limitId;
    }

    public void setLimitId(String limitId) {
        this.limitId = limitId;
    }

    public String getLimitStart() {
        return limitStart;
    }

    public void setLimitStart(String limitStart) {
        this.limitStart = limitStart;
    }
}
