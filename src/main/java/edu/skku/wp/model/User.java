package edu.skku.wp.model;

import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;

@DatabaseTable(tableName = "users")
public class User {
    @DatabaseField(id = true)
    private String id;
    @DatabaseField(canBeNull = false)
    private String password;
    @DatabaseField(canBeNull = false)
    private String name;
    @DatabaseField
    private String phoneNumber;
    @DatabaseField(canBeNull = false)
    private Type type;

    public User() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public enum Type {
        BUYER, SELLER, ADMIN;
    }
}
