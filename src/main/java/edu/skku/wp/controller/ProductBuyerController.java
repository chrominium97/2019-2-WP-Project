package edu.skku.wp.controller;

import com.j256.ormlite.dao.Dao;
import edu.skku.wp.database.DBManager;
import edu.skku.wp.model.*;
import edu.skku.wp.security.Permission;
import edu.skku.wp.security.SessionAuthProvider;
import edu.skku.wp.util.StringUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;

@WebServlet({"/product/bid", "/product/buy", "/product/offer", "/product/wishlist"})
public class ProductBuyerController extends Controller {

    @Override
    protected Permission requiredPermission() {
        return Permission.BUYER;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        switch (path(req)) {
            case "/product/bid":
                handleBidPost(req, res);
                break;
            case "/product/buy":
                handleBuyPost(req, res);
                break;
            case "/product/offer":
                handleOfferPost(req, res);
                break;
            case "/product/wishlist":
                handleWishlistPost(req, res);
                break;
            default:
                errorBadRequest(req, res);
                break;
        }
    }

    private void handleWishlistPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String productIdStr = req.getParameter("productId");

        if (!StringUtil.isNotEmpty(productIdStr)) {
            json(new JsonResponse(false, "상품 ID가 없습니다."), req, res);
            return;
        }

        Integer productId = Integer.parseInt(productIdStr);

        try {
            Dao<Wishlist, Integer> wishlistDao = DBManager.getDao(Wishlist.class);
            Dao<Product, Integer> productDao = DBManager.getDao(Product.class);

            Product product = productDao.queryForId(productId);
            User user = SessionAuthProvider.getAuthUser(req);

            if (wishlistDao.queryBuilder()
                    .where()
                    .eq("product_id", product.getId())
                    .and()
                    .eq("user_id", user.getId())
                    .queryForFirst() != null) {
                json(new JsonResponse(false, "이미 찜 목록에 추가되었습니다."), req, res);
                return;
            }

            Wishlist wishlist = new Wishlist();
            wishlist.setUser(user);
            wishlist.setProduct(product);
            wishlist.setDate(new Date());

            wishlistDao.create(wishlist);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        json(new JsonResponse(true, "성공적으로 추가되었습니다."), req, res);
    }

    private void handleBidPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String productIdStr = req.getParameter("productId");
        String priceStr = req.getParameter("price");

        if (!StringUtil.isNotEmpty(productIdStr) || !StringUtil.isNotEmpty(priceStr)) {
            json(new JsonResponse(false, "유효하지 않은 파라미터입니다."), req, res);
            return;
        }

        Integer productId = Integer.parseInt(productIdStr);
        Integer price = Integer.parseInt(priceStr);

        try {
            Dao<Bid, Integer> bidDao = DBManager.getDao(Bid.class);
            Dao<Product, Integer> productDao = DBManager.getDao(Product.class);

            Product product = productDao.queryForId(productId);
            User user = SessionAuthProvider.getAuthUser(req);

            if (price <= product.getFinalPrice()) {
                json(new JsonResponse(false, "현재 가격 이하로는 입찰할 수 없습니다."), req, res);
                return;
            }

            Bid bid = new Bid();
            bid.setUser(user);
            bid.setProduct(product);
            bid.setPrice(price);
            bid.setDate(new Date());
            bidDao.create(bid);

            product.setFinalPrice(price);
            productDao.update(product);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        json(new JsonResponse(true, "성공적으로 입찰되었습니다!"), req, res);
    }

    private void handleBuyPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String productIdStr = req.getParameter("productId");

        if (!StringUtil.isNotEmpty(productIdStr)) {
            json(new JsonResponse(false, "상품 ID가 없습니다."), req, res);
            return;
        }

        Integer productId = Integer.parseInt(productIdStr);

        try {
            Dao<Product, Integer> productDao = DBManager.getDao(Product.class);

            Product product = productDao.queryForId(productId);
            User user = SessionAuthProvider.getAuthUser(req);

            product.setBuyer(user);
            product.setStatus(Product.Status.SOLD);
            productDao.update(product);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        json(new JsonResponse(true, "성공적으로 구매했습니다!"), req, res);
    }

    private void handleOfferPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String productIdStr = req.getParameter("productId");
        String priceStr = req.getParameter("price");
        String commentStr = req.getParameter("comment");

        if (!StringUtil.isNotEmpty(productIdStr) || !StringUtil.isNotEmpty(priceStr)) {
            json(new JsonResponse(false, "유효하지 않은 파라미터입니다."), req, res);
            return;
        }

        Integer productId = Integer.parseInt(productIdStr);
        Integer price = Integer.parseInt(priceStr);

        try {
            Dao<Product, Integer> productDao = DBManager.getDao(Product.class);

            Product product = productDao.queryForId(productId);
            if(product.getStatus() != Product.Status.AVAILABLE) {
                json(new JsonResponse(false, "이미 종료된 거래입니다."), req, res);
                return;
            }
            Dao<Offer, Integer> offerDao = DBManager.getDao(Offer.class);
            User user = SessionAuthProvider.getAuthUser(req);
            Offer offer = offerDao.queryBuilder()
                    .where()
                    .eq("user_id", user.getId())
                    .and()
                    .eq("product_id", product.getId())
                    .queryForFirst();
            if(offer != null) {
                offer.setPrice(price);
                offer.setDate(new Date());
                offer.setComment(commentStr);
                offerDao.update(offer);
            } else {
                offer = new Offer();
                offer.setUser(user);
                offer.setProduct(product);
                offer.setPrice(price);
                offer.setDate(new Date());
                offer.setAccept(false);
                offer.setComment(commentStr);
                offerDao.create(offer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        json(new JsonResponse(true, "판매자의 수락을 기다려주세요!"), req, res);
    }
}
