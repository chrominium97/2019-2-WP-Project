package edu.skku.wp.controller;

import com.j256.ormlite.dao.Dao;
import edu.skku.wp.database.DBManager;
import edu.skku.wp.model.User;
import edu.skku.wp.util.StringUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Base64;

@WebServlet(urlPatterns = {"/register", "/register/check-id"})
public class RegisterController extends Controller {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        switch (path(req)) {
            case "/register":
                handleRegister(req, res);
                break;
            default:
                errorBadRequest(req, res);
                break;
        }
        jsp("register", req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        switch (path(req)) {
            case "/register":
                handleRegister(req, res);
                break;
            case "/register/check-id":
                handleCheckId(req, res);
                break;
            default:
                errorBadRequest(req, res);
                break;
        }
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String id = req.getParameter("id");
        String password = req.getParameter("password");
        String name = req.getParameter("name");
        String phoneNumber = req.getParameter("phoneNumber");
        String type = req.getParameter("type");

        try {
            Dao<User, String> userDao = DBManager.getDao(User.class);

            User user = userDao.queryForId(id);
            if (user != null) {
                req.setAttribute("errorMessage", "아이디가 중복됩니다. 다른 단어로 바꿔 주세요.");
                jsp("register", req, res);
            } else {
                user = new User();
                user.setId(id);
                user.setPassword(Base64.getEncoder().encodeToString(password.getBytes()));
                user.setName(name);
                user.setPhoneNumber(phoneNumber);
                user.setType(User.Type.valueOf(type));

                userDao.create(user);
                redirect("login", req, res);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void handleCheckId(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String id = req.getParameter("id");
        if (!StringUtil.isNotEmpty(id)) {
            json(false, req, res);
            return;
        }

        try {
            Dao<User, String> userDao = DBManager.getDao(User.class);

            User user = userDao.queryBuilder()
                    .where()
                    .eq("id", id)
                    .queryForFirst();
            if (user != null) {
                json(false, req, res);
            } else
                json(true, req, res);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
