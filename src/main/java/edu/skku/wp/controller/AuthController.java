package edu.skku.wp.controller;

import com.j256.ormlite.dao.Dao;
import edu.skku.wp.database.DBManager;
import edu.skku.wp.model.User;
import edu.skku.wp.security.SessionAuthProvider;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Base64;

@WebServlet(urlPatterns = {"/login", "/logout"})
public class AuthController extends Controller {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        switch (path(req)) {
            case "/login":
                handleLoginGet(req, res);
                break;
            default:
                errorBadRequest(req, res);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        switch (path(req)) {
            case "/login":
                handleLoginPost(req, res);
                break;
            case "/logout":
                handleLogoutPost(req, res);
                break;
            default:
                errorBadRequest(req, res);
                break;
        }
    }

    private void handleLoginGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        if (SessionAuthProvider.isLogin(req))
            redirect("/", req, res);

        jsp("login", req, res);
    }

    private void handleLoginPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String id = req.getParameter("id");
        String password = req.getParameter("password");

        Dao<User, String> userDao = DBManager.getDao(User.class);

        try {
            User user = userDao.queryBuilder()
                    .where()
                    .eq("id", id)
                    .and()
                    .eq("password", Base64.getEncoder().encodeToString(password.getBytes()))
                    .queryForFirst();

            if (user != null) {
                SessionAuthProvider.setAuthUser(user, req);
                redirect("/", req, res);
            } else {
                req.setAttribute("errorMessage", "로그인 정보가 일치하지 않습니다.");
                jsp("login", req, res);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void handleLogoutPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        SessionAuthProvider.removeAuthUser(req);
        redirect("/", req, res);
    }

}
