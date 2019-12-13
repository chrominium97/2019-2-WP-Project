package edu.skku.wp.model;

import java.util.Date;

public class Wishlist {
    private User user;
    private Product product;
    private Date date;

    public Wishlist(User user, Product product, Date date) {
        this.user = user;
        this.product = product;
        this.date = date;
    }

    public User getUser() {
        return user;
    }

    public Product getProduct() {
        return product;
    }

    public Date getDate() {
        return date;
    }
}
