package edu.skku.wp.model;

public class Product {
    private Integer id;
    private String name;
    private String description;
    private Integer price;
    private String tradingPlace;
    private Status status;
    private User seller;

    public Product(Integer id, String name, String description, Integer price, String tradingPlace, Status status, User seller) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.tradingPlace = tradingPlace;
        this.status = status;
        this.seller = seller;
    }

    public Integer getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public Integer getPrice() {
        return price;
    }

    public String getTradingPlace() {
        return tradingPlace;
    }

    public Status getStatus() {
        return status;
    }

    public User getSeller() {
        return seller;
    }

    public enum Status {
        PENDING(0),
        AVAILABLE(1),
        SOLD(2),
        FAILED(3);

        private Integer code;

        Status(Integer code) {
            this.code = code;
        }
    }
}
