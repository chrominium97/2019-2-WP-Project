package edu.skku.wp.controller;

import com.j256.ormlite.dao.Dao;
import edu.skku.wp.database.DBManager;
import edu.skku.wp.model.Product;
import edu.skku.wp.model.User;
import edu.skku.wp.security.Permission;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(urlPatterns = "/admin/*")
public class AdminController extends Controller {

    @Override
    protected Permission requiredPermission() {
        return Permission.ADMIN;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        switch (req.getServletPath()) {
            case "/admin":
            case "/admin/manage-user":
                handleManageUserGet(req, res);
                break;
            case "/admin/manage-product":
                handleManageProductGet(req, res);
                break;
            default:
                errorBadRequest(req, res);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        switch (req.getServletPath()) {
            case "/admin/manage-user/edit":
                handleUserEditPost(req, res);
                break;
            case "/admin/manager-user/delete":
                handleUserDeletePost(req, res);
                break;
            default:
                errorBadRequest(req, res);
                break;
        }
    }

    private void handleManageProductGet(HttpServletRequest req, HttpServletResponse res) {
        Dao<Product, Integer> productDao = DBManager.getDao(Product.class);
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

    // TODO: Ajax로 바꾸기
    private void handleUserEditPost(HttpServletRequest req, HttpServletResponse res) {
        String id = req.getParameter("id");
    }

    // TODO: Ajax로 바꾸기
    private void handleUserDeletePost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String id = req.getParameter("id");

        try {
            Dao<User, String> userDao = DBManager.getDao(User.class);

            userDao.deleteById(id);
            jsp("admin/manage-user", req, res);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
