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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(urlPatterns = {"/mypage/history/seller/*"})
public class MypageSellerController extends Controller {
    @Override
    protected Permission requiredPermission() {
        return Permission.USER;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        switch (path(req)) {
            case "/mypage/history/seller":
                handleHistorySellerGet(req, res);
                break;
            case "/mypage/history/seller/get":
                handleProductGetGet(req, res);
                break;
            default:
                errorBadRequest(req, res);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        switch (path(req)) {
            case "/mypage/history/seller/edit":
                handleProductEditPost(req, res);
                break;
            case "/mypage/history/seller/delete":
                handleProductDeletePost(req, res);
                break;
            default:
                errorBadRequest(req, res);
                break;
        }
    }

    private void handleHistorySellerGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        User user = SessionAuthProvider.getAuthUser(req);
        try {
            Dao<Product, String> productDao = DBManager.getDao(Product.class);
            Dao<Bid, String> bidDao = DBManager.getDao(Bid.class);
            Dao<Wishlist, String> wishlistDao = DBManager.getDao(Wishlist.class);

            List<Product> products = productDao.queryForEq("seller_id", user.getId());
            for (Product product : products) {
                List<Bid> bids = bidDao.queryForEq("product_id", product.getId());
                List<Wishlist> wishlists = wishlistDao.queryForEq("product_id", product.getId());

                product.setBids(bids);
                product.setWishlists(wishlists);
            }

            req.setAttribute("products", products);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        jsp("mypage/history-seller", req, res);
    }

    private void handleProductGetGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String id = req.getParameter("id");
        try {
            Dao<Product, String> productDao = DBManager.getDao(Product.class);
            Product product = productDao.queryForId(id);
            product.setSeller(null);

            json(product, req, res);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void handleProductEditPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String categoryStr = req.getParameter("category");
        String tradingPlace = req.getParameter("tradingPlace");
        String priceStr = req.getParameter("price");
        String expireDateStr = req.getParameter("expireDate");
        String description = req.getParameter("description");
        String image = req.getParameter("image");

        try {
            Product.Category category = Product.Category.valueOf(categoryStr);
            Integer price = Integer.parseInt(priceStr);
            Date expireDate = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(expireDateStr);

            Dao<Product, String> productDao = DBManager.getDao(Product.class);
            Product product = productDao.queryForId(id);

            if (product.getStatus() == Product.Status.SOLD) {
                json(new JsonResponse(false, "이미 판매완료된 상품은 수정이 불가합니다."), req, res);
            } else {
                product.setName(name);
                product.setCategory(category);
                product.setTradingPlace(tradingPlace);
                product.setExpireDate(expireDate);
                product.setDescription(description);
                product.setImage(image);
                product.setPrice(price);
                if (!product.getType().equals(Product.Type.AUCTION))
                    product.setFinalPrice(price);

                productDao.update(product);
                json(new JsonResponse(true, "정상적으로 수정되었습니다."), req, res);
            }

        } catch (SQLException | ParseException e) {
            e.printStackTrace();
        }
    }

    private void handleProductDeletePost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String id = req.getParameter("id");
        try {
            Dao<Product, String> productDao = DBManager.getDao(Product.class);
            Product product = productDao.queryForId(id);

            if (product.getStatus() == Product.Status.SOLD) {
                json(new JsonResponse(false, "이미 판매완료된 상품은 삭제가 불가합니다."), req, res);
            } else  {
                productDao.deleteById(id);
                json(new JsonResponse(true, "정상적으로 제거되었습니다."), req, res);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
