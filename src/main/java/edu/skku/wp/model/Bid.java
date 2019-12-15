package edu.skku.wp.model;

import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;

import java.time.LocalDate;
import java.util.Date;

@DatabaseTable(tableName = "bids")
public class Bid {
    @DatabaseField(generatedId = true)
    private Integer id;
    @DatabaseField(foreign = true, canBeNull = false, foreignAutoRefresh = true)
    private User user;
    @DatabaseField(foreign = true, canBeNull = false)
    private Product product;
    @DatabaseField(canBeNull = false)
    private Integer price;
    @DatabaseField(canBeNull = false)
    private Date date;
    @DatabaseField
    private Boolean win;

    public Bid() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Boolean getWin() {
        return win;
    }

    public void setWin(Boolean win) {
        this.win = win;
    }
}
