package edu.skku.wp.security;

import edu.skku.wp.model.User;

import javax.servlet.http.HttpServletRequest;

public class SecurityChecker {

    public static Boolean hasValidPermission(HttpServletRequest req, Permission permission) {
        User authUser = SessionAuthProvider.getAuthUser(req);
        User.UserType userType = authUser.getType();

        if (Permission.getPermission(userType).canAccess(permission))
            return true;

        return false;
    }

    public static Boolean hasValidPermission(HttpServletRequest req, String userId) {
        User authUser = SessionAuthProvider.getAuthUser(req);

        if (authUser.getId().equals(userId))
            return true;

        return false;
    }
}
