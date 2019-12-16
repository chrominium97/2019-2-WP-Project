package edu.skku.wp.controller;

import com.j256.ormlite.dao.Dao;
import edu.skku.wp.database.DBManager;
import edu.skku.wp.model.JsonResponse;
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
import java.util.Base64;

@WebServlet(urlPatterns = {"/mypage", "/mypage/profile/*"})
public class MypageUserController extends Controller {
    @Override
    protected Permission requiredPermission() {
        return Permission.USER;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        switch (path(req)) {
            case "/mypage":
            case "/mypage/profile":
                handleUserProfileGet(req, res);
                break;
            default:
                errorBadRequest(req, res);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        switch (path(req)) {
            case "/mypage/profile/edit":
                handleUserEditPost(req, res);
                break;
            default:
                errorBadRequest(req, res);
                break;
        }
    }

    private void handleUserProfileGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String id = SessionAuthProvider.getAuthUser(req).getId();
        try {
            Dao<User, String> userDao = DBManager.getDao(User.class);

            req.setAttribute("user", userDao.queryForId(id));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        jsp("mypage/profile", req, res);
    }

    private void handleUserEditPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String id = SessionAuthProvider.getAuthUser(req).getId();

        String name = req.getParameter("name");
        String phoneNumber = req.getParameter("phoneNumber");
        String password = req.getParameter("password");

        try {
            Dao<User, String> userDao = DBManager.getDao(User.class);
            User user = userDao.queryForId(id);
            user.setName(name);
            user.setPhoneNumber(phoneNumber);
            if (StringUtil.isNotEmpty(password))
                user.setPassword(Base64.getEncoder().encodeToString(password.getBytes()));

            userDao.update(user);
            json(new JsonResponse(true, "정상적으로 수정되었습니다."), req, res);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
