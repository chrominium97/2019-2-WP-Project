package edu.skku.wp.security;

import edu.skku.wp.model.User;
import edu.skku.wp.util.SessionUtil;

import javax.servlet.http.HttpServletRequest;

public class SessionAuthProvider {
    public static Permission getPermission(HttpServletRequest req) {
        Permission permission = (Permission) SessionUtil.getAttribute("permission", req);
        if (permission == null)
            return Permission.ANONYMOUS;
        else
            return permission;
    }

    public static User getAuthUser(HttpServletRequest req) {
        User user = (User) SessionUtil.getAttribute("user", req);

        return user;
    }

    public static void setAuthUser(User user, HttpServletRequest req) {
        SessionUtil.setAttribute("user", user, req);
        SessionUtil.setAttribute("permission", Permission.getPermission(user.getType()), req);
    }

    public static void removeAuthUser(HttpServletRequest req) {
        SessionUtil.expireSession(req);
    }

    public static Boolean isLogin(HttpServletRequest req) {
        return getAuthUser(req) != null;
    }
}
