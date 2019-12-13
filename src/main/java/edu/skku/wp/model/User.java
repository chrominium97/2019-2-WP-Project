package edu.skku.wp.model;

public class User {
    private String id;
    private String password;
    private String name;
    private String phoneNumber;
    private UserType type;

    public User(String id, String password, String name, String phoneNumber, UserType type) {
        this.id = id;
        this.password = password;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.type = type;
    }

    public String getId() {
        return id;
    }

    public String getPassword() {
        return password;
    }

    public String getName() {
        return name;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public UserType getType() {
        return type;
    }

    public enum UserType {
        BUYER(1),
        SELLER(2),
        ADMIN(3);

        private Integer code;

        UserType(int code) {
            this.code = code;
        }
    }
}
