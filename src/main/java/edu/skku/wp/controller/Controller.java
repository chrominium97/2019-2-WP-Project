package edu.skku.wp.controller;

import com.google.gson.Gson;
import edu.skku.wp.security.Permission;
import edu.skku.wp.security.SecurityChecker;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.core.MediaType;
import java.io.IOException;
import java.io.PrintWriter;

public abstract class Controller extends HttpServlet {
    /**
     * Required permission to access the page.
     * Default value is <b>ANONYMOUS</b>.
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
        // check if the user has a valid permission
        if (!SecurityChecker.hasValidPermission(req, requiredPermission())) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "유효한 권한을 가지고 있지 않습니다.");
            return;
        }

        // if no problem, proceed
        super.service(req, res);
    }

    /**
     * Redirect to Path.
     *
     * @param path URI (not a whole URL!)
     * @param req  original page request
     * @param res  original page response
     */
    protected void redirect(String path, HttpServletRequest req, HttpServletResponse res) throws IOException {
        res.sendRedirect(req.getContextPath() + path);
    }

    /**
     * Forward to JSP file.
     *
     * @param path JSP file path to bind
     * @param req  original page request
     * @param res  original page response
     */
    protected void jsp(String path, HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/pages/" + path + ".jsp");
        dispatcher.forward(req, res);
    }

    /**
     * Transmit JSON file as a response.
     *
     * @param obj Java Object to transmit
     * @param req original page request
     * @param res original page response
     */
    protected void json(Object obj, HttpServletRequest req, HttpServletResponse res) throws IOException {
        res.setContentType(MediaType.APPLICATION_JSON);
        res.setCharacterEncoding("UTF-8");

        String encodedObj = new Gson().toJson(obj);

        PrintWriter writer = res.getWriter();
        writer.print(encodedObj);
        writer.flush();
    }

    protected void errorBadRequest(HttpServletRequest req, HttpServletResponse res) throws IOException {
        res.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 요청입니다.");
    }

    protected String path(HttpServletRequest req) {
        return req.getRequestURI().replaceFirst(req.getContextPath(), "");
    }
}
