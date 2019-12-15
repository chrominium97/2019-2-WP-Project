package edu.skku.wp.model;

import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;

import java.util.Date;

@DatabaseTable(tableName = "shoppingcart")
public class ShoppingCart {
    @DatabaseField(generatedId = true)
    private Integer id;
    @DatabaseField(foreign = true, canBeNull = false, foreignAutoRefresh = true)
    private User user;
    @DatabaseField(foreign = true, canBeNull = false, foreignAutoRefresh = true)
    private Product product;
    @DatabaseField
    private Date date;

    public ShoppingCart() {
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

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
