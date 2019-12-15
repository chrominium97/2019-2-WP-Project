package edu.skku.wp.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class SessionUtil {
    public static final int EXPIRE_SECONDS = 15 * 60;

    public static HttpSession getSession(HttpServletRequest req) {
        HttpSession session = req.getSession(true);
        session.setMaxInactiveInterval(EXPIRE_SECONDS);
        return session;
    }

    public static Object getAttribute(String attr, HttpServletRequest req) {
        return getSession(req).getAttribute(attr);
    }

    public static void setAttribute(String attr, Object obj, HttpServletRequest req) {
        getSession(req).setAttribute(attr, obj);
    }

    public static void expireSession(HttpServletRequest req) {
        getSession(req).invalidate();
    }
}
