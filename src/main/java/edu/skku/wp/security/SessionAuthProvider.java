package edu.skku.wp.security;

import edu.skku.wp.model.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class SessionAuthProvider {

    public static User getAuthUser(HttpServletRequest req) {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        return user;
    }
}
