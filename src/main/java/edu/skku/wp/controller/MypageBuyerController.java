package edu.skku.wp.controller;

import com.j256.ormlite.dao.Dao;
import edu.skku.wp.database.DBManager;
import edu.skku.wp.model.*;
import edu.skku.wp.security.Permission;
import edu.skku.wp.security.SessionAuthProvider;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Base64;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@WebServlet(urlPatterns = {"/mypage/history/buyer", "/mypage/wishlist/*"})
public class MypageBuyerController extends Controller {
    @Override
    protected Permission requiredPermission() {
        return Permission.BUYER;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        switch (path(req)) {
            case "/mypage/history/buyer":
                handleHistoryBuyerGet(req, res);
                break;
            case "/mypage/wishlist":
                handleUserWishlistGet(req, res);
                break;
            default:
                errorBadRequest(req, res);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        switch (path(req)) {
            case "/mypage/wishlist/delete":
                handleWishlistDelete(req, res);
                break;
            default:
                errorBadRequest(req, res);
                break;
        }
    }

    private void handleHistoryBuyerGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        User user = SessionAuthProvider.getAuthUser(req);

        try {
            Dao<Product, Integer> productDao = DBManager.getDao(Product.class);
            Dao<Bid, Integer> bidDao = DBManager.getDao(Bid.class);
            Dao<Offer, Integer> offerDao = DBManager.getDao(Offer.class);

            List<Product> products = productDao.queryForEq("buyer_id", user.getId());

            // pending auctions
            List<Bid> bids =
                    bidDao.queryForEq("user_id", user.getId())
                            .stream()
                            .collect(Collectors.groupingBy(Bid::getProduct))
                            .values()
                            .stream()
                            .map(pBids -> pBids.stream().max((bid, t1) -> bid.getPrice() - t1.getPrice()))
                            .filter(Optional::isPresent)
                            .map(Optional::get)
                            .collect(Collectors.toList());
            List<Offer> offers =
                    offerDao.queryForEq("user_id", user.getId())
                            .stream()
                            .collect(Collectors.groupingBy(Offer::getProduct))
                            .values()
                            .stream()
                            .map(pOffers -> pOffers.stream().max((offer, t1) -> offer.getPrice() - t1.getPrice()))
                            .filter(Optional::isPresent)
                            .map(Optional::get)
                            .collect(Collectors.toList());


            Integer totalPrice = products.stream().map(Product::getFinalPrice).reduce(Integer::sum).orElse(0);
            Integer pendingPrice = bids.stream().map(Bid::getPrice).reduce(Integer::sum).orElse(0);
            Integer offerPrice = offers.stream().map(Offer::getPrice).reduce(Integer::sum).orElse(0);

            req.setAttribute("products", products);
            req.setAttribute("bids", bids);
            req.setAttribute("offers", offers);
            req.setAttribute("totalPrice", totalPrice);
            req.setAttribute("pendingPrice", pendingPrice);
            req.setAttribute("offerPrice", offerPrice);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        jsp("mypage/history-buyer", req, res);
    }

    private void handleUserWishlistGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String id = SessionAuthProvider.getAuthUser(req).getId();
        try {
            Dao<Wishlist, Integer> wishlistDao = DBManager.getDao(Wishlist.class);
            List<Wishlist> wishlists = wishlistDao.queryForEq("user_id", id);

            req.setAttribute("wishlists", wishlists);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        jsp("mypage/wishlist", req, res);
    }

    private void handleWishlistDelete(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String id = req.getParameter("id");

        try {
            Dao<Wishlist, String> wishlistDao = DBManager.getDao(Wishlist.class);
            wishlistDao.deleteById(id);
            json(new JsonResponse(true, "정상적으로 수정되었습니다."), req, res);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void handleUserEditPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String phoneNumber = req.getParameter("phoneNumber");
        String typeStr = req.getParameter("type");
        String password = req.getParameter("password");

        try {
            Dao<User, String> userDao = DBManager.getDao(User.class);
            User user = userDao.queryForId(id);
            user.setName(name);
            user.setPhoneNumber(phoneNumber);
            user.setType(User.Type.valueOf(typeStr));
            user.setPassword(Base64.getEncoder().encodeToString(password.getBytes()));

            userDao.update(user);
            json(new JsonResponse(true, "정상적으로 수정되었습니다."), req, res);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
