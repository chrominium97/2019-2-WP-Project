package edu.skku.wp.controller;

import edu.skku.wp.security.Permission;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({"/product/register"})
public class SellerController extends Controller {
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
        jsp("product/product-register", req, res);
    }

}
