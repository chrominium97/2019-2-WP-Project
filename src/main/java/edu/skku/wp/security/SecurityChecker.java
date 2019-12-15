package edu.skku.wp.security;

import edu.skku.wp.model.User;

import javax.servlet.http.HttpServletRequest;

public class SecurityChecker {

    public static Boolean hasValidPermission(HttpServletRequest req, Permission permission) {
        User authUser = SessionAuthProvider.getAuthUser(req);
        if (authUser == null)
            return permission.equals(Permission.ANONYMOUS);

        return Permission.getPermission(authUser.getType()).canAccess(permission);
    }

    public static Boolean hasValidPermission(HttpServletRequest req, String userId) {
        User authUser = SessionAuthProvider.getAuthUser(req);

        return authUser.getId().equals(userId);
    }
}
