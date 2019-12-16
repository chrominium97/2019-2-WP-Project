package edu.skku.wp.controller;

import com.j256.ormlite.dao.Dao;
import edu.skku.wp.database.DBManager;
import edu.skku.wp.model.Product;
import edu.skku.wp.model.User;
import edu.skku.wp.security.Permission;
import edu.skku.wp.security.SessionAuthProvider;
import edu.skku.wp.util.StringUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet({"/product/register", "/product/modify", "/product/remove"})
public class ProductSellerController extends Controller {
    @Override
    protected Permission requiredPermission() {
        return Permission.SELLER;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        switch (path(req)) {
            case "/product/register":
                handleRegisterGet(req, res);
                break;
            default:
                errorBadRequest(req, res);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        switch (path(req)) {
            case "/product/register":
                handleRegisterPost(req, res);
                break;
            default:
                errorBadRequest(req, res);
                break;
        }
    }

    private void handleRegisterGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        jsp("product/product-register", req, res);
    }

    private void handleRegisterPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String name = req.getParameter("name");
        String categoryStr = req.getParameter("category");
        String tradingPlace = req.getParameter("tradingPlace");
        String typeStr = req.getParameter("type");
        String priceStr = req.getParameter("price");
        String expireDateStr = req.getParameter("expireDate");
        String description = req.getParameter("description");
        String image = req.getParameter("image");

        if (!StringUtil.isNotEmpty(name) || !StringUtil.isNotEmpty(categoryStr) ||
                !StringUtil.isNotEmpty(tradingPlace) || !StringUtil.isNotEmpty(typeStr) ||
                !StringUtil.isNotEmpty(expireDateStr) || !StringUtil.isNotEmpty(description)) {
            errorBadRequest(req, res);
            return;
        }

        try {
            User user = SessionAuthProvider.getAuthUser(req);
            Product.Category category = Product.Category.valueOf(categoryStr);
            Product.Type type = Product.Type.valueOf(typeStr);
            Date expireDate = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(expireDateStr);
            Integer price = Integer.parseInt(StringUtil.nvl(priceStr, "0"));

            Dao<Product, Integer> productDao = DBManager.getDao(Product.class);
            Product product = new Product();
            product.setName(name);
            product.setDescription(description);
            product.setStatus(Product.Status.PENDING);
            product.setType(type);
            product.setCategory(category);
            product.setTradingPlace(tradingPlace);
            product.setRegisterDate(new Date());
            product.setExpireDate(expireDate);
            product.setImage(image);
            product.setPrice(price);
            product.setFinalPrice(price);
            product.setSeller(user);

            productDao.create(product);

            req.setAttribute("message", "등록 성공하였습니다!\\n 관리자의 승인 후 상품이 표시됩니다.");
        } catch (ParseException | SQLException e) {
            e.printStackTrace();
            req.setAttribute("message", "등록 실패하였습니다!");
        }

        jsp("product/product-register", req, res);
    }

}
