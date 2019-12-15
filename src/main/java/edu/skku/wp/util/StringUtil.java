package edu.skku.wp.util;

public class StringUtil {
    public static boolean isNotEmpty(String str) {
        return str != null && !str.isEmpty();
    }

    public static String nvl(String str, String defaultValue) {
        return isNotEmpty(str) ? str : defaultValue;
    }
}
