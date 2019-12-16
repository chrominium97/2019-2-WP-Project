package edu.skku.wp.controller;

import com.j256.ormlite.dao.Dao;
import edu.skku.wp.database.DBManager;
import edu.skku.wp.model.JsonResponse;
import edu.skku.wp.model.Product;
import edu.skku.wp.model.User;
import edu.skku.wp.security.Permission;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;

@WebServlet(urlPatterns = "/admin/*")
public class AdminController extends Controller {

    @Override
    protected Permission requiredPermission() {
        return Permission.ADMIN;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        switch (path(req)) {
            case "/admin":
            case "/admin/manage-user":
                handleManageUserGet(req, res);
                break;
            case "/admin/manage-user/get":
                handleUserGetGet(req, res);
                break;
            case "/admin/manage-product":
                handleManageProductGet(req, res);
                break;
            case "/admin/manage-product/get":
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
            case "/admin/manage-user/edit":
                handleUserEditPost(req, res);
                break;
            case "/admin/manage-user/delete":
                handleUserDeletePost(req, res);
                break;
            case "/admin/manage-product/edit":
                handleProductEditPost(req, res);
                break;
            case "/admin/manage-product/delete":
                handleProductDeletePost(req, res);
                break;
            case "/admin/manage-product/approve":
                handleProductApprovePost(req, res);
                break;
            default:
                errorBadRequest(req, res);
                break;
        }
    }

    private void handleManageProductGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            Dao<Product, Integer> productDao = DBManager.getDao(Product.class);

            req.setAttribute("products", productDao.queryForAll());
        } catch (SQLException e) {
            e.printStackTrace();
        }

        jsp("admin/manage-product", req, res);
    }

    private void handleManageUserGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            Dao<User, String> userDao = DBManager.getDao(User.class);

            req.setAttribute("users", userDao.queryForAll());
        } catch (SQLException e) {
            e.printStackTrace();
        }

        jsp("admin/manage-user", req, res);
    }

    private void handleUserGetGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String id = req.getParameter("id");
        try {
            Dao<User, String> userDao = DBManager.getDao(User.class);
            User user = userDao.queryForId(id);

            json(user, req, res);
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

    private void handleUserDeletePost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String id = req.getParameter("id");
        try {
            Dao<User, String> userDao = DBManager.getDao(User.class);
            userDao.deleteById(id);
            json(new JsonResponse(true, "정상적으로 제거되었습니다."), req, res);
        } catch (SQLException e) {
            e.printStackTrace();
        }
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
        } catch (SQLException | ParseException e) {
            e.printStackTrace();
        }
    }

    private void handleProductDeletePost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String id = req.getParameter("id");
        try {
            Dao<Product, String> productDao = DBManager.getDao(Product.class);
            productDao.deleteById(id);
            json(new JsonResponse(true, "정상적으로 제거되었습니다."), req, res);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void handleProductApprovePost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String id = req.getParameter("id");
        try {
            Dao<Product, String> productDao = DBManager.getDao(Product.class);
            Product product = productDao.queryForId(id);
            product.setStatus(Product.Status.AVAILABLE);

            productDao.update(product);

            json(new JsonResponse(true, "정상적으로 승인되었습니다."), req, res);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
