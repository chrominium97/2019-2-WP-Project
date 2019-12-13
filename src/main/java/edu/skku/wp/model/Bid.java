package edu.skku.wp.model;

import java.util.Date;

public class Bid {
    private User user;
    private Product product;
    private Integer price;
    private Date date;
    private Boolean win;

    public Bid(User user, Product product, Integer price, Date date, Boolean win) {
        this.user = user;
        this.product = product;
        this.price = price;
        this.date = date;
        this.win = win;
    }

    public User getUser() {
        return user;
    }

    public Product getProduct() {
        return product;
    }

    public Integer getPrice() {
        return price;
    }

    public Date getDate() {
        return date;
    }

    public Boolean isWin() {
        return win;
    }
}
