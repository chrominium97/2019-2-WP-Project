package edu.skku.wp.model;

import com.j256.ormlite.field.DataType;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;

import java.util.Base64;
import java.util.Date;

@DatabaseTable(tableName = "products")
public class Product {
    @DatabaseField(generatedId = true)
    private Integer id;
    @DatabaseField(canBeNull = false)
    private String name;
    @DatabaseField
    private String description;
    @DatabaseField
    private String tradingPlace;
    @DatabaseField
    private Integer price;
    @DatabaseField
    private Integer finalPrice;
    @DatabaseField(canBeNull = false)
    private Category category;
    @DatabaseField(canBeNull = false)
    private Status status;
    @DatabaseField(canBeNull = false)
    private Type type;
    @DatabaseField(canBeNull = false, foreign = true, foreignAutoRefresh = true)
    private User seller;
    @DatabaseField(foreign = true, foreignAutoRefresh = true)
    private User buyer;
    @DatabaseField(canBeNull = false)
    private Date registerDate;
    @DatabaseField(canBeNull = false)
    private Date expireDate;
    @DatabaseField
    private String image;

    public Product() {
    }

    public Product(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTradingPlace() {
        return tradingPlace;
    }

    public void setTradingPlace(String tradingPlace) {
        this.tradingPlace = tradingPlace;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Integer getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(Integer finalPrice) {
        this.finalPrice = finalPrice;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public User getSeller() {
        return seller;
    }

    public void setSeller(User seller) {
        this.seller = seller;
    }

    public User getBuyer() {
        return buyer;
    }

    public void setBuyer(User buyer) {
        this.buyer = buyer;
    }

    public Date getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Date registerDate) {
        this.registerDate = registerDate;
    }

    public Date getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(Date expireDate) {
        this.expireDate = expireDate;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public enum Status {
        PENDING("등록 대기"),
        AVAILABLE("판매중"),
        SOLD("판매 완료"),
        FAILED("기한 만료");

        private String name;

        Status(String name) {
            this.name = name;
        }

        public String getName() {
            return name;
        }
    }

    public enum Category {
        ELECTRONICS("전자기기"),
        FURNITURE("가구"),
        BOOKS("도서"),
        CLOTHES("의류"),
        ETC("기타");

        private String name;

        Category(String name) {
            this.name = name;
        }

        public String getName() {
            return name;
        }
    }

    public enum Type {
        AUCTION("경매"),
        FIXED("정찰제"),
        OFFER("네고");

        private String name;

        Type(String name) {
            this.name = name;
        }

        public String getName() {
            return name;
        }
    }
}
