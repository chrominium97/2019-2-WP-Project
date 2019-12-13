package edu.skku.wp.security;

import edu.skku.wp.model.User;

public enum Permission {
    ANONYMOUS,
    USER,
    SELLER,
    BUYER,
    ADMIN;

    /**
     * Convert {@link edu.skku.wp.model.User.UserType} to Permission.
     *
     * @param type Target user type
     * @return Permission
     */
    public static Permission getPermission(User.UserType type) {
        switch (type) {
            case ADMIN:
                return ADMIN;
            case BUYER:
                return BUYER;
            case SELLER:
                return SELLER;
            default:
                return ANONYMOUS;
        }
    }

    /**
     * Tests if target permission is accessible.
     * Permission is hierarchical (ADMIN > USER > ANONYMOUS).
     * The former one can access to the later one.
     * Note: SELLER and BUYER both treated as USER, but SELLER cannot access BUYER, vice versa.
     *
     * @param permission Target permission
     * @return Boolean
     */
    public Boolean canAccess(Permission permission) {
        switch (this) {
            case ADMIN:
                return true;
            case BUYER:
                switch (permission) {
                    case BUYER:
                    case USER:
                    case ANONYMOUS:
                        return true;
                    default:
                        return false;
                }
            case SELLER:
                switch (permission) {
                    case SELLER:
                    case USER:
                    case ANONYMOUS:
                        return true;
                    default:
                        return false;
                }
            case USER:
                switch (permission) {
                    case USER:
                    case ANONYMOUS:
                        return true;
                    default:
                        return false;
                }
            case ANONYMOUS:
                return this.equals(permission);
            default:
                return false;
        }
    }
}
