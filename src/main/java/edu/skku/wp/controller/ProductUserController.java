package edu.skku.wp.controller;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.stmt.QueryBuilder;
import com.j256.ormlite.stmt.Where;
import edu.skku.wp.database.DBManager;
import edu.skku.wp.model.Bid;
import edu.skku.wp.model.Product;
import edu.skku.wp.model.User;
import edu.skku.wp.security.Permission;
import edu.skku.wp.util.StringUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(urlPatterns = {"/product/*"})
public class ProductUserController extends Controller {
    @Override
    protected Permission requiredPermission() {
        return Permission.USER;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        switch (path(req)) {
            case "/product":
            case "/product/list":
                handleProductListGet(req, res);
                break;
            case "/product/detail":
                handleProductDetailGet(req, res);
                break;
            default:
                errorBadRequest(req, res);
                break;
        }
    }

    private void handleProductDetailGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Integer id = Integer.parseInt(req.getParameter("id"));

        try {
            Dao<Product, Integer> productDao = DBManager.getDao(Product.class);
            Dao<Bid, Integer> bidDao = DBManager.getDao(Bid.class);

            Product product = productDao.queryForId(id);
            List<Bid> bids = bidDao.queryBuilder()
                    .orderBy("date", false)
                    .limit(10L)
                    .where()
                    .eq("product_id", product.getId())
                    .query();

            req.setAttribute("product", product);
            req.setAttribute("bids", bids);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        jsp("product/product-detail", req, res);
    }

    private void handleProductListGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        String keywordType = req.getParameter("keywordType");
        String minPriceStr = req.getParameter("minPrice");
        String maxPriceStr = req.getParameter("maxPrice");
        String[] categories = req.getParameterValues("category");

        try {
            Dao<Product, Integer> productDao = DBManager.getDao(Product.class);
            Dao<User, Integer> userDao = DBManager.getDao(User.class);

            QueryBuilder<Product, Integer> productQb = productDao.queryBuilder();
            Where<Product, Integer> w = productQb.where().ge("id", 1);

            if (StringUtil.isNotEmpty(keyword) && StringUtil.isNotEmpty(keywordType)) {
                switch (keywordType) {
                    case "productName":
                        w.and().like("name", "%" + keyword + "%");
                        break;
                    case "tradingPlace":
                        w.and().like("tradingPlace", "%" + keyword + "%");
                        break;
                    case "sellerName":
                        QueryBuilder<User, Integer> userQb = userDao.queryBuilder();
                        userQb.where().eq("name", keyword);
                        productQb.join(userQb);
                        break;
                }
            }

            if (StringUtil.isNotEmpty(minPriceStr)) {
                Integer minPrice = Integer.parseInt(minPriceStr);
                w.and().ge("finalPrice", minPrice);
            }

            if (StringUtil.isNotEmpty(maxPriceStr)) {
                Integer maxPrice = Integer.parseInt(maxPriceStr);
                w.and().le("finalPrice", maxPrice);
            }

            if (categories != null && categories.length > 0) {
                for (String category : categories)
                    w.eq("category", Product.Category.valueOf(category));
                w.or(categories.length);
                w.and(w, w);
            }

            List<Product> products = productQb.query();
            req.setAttribute("products", products);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        jsp("product/product-list", req, res);
    }
}
