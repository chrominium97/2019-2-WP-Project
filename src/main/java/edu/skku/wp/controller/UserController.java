package edu.skku.wp.controller;

import edu.skku.wp.security.Permission;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = "/user/*")
public class UserController extends Controller {
    @Override
    protected Permission requiredPermission() {
        return Permission.USER;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        switch (req.getServletPath()) {
            case "/user":
            case "/user/profile":
                handleUserProfileGet(req, res);
                break;
            case "/user/wishlist":
                handleUserWishlistGet(req, res);
                break;
            case "/user/history":
                handleUserHistoryGet(req, res);
                break;
            default:
                errorBadRequest(req, res);
                break;
        }
    }

    private void handleUserHistoryGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        jsp("user/history", req, res);
    }

    private void handleUserWishlistGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        jsp("user/wishlist", req, res);
    }

    private void handleUserProfileGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        jsp("user/profile", req, res);
    }
}
