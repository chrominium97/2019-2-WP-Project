package edu.skku.wp.controller;

import edu.skku.wp.database.DBManager;
import edu.skku.wp.security.Permission;
import edu.skku.wp.security.SecurityChecker;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public abstract class Controller extends HttpServlet {

    /**
     * Database Connection
     */
    protected DBManager dbManager = DBManager.getInstance();

    /**
     * Required permission to access the page
     *
     * @return Permission
     */
    protected Permission requiredPermission() {
        return Permission.ANONYMOUS;
    }

    /**
     * Preprocess before load every page
     *
     * @param req original page request
     * @param res original page response
     */
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // check the user has a valid permission
        if (!SecurityChecker.hasValidPermission(req, requiredPermission())) {
            req.setAttribute("errorMessage", "유효한 권한을 가지고 있지 않습니다.");
            jsp("/pages/error.jsp", req, res);
        }

        // if no problem, proceed
        super.service(req, res);
    }

    /**
     * Forward to JSP file
     *
     * @param path JSP file path to bind
     * @param req  original page request
     * @param res  original page response
     */
    protected void jsp(String path, HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher(path);
        dispatcher.forward(req, res);
    }
}
